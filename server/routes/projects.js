const express = require('express');
const axios = require('axios');
const path = require('path');
const fs = require('fs-extra');
const crypto = require('crypto');

const DETAIL_API = 'https://www.drupal.org/jsonapi/node/project_module';

module.exports = (ctx) => {
  const {
    db,
    authenticateToken,
    optionalAuth,
    getFilteredIndex,
    fixDrupalUrl,
    fixRelativeUrls,
    getExcerpt
  } = ctx;
  const router = express.Router();

  const LANGUAGES_FILE = path.join(__dirname, '../languages.json');

  // Fetches remote images server-side and relays them with CORS headers so
  // Flutter web (which uses the browser fetch API) can display cross-origin images.
  router.get('/image-proxy', async (req, res) => {
    const { url } = req.query;
    if (!url || typeof url !== 'string') {
      return res.status(400).json({ error: 'url query parameter required' });
    }

    let parsed;
    try {
      parsed = new URL(url);
    } catch {
      return res.status(400).json({ error: 'Invalid URL' });
    }

    if (!['http:', 'https:'].includes(parsed.protocol)) {
      return res.status(400).json({ error: 'Only http/https URLs are allowed' });
    }

    try {
      const response = await axios.get(url, {
        responseType: 'arraybuffer',
        timeout: 8000,
        headers: {
          'User-Agent': 'Mozilla/5.0 (compatible; PBTranslationHub/1.0; +https://drupal.org)',
          'Accept': 'image/png,image/jpeg,image/svg+xml,image/gif,image/*',
        },
        maxRedirects: 5,
      });

      const contentType = response.headers['content-type'] || 'image/png';
      res.set('Content-Type', contentType);
      res.set('Cache-Control', 'public, max-age=86400'); // 24 h client cache
      res.set('Access-Control-Allow-Origin', '*');
      res.send(Buffer.from(response.data));
    } catch {
      res.status(502).json({ error: 'Failed to fetch image' });
    }
  });

  // Get list of supported languages
  router.get('/languages', async (req, res) => {
    if (await fs.pathExists(LANGUAGES_FILE)) res.json(await fs.readJson(LANGUAGES_FILE));
    else res.status(500).json({ error: 'Languages file missing' });
  });

  // Get paginated list of projects with filters and search
  router.get('/projects', optionalAuth, async (req, res) => {
    console.log(`[${new Date().toISOString()}] GET /api/projects - Query:`, req.query);
    let { search, limit = 50, offset = 0, langcode = 'de', filter = 'all', machine_name, prioritize_drupal11, core_version } = req.query;
    const coreVer = core_version ? parseInt(core_version) : null;
    
    const isExternal = !req.user;
    if (isExternal) {
      filter = 'released';
    }
    
    if (typeof search === 'string') search = search.trim();
    
    let machineNamesArray = null;
    let rawMachineName = machine_name;
    if (!rawMachineName) {
      const keys = Object.keys(req.query).filter(k => k.startsWith('machine_name['));
      if (keys.length > 0) {
        rawMachineName = keys.map(k => req.query[k]);
      }
    }

    if (rawMachineName) {
      if (typeof rawMachineName === 'string') {
        machineNamesArray = rawMachineName.split(',').map(s => s.trim());
      } else if (Array.isArray(rawMachineName)) {
        machineNamesArray = rawMachineName;
      } else if (typeof rawMachineName === 'object') {
        machineNamesArray = Object.values(rawMachineName);
      }
    }
    
    try {
      const paginated = await getFilteredIndex(
        filter,
        search,
        langcode,
        limit,
        offset,
        machineNamesArray,
        prioritize_drupal11 === 'true' || prioritize_drupal11 === true,
        coreVer
      );
      
      let countQuery = `
        SELECT COUNT(*) as total FROM projects p
        WHERE ${filter === 'ignored' ? 'p.machine_name IN (SELECT machine_name FROM ignored_projects)' : 'p.machine_name NOT IN (SELECT machine_name FROM ignored_projects)'}
      `;
      const countParams = [];

      if (filter === 'missing') {
        countQuery += ' AND p.machine_name NOT IN (SELECT machine_name FROM translations WHERE langcode = ?) ';
        countParams.push(langcode);
      } else if (filter === 'translated') {
        countQuery += ' AND p.machine_name IN (SELECT machine_name FROM translations WHERE langcode = ?) ';
        countParams.push(langcode);
      } else if (filter === 'stale') {
        countQuery += ' AND p.machine_name IN (SELECT t.machine_name FROM translations t JOIN projects p2 ON t.machine_name = p2.machine_name WHERE t.langcode = ? AND p2.changed > t.updated_at) ';
        countParams.push(langcode);
      } else if (filter === 'review') {
        countQuery += ' AND p.machine_name IN (SELECT machine_name FROM translations WHERE langcode = ? AND is_reviewed = FALSE) ';
        countParams.push(langcode);
      } else if (filter === 'released') {
        countQuery += ' AND p.machine_name IN (SELECT machine_name FROM translations WHERE langcode = ? AND is_reviewed = TRUE) ';
        countParams.push(langcode);
      } else if (filter === 'priority') {
        countQuery += ' AND p.machine_name IN (SELECT machine_name FROM priority_projects) AND p.machine_name NOT IN (SELECT machine_name FROM translations WHERE langcode = ?) ';
        countParams.push(langcode);
      }

      if (search) {
        countQuery += ' AND (p.machine_name LIKE ? OR p.title LIKE ? OR p.machine_name IN (SELECT machine_name FROM translations WHERE langcode = ? AND title LIKE ?)) ';
        countParams.push(`%${search}%`, `%${search}%`, langcode, `%${search}%`);
      }
      
      if (machineNamesArray && machineNamesArray.length > 0) {
        const placeholders = machineNamesArray.map(() => '?').join(',');
        countQuery += ` AND p.machine_name IN (${placeholders}) `;
        countParams.push(...machineNamesArray);
      }

      if (coreVer !== null) {
        const vMin = coreVer * 1000000;
        const vMax = coreVer * 1000000 + 999999;
        countQuery += ` AND CAST(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.field_core_semver_minimum')) AS UNSIGNED) <= ${vMax}
                        AND CAST(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.field_core_semver_maximum')) AS UNSIGNED) >= ${vMin} `;
      }

      console.log(`[${new Date().toISOString()}] SQL execution finished. Paginated count: ${paginated.length}. Filter: ${filter}`);
      const [countRows] = await db.execute(countQuery, countParams);
      const totalCount = countRows[0].total;
      console.log(`[${new Date().toISOString()}] Total count fetched: ${totalCount} for filter: ${filter}`);
      
      const enrichedData = [];
      let i = 0;
      for (const match of paginated) {
        i++;
        if (i % 10 === 0) console.log(`[${new Date().toISOString()}] Processing record ${i}/${paginated.length}`);
        if (!match.data) continue;
        
        const item = JSON.parse(match.data);
        let status = 'missing';

        if (match.t_title !== null) {
          if (isExternal && match.is_reviewed !== 1) {
            // Serve English source only — no translation overlay
          } else {
            status = 'translated';

            if (match.t_source_hash) {
              const source = item.attributes.title + (item.attributes.body?.summary || '') + (item.attributes.body?.value || '');
              const sourceHash = crypto.createHash('md5').update(source).digest('hex');
              if (match.t_source_hash !== sourceHash) {
                status = 'stale';
              } else {
                status = match.is_reviewed === 1 ? 'released' : 'review';
              }
            } else if (match.p_changed && match.t_updated_at && new Date(match.p_changed) > new Date(match.t_updated_at)) {
              status = 'stale';
            } else if (match.is_reviewed === 1) {
              status = 'released';
            } else {
              status = 'review';
            }

            item.meta = item.meta || {};
            item.meta.translation = {
              title: match.t_title,
              summary: match.t_summary,
              body: match.t_body,
              status: status
            };
          }
        }

        if (!item.attributes.body?.summary && item.attributes.body?.value) {
          item.attributes.body.summary = getExcerpt(item.attributes.body.value);
        }

        if (item.attributes?.body?.summary) {
          item.attributes.body.summary = fixRelativeUrls(item.attributes.body.summary);
        }
        if (item.attributes?.body?.value) {
          item.attributes.body.value = fixRelativeUrls(item.attributes.body.value);
        }
        if (item.meta?.translation?.summary) {
          item.meta.translation.summary = fixRelativeUrls(item.meta.translation.summary);
        }
        if (item.meta?.translation?.body) {
          item.meta.translation.body = fixRelativeUrls(item.meta.translation.body);
        }

        let logoUrl = null;
        if (item.attributes?.field_logo_url?.uri) logoUrl = fixDrupalUrl(item.attributes.field_logo_url.uri);
        else if (item.attributes?.field_project_logo?.uri) logoUrl = fixDrupalUrl(item.attributes.field_project_logo.uri);
        else if (item.meta?.screenshot_urls?.length > 0) logoUrl = item.meta.screenshot_urls[0].url;
        if (!logoUrl) {
          const mn = item.attributes?.field_project_machine_name || match?.machineName;
          if (mn) logoUrl = `https://git.drupalcode.org/project/${mn}/-/avatar`;
        }

        if (!item.attributes.title || item.attributes.title === match.machineName) {
          item.attributes.title = match.title || item.attributes.title;
        }

        item.meta = item.meta || {};
        item.meta.translation_status = status;
        item.meta.logo_url = logoUrl;

        if (item.relationships) {
          delete item.relationships.field_project_images;
        }

        enrichedData.push(item);
      }

      res.json({ 
        data: enrichedData, 
        included: [],
        meta: { count: totalCount },
        jsonapi: { version: "1.0" }
      });
    } catch (error) {
      console.error('Fetch projects list error:', error);
      res.status(500).json({ error: 'Failed to fetch projects' });
    }
  });

  // Get project count by translation status filters
  router.get('/projects/filter-counts', async (req, res) => {
    const { langcode = 'de', core_version } = req.query;
    const coreVer = core_version ? parseInt(core_version) : null;

    // Build an optional SQL snippet that restricts to a specific Drupal core version.
    // field_core_semver_minimum/maximum are stored as integers like 10000000 = 10.0.0.
    let vSnippet = '';
    if (coreVer !== null) {
      const vMin = coreVer * 1000000;
      const vMax = coreVer * 1000000 + 999999;
      vSnippet = ` AND CAST(JSON_UNQUOTE(JSON_EXTRACT(data, '$.attributes.field_core_semver_minimum')) AS UNSIGNED) <= ${vMax}
                   AND CAST(JSON_UNQUOTE(JSON_EXTRACT(data, '$.attributes.field_core_semver_maximum')) AS UNSIGNED) >= ${vMin} `;
    }
    // Same snippet but using table alias 'p'
    let vSnippetP = '';
    if (coreVer !== null) {
      const vMin = coreVer * 1000000;
      const vMax = coreVer * 1000000 + 999999;
      vSnippetP = ` AND CAST(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.field_core_semver_minimum')) AS UNSIGNED) <= ${vMax}
                    AND CAST(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.field_core_semver_maximum')) AS UNSIGNED) >= ${vMin} `;
    }

    try {
      const [[allRes]] = await db.execute(
        `SELECT COUNT(*) as count FROM projects WHERE machine_name NOT IN (SELECT machine_name FROM ignored_projects)${vSnippet}`
      );
      const [[priorityRes]] = await db.execute(
        `SELECT COUNT(*) as count FROM projects WHERE machine_name IN (SELECT machine_name FROM priority_projects) AND machine_name NOT IN (SELECT machine_name FROM translations WHERE langcode = ?) AND machine_name NOT IN (SELECT machine_name FROM ignored_projects)${vSnippet}`,
        [langcode]
      );
      const [[missingRes]] = await db.execute(
        `SELECT COUNT(*) as count FROM projects WHERE machine_name NOT IN (SELECT machine_name FROM translations WHERE langcode = ?) AND machine_name NOT IN (SELECT machine_name FROM ignored_projects)${vSnippet}`,
        [langcode]
      );
      const [[reviewRes]] = await db.execute(
        `SELECT COUNT(*) as count FROM projects WHERE machine_name IN (SELECT machine_name FROM translations WHERE langcode = ? AND is_reviewed = FALSE) AND machine_name NOT IN (SELECT machine_name FROM ignored_projects)${vSnippet}`,
        [langcode]
      );
      const [[releasedRes]] = await db.execute(
        `SELECT COUNT(*) as count FROM projects WHERE machine_name IN (SELECT machine_name FROM translations WHERE langcode = ? AND is_reviewed = TRUE) AND machine_name NOT IN (SELECT machine_name FROM ignored_projects)${vSnippet}`,
        [langcode]
      );
      const [[staleRes]] = await db.execute(
        `SELECT COUNT(*) as count FROM translations t
         JOIN projects p ON t.machine_name = p.machine_name
         WHERE t.langcode = ?
           AND t.source_hash IS NOT NULL AND t.source_hash != ''
           AND MD5(CONCAT(
             IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.title')), ''),
             IFNULL(NULLIF(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.body.summary')), 'null'), ''),
             IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.body.value')), '')
           )) != t.source_hash
           AND t.machine_name NOT IN (SELECT machine_name FROM ignored_projects)${vSnippetP}`,
        [langcode]
      );
      const [[translatedRes]] = await db.execute(
        `SELECT COUNT(*) as count FROM projects WHERE machine_name IN (SELECT machine_name FROM translations WHERE langcode = ?) AND machine_name NOT IN (SELECT machine_name FROM ignored_projects)${vSnippet}`,
        [langcode]
      );
      const [[ignoredRes]] = await db.execute('SELECT COUNT(*) as count FROM ignored_projects');

      // Per-version breakdown for all relevant statuses (unfiltered by core_version,
      // so the version chips always show their totals regardless of current version selection).
      const versions = [9, 10, 11, 12];
      const versionCounts = {};
      for (const v of versions) {
        const vMin = v * 1000000;
        const vMax = v * 1000000 + 999999;
        const vClause = ` AND CAST(JSON_UNQUOTE(JSON_EXTRACT(data, '$.attributes.field_core_semver_minimum')) AS UNSIGNED) <= ${vMax}
                          AND CAST(JSON_UNQUOTE(JSON_EXTRACT(data, '$.attributes.field_core_semver_maximum')) AS UNSIGNED) >= ${vMin} `;
        const vClauseP = ` AND CAST(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.field_core_semver_minimum')) AS UNSIGNED) <= ${vMax}
                           AND CAST(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.field_core_semver_maximum')) AS UNSIGNED) >= ${vMin} `;
        const [[va]] = await db.execute(`SELECT COUNT(*) as c FROM projects WHERE machine_name NOT IN (SELECT machine_name FROM ignored_projects)${vClause}`);
        const [[vm]] = await db.execute(`SELECT COUNT(*) as c FROM projects WHERE machine_name NOT IN (SELECT machine_name FROM translations WHERE langcode = ?) AND machine_name NOT IN (SELECT machine_name FROM ignored_projects)${vClause}`, [langcode]);
        const [[vr]] = await db.execute(`SELECT COUNT(*) as c FROM projects WHERE machine_name IN (SELECT machine_name FROM translations WHERE langcode = ? AND is_reviewed = FALSE) AND machine_name NOT IN (SELECT machine_name FROM ignored_projects)${vClause}`, [langcode]);
        const [[vrel]] = await db.execute(`SELECT COUNT(*) as c FROM projects WHERE machine_name IN (SELECT machine_name FROM translations WHERE langcode = ? AND is_reviewed = TRUE) AND machine_name NOT IN (SELECT machine_name FROM ignored_projects)${vClause}`, [langcode]);
        versionCounts[v] = { all: va.c, missing: vm.c, review: vr.c, released: vrel.c };
      }

      res.json({
        all: allRes.count,
        priority: priorityRes.count,
        missing: missingRes.count,
        review: reviewRes.count,
        released: releasedRes.count,
        stale: staleRes.count,
        translated: translatedRes.count,
        ignored: ignoredRes.count,
        version_counts: versionCounts,
      });
    } catch (error) {
      console.error('Filter counts error:', error);
      res.status(500).json({ error: 'Failed to fetch filter counts' });
    }
  });

  // Get statistics on total projects vs translated projects
  router.get('/stats', async (req, res) => {
    try {
      const [pCount] = await db.execute('SELECT COUNT(*) as total FROM projects WHERE machine_name NOT IN (SELECT machine_name FROM ignored_projects)');
      const [tCount] = await db.execute('SELECT langcode, COUNT(*) as count FROM translations WHERE machine_name NOT IN (SELECT machine_name FROM ignored_projects) GROUP BY langcode');
      
      const translationCounts = {};
      tCount.forEach(r => translationCounts[r.langcode] = r.count);
      
      res.json({
        projects: pCount[0].total,
        translations: translationCounts
      });
    } catch (error) {
      res.status(500).json({ error: 'Failed to fetch stats' });
    }
  });

  // Get detailed project data and its translation overlay
  router.get('/projects/:machine_name', optionalAuth, async (req, res) => {
    const { machine_name } = req.params;
    const { langcode = 'de', filter = 'all', search = '' } = req.query;

    try {
      let item;
      const [pRows] = await db.execute(`
        SELECT 
          p.data,
          t.title as t_title,
          t.summary as t_summary,
          t.body as t_body,
          t.screenshot_alts as t_screenshot_alts,
          t.source_hash as t_source_hash,
          t.updated_at as t_updated_at,
          t.is_reviewed
        FROM projects p
        LEFT JOIN translations t ON p.machine_name = t.machine_name AND t.langcode = ?
        WHERE p.machine_name = ?
      `, [langcode, machine_name]);

      if (pRows.length > 0) {
        item = JSON.parse(pRows[0].data);
        let status = 'missing';

        const isExternal = !req.user;
        const canSeeTranslation = pRows[0].t_title !== null && (!isExternal || pRows[0].is_reviewed === 1);

        if (canSeeTranslation) {
          status = 'translated';
          let isStale = false;
          if (pRows[0].t_source_hash) {
            const source = item.attributes.title + (item.attributes.body?.summary || '') + (item.attributes.body?.value || '');
            const sourceHash = crypto.createHash('md5').update(source).digest('hex');
            if (pRows[0].t_source_hash !== sourceHash) isStale = true;
          }

          if (isStale) {
            status = 'stale';
          } else {
            status = pRows[0].is_reviewed === 1 ? 'released' : 'review';
          }

          item.meta = item.meta || {};
          item.meta.translation = {
            title: pRows[0].t_title,
            summary: pRows[0].t_summary,
            body: pRows[0].t_body,
            screenshot_alts: JSON.parse(pRows[0].t_screenshot_alts || '{}'),
            status: status,
            is_reviewed: pRows[0].is_reviewed === 1
          };
        }
      }

      let included = [];
      if (!item) {
        const response = await axios.get(DETAIL_API, {
          params: { 'filter[field_project_machine_name]': machine_name, 'include': 'field_module_categories,field_maintenance_status,field_development_status,uid,field_project_images' }
        });
        item = response.data.data[0];
        included = response.data.included || [];
      }

      if (!item) return res.status(404).json({ error: 'Project not found' });

      if (item.attributes?.body) {
        if (!item.attributes.body.summary && item.attributes.body.value) {
          item.attributes.body.summary = getExcerpt(item.attributes.body.value);
        }
        if (item.attributes.body.value) {
          item.attributes.body.value = fixRelativeUrls(item.attributes.body.value);
        }
        if (item.attributes.body.summary) {
          item.attributes.body.summary = fixRelativeUrls(item.attributes.body.summary);
        }
      }

      if (item.meta?.translation?.body) {
        item.meta.translation.body = fixRelativeUrls(item.meta.translation.body);
      }
      if (item.meta?.translation?.summary) {
        item.meta.translation.summary = fixRelativeUrls(item.meta.translation.summary);
      }

      let status = item.meta?.translation ? item.meta.translation.status : 'missing';

      let logoUrl = null;
      if (item.attributes?.field_logo_url?.uri) logoUrl = fixDrupalUrl(item.attributes.field_logo_url.uri);
      else if (item.attributes?.field_project_logo?.uri) logoUrl = fixDrupalUrl(item.attributes.field_project_logo.uri);
      else if (item.meta?.screenshot_urls?.length > 0) logoUrl = item.meta.screenshot_urls[0].url;
      if (!logoUrl) {
        const mn = item.attributes?.field_project_machine_name || machine_name;
        if (mn) logoUrl = `https://git.drupalcode.org/project/${mn}/-/avatar`;
      }

      const [ignoredRows] = await db.execute('SELECT 1 FROM ignored_projects WHERE machine_name = ?', [machine_name]);
      const isIgnored = ignoredRows.length > 0;

      item.meta = item.meta || {};
      item.meta.translation_status = status;
      item.meta.logo_url = logoUrl;
      item.meta.is_ignored = isIgnored;

      const filteredIndex = await getFilteredIndex(filter, search, langcode);
      let nextMachineName = null;
      const currentIndex = filteredIndex.findIndex(p => p.machineName === machine_name);
      if (currentIndex !== -1 && currentIndex < filteredIndex.length - 1) nextMachineName = filteredIndex[currentIndex + 1].machineName;
      else if (currentIndex === -1) {
        const nextItem = filteredIndex.find(p => p.machineName.localeCompare(machine_name) > 0);
        if (nextItem) nextMachineName = nextItem.machineName;
      }
      item.meta.next_machine_name = nextMachineName;
      item.meta.filter_count = filteredIndex.length;

      if (langcode) {
        const [revRows] = await db.execute('SELECT COUNT(*) as count FROM translations WHERE langcode = ? AND is_reviewed = FALSE', [langcode]);
        item.meta.review_count = revRows[0].count;
      }

      if (item.relationships && included.length === 0) {
        delete item.relationships.field_project_images;
      }

      res.json({
        data: item,
        included: included
      });
    } catch (error) {
      console.error('Fetch project detail error:', error);
      res.status(500).json({ error: 'Failed to fetch project details' });
    }
  });

  // Ignore a project (permanently hide from review/missing lists)
  router.post('/projects/:machine_name/ignore', authenticateToken, async (req, res) => {
    const { machine_name } = req.params;
    try {
      await db.execute(
        'INSERT INTO ignored_projects (machine_name) VALUES (?) ON DUPLICATE KEY UPDATE machine_name = VALUES(machine_name)',
        [machine_name]
      );
      console.log(`[Projects] Project ignored: ${machine_name}`);
      res.json({ success: true });
    } catch (error) {
      console.error('Ignore project error:', error);
      res.status(500).json({ error: 'Failed to ignore project' });
    }
  });

  // Unignore a project
  router.delete('/projects/:machine_name/ignore', authenticateToken, async (req, res) => {
    const { machine_name } = req.params;
    try {
      await db.execute('DELETE FROM ignored_projects WHERE machine_name = ?', [machine_name]);
      res.json({ success: true });
    } catch (error) {
      res.status(500).json({ error: 'Failed to unignore project' });
    }
  });

  // Unignore all ignored projects at once
  router.delete('/projects/ignore-all', authenticateToken, async (req, res) => {
    try {
      const [result] = await db.execute('DELETE FROM ignored_projects');
      console.log(`[Projects] All ignored projects unignored (${result.affectedRows} rows)`);
      res.json({ success: true, count: result.affectedRows });
    } catch (error) {
      console.error('Unignore-all error:', error);
      res.status(500).json({ error: 'Failed to unignore all projects' });
    }
  });

  // ── Public configuration ─────────────────────────────────────────────────
  // Returns URLs for the help screen tutorial videos.
  // Set HELP_VIDEO_DE and HELP_VIDEO_EN in server/.env to enable the video panel.
  // Accepts both https://youtu.be/<ID> and https://www.youtube.com/watch?v=<ID> formats.
  // Returns null for each key when the env variable is not set.
  router.get('/config/help-videos', (req, res) => {
    res.json({
      de: process.env.HELP_VIDEO_DE || null,
      en: process.env.HELP_VIDEO_EN || null,
    });
  });

  return router;
};
