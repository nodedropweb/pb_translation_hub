const express = require('express');
const axios = require('axios');
const path = require('path');
const fs = require('fs-extra');

const CATEGORIES_API = 'https://www.drupal.org/jsonapi/taxonomy_term/module_categories';

// Storage filename for category UUID→name translations.
// Uses underscore prefix so it can never collide with a Drupal module
// machine name (which would be stored as plain "categories.json").
const CAT_FILENAME = '_categories.json';

/**
 * Resolves the path to the category translations file for a given language.
 * Falls back to the legacy 'categories.json' if the new file doesn't exist yet
 * AND the legacy file looks like a UUID→name map (i.e. has no 'machine_name' key).
 */
async function catTransPath(translationsDir, langcode) {
  const newPath = path.join(translationsDir, langcode, CAT_FILENAME);
  if (await fs.pathExists(newPath)) return newPath;

  // Legacy fallback: migrate old categories.json if it holds UUID→name data.
  const legacyPath = path.join(translationsDir, langcode, 'categories.json');
  if (await fs.pathExists(legacyPath)) {
    try {
      const data = await fs.readJson(legacyPath);
      if (typeof data === 'object' && data !== null && !('machine_name' in data)) {
        // Looks like a valid UUID→name map — migrate it.
        await fs.writeJson(newPath, data, { spaces: 4 });
        console.log(`[categories] Migrated legacy categories.json → ${CAT_FILENAME} for ${langcode}`);
        return newPath;
      }
    } catch (_) { /* ignore corrupt file */ }
  }

  return newPath; // return the new path even if it doesn't exist yet
}

module.exports = (ctx) => {
  const {
    db,
    authenticateToken,
    TRANSLATIONS_DIR
  } = ctx;
  const router = express.Router();

  // Autocomplete projects query
  router.get('/autocomplete', async (req, res) => {
    const { q, langcode = 'de', filter } = req.query;
    if (!q || q.length < 2) return res.json([]);
    try {
      let sql = `
        SELECT p.machine_name, p.title, p.changed as p_changed,
               t.title as t_title, t.updated_at as t_updated_at
        FROM projects p
        LEFT JOIN translations t ON p.machine_name = t.machine_name AND t.langcode = ?
        WHERE (p.machine_name LIKE ? OR p.title LIKE ?)
      `;
      
      const params = [langcode, `%${q}%`, `%${q}%` ];

      if (filter === 'translated') {
        sql += ` AND t.machine_name IS NOT NULL `;
      }

      sql += `
        ORDER BY 
          CASE 
            WHEN p.machine_name = ? THEN 0
            WHEN p.title = ? THEN 0
            WHEN p.machine_name LIKE ? THEN 1
            WHEN p.title LIKE ? THEN 1
            ELSE 2
          END,
          p.machine_name ASC
        LIMIT 10
      `;
      params.push(q, q, `${q}%`, `${q}%`);

      const [rows] = await db.execute(sql, params);
      
      const results = rows.map(r => {
        let status = 'missing';
        if (r.t_updated_at) {
          status = 'translated';
          if (r.p_changed && new Date(r.t_updated_at * 1000) < new Date(r.p_changed * 1000)) {
            status = 'stale';
          }
        }
        return { 
          machine_name: r.machine_name, 
          title: r.t_title || r.title,
          status: status
        };
      });
      
      res.json(results);
    } catch (error) {
      console.error('Autocomplete error:', error);
      res.status(500).json({ error: 'Autocomplete failed' });
    }
  });

  // Get categories taxonomy terms and local translation overlay
  router.get('/categories', async (req, res) => {
    const { langcode = 'de' } = req.query;
    try {
      const response = await axios.get(CATEGORIES_API, { params: { 'sort': 'name', 'filter[status]': 1, 'fields[taxonomy_term--module_categories]': 'name' } });
      const transPath = await catTransPath(TRANSLATIONS_DIR, langcode);
      let trans = {};
      if (await fs.pathExists(transPath)) trans = await fs.readJson(transPath);
      for (let item of response.data.data) {
        item.meta = item.meta || {};
        item.meta.translated_name = trans[item.id] || null;
      }
      res.json(response.data);
    } catch (error) {
      console.error('Fetch categories error:', error);
      res.status(500).json({ error: 'Failed to fetch categories' });
    }
  });

  // Public endpoint: returns the raw UUID→translated-name map for a language.
  // Used by pb_localizer's ProxyManager::syncCategoryTranslations() to build
  // a local cache — avoids the drupal.org round-trip on every request.
  router.get('/categories/names', async (req, res) => {
    const { langcode = 'de' } = req.query;
    const transPath = await catTransPath(TRANSLATIONS_DIR, langcode);
    if (!await fs.pathExists(transPath)) {
      return res.status(404).json({ error: 'No category translations found for this language' });
    }
    try {
      const data = await fs.readJson(transPath);
      res.json(data);
    } catch (error) {
      console.error('Fetch category names error:', error);
      res.status(500).json({ error: 'Failed to read category translations' });
    }
  });

  // Submit category translations
  router.post('/categories/translate', authenticateToken, async (req, res) => {
    const { langcode = 'de', translations } = req.body;
    const transPath = await catTransPath(TRANSLATIONS_DIR, langcode);
    try {
      let existing = {};
      if (await fs.pathExists(transPath)) existing = await fs.readJson(transPath);
      await fs.writeJson(transPath, { ...existing, ...translations }, { spaces: 4 });
      res.json({ success: true });
    } catch (error) {
      console.error('Save category translations error:', error);
      res.status(500).json({ error: 'Failed to save category translations' });
    }
  });

  // Import local categories translations from Drupal cache
  router.post('/categories/import-local', async (req, res) => {
    const { langcode = 'de' } = req.body;
    const sourcePath = `/var/www/drupalcms/web/sites/default/files/pb_localizer/${langcode}/categories.json`;
    const targetPath = await catTransPath(TRANSLATIONS_DIR, langcode);
    try {
      if (!await fs.pathExists(sourcePath)) return res.status(404).json({ error: 'Source file not found' });
      const sourceData = await fs.readJson(sourcePath);
      let targetData = {};
      if (await fs.pathExists(targetPath)) targetData = await fs.readJson(targetPath);
      await fs.writeJson(targetPath, { ...targetData, ...sourceData }, { spaces: 4 });
      res.json({ success: true, count: Object.keys(sourceData).length });
    } catch (error) {
      console.error('Import categories error:', error);
      res.status(500).json({ error: 'Failed to import categories' });
    }
  });

  return router;
};
