const express = require('express');
const path = require('path');
const fs = require('fs-extra');
const crypto = require('crypto');
const AdmZip = require('adm-zip');

module.exports = (ctx) => {
  const {
    db,
    authenticateToken,
    optionalAuth,
    isReviewerOrAdmin,
    isAdmin,
    DATA_DIR,
    METADATA_DIR,
    TRANSLATIONS_DIR,
    fixRelativeUrls,
    upload
  } = ctx;
  const router = express.Router();

  // Constant-time comparison for the debug shared secret — a plain !==
  // leaks timing information proportional to how many leading characters
  // match, which can be used to brute-force the key byte by byte.
  function timingSafeEqualStrings(a, b) {
    const bufA = Buffer.from(String(a));
    const bufB = Buffer.from(String(b));
    if (bufA.length !== bufB.length) return false;
    return crypto.timingSafeEqual(bufA, bufB);
  }

  // Resolves a langcode/filename pair to a path inside TRANSLATIONS_DIR,
  // rejecting anything that would escape it (path traversal) or doesn't look
  // like a real langcode/JSON filename.
  function safeTranslationPath(langcode, filename) {
    if (!/^[a-z]{2,3}(-[a-z0-9]{2,8})?$/i.test(langcode)) return null;
    if (!/^[a-zA-Z0-9._-]+\.json$/.test(filename)) return null;
    const root = path.resolve(TRANSLATIONS_DIR) + path.sep;
    const resolved = path.resolve(TRANSLATIONS_DIR, langcode, filename);
    return resolved.startsWith(root) ? resolved : null;
  }

  // Get active translation overlay (file-based with DB fallback)
  router.get('/translations/:langcode/:machine_name', authenticateToken, async (req, res) => {
    const { langcode, machine_name } = req.params;
    const filePath = safeTranslationPath(langcode, `${machine_name}.json`);
    if (filePath && await fs.pathExists(filePath)) {
      const data = await fs.readJson(filePath);
      if (data.body) {
        if (typeof data.body === 'string') {
          data.body = fixRelativeUrls(data.body);
        } else if (typeof data.body === 'object') {
          data.body = {
            ...data.body,
            value:   fixRelativeUrls(data.body.value   || ''),
            summary: fixRelativeUrls(data.body.summary || ''),
          };
        }
      }
      return res.json(data);
    }

    try {
      const [tRows] = await db.execute(
        'SELECT title, summary, body, screenshot_alts, source_hash, is_reviewed FROM translations WHERE machine_name = ? AND langcode = ?',
        [machine_name, langcode]
      );
      if (tRows.length > 0) {
        const row = tRows[0];
        return res.json({
          machine_name,
          title: row.title,
          body: {
            value:   fixRelativeUrls(row.body    || ''),
            summary: fixRelativeUrls(row.summary || ''),
          },
          screenshot_alts: JSON.parse(row.screenshot_alts || '{}'),
          is_reviewed: row.is_reviewed === 1,
          source_hash: row.source_hash
        });
      }
    } catch (dbErr) {
      console.error('Database translation lookup error:', dbErr);
    }

    res.status(404).json({ error: 'Not found' });
  });

  // Save translation (either edit update or review approval)
  router.post('/translations/:langcode/:machine_name', authenticateToken, async (req, res) => {
    const { langcode, machine_name } = req.params;
    const { title, summary, body, screenshot_alts = {}, is_review = false } = req.body;

    // Translators may not approve (is_review=true)
    if (is_review && req.user.role !== 'admin' && req.user.user_type !== 'reviewer') {
      return res.status(403).json({ error: 'Only reviewers and admins can approve translations.' });
    }
    try {
      const [pRows] = await db.execute('SELECT data FROM projects WHERE machine_name = ?', [machine_name]);
      let sourceHash = '';
      if (pRows.length > 0) {
        const item = JSON.parse(pRows[0].data);
        const source = item.attributes.title + (item.attributes.body?.summary || '') + (item.attributes.body?.value || '');
        sourceHash = crypto.createHash('md5').update(source).digest('hex');
      }

      // Regular saves (is_review=false) always reset to review-queue (0).
      // Only explicit approval (is_review=true) promotes to released (1).
      const newIsReviewed = is_review ? 1 : 0;

      const translationData = {
        machine_name,
        title,
        body: { value: body, summary: summary },
        screenshot_alts,
        is_reviewed: newIsReviewed === 1,
        source_hash: sourceHash,
        updated: Math.floor(Date.now() / 1000),
        reviewed_by: is_review ? req.user.username : undefined
      };

      await db.execute(`
        INSERT INTO translations (machine_name, langcode, title, summary, body, screenshot_alts, source_hash, is_reviewed)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE
          title=VALUES(title),
          summary=VALUES(summary),
          body=VALUES(body),
          screenshot_alts=VALUES(screenshot_alts),
          source_hash=VALUES(source_hash),
          is_reviewed=VALUES(is_reviewed),
          updated_at=NOW()
      `, [machine_name, langcode, title, summary, body, JSON.stringify(screenshot_alts), sourceHash, newIsReviewed]);
      
      if (is_review) {
        await db.execute('UPDATE users SET last_reviewed_project = ? WHERE id = ?', [machine_name, req.user.id]);
      }

      // Respond immediately after DB save — client can navigate without waiting for disk I/O.
      // JSON file write and suggestion insert run in the background (fire & forget).
      res.json({ success: true, source_hash: sourceHash, is_reviewed: is_review });

      // Background: write JSON file to disk (non-blocking)
      fs.ensureDir(path.join(TRANSLATIONS_DIR, langcode))
        .then(() => fs.writeJson(path.join(TRANSLATIONS_DIR, langcode, `${machine_name}.json`), translationData, { spaces: 2 }))
        .catch(e => console.error(`[BG] writeJson failed for ${machine_name}:`, e.message));

      // Background: insert suggestion (only for non-review saves)
      if (!is_review) {
        db.execute(`
          INSERT INTO translation_suggestions (machine_name, langcode, title, summary, body, source_hash, user_id, suggestion_type)
          VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        `, [machine_name, langcode, title, summary, body, sourceHash, req.user.id, 'manual'])
          .catch(e => console.error(`[BG] suggestion insert failed for ${machine_name}:`, e.message));
      }
    } catch (error) {
      console.error('Save translation error:', error);
      res.status(500).json({ error: 'Failed to save translation' });
    }
  });

  // Reset a single translation back to unreviewed (un-publish)
  router.patch('/translations/:langcode/:machine_name/unreview', authenticateToken, async (req, res) => {
    const { langcode, machine_name } = req.params;
    try {
      await db.execute(
        'UPDATE translations SET is_reviewed = 0 WHERE langcode = ? AND machine_name = ?',
        [langcode, machine_name]
      );
      // Update the JSON file on disk if it exists
      const filePath = path.join(TRANSLATIONS_DIR, langcode, `${machine_name}.json`);
      if (await fs.pathExists(filePath)) {
        const data = await fs.readJson(filePath);
        data.is_reviewed = false;
        data.reviewed_by = undefined;
        await fs.writeJson(filePath, data, { spaces: 2 });
      }
      console.log(`[Translations] Un-reviewed: ${machine_name} (${langcode})`);
      res.json({ success: true });
    } catch (error) {
      console.error('Unreview error:', error);
      res.status(500).json({ error: 'Failed to reset review state' });
    }
  });

  // Reset ALL reviewed translations for a langcode back to unreviewed
  router.post('/translations/unreview-all', authenticateToken, async (req, res) => {
    const { langcode } = req.body;
    if (!langcode) return res.status(400).json({ error: 'langcode required' });
    try {
      const [rows] = await db.execute(
        'SELECT machine_name FROM translations WHERE langcode = ? AND is_reviewed = 1',
        [langcode]
      );
      await db.execute(
        'UPDATE translations SET is_reviewed = 0 WHERE langcode = ? AND is_reviewed = 1',
        [langcode]
      );
      // Update each JSON file on disk
      let updated = 0;
      for (const row of rows) {
        const filePath = path.join(TRANSLATIONS_DIR, langcode, `${row.machine_name}.json`);
        if (await fs.pathExists(filePath)) {
          try {
            const data = await fs.readJson(filePath);
            data.is_reviewed = false;
            data.reviewed_by = undefined;
            await fs.writeJson(filePath, data, { spaces: 2 });
            updated++;
          } catch (_) {}
        }
      }
      console.log(`[Translations] Unreview-all (${langcode}): ${rows.length} DB rows, ${updated} files updated`);
      res.json({ success: true, count: rows.length });
    } catch (error) {
      console.error('Unreview-all error:', error);
      res.status(500).json({ error: 'Failed to reset all reviews' });
    }
  });

  // Get translation suggestions
  router.get('/suggestions/:langcode/:machine_name', async (req, res) => {
    const { langcode, machine_name } = req.params;
    try {
      const [rows] = await db.execute(`
        SELECT s.*, u.username 
        FROM translation_suggestions s
        LEFT JOIN users u ON s.user_id = u.id
        WHERE s.machine_name = ? AND s.langcode = ?
        ORDER BY s.created_at DESC
      `, [machine_name, langcode]);
      res.json(rows);
    } catch (error) {
      console.error(`[Suggestions Error] Fetch failed for ${machine_name} in ${langcode}:`, error);
      res.status(500).json({ error: 'Failed to fetch suggestions', details: error.message });
    }
  });

  // Submit a translation suggestion
  router.post('/suggestions/:langcode/:machine_name', authenticateToken, async (req, res) => {
    const { langcode, machine_name } = req.params;
    const { title, summary, body, suggestion_type = 'manual' } = req.body;
    try {
      const [pRows] = await db.execute('SELECT data FROM projects WHERE machine_name = ?', [machine_name]);
      let sourceHash = '';
      if (pRows.length > 0) {
        const item = JSON.parse(pRows[0].data);
        const source = item.attributes.title + (item.attributes.body?.summary || '') + (item.attributes.body?.value || '');
        sourceHash = crypto.createHash('md5').update(source).digest('hex');
      }

      const [result] = await db.execute(`
        INSERT INTO translation_suggestions (machine_name, langcode, title, summary, body, source_hash, user_id, suggestion_type)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
      `, [machine_name, langcode, title, summary, body, sourceHash, req.user.id, suggestion_type]);
      
      res.json({ success: true, id: result.insertId });
    } catch (error) {
      console.error('Save suggestion error:', error);
      res.status(500).json({ error: 'Failed to save suggestion' });
    }
  });

  // Delete suggestion
  router.delete('/suggestions/:id', authenticateToken, async (req, res) => {
    try {
      const [sRows] = await db.execute('SELECT user_id FROM translation_suggestions WHERE id = ?', [req.params.id]);
      if (sRows.length === 0) return res.status(404).json({ error: 'Suggestion not found' });
      
      if (sRows[0].user_id !== req.user.id && req.user.role !== 'admin') {
        return res.status(403).json({ error: 'Not authorized to delete this suggestion' });
      }
      
      await db.execute('DELETE FROM translation_suggestions WHERE id = ?', [req.params.id]);
      res.json({ success: true });
    } catch (error) {
      console.error('Delete suggestion error:', error);
      res.status(500).json({ error: 'Failed to delete suggestion' });
    }
  });

  // Import local project JSONs from Drupal cache
  router.post('/import-local', authenticateToken, isAdmin, async (req, res) => {
    const drupalEnDir = '/var/www/drupalcms/web/sites/default/files/pb_localizer/en';
    if (!await fs.pathExists(drupalEnDir)) return res.status(404).json({ error: 'Local Drupal metadata directory not found' });
    try {
      const files = await fs.readdir(drupalEnDir);
      const jsonFiles = files.filter(f => f.endsWith('.json'));
      for (const file of jsonFiles) {
        const data = await fs.readJson(path.join(drupalEnDir, file));
        const machineName = data.attributes.field_project_machine_name || file.replace('.json', '');
        await fs.copy(path.join(drupalEnDir, file), path.join(METADATA_DIR, file));
        await db.execute('INSERT INTO projects (machine_name, title, data) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE title=VALUES(title), data=VALUES(data)', [machineName, data.attributes.title || machineName, JSON.stringify(data)]);
      }
      res.json({ success: true, count: jsonFiles.length });
    } catch (error) {
      console.error('Import local error:', error);
      res.status(500).json({ error: 'Failed to import local files' });
    }
  });

  // Debug endpoint: serves translations regardless of is_reviewed status.
  // Protected by a shared secret (PB_DEBUG_KEY env var). Intended for
  // contributors who need to preview pending translations before approval.
  router.get('/debug/:langcode/:filename', async (req, res) => {
    const debugKey = process.env.PB_DEBUG_KEY;
    if (!debugKey) {
      return res.status(403).json({ error: 'Debug endpoint is not enabled on this server.' });
    }
    const providedKey = req.headers['x-pb-debug-key'];
    if (!providedKey || !timingSafeEqualStrings(providedKey, debugKey)) {
      return res.status(403).json({ error: 'Invalid or missing debug key.' });
    }

    const { langcode, filename } = req.params;
    const filePath = safeTranslationPath(langcode, filename);
    if (!filePath || !await fs.pathExists(filePath)) {
      // Fall back to DB if no file exists yet.
      const machine_name = filename.replace(/\.json$/, '');
      try {
        const [tRows] = await db.execute(
          'SELECT title, summary, body, screenshot_alts, source_hash, is_reviewed FROM translations WHERE machine_name = ? AND langcode = ?',
          [machine_name, langcode]
        );
        if (tRows.length > 0) {
          const row = tRows[0];
          return res.json({
            machine_name,
            title: row.title,
            body: { value: fixRelativeUrls(row.body || ''), summary: fixRelativeUrls(row.summary || '') },
            screenshot_alts: JSON.parse(row.screenshot_alts || '{}'),
            is_reviewed: row.is_reviewed === 1,
            source_hash: row.source_hash
          });
        }
      } catch (dbErr) {
        console.error('Debug DB lookup error:', dbErr);
      }
      return res.status(404).json({ error: 'File not found' });
    }
    res.sendFile(filePath);
  });

  // Public endpoint for downloading translations (used by Drupal modules client)
  // Guard: skip reserved API prefixes so the wildcard never shadows other routers.
  const RESERVED_PREFIXES = ['admin', 'ai', 'auth', 'sync', 'projects', 'categories', 'debug'];
  router.get('/:langcode/:filename', optionalAuth, async (req, res, next) => {
    const { langcode, filename } = req.params;
    if (RESERVED_PREFIXES.includes(langcode)) return next();
    const filePath = safeTranslationPath(langcode, filename);
    if (!filePath || !await fs.pathExists(filePath)) {
      return res.status(404).json({ error: 'File not found' });
    }

    // categories.json is a UUID→name map (no is_reviewed field) — always public.
    const isPublicFile = filename === 'categories.json';
    if (!req.user && !isPublicFile) {
      try {
        const data = await fs.readJson(filePath);
        if (!data.is_reviewed) {
          return res.status(404).json({ error: 'File not found' });
        }
      } catch (e) {
        return res.status(404).json({ error: 'File not found' });
      }
    }

    res.sendFile(filePath);
  });

  // Restore translations backup archive.
  // Admin-only (was authenticateToken-only — any logged-in translator could
  // restore/overwrite server data), and extracted with adm-zip instead of a
  // shelled-out `unzip`/`tar`, with every archive entry checked to resolve
  // inside DATA_DIR before being written (zip-slip protection).
  router.post('/upload-backup', authenticateToken, isAdmin, upload.single('file'), async (req, res) => {
    if (!req.file) return res.status(400).json({ error: 'No file uploaded' });

    const filePath = req.file.path;
    const originalName = req.file.originalname;
    const extension = path.extname(originalName).toLowerCase();
    const destRoot = path.resolve(DATA_DIR);

    try {
      if (extension === '.zip') {
        const zip = new AdmZip(filePath);
        for (const entry of zip.getEntries()) {
          const target = path.resolve(destRoot, entry.entryName);
          if (target !== destRoot && !target.startsWith(destRoot + path.sep)) {
            await fs.remove(filePath);
            return res.status(400).json({ error: 'Archive contains an entry outside the target directory.' });
          }
        }
        zip.extractAllTo(destRoot, true);
      } else if (extension === '.gz' || extension === '.tgz') {
        // .tar.gz backups are produced by our own backup.sh, not user-uploadable
        // through any other path — kept on tar for that format, but still
        // routed through execFile (no shell) with fixed, non-interpolated args.
        const { execFile } = require('child_process');
        await new Promise((resolve, reject) => {
          execFile('tar', ['-xzf', filePath, '-C', destRoot], (error) => {
            if (error) reject(error); else resolve();
          });
        });
      } else {
        await fs.remove(filePath);
        return res.status(400).json({ error: 'Unsupported file format. Please use .zip or .tar.gz' });
      }

      await fs.remove(filePath);

      // Sanitize extracted content: only .json files are expected, fixed
      // permissions. DATA_DIR itself is a server-side constant (not user
      // input), so this remains injection-safe even though it still shells out.
      const { exec } = require('child_process');
      const sanitationCmd = `find "${destRoot}" -type f -not -name "*.json" -delete && chmod -R 644 "${destRoot}" && find "${destRoot}" -type d -exec chmod 755 {} +`;
      await new Promise((resolve) => {
        exec(sanitationCmd, (sanError) => {
          if (sanError) console.error('Sanitation error:', sanError);
          resolve();
        });
      });

      try {
        const langcodes = await fs.readdir(TRANSLATIONS_DIR);
        let count = 0;
        for (const lang of langcodes) {
          const langPath = path.join(TRANSLATIONS_DIR, lang);
          if (await fs.pathExists(langPath) && (await fs.stat(langPath)).isDirectory()) {
            const files = await fs.readdir(langPath);
            count += files.filter(f => f.endsWith('.json')).length;
          }
        }
        res.json({ success: true, message: 'Backup restored, sanitized and synced', count });
      } catch (syncErr) {
        res.json({ success: true, message: 'Backup extracted and sanitized, but auto-sync report failed' });
      }
    } catch (error) {
      console.error('Backup upload processing error:', error);
      await fs.remove(filePath).catch(() => {});
      res.status(500).json({ error: 'Failed to extract archive' });
    }
  });

  return router;
};
