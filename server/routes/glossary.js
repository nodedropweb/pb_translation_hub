/**
 * routes/glossary.js — Glossar-API für fachsprachliche Übersetzungshinweise
 *
 * GET    /glossary              — Alle Einträge (optional ?langcode=de)
 * POST   /glossary              — Neuen Eintrag anlegen (Reviewer/Admin)
 * PUT    /glossary/:id          — Eintrag aktualisieren (Reviewer/Admin)
 * DELETE /glossary/:id          — Eintrag löschen (Reviewer/Admin)
 */

const express = require('express');

module.exports = (ctx) => {
  const { db, authenticateToken, isReviewerOrAdmin } = ctx;
  const router = express.Router();

  // ── GET /glossary  ─────────────────────────────────────────────────────────
  // Öffentlich für alle eingeloggten Nutzer — Lesezugriff reicht für das Plugin
  router.get('/glossary', authenticateToken, async (req, res) => {
    const { langcode } = req.query;
    try {
      let sql = `
        SELECT g.*, u.username AS creator_name
        FROM   glossary_terms g
        LEFT JOIN users u ON u.id = g.created_by
      `;
      const params = [];
      if (langcode) {
        sql += ' WHERE g.lang_code = ?';
        params.push(langcode);
      }
      sql += ' ORDER BY g.source_word ASC';
      const [rows] = await db.execute(sql, params);
      // Normalize word_forms: always return as array for the JS plugin
      rows.forEach(row => {
        row.word_forms = row.word_forms
          ? row.word_forms.split(',').map(s => s.trim()).filter(Boolean)
          : [];
      });
      res.json(rows);
    } catch (err) {
      console.error('[glossary] GET error:', err);
      res.status(500).json({ error: 'Database error' });
    }
  });

  // ── POST /glossary  ────────────────────────────────────────────────────────
  router.post('/glossary', authenticateToken, isReviewerOrAdmin, async (req, res) => {
    const { lang_code, source_word, preferred_word, explanation, word_forms } = req.body;
    if (!lang_code || !source_word || !preferred_word) {
      return res.status(400).json({ error: 'lang_code, source_word and preferred_word are required' });
    }
    const wordFormsStr = Array.isArray(word_forms)
      ? word_forms.map(s => s.trim()).filter(Boolean).join(',')
      : (word_forms || '').trim();
    try {
      const [result] = await db.execute(
        `INSERT INTO glossary_terms (lang_code, source_word, word_forms, preferred_word, explanation, created_by)
         VALUES (?, ?, ?, ?, ?, ?)`,
        [lang_code.trim(), source_word.trim(), wordFormsStr || null,
         preferred_word.trim(), (explanation || '').trim(), req.user.id]
      );
      const [rows] = await db.execute('SELECT * FROM glossary_terms WHERE id = ?', [result.insertId]);
      rows[0].word_forms = rows[0].word_forms
        ? rows[0].word_forms.split(',').map(s => s.trim()).filter(Boolean)
        : [];
      res.status(201).json(rows[0]);
    } catch (err) {
      console.error('[glossary] POST error:', err);
      res.status(500).json({ error: 'Database error' });
    }
  });

  // ── PUT /glossary/:id  ─────────────────────────────────────────────────────
  router.put('/glossary/:id', authenticateToken, isReviewerOrAdmin, async (req, res) => {
    const { id } = req.params;
    const { lang_code, source_word, preferred_word, explanation, word_forms } = req.body;
    if (!lang_code || !source_word || !preferred_word) {
      return res.status(400).json({ error: 'lang_code, source_word and preferred_word are required' });
    }
    const wordFormsStr = Array.isArray(word_forms)
      ? word_forms.map(s => s.trim()).filter(Boolean).join(',')
      : (word_forms || '').trim();
    try {
      await db.execute(
        `UPDATE glossary_terms SET lang_code=?, source_word=?, word_forms=?, preferred_word=?, explanation=?
         WHERE id=?`,
        [lang_code.trim(), source_word.trim(), wordFormsStr || null,
         preferred_word.trim(), (explanation || '').trim(), id]
      );
      const [rows] = await db.execute('SELECT * FROM glossary_terms WHERE id = ?', [id]);
      if (rows.length === 0) return res.status(404).json({ error: 'Not found' });
      rows[0].word_forms = rows[0].word_forms
        ? rows[0].word_forms.split(',').map(s => s.trim()).filter(Boolean)
        : [];
      res.json(rows[0]);
    } catch (err) {
      console.error('[glossary] PUT error:', err);
      res.status(500).json({ error: 'Database error' });
    }
  });

  // ── DELETE /glossary/:id  ──────────────────────────────────────────────────
  router.delete('/glossary/:id', authenticateToken, isReviewerOrAdmin, async (req, res) => {
    const { id } = req.params;
    try {
      const [result] = await db.execute('DELETE FROM glossary_terms WHERE id = ?', [id]);
      if (result.affectedRows === 0) return res.status(404).json({ error: 'Not found' });
      res.json({ ok: true });
    } catch (err) {
      console.error('[glossary] DELETE error:', err);
      res.status(500).json({ error: 'Database error' });
    }
  });

  return router;
};
