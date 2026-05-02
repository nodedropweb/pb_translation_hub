const express = require('express');
const axios = require('axios');
const cors = require('cors');
const bodyParser = require('body-parser');
const fs = require('fs-extra');
const path = require('path');
const crypto = require('crypto');
const mysql = require('mysql2/promise');

const db = mysql.createPool({
  host: process.env.DB_HOST || '127.0.0.1',
  user: process.env.DB_USER || 'pb_hub',
  password: process.env.DB_PASSWORD || 'drupal',
  database: process.env.DB_NAME || 'pb_translation_hub',
  waitForConnections: true,
  connectionLimit: parseInt(process.env.DB_CONNECTION_LIMIT) || 100,
  queueLimit: 0
});

const app = express();
const PORT = process.env.PORT || 3001;
const DATA_DIR = path.join(__dirname, 'data');
const METADATA_DIR = path.join(DATA_DIR, 'metadata');
const TRANSLATIONS_DIR = path.join(DATA_DIR, 'translations');
const LANGUAGES_FILE = path.join(__dirname, 'languages.json');
const STATUS_FILE = path.join(DATA_DIR, 'status.json');
const UNSPLASH_ACCESS_KEY = 'z9UkfFm44OVpiQfYrNl1CV9lfTLJEdGD9EGyrYurgr8';

// Ensure directories exist
fs.ensureDirSync(METADATA_DIR);
fs.ensureDirSync(TRANSLATIONS_DIR);

app.use(cors());
app.use(bodyParser.json({ limit: '50mb' }));

// --- Sync State ---
let syncStatus = {
  active: false,
  finished: false,
  current: 0,
  total: 38252, 
  lastMachineName: '',
  error: null,
  shouldStop: false,
  lastFullSync: null
};

// Load last status if exists
if (fs.existsSync(STATUS_FILE)) {
  try {
    const savedStatus = fs.readJsonSync(STATUS_FILE);
    syncStatus = { ...syncStatus, ...savedStatus, active: false };
  } catch (e) {}
}

const saveStatus = () => {
  fs.writeJsonSync(STATUS_FILE, syncStatus);
};

app.get('/', (req, res) => {
  let statusText = 'Idle';
  if (syncStatus.active) statusText = 'Syncing...';
  else if (syncStatus.finished) statusText = 'Finished (Complete)';
  
  res.send(`
    <div style="font-family: sans-serif; padding: 2rem; line-height: 1.6;">
      <h1>PB Translation Hub Backend</h1>
      <p>This is the <strong>API and Mirror Server</strong>.</p>
      <ul>
        <li><strong>Frontend (UI):</strong> <a href="http://localhost:5173">http://localhost:5173</a></li>
        <li><strong>API Status:</strong> Running</li>
        <li><strong>Sync Status:</strong> <span style="color: ${syncStatus.finished ? 'green' : 'inherit'}">${statusText}</span> (${syncStatus.current.toLocaleString()} files)</li>
        <li><strong>Last Sync:</strong> ${syncStatus.lastFullSync || 'Never'}</li>
      </ul>
    </div>
  `);
});

// --- Drupal.org API Constants ---
const DRUPAL_ORG_API = 'https://www.drupal.org/jsonapi/index/project_modules';
const DETAIL_API = 'https://www.drupal.org/jsonapi/node/project_module';
const CATEGORIES_API = 'https://www.drupal.org/jsonapi/taxonomy_term/module_categories';

// --- Helper Functions ---
function fixDrupalUrl(url) {
  if (!url) return null;
  let fixed = url;
  if (fixed.startsWith('public://')) {
    fixed = fixed.replace('public://', '/files/');
  }
  if (!fixed.startsWith('http')) {
    fixed = `https://www.drupal.org${fixed.startsWith('/') ? '' : '/'}${fixed}`;
  }
  return fixed;
}

function fixRelativeUrls(html) {
  if (typeof html !== 'string') return '';
  return html.replace(/src="\/([^"]+)"/g, 'src="https://www.drupal.org/$1"')
             .replace(/href="\/([^"]+)"/g, 'href="https://www.drupal.org/$1"');
}

function stripHtml(html) {
  if (!html) return '';
  return html.replace(/<[^>]*>?/gm, '');
}

