const express = require('express');
const axios = require('axios');
const path = require('path');
const fs = require('fs-extra');
const crypto = require('crypto');

module.exports = (ctx) => {
  const {
    db,
    authenticateToken,
    TRANSLATIONS_DIR
  } = ctx;
  const router = express.Router();

  // ── Shared helpers ──────────────────────────────────────────────────────────

  /**
   * Build a human-readable target language name from a langcode.
   */
  function targetLangName(langcode) {
    const map = {
      de: 'German', fr: 'French', es: 'Spanish', nl: 'Dutch',
      it: 'Italian', pl: 'Polish', cs: 'Czech', sk: 'Slovak',
      hu: 'Hungarian', ro: 'Romanian', sv: 'Swedish', da: 'Danish',
      fi: 'Finnish', nb: 'Norwegian', el: 'Greek', tr: 'Turkish',
      ru: 'Russian', uk: 'Ukrainian', bg: 'Bulgarian',
      'pt-pt': 'Portuguese (Portugal)', 'pt-br': 'Portuguese (Brazil)',
      'zh-hans': 'Simplified Chinese', 'zh-hant': 'Traditional Chinese',
      ja: 'Japanese', ko: 'Korean',
    };
    return map[langcode] || langcode;
  }

  const DEFAULT_PROMPT = `Translate the following two HTML blocks (summary and main description) from the Drupal Project Browser to {{langcode}}.
IMPORTANT:
1. Return ONLY the translation.
2. Do NOT add any introduction, comments, or explanations (e.g., NO "Here is the translation").
3. Module names must stay in English.
4. Links and image URLs must remain unchanged.
5. Separate the two translated blocks EXACTLY by the string '---'.

Summary:
{{summary}}

---

Main Description:
{{body}}`;

  /**
   * Call Google Gemini and return the raw text response.
   */
  async function callGemini(apiKey, promptText) {
    const url = `https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-flash-lite:generateContent?key=${apiKey}`;
    const res = await axios.post(url, {
      contents: [{ parts: [{ text: promptText }] }]
    });
    return res.data.candidates[0].content.parts[0].text;
  }

  /**
   * Parse the "summary --- body" format returned by both AI backends.
   */
  function parseSummaryBody(aiText) {
    const cleaned = aiText
      .replace(/^(Hier ist die Übersetzung|Hier sind die übersetzten|Übersetzung:|Hier ist die).*?\n+/gi, '')
      .trim();
    const parts = cleaned.split('---');
    return {
      summary: (parts[0] || '').trim(),
      body:    (parts[1] || '').trim(),
    };
  }

  /**
   * Persist a completed translation to the DB + JSON file.
   */
  async function saveTranslation(db, TRANSLATIONS_DIR, {
    machine_name, langcode, title,
    translatedSummary, translatedBody,
    summarySrc, bodySrc, userId, suggestionType,
  }) {
    const sourceHash = crypto
      .createHash('md5')
      .update(title + summarySrc + bodySrc)
      .digest('hex');

    await db.execute(`
      INSERT INTO translations
        (machine_name, langcode, title, summary, body, screenshot_alts, source_hash, is_reviewed)
      VALUES (?, ?, ?, ?, ?, ?, ?, 0)
      ON DUPLICATE KEY UPDATE
        title=VALUES(title), summary=VALUES(summary), body=VALUES(body),
        source_hash=VALUES(source_hash), is_reviewed=0
    `, [machine_name, langcode, title, translatedSummary, translatedBody, '{}', sourceHash]);

    await db.execute(`
      INSERT INTO translation_suggestions
        (machine_name, langcode, title, summary, body, source_hash, user_id, suggestion_type)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `, [machine_name, langcode, title, translatedSummary, translatedBody, sourceHash, userId, suggestionType]);

    await fs.ensureDir(path.join(TRANSLATIONS_DIR, langcode));
    await fs.writeJson(
      path.join(TRANSLATIONS_DIR, langcode, `${machine_name}.json`),
      {
        machine_name, title,
        body: { value: translatedBody, summary: translatedSummary },
        screenshot_alts: {}, reviewed: false,
        source_hash: sourceHash,
        updated: Math.floor(Date.now() / 1000),
      },
      { spaces: 2 },
    );
  }

  // ── Bulk translation (Gemini) ────────────────────────────────────────────────

  router.post('/ai/translate-bulk', authenticateToken, async (req, res) => {
    const { machineNames, langcode } = req.body;
    if (!Array.isArray(machineNames)) return res.status(400).json({ error: 'Invalid machine names' });

    try {
      const [uRows] = await db.execute(
        'SELECT google_ai_key, ai_batch_limit, ai_prompt FROM users WHERE id = ?',
        [req.user.id]
      );
      const user = uRows[0];

      if (!user || !user.google_ai_key) {
        return res.status(400).json({ error: 'Missing Google AI Key in your profile.' });
      }

      const limit = Math.min(machineNames.length, user.ai_batch_limit || 10);
      const projectsToTranslate = machineNames.slice(0, limit);
      const results = [];
      const promptTemplate = user.ai_prompt || DEFAULT_PROMPT;

      console.log(`[AI] Starting bulk translation for user ${req.user.username} (${projectsToTranslate.length} projects)`);

      for (const machine_name of projectsToTranslate) {
        try {
          const [pRows] = await db.execute(
            'SELECT data, title FROM projects WHERE machine_name = ?', [machine_name]
          );
          if (pRows.length === 0) continue;

          const project    = JSON.parse(pRows[0].data);
          const title      = project.attributes.title || pRows[0].title;
          const summarySrc = project.attributes.body?.summary || '';
          const bodySrc    = project.attributes.body?.value   || '';

          const promptText = promptTemplate
            .replace(/{{langcode}}/g, targetLangName(langcode))
            .replace(/{{summary}}/g, summarySrc)
            .replace(/{{body}}/g, bodySrc);

          const rawText = await callGemini(user.google_ai_key, promptText);
          const { summary: translatedSummary, body: translatedBody } = parseSummaryBody(rawText);

          await saveTranslation(db, TRANSLATIONS_DIR, {
            machine_name, langcode, title,
            translatedSummary, translatedBody,
            summarySrc, bodySrc,
            userId: req.user.id,
            suggestionType: 'ai',
          });

          console.log(`[AI] Translated: ${machine_name} (${langcode})`);
          results.push({ machine_name, success: true });
        } catch (err) {
          let humanError = err.message;
          if (err.response) {
            const msg = err.response.data?.error?.message || JSON.stringify(err.response.data);
            console.error(`[AI] Gemini Error (${err.response.status}) for ${machine_name}:`, msg);
            humanError = `Gemini ${err.response.status}: ${msg}`;
          } else {
            console.error(`[AI] Failed to translate ${machine_name}:`, err.message);
          }
          results.push({ machine_name, success: false, error: humanError });
        }
      }

      const successCount = results.filter(r => r.success).length;
      console.log(`[AI] Bulk finished. Success: ${successCount}/${results.length}`);
      const status = successCount === 0 && results.length > 0 ? 422 : 200;
      res.status(status).json({ results, count: successCount });
    } catch (error) {
      console.error('Bulk AI Translation error:', error);
      res.status(500).json({ error: 'Bulk AI Translation process failed.' });
    }
  });

  // Pre-calculate token count and safety cost estimate for bulk translation
  router.post('/ai/estimate-cost', authenticateToken, async (req, res) => {
    const { machineNames, langcode } = req.body;
    if (!Array.isArray(machineNames)) return res.status(400).json({ error: 'Invalid machine names' });

    try {
      const [uRows] = await db.execute('SELECT google_ai_key, ai_prompt FROM users WHERE id = ?', [req.user.id]);
      const user = uRows[0];
      
      if (!user || !user.google_ai_key) {
        return res.status(400).json({ error: 'Missing Google AI Key.' });
      }

      const COUNT_URL = `https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-flash-lite:countTokens?key=${user.google_ai_key}`;
      
      const defaultPrompt = `Translate the following two HTML blocks (summary and main description) from the Drupal Project Browser to {{langcode}}.
IMPORTANT:
1. Return ONLY the translation.
2. Do NOT add any introduction, comments, or explanations.
3. Module names must stay in English.
4. Links and image URLs must remain unchanged.
5. Separate the two translated blocks EXACTLY by the string '---'.

Summary:
{{summary}}

---

Main Description:
{{body}}`;

      const userPromptTemplate = user.ai_prompt || defaultPrompt;
      let totalTokens = 0;

      for (const machine_name of machineNames) {
        const [pRows] = await db.execute('SELECT data FROM projects WHERE machine_name = ?', [machine_name]);
        if (pRows.length === 0) continue;
        
        const project = JSON.parse(pRows[0].data);
        const summarySrc = project.attributes.body?.summary || '';
        const bodySrc = project.attributes.body?.value || '';

        const targetLang = langcode === 'de' ? 'German' : langcode;
        const promptText = userPromptTemplate
          .replace(/{{langcode}}/g, targetLang)
          .replace(/{{summary}}/g, summarySrc)
          .replace(/{{body}}/g, bodySrc);

        try {
          const countRes = await axios.post(COUNT_URL, {
            contents: [{ parts: [{ text: promptText }] }]
          });
          totalTokens += countRes.data.totalTokens || 0;
        } catch (err) {
          console.error(`[AI] Token count failed for ${machine_name}:`, err.message);
        }
      }

      const estimatedCost = (totalTokens / 1000000) * 0.25; 
      const safeEstimate = estimatedCost * 4; 

      res.json({ totalTokens, estimatedCost: safeEstimate.toFixed(4) });
    } catch (error) {
      console.error('AI Cost Estimation error:', error);
      res.status(500).json({ error: 'Estimation failed.' });
    }
  });

  // Translate a single project with the DeepL API
  router.post('/ai/deepl-translate', authenticateToken, async (req, res) => {
    const { machineName, langcode } = req.body;
    if (!machineName || !langcode) {
      return res.status(400).json({ error: 'machineName and langcode sind erforderlich.' });
    }

    try {
      const [uRows] = await db.execute('SELECT deepl_api_key FROM users WHERE id = ?', [req.user.id]);
      const user = uRows[0];

      if (!user || !user.deepl_api_key) {
        return res.status(400).json({ error: 'Kein DeepL API-Key im Profil hinterlegt.' });
      }

      const apiKey = user.deepl_api_key;
      // Free keys end with :fx → use free endpoint
      const apiBase = apiKey.endsWith(':fx')
        ? 'https://api-free.deepl.com'
        : 'https://api.deepl.com';

      // Fetch English source data
      const [pRows] = await db.execute('SELECT data, title FROM projects WHERE machine_name = ?', [machineName]);
      if (pRows.length === 0) {
        return res.status(404).json({ error: 'Projekt nicht gefunden.' });
      }

      const project   = JSON.parse(pRows[0].data);
      const title     = project.attributes.title || pRows[0].title;
      const summarySrc = project.attributes.body?.summary || '';
      const bodySrc    = project.attributes.body?.value   || '';

      // Map internal langcodes → DeepL target_lang codes
      const langMap = {
        'de': 'DE', 'fr': 'FR', 'es': 'ES', 'nl': 'NL',
        'it': 'IT', 'pl': 'PL', 'cs': 'CS', 'sk': 'SK',
        'hu': 'HU', 'ro': 'RO', 'sv': 'SV', 'da': 'DA',
        'fi': 'FI', 'nb': 'NB', 'el': 'EL', 'tr': 'TR',
        'pt-pt': 'PT-PT', 'pt-br': 'PT-BR',
        'zh-hans': 'ZH-HANS', 'zh-hant': 'ZH-HANT',
        'ja': 'JA', 'ko': 'KO', 'uk': 'UK', 'ru': 'RU', 'bg': 'BG',
      };
      const targetLang = langMap[langcode] || langcode.toUpperCase();

      // Build the list of non-empty texts (preserves index mapping)
      const textsToTranslate = [];
      if (summarySrc.trim()) textsToTranslate.push(summarySrc);
      if (bodySrc.trim())    textsToTranslate.push(bodySrc);

      let translatedSummary = summarySrc;
      let translatedBody    = bodySrc;

      if (textsToTranslate.length > 0) {
        const deeplRes = await axios.post(
          `${apiBase}/v2/translate`,
          {
            text:         textsToTranslate,
            source_lang:  'EN',
            target_lang:  targetLang,
            tag_handling: 'html',
          },
          {
            headers: {
              'Authorization': `DeepL-Auth-Key ${apiKey}`,
              'Content-Type':  'application/json',
            },
          }
        );

        const translations = deeplRes.data.translations;
        let idx = 0;
        if (summarySrc.trim()) translatedSummary = translations[idx++]?.text || summarySrc;
        if (bodySrc.trim())    translatedBody    = translations[idx++]?.text || bodySrc;
      }

      const sourceStr  = title + summarySrc + bodySrc;
      const sourceHash = crypto.createHash('md5').update(sourceStr).digest('hex');

      const translationData = {
        machine_name:    machineName,
        title,
        body:            { value: translatedBody, summary: translatedSummary },
        screenshot_alts: {},
        reviewed:        false,
        source_hash:     sourceHash,
        updated:         Math.floor(Date.now() / 1000),
      };

      await db.execute(`
        INSERT INTO translations (machine_name, langcode, title, summary, body, screenshot_alts, source_hash, is_reviewed)
        VALUES (?, ?, ?, ?, ?, ?, ?, 0)
        ON DUPLICATE KEY UPDATE
          title=VALUES(title),
          summary=VALUES(summary),
          body=VALUES(body),
          source_hash=VALUES(source_hash),
          is_reviewed=0
      `, [machineName, langcode, title, translatedSummary, translatedBody, '{}', sourceHash]);

      await db.execute(`
        INSERT INTO translation_suggestions (machine_name, langcode, title, summary, body, source_hash, user_id, suggestion_type)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      `, [machineName, langcode, title, translatedSummary, translatedBody, sourceHash, req.user.id, 'deepl']);

      await fs.ensureDir(path.join(TRANSLATIONS_DIR, langcode));
      await fs.writeJson(
        path.join(TRANSLATIONS_DIR, langcode, `${machineName}.json`),
        translationData,
        { spaces: 2 }
      );

      console.log(`[DeepL] Translated: ${machineName} → ${targetLang}`);
      res.json({ success: true, machine_name: machineName });

    } catch (error) {
      if (error.response) {
        const status  = error.response.status;
        const message = error.response.data?.message || JSON.stringify(error.response.data);
        console.error(`[DeepL] API Error (${status}):`, message);
        // 403 = invalid key, 456 = quota exceeded
        if (status === 403) return res.status(400).json({ error: 'Ungültiger DeepL API-Key.' });
        if (status === 456) return res.status(402).json({ error: 'DeepL Kontingent erschöpft.' });
        return res.status(502).json({ error: `DeepL API Fehler (${status}): ${message}` });
      }
      console.error('[DeepL] Translation error:', error.message);
      res.status(500).json({ error: 'DeepL Übersetzung fehlgeschlagen.' });
    }
  });

  return router;
};
