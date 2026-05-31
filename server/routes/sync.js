const express = require('express');
const axios = require('axios');
const path = require('path');
const fs = require('fs-extra');

const DETAIL_API = 'https://www.drupal.org/jsonapi/node/project_module';

module.exports = (ctx) => {
  const {
    db,
    authenticateToken,
    syncStatus,
    syncProjects,
    DATA_DIR,
    METADATA_DIR,
    TRANSLATIONS_DIR,
    fixDrupalUrl
  } = ctx;
  const router = express.Router();

  // Sync a single project details by machine name
  router.post('/sync/project/:machine_name', async (req, res) => {
    const { machine_name } = req.params;
    try {
      const query = {
        'filter[field_project_machine_name]': machine_name,
        'include': 'field_module_categories,field_maintenance_status,field_development_status,uid,field_project_images',
      };

      const response = await axios.get(DETAIL_API, { params: query });
      const item = response.data.data[0];
      const included = response.data.included || [];

      if (!item) return res.status(404).json({ error: 'Project not found on Drupal.org' });

      const fileMap = {};
      included.forEach(inc => {
        if (inc.type === 'file--file') fileMap[inc.id] = inc.attributes.uri.url;
      });

      if (item.relationships?.field_project_images?.data) {
        item.meta = item.meta || {};
        item.meta.screenshot_urls = item.relationships.field_project_images.data.map(img => ({
          id: img.id,
          url: fixDrupalUrl(fileMap[img.id]),
          alt: img.meta?.alt || ''
        })).filter(img => img.url);
      }

      await fs.writeJson(path.join(METADATA_DIR, `${machine_name}.json`), item);
      await db.execute(
        'INSERT INTO projects (machine_name, title, data) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE title=VALUES(title), data=VALUES(data)',
        [machine_name, item.attributes.title || machine_name, JSON.stringify(item)]
      );

      res.json({ success: true, title: item.attributes.title });
    } catch (error) {
      console.error('Failed to sync single project:', error);
      res.status(500).json({ error: 'Failed to sync project' });
    }
  });

  // Get current sync status
  router.get('/sync/status', (req, res) => res.json(syncStatus));

  // Start background sync
  router.post('/sync/start', authenticateToken, (req, res) => {
    syncProjects();
    res.json({ success: true });
  });

  // Stop background sync
  router.post('/sync/stop', authenticateToken, (req, res) => {
    syncStatus.shouldStop = true;
    res.json({ success: true });
  });

  // Sync translations from local JSON backup files to the DB
  router.post('/sync/translations', authenticateToken, async (req, res) => {
    try {
      const langcodes = await fs.readdir(TRANSLATIONS_DIR);
      let synced = 0;
      for (const langcode of langcodes) {
        const langPath = path.join(TRANSLATIONS_DIR, langcode);
        const stat = await fs.stat(langPath);
        if (!stat.isDirectory()) continue;

        const files = await fs.readdir(langPath);
        for (const file of files) {
          if (!file.endsWith('.json')) continue;
          const machine_name = file.replace('.json', '');
          const data = await fs.readJson(path.join(langPath, file));
          
          const title = data.title || '';
          let summary = '';
          let body = '';
          if (typeof data.body === 'object' && data.body !== null) {
            summary = data.body.summary || '';
            body = data.body.value || '';
          } else {
            summary = data.summary || '';
            body = data.body || '';
          }
          
          const screenshot_alts = JSON.stringify(data.screenshot_alts || {});
          const source_hash = data.source_hash || '';
          const is_reviewed_file = data.is_reviewed === true ? 1 : 0;

          await db.execute(`
            INSERT INTO translations (machine_name, langcode, title, summary, body, screenshot_alts, source_hash, is_reviewed)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            ON DUPLICATE KEY UPDATE
              title=VALUES(title),
              summary=VALUES(summary),
              body=VALUES(body),
              screenshot_alts=VALUES(screenshot_alts),
              source_hash=VALUES(source_hash),
              is_reviewed=GREATEST(VALUES(is_reviewed), is_reviewed)
          `, [machine_name, langcode, title, summary, body, screenshot_alts, source_hash, is_reviewed_file]);
          synced++;
        }
      }
      res.json({ success: true, count: synced });
    } catch (error) {
      console.error('Translation sync error:', error);
      res.status(500).json({ error: 'Failed to sync translations' });
    }
  });

  // Start quick sync (for recently changed modules)
  router.post('/sync/quick', (req, res) => {
    const { days = 7 } = req.body;
    const since = Math.floor((Date.now() - (days * 24 * 60 * 60 * 1000)) / 1000);
    syncProjects(since);
    res.json({ success: true });
  });

  // Sync priority list of modules from static JSON file
  router.post('/sync/priority', authenticateToken, async (req, res) => {
    const priorityFile = path.join(DATA_DIR, 'drupal11_projects.json');
    if (!await fs.pathExists(priorityFile)) {
      return res.status(404).json({ error: 'Priority list file not found' });
    }

    try {
      console.log(`[${new Date().toISOString()}] Starting priority sync from ${priorityFile}`);
      let machineNames = await fs.readJson(priorityFile);
      if (!Array.isArray(machineNames)) {
        throw new Error('JSON content is not an array');
      }
      
      machineNames = [...new Set(machineNames)];
      
      await db.execute("DELETE FROM priority_projects WHERE list_name = 'drupal11'");
      
      const batchSize = 500;
      for (let i = 0; i < machineNames.length; i += batchSize) {
        const batch = machineNames.slice(i, i + batchSize);
        const values = batch.map(name => `('${name.replace(/'/g, "''")}', 'drupal11')`).join(',');
        await db.execute(`INSERT IGNORE INTO priority_projects (machine_name, list_name) VALUES ${values}`);
      }
      
      res.json({ success: true, count: machineNames.length });
    } catch (error) {
      console.error('Priority sync error:', error);
      res.status(500).json({ error: 'Failed to sync priority list: ' + error.message });
    }
  });

  return router;
};