function getExcerpt(html, limit = 200) {
  if (typeof html !== 'string') return '';
  const text = stripHtml(html);
  if (text.length <= limit) return text;
  return text.substring(0, limit) + '...';
}

// --- Shared Filtering Logic (SQL version) ---
async function getFilteredIndex(filter, search, langcode) {
  if (search === 'undefined' || search === 'null') search = '';
  if (filter === 'undefined' || filter === 'null') filter = 'all';

  let query = `
    SELECT p.machine_name as machineName, p.title
    FROM projects p
    LEFT JOIN translations t ON p.machine_name = t.machine_name AND t.langcode = ?
    WHERE 1=1
  `;
  const params = [langcode];

  if (search) {
    query += ` AND (p.machine_name LIKE ? OR p.title LIKE ?) `;
    params.push(`%${search}%`, `%${search}%`);
  }

  if (filter === 'missing') {
    query += ` AND t.machine_name IS NULL `;
  } else if (filter === 'translated' || filter === 'stale') {
    query += ` AND t.machine_name IS NOT NULL `;
  }

  if (search) {
    query += `
      ORDER BY 
        CASE 
          WHEN p.machine_name = ? THEN 0
          WHEN p.title = ? THEN 0
          WHEN p.machine_name LIKE ? THEN 1
          WHEN p.title LIKE ? THEN 1
          ELSE 2
        END,
        p.machine_name ASC
    `;
    params.push(search, search, `${search}%`, `${search}%`);
  } else {
    query += ` ORDER BY p.machine_name ASC `;
  }

  const [rows] = await db.execute(query, params);
  return rows;
}

// --- Sync Service ---
async function syncProjects(sinceTimestamp = null) {
  if (syncStatus.active) return;
  
  syncStatus.active = true;
  syncStatus.shouldStop = false;
  syncStatus.error = null;

  if (!sinceTimestamp) {
    try {
      const existingFiles = await fs.readdir(METADATA_DIR);
      if (existingFiles.length > 0 && !syncStatus.finished) {
        const jsonFiles = existingFiles.filter(f => f.endsWith('.json')).sort();
        const lastFile = jsonFiles[jsonFiles.length - 1];
        const lastData = await fs.readJson(path.join(METADATA_DIR, lastFile));
        syncStatus.lastMachineName = lastData.attributes.field_project_machine_name || '';
        syncStatus.current = existingFiles.length;
      } else {
        syncStatus.lastMachineName = '';
        syncStatus.current = 0;
      }
    } catch (err) {
      syncStatus.lastMachineName = '';
      syncStatus.current = 0;
    }
  } else {
    syncStatus.current = 0;
    syncStatus.total = 100; 
  }

  console.log(sinceTimestamp ? `Starting quick update since ${sinceTimestamp}...` : 'Starting full metadata sync...');
  let page = 0;

  while (syncStatus.active && !syncStatus.shouldStop) {
    try {
      const query = {
        'filter[status]': 1,
        'filter[type]': 'project_module',
        'filter[project_type]': 'full',
        'sort': sinceTimestamp ? '-changed' : 'machine_name',
        'page[limit]': 50,
        'include': 'field_module_categories,field_maintenance_status,field_development_status,uid,field_project_images',
      };

      if (sinceTimestamp) {
        query['filter[changed][condition][path]'] = 'changed';
        query['filter[changed][condition][operator]'] = '>';
        query['filter[changed][condition][value]'] = sinceTimestamp;
      } else if (syncStatus.lastMachineName) {
        query['filter[waterfall][condition][path]'] = 'machine_name';
        query['filter[waterfall][condition][operator]'] = '>';
        query['filter[waterfall][condition][value]'] = syncStatus.lastMachineName;
      }

      const response = await axios.get(DRUPAL_ORG_API, { params: query });
      const data = response.data.data;
      const included = response.data.included || [];

      if (!data || data.length === 0) {
        if (!sinceTimestamp) syncStatus.finished = true;
        break;
      }

      if (sinceTimestamp) syncStatus.total = response.data.meta.count || 100;

      const fileMap = {};
      included.forEach(inc => {
        if (inc.type === 'file--file') {
          fileMap[inc.id] = inc.attributes.uri.url;
        }
      });

      for (const item of data) {
        const machineName = item.attributes.field_project_machine_name;
        if (machineName) {
          if (item.relationships?.field_project_images?.data) {
            item.meta = item.meta || {};
            item.meta.screenshot_urls = item.relationships.field_project_images.data.map(img => ({
              id: img.id,
              url: fixDrupalUrl(fileMap[img.id]),
              alt: img.meta?.alt || ''
            })).filter(img => img.url);
          }

          await fs.writeJson(path.join(METADATA_DIR, `${machineName}.json`), item);
          await db.execute(
            'INSERT INTO projects (machine_name, title, data) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE title=VALUES(title), data=VALUES(data)',
            [machineName, item.attributes.title || machineName, JSON.stringify(item)]
          );

          if (!sinceTimestamp) syncStatus.lastMachineName = machineName;
          syncStatus.current++;
        }
      }

      page++;
      saveStatus();
      await new Promise(r => setTimeout(r, 100)); 
    } catch (error) {
      console.error('Sync error:', error.message);
      syncStatus.error = error.message;
      syncStatus.active = false;
    }
  }
  
  if (!syncStatus.shouldStop && !syncStatus.error) {
    syncStatus.lastFullSync = new Date().toISOString();
  }
  
  syncStatus.active = false;
  saveStatus();
  console.log('Sync process finished or stopped.');
}

app.post('/api/sync/project/:machine_name', async (req, res) => {
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
    res.status(500).json({ error: 'Failed to sync project' });
  }
});

// --- API Endpoints ---
app.get('/api/languages', async (req, res) => {
  if (await fs.pathExists(LANGUAGES_FILE)) res.json(await fs.readJson(LANGUAGES_FILE));
  else res.status(500).json({ error: 'Languages file missing' });
});

app.get('/api/sync/status', (req, res) => res.json(syncStatus));

app.post('/api/sync/start', (req, res) => {
  syncProjects();
  res.json({ success: true });
});

app.post('/api/sync/stop', (req, res) => {
  syncStatus.shouldStop = true;
  res.json({ success: true });
});

app.post('/api/sync/quick', (req, res) => {
  const { days = 7 } = req.body;
  const since = Math.floor((Date.now() - (days * 24 * 60 * 60 * 1000)) / 1000);
  syncProjects(since);
  res.json({ success: true });
});

app.get('/api/projects', async (req, res) => {
  const { search, limit = 50, offset = 0, langcode = 'de', filter = 'all' } = req.query;
  try {
    const filteredIndex = await getFilteredIndex(filter, search, langcode);
    const paginated = filteredIndex.slice(parseInt(offset), parseInt(offset) + parseInt(limit));
    
    const enrichedData = [];
    for (const match of paginated) {
      const [pRows] = await db.execute('SELECT data FROM projects WHERE machine_name = ?', [match.machineName]);
      if (pRows.length === 0) continue;
      
      const item = JSON.parse(pRows[0].data);
      const [tRows] = await db.execute('SELECT * FROM translations WHERE machine_name = ? AND langcode = ?', [match.machineName, langcode]);
      let status = 'missing';

      if (tRows.length > 0) {
        status = 'translated';
        const trans = tRows[0];
        const source = item.attributes.title + (item.attributes.body?.summary || '') + (item.attributes.body?.value || '');
        const sourceHash = crypto.createHash('md5').update(source).digest('hex');
        if (trans.source_hash && trans.source_hash !== sourceHash) status = 'stale';

        item.meta = item.meta || {};
        item.meta.translation = { title: trans.title, summary: trans.summary, status: status };
      }

      if (!item.attributes.body?.summary && item.attributes.body?.value) {
        item.attributes.body.summary = getExcerpt(item.attributes.body.value);
      }

      // Robust Logo Resolving
      let logoUrl = null;
      if (item.attributes?.field_logo_url?.uri) logoUrl = fixDrupalUrl(item.attributes.field_logo_url.uri);
      else if (item.attributes?.field_project_logo?.uri) logoUrl = fixDrupalUrl(item.attributes.field_project_logo.uri);
      else if (item.meta?.screenshot_urls?.length > 0) logoUrl = item.meta.screenshot_urls[0].url;

      // Title correction
      if (!item.attributes.title || item.attributes.title === match.machineName) {
        item.attributes.title = match.title || item.attributes.title;
      }

      item.meta = item.meta || {};
      item.meta.translation_status = status;
      item.meta.logo_url = logoUrl;
      enrichedData.push(item);
    }

    res.json({ data: enrichedData, meta: { count: filteredIndex.length } });
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch projects' });
  }
});

app.get('/api/projects/:machine_name', async (req, res) => {
  const { machine_name } = req.params;
  const { langcode = 'de', filter = 'all', search = '' } = req.query;

  try {
    let item;
    const [pRows] = await db.execute('SELECT data FROM projects WHERE machine_name = ?', [machine_name]);
    if (pRows.length > 0) {
      item = JSON.parse(pRows[0].data);
    } else {
      const response = await axios.get(DETAIL_API, {
        params: { 'filter[field_project_machine_name]': machine_name, 'include': 'field_module_categories,field_maintenance_status,field_development_status,uid,field_project_images' }
      });
      item = response.data.data[0];
    }

    if (!item) return res.status(404).json({ error: 'Project not found' });

    const [tRows] = await db.execute('SELECT * FROM translations WHERE machine_name = ? AND langcode = ?', [machine_name, langcode]);
    let status = 'missing';

    if (tRows.length > 0) {
      status = 'translated';
      const trans = tRows[0];
      const source = item.attributes.title + (item.attributes.body?.summary || '') + (item.attributes.body?.value || '');
      const sourceHash = crypto.createHash('md5').update(source).digest('hex');
      if (trans.source_hash && trans.source_hash !== sourceHash) status = 'stale';

      item.meta = item.meta || {};
      item.meta.translation = {
        title: trans.title,
        summary: trans.summary,
        body: trans.body,
        screenshot_alts: JSON.parse(trans.screenshot_alts || '{}'),
        status: status
      };
    }

    let logoUrl = null;
    if (item.attributes?.field_logo_url?.uri) logoUrl = fixDrupalUrl(item.attributes.field_logo_url.uri);
    else if (item.attributes?.field_project_logo?.uri) logoUrl = fixDrupalUrl(item.attributes.field_project_logo.uri);
    else if (item.meta?.screenshot_urls?.length > 0) logoUrl = item.meta.screenshot_urls[0].url;

    item.meta = item.meta || {};
    item.meta.translation_status = status;
    item.meta.logo_url = logoUrl;

    const filteredIndex = await getFilteredIndex(filter, search, langcode);
    let nextMachineName = null;
    const currentIndex = filteredIndex.findIndex(p => p.machineName === machine_name);
    if (currentIndex !== -1 && currentIndex < filteredIndex.length - 1) nextMachineName = filteredIndex[currentIndex + 1].machineName;
    else if (currentIndex === -1) {
      const nextItem = filteredIndex.find(p => p.machineName.localeCompare(machine_name) > 0);
      if (nextItem) nextMachineName = nextItem.machineName;
    }
    item.meta.next_machine_name = nextMachineName;

    if (item.attributes?.body) {
      if (item.attributes.body.value) item.attributes.body.value = fixRelativeUrls(item.attributes.body.value);
      if (item.attributes.body.processed) item.attributes.body.processed = fixRelativeUrls(item.attributes.body.processed);
    }
    
    res.json(item);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch project details' });
  }
});

app.get('/api/autocomplete', async (req, res) => {
  const { q, langcode = 'de' } = req.query;
  if (!q || q.length < 2) return res.json([]);
  try {
    const [rows] = await db.execute(`
      SELECT p.machine_name, p.title, t.title as t_title
      FROM projects p
      LEFT JOIN translations t ON p.machine_name = t.machine_name AND t.langcode = ?
      WHERE p.machine_name LIKE ? OR p.title LIKE ?
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
    `, [langcode, `%${q}%`, `%${q}%`, q, q, `${q}%`, `${q}%`]);
    res.json(rows.map(r => ({ machine_name: r.machine_name, title: r.t_title || r.title })));
  } catch (error) {
    res.status(500).json({ error: 'Autocomplete failed' });
  }
});

app.get('/api/categories', async (req, res) => {
  const { langcode = 'de' } = req.query;
  try {
    const response = await axios.get(CATEGORIES_API, { params: { 'sort': 'name', 'filter[status]': 1, 'fields[taxonomy_term--module_categories]': 'name' } });
    const transPath = path.join(TRANSLATIONS_DIR, langcode, 'categories.json');
    let trans = {};
    if (await fs.pathExists(transPath)) trans = await fs.readJson(transPath);
    for (let item of response.data.data) {
      item.meta = item.meta || {};
      item.meta.translated_name = trans[item.id] || null;
    }
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch categories' });
  }
});

app.post('/api/categories/translate', async (req, res) => {
  const { langcode = 'de', translations } = req.body;
  const transPath = path.join(TRANSLATIONS_DIR, langcode, 'categories.json');
  try {
    let existing = {};
    if (await fs.pathExists(transPath)) existing = await fs.readJson(transPath);
    await fs.writeJson(transPath, { ...existing, ...translations }, { spaces: 4 });
    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ error: 'Failed to save category translations' });
  }
});

app.post('/api/categories/import-local', async (req, res) => {
  const { langcode = 'de' } = req.body;
  const sourcePath = `/var/www/drupalcms/web/sites/default/files/pb_localizer/${langcode}/categories.json`;
  const targetPath = path.join(TRANSLATIONS_DIR, langcode, 'categories.json');
  try {
    if (!await fs.pathExists(sourcePath)) return res.status(404).json({ error: 'Source file not found' });
    const sourceData = await fs.readJson(sourcePath);
    let targetData = {};
    if (await fs.pathExists(targetPath)) targetData = await fs.readJson(targetPath);
    await fs.writeJson(targetPath, { ...targetData, ...sourceData }, { spaces: 4 });
    res.json({ success: true, count: Object.keys(sourceData).length });
  } catch (error) {
    res.status(500).json({ error: 'Failed to import categories' });
  }
});

app.get('/api/translations/:langcode/:machine_name', async (req, res) => {
  const { langcode, machine_name } = req.params;
  const filePath = path.join(TRANSLATIONS_DIR, langcode, `${machine_name}.json`);
  if (await fs.pathExists(filePath)) res.json(await fs.readJson(filePath));
  else res.status(404).json({ error: 'Not found' });
});

app.post('/api/translations/:langcode/:machine_name', async (req, res) => {
  const { langcode, machine_name } = req.params;
  const { title, summary, body, screenshot_alts } = req.body;
  try {
    const [pRows] = await db.execute('SELECT data FROM projects WHERE machine_name = ?', [machine_name]);
    let sourceHash = '';
    if (pRows.length > 0) {
      const item = JSON.parse(pRows[0].data);
      const source = item.attributes.title + (item.attributes.body?.summary || '') + (item.attributes.body?.value || '');
      sourceHash = crypto.createHash('md5').update(source).digest('hex');
    }
    const translationData = { machine_name, title, body: { value: body, summary: summary }, screenshot_alts, reviewed: false, source_hash: sourceHash, updated: Math.floor(Date.now() / 1000) };
    await db.execute(`INSERT INTO translations (machine_name, langcode, title, summary, body, screenshot_alts, source_hash) VALUES (?, ?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE title=VALUES(title), summary=VALUES(summary), body=VALUES(body), screenshot_alts=VALUES(screenshot_alts), source_hash=VALUES(source_hash)`, [machine_name, langcode, title, summary, body, JSON.stringify(screenshot_alts), sourceHash]);
    await fs.ensureDir(path.join(TRANSLATIONS_DIR, langcode));
    await fs.writeJson(path.join(TRANSLATIONS_DIR, langcode, `${machine_name}.json`), translationData, { spaces: 2 });
    res.json({ success: true, source_hash: sourceHash });
  } catch (error) {
    res.status(500).json({ error: 'Failed to save translation' });
  }
});

app.post('/api/import-local', async (req, res) => {
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
    res.status(500).json({ error: 'Failed to import local files' });
  }
});

app.get('/:langcode/:filename', async (req, res) => {
  const { langcode, filename } = req.params;
  const filePath = path.join(TRANSLATIONS_DIR, langcode, filename);
  if (await fs.pathExists(filePath)) res.sendFile(filePath);
  else res.status(404).json({ error: 'File not found' });
});

app.get('/api/unsplash/random-bg', async (req, res) => {
  try {
    const response = await axios.get('https://api.unsplash.com/photos/random', { params: { query: 'nature,forest,dark', orientation: 'landscape', client_id: UNSPLASH_ACCESS_KEY } });
    res.json({ url: response.data.urls.regular });
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch image' });
  }
});

app.listen(PORT, () => {
  console.log(`PB Translation Hub Backend running on http://localhost:${PORT}`);
});
