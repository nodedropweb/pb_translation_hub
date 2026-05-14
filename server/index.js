const express = require('express');
const axios = require('axios');
const cors = require('cors');
const bodyParser = require('body-parser');
const fs = require('fs-extra');
const path = require('path');
const crypto = require('crypto');
const mysql = require('mysql2/promise');
const multer = require('multer');
const { exec } = require('child_process');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'pb-hub-super-secret-key-2026';

const upload = multer({ dest: 'uploads/' });
const avatarStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    const dir = path.join(__dirname, 'uploads/avatars');
    fs.ensureDirSync(dir);
    cb(null, dir);
  },
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname);
    cb(null, `avatar-${Date.now()}${ext}`);
  }
});
const uploadAvatar = multer({ 
  storage: avatarStorage,
  limits: { fileSize: 2 * 1024 * 1024 }, // 2MB limit
  fileFilter: (req, file, cb) => {
    if (file.mimetype.startsWith('image/')) cb(null, true);
    else cb(new Error('Only images are allowed'));
  }
});

// Middleware to authenticate JWT
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  
  if (!token) return res.status(401).json({ error: 'Access denied. No token provided.' });
  
  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) return res.status(403).json({ error: 'Invalid or expired token.' });
    req.user = user;
    next();
  });
};

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
const PORT = process.env.PORT || 9901;
const DATA_DIR = path.join(__dirname, 'data');
const METADATA_DIR = path.join(DATA_DIR, 'metadata');
const TRANSLATIONS_DIR = path.join(DATA_DIR, 'translations');
const LANGUAGES_FILE = path.join(__dirname, 'languages.json');
const STATUS_FILE = path.join(DATA_DIR, 'status.json');
const UNSPLASH_ACCESS_KEY = 'z9UkfFm44OVpiQfYrNl1CV9lfTLJEdGD9EGyrYurgr8';

// Ensure directories exist
fs.ensureDirSync(METADATA_DIR);
fs.ensureDirSync(TRANSLATIONS_DIR);
fs.ensureDirSync(path.join(__dirname, 'uploads'));

app.use(cors());
app.use(bodyParser.json({ limit: '50mb' }));
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

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
  // Fix paths starting with / or directly with sites/files/etc.
  return html.replace(/(src|href)=["']\/(sites|files|core|themes|modules)\/([^"']+)["']/g, '$1="https://www.drupal.org/$2/$3"')
             .replace(/(src|href)=["'](sites|files|core|themes|modules)\/([^"']+)["']/g, '$1="https://www.drupal.org/$2/$3"');
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
async function getFilteredIndex(filter, search, langcode, limit = null, offset = 0, machine_names = null) {
  if (search === 'undefined' || search === 'null') search = '';
  if (typeof search === 'string') search = search.trim();
  if (filter === 'undefined' || filter === 'null' || typeof filter === 'object') filter = 'all';

  let query = `
    SELECT 
      p.machine_name as machineName, 
      p.title, 
      p.data,
      t.title as t_title,
      t.summary as t_summary,
      t.body as t_body,
      t.tags as t_tags,
      t.source_hash as t_source_hash,
      t.updated_at as t_updated_at,
      p.changed as p_changed
    FROM projects p
    LEFT JOIN translations t ON p.machine_name = t.machine_name AND t.langcode = ?
    WHERE 1=1
  `;
  const params = [langcode];

  if (Array.isArray(machine_names) && machine_names.length > 0) {
    const placeholders = machine_names.map(() => '?').join(',');
    query += ` AND p.machine_name IN (${placeholders}) `;
    params.push(...machine_names);
  }

  if (search) {
    // Optimized search: Search in projects and translations separately and combine.
    // This is much faster than a LEFT JOIN with multiple LIKE OR conditions.
    query += ` AND (
      p.machine_name LIKE ? OR 
      p.title LIKE ? OR 
      p.machine_name IN (SELECT machine_name FROM translations WHERE langcode = ? AND (title LIKE ? OR tags LIKE ?))
    ) `;
    params.push(`%${search}%`, `%${search}%`, langcode, `%${search}%`, `%${search}%`);
  }

  if (filter === 'missing') {
    query += ` AND t.machine_name IS NULL `;
  } else if (filter === 'translated') {
    query += ` AND t.machine_name IS NOT NULL `;
  } else if (filter === 'stale') {
    query += ` AND t.machine_name IS NOT NULL AND p.changed > t.updated_at `;
  } else if (filter === 'review') {
    query += ` AND t.machine_name IS NOT NULL AND t.is_reviewed = FALSE `;
  } else if (filter === 'priority') {
    query += ` AND p.machine_name IN (SELECT machine_name FROM priority_projects) AND t.machine_name IS NULL `;
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

  if (limit !== null) {
    query += ` LIMIT ? OFFSET ? `;
    params.push(parseInt(limit), parseInt(offset));
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
            'INSERT INTO projects (machine_name, title, data, changed) VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE title=VALUES(title), data=VALUES(data), changed=VALUES(changed)',
            [machineName, item.attributes.title || machineName, JSON.stringify(item), item.attributes.changed || null]
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

app.post('/api/sync/start', authenticateToken, (req, res) => {
  syncProjects();
  res.json({ success: true });
});

app.post('/api/sync/stop', authenticateToken, (req, res) => {
  syncStatus.shouldStop = true;
  res.json({ success: true });
});

app.post('/api/sync/translations', authenticateToken, async (req, res) => {
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
        const tags = data.tags || '';

        await db.execute(`
          INSERT INTO translations (machine_name, langcode, title, summary, body, screenshot_alts, tags, source_hash) 
          VALUES (?, ?, ?, ?, ?, ?, ?, ?) 
          ON DUPLICATE KEY UPDATE 
            title=VALUES(title), 
            summary=VALUES(summary), 
            body=VALUES(body), 
            screenshot_alts=VALUES(screenshot_alts), 
            tags=VALUES(tags),
            source_hash=VALUES(source_hash)
        `, [machine_name, langcode, title, summary, body, screenshot_alts, tags, source_hash]);
        synced++;
      }
    }
    res.json({ success: true, count: synced });
  } catch (error) {
    console.error('Translation sync error:', error);
    res.status(500).json({ error: 'Failed to sync translations' });
  }
});

app.post('/api/sync/quick', (req, res) => {
  const { days = 7 } = req.body;
  const since = Math.floor((Date.now() - (days * 24 * 60 * 60 * 1000)) / 1000);
  syncProjects(since);
  res.json({ success: true });
});

app.post('/api/sync/priority', authenticateToken, async (req, res) => {
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
    
    // Deduplicate
    machineNames = [...new Set(machineNames)];
    
    // Clear existing priority list (for 'drupal11')
    await db.execute("DELETE FROM priority_projects WHERE list_name = 'drupal11'");
    
    // Insert in batches of 500
    const batchSize = 500;
    for (let i = 0; i < machineNames.length; i += batchSize) {
      const batch = machineNames.slice(i, i + batchSize);
      // Use INSERT IGNORE to skip duplicates just in case
      const values = batch.map(name => `('${name.replace(/'/g, "''")}', 'drupal11')`).join(',');
      await db.execute(`INSERT IGNORE INTO priority_projects (machine_name, list_name) VALUES ${values}`);
    }
    
    res.json({ success: true, count: machineNames.length });
  } catch (error) {
    console.error('Priority sync error:', error);
    res.status(500).json({ error: 'Failed to sync priority list: ' + error.message });
  }
});

app.get('/api/projects', async (req, res) => {
  console.log(`[${new Date().toISOString()}] GET /api/projects - Query:`, req.query);
  let { search, limit = 50, offset = 0, langcode = 'de', filter = 'all', machine_name } = req.query;
  if (typeof search === 'string') search = search.trim();
  
  // Robust machine_name parsing
  let machineNamesArray = null;
  
  // Try to find machine_name in various formats
  let rawMachineName = machine_name;
  if (!rawMachineName) {
    // Check for machine_name[0], machine_name[1] etc. if query parser is not extended
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
    const paginated = await getFilteredIndex(filter, search, langcode, limit, offset, machineNamesArray);
    
    // For pagination, we need the total count.
    let countQuery = `
      SELECT COUNT(*) as total FROM projects p
      WHERE 1=1 
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
    } else if (filter === 'priority') {
      countQuery += ' AND p.machine_name IN (SELECT machine_name FROM priority_projects) AND p.machine_name NOT IN (SELECT machine_name FROM translations WHERE langcode = ?) ';
      countParams.push(langcode);
    }

    if (search) {
      countQuery += ' AND (p.machine_name LIKE ? OR p.title LIKE ? OR p.machine_name IN (SELECT machine_name FROM translations WHERE langcode = ? AND (title LIKE ? OR tags LIKE ?))) ';
      countParams.push(`%${search}%`, `%${search}%`, langcode, `%${search}%`, `%${search}%`);
    }
    
    if (machineNamesArray && machineNamesArray.length > 0) {
      const placeholders = machineNamesArray.map(() => '?').join(',');
      countQuery += ` AND p.machine_name IN (${placeholders}) `;
      countParams.push(...machineNamesArray);
    }

    console.log(`[${new Date().toISOString()}] SQL execution finished. Paginated count: ${paginated.length}`);
    const [countRows] = await db.execute(countQuery, countParams);
    const totalCount = countRows[0].total;
    console.log(`[${new Date().toISOString()}] Total count fetched: ${totalCount}`);
    
    const enrichedData = [];
    let i = 0;
    for (const match of paginated) {
      i++;
      if (i % 10 === 0) console.log(`[${new Date().toISOString()}] Processing record ${i}/${paginated.length}`);
      if (!match.data) continue;
      
      const item = JSON.parse(match.data);
      let status = 'missing';

      if (match.t_title !== null) {
        status = 'translated';
        
        // Accurate MD5 stale check even in the list view (it's only 50-100 items, so it's fast enough)
        if (match.t_source_hash) {
          const source = item.attributes.title + (item.attributes.body?.summary || '') + (item.attributes.body?.value || '');
          const sourceHash = crypto.createHash('md5').update(source).digest('hex');
          if (match.t_source_hash !== sourceHash) {
            status = 'stale';
          }
        } else if (match.p_changed && match.t_updated_at && new Date(match.p_changed) > new Date(match.t_updated_at)) {
          // Fallback to timestamp if hash is missing
          status = 'stale';
        }
        
        item.meta = item.meta || {};
        item.meta.translation = { 
          title: match.t_title, 
          summary: match.t_summary, 
          body: match.t_body, 
          status: status 
        };
      }

      if (!item.attributes.body?.summary && item.attributes.body?.value) {
        item.attributes.body.summary = getExcerpt(item.attributes.body.value);
      }

      // Fix relative URLs in summaries and bodies
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

      // Clean up relationships to avoid crashes in Drupal if included data is missing
      if (item.relationships) {
        // We only remove them if we are in the list view (no included data)
        delete item.relationships.field_project_images;
        // Keep field_logo_url as it often has the URI directly in attributes in some versions
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
    res.status(500).json({ error: 'Failed to fetch projects' });
  }
});

app.get('/api/stats', async (req, res) => {
  try {
    const [pCount] = await db.execute('SELECT COUNT(*) as total FROM projects');
    const [tCount] = await db.execute('SELECT langcode, COUNT(*) as count FROM translations GROUP BY langcode');
    
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

app.get('/api/projects/:machine_name', async (req, res) => {
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
        t.tags as t_tags,
        t.source_hash as t_source_hash,
        t.updated_at as t_updated_at
      FROM projects p
      LEFT JOIN translations t ON p.machine_name = t.machine_name AND t.langcode = ?
      WHERE p.machine_name = ?
    `, [langcode, machine_name]);

    if (pRows.length > 0) {
      item = JSON.parse(pRows[0].data);
      let status = 'missing';

      if (pRows[0].t_title !== null) {
        status = 'translated';
        let isStale = false;
        if (pRows[0].t_source_hash) {
          if (item.attributes?.changed && pRows[0].t_updated_at) {
            const changedTime = new Date(item.attributes.changed).getTime();
            const updatedTime = new Date(pRows[0].t_updated_at).getTime();
            if (changedTime > updatedTime) {
              const source = item.attributes.title + (item.attributes.body?.summary || '') + (item.attributes.body?.value || '');
              const sourceHash = crypto.createHash('md5').update(source).digest('hex');
              if (pRows[0].t_source_hash !== sourceHash) isStale = true;
            }
          } else {
            const source = item.attributes.title + (item.attributes.body?.summary || '') + (item.attributes.body?.value || '');
            const sourceHash = crypto.createHash('md5').update(source).digest('hex');
            if (pRows[0].t_source_hash !== sourceHash) isStale = true;
          }
        }

        if (isStale) status = 'stale';

        item.meta = item.meta || {};
        item.meta.translation = {
          title: pRows[0].t_title,
          summary: pRows[0].t_summary,
          body: pRows[0].t_body,
          screenshot_alts: JSON.parse(pRows[0].t_screenshot_alts || '{}'),
          tags: pRows[0].t_tags || '',
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

    // Fix relative URLs in bodies and generate summary if missing
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
    item.meta.filter_count = filteredIndex.length;

    // Review count for the bar
    if (langcode) {
      const [revRows] = await db.execute('SELECT COUNT(*) as count FROM translations WHERE langcode = ? AND is_reviewed = FALSE', [langcode]);
      item.meta.review_count = revRows[0].count;
    }

    // Clean up relationships to avoid crashes if included data is missing
    if (item.relationships && included.length === 0) {
      delete item.relationships.field_project_images;
    }

    res.json({
      data: item,
      included: included
    });
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch project details' });
  }
});

app.get('/api/autocomplete', async (req, res) => {
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

app.post('/api/categories/translate', authenticateToken, async (req, res) => {
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

app.post('/api/translations/:langcode/:machine_name', authenticateToken, async (req, res) => {
  const { langcode, machine_name } = req.params;
  const { title, summary, body, screenshot_alts, tags, is_review = false } = req.body;
  try {
    const [pRows] = await db.execute('SELECT data FROM projects WHERE machine_name = ?', [machine_name]);
    let sourceHash = '';
    if (pRows.length > 0) {
      const item = JSON.parse(pRows[0].data);
      const source = item.attributes.title + (item.attributes.body?.summary || '') + (item.attributes.body?.value || '');
      sourceHash = crypto.createHash('md5').update(source).digest('hex');
    }
    const translationData = { machine_name, title, body: { value: body, summary: summary }, screenshot_alts, tags, reviewed: is_review, source_hash: sourceHash, updated: Math.floor(Date.now() / 1000) };
    
    await db.execute(`
      INSERT INTO translations (machine_name, langcode, title, summary, body, screenshot_alts, tags, source_hash, is_reviewed) 
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) 
      ON DUPLICATE KEY UPDATE 
        title=VALUES(title), 
        summary=VALUES(summary), 
        body=VALUES(body), 
        screenshot_alts=VALUES(screenshot_alts), 
        tags=VALUES(tags), 
        source_hash=VALUES(source_hash),
        is_reviewed=VALUES(is_reviewed)
    `, [machine_name, langcode, title, summary, body, JSON.stringify(screenshot_alts), tags, sourceHash, is_review ? 1 : 0]);
    
    // Update user's last reviewed project if in review mode
    if (is_review) {
      await db.execute('UPDATE users SET last_reviewed_project = ? WHERE id = ?', [machine_name, req.user.id]);
    }

    await fs.ensureDir(path.join(TRANSLATIONS_DIR, langcode));
    await fs.writeJson(path.join(TRANSLATIONS_DIR, langcode, `${machine_name}.json`), translationData, { spaces: 2 });
    res.json({ success: true, source_hash: sourceHash });
  } catch (error) {
    console.error('Save translation error:', error);
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

app.post('/api/upload-backup', authenticateToken, upload.single('file'), async (req, res) => {
  if (!req.file) return res.status(400).json({ error: 'No file uploaded' });
  
  const filePath = req.file.path;
  const originalName = req.file.originalname;
  const extension = path.extname(originalName).toLowerCase();
  
  try {
    let command = '';
    if (extension === '.zip') {
      command = `unzip -o "${filePath}" -d "${DATA_DIR}"`;
    } else if (extension === '.gz' || extension === '.tgz') {
      command = `tar -xzf "${filePath}" -C "${DATA_DIR}"`;
    } else {
      await fs.remove(filePath);
      return res.status(400).json({ error: 'Unsupported file format. Please use .zip or .tar.gz' });
    }

    exec(command, async (error) => {
      if (error) {
        console.error('Extraction error:', error);
        return res.status(500).json({ error: 'Failed to extract archive' });
      }
      
      // Cleanup the uploaded file
      await fs.remove(filePath);

      // --- SECURITY SANITATION ---
      // Delete all files that are NOT .json files to prevent executable uploads
      const sanitationCmd = `find "${DATA_DIR}" -type f -not -name "*.json" -delete && chmod -R 644 "${DATA_DIR}" && find "${DATA_DIR}" -type d -exec chmod 755 {} +`;
      
      exec(sanitationCmd, async (sanError) => {
        if (sanError) console.error('Sanitation error:', sanError);

        // Trigger a sync automatically after extraction
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
      });
    });
  } catch (error) {
    res.status(500).json({ error: 'Processing failed' });
  }
});

// --- Auth & User Management ---

app.get('/api/auth/settings', async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT setting_key, setting_value FROM site_settings WHERE setting_key = ?', ['registration_enabled']);
    const settings = {};
    rows.forEach(r => settings[r.setting_key] = r.setting_value);
    res.json(settings);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch settings' });
  }
});

app.post('/api/auth/register', async (req, res) => {
  const { username, password, name, email } = req.body;
  try {
    const [settings] = await db.execute('SELECT setting_value FROM site_settings WHERE setting_key = ?', ['registration_enabled']);
    if (settings.length > 0 && settings[0].setting_value === '0') {
      return res.status(403).json({ error: 'Registration is currently disabled by the administrator' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const [result] = await db.execute(
      'INSERT INTO users (username, password, name, email, is_active) VALUES (?, ?, ?, ?, ?)',
      [username, hashedPassword, name || username, email || '', 0]
    );
    res.json({ success: true, userId: result.insertId });
  } catch (err) {
    console.error('Registration Error:', err);
    if (err.code === 'ER_DUP_ENTRY') {
      return res.status(400).json({ error: 'Username already exists' });
    }
    res.status(500).json({ error: 'Registration failed' });
  }
});

app.post('/api/auth/login', async (req, res) => {
  const { username, password } = req.body;
  try {
    const [rows] = await db.execute('SELECT * FROM users WHERE username = ?', [username]);
    if (rows.length === 0) return res.status(401).json({ error: 'Invalid credentials' });
    
    const user = rows[0];
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(401).json({ error: 'Invalid credentials' });
    
    if (user.is_active === 0) {
      return res.status(403).json({ error: 'Your account is pending approval by an administrator.' });
    }
    
    const token = jwt.sign({ id: user.id, username: user.username, role: user.role }, JWT_SECRET, { expiresIn: '7d' });
    res.json({ 
      token, 
      user: { 
        id: user.id, 
        username: user.username, 
        name: user.name, 
        email: user.email, 
        avatar_url: user.avatar_url, 
        role: user.role, 
        google_ai_key: user.google_ai_key, 
        ai_batch_limit: user.ai_batch_limit,
        last_reviewed_project: user.last_reviewed_project
      } 
    });
  } catch (err) {
    res.status(500).json({ error: 'Login failed' });
  }
});

app.get('/api/auth/me', authenticateToken, async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT id, username, name, email, avatar_url, role, is_active, google_ai_key, ai_batch_limit, ai_prompt, last_reviewed_project FROM users WHERE id = ?', [req.user.id]);
    if (rows.length === 0) return res.status(404).json({ error: 'User not found' });
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch user' });
  }
});

// --- Admin Management ---

const isAdmin = (req, res, next) => {
  if (req.user && req.user.role === 'admin') next();
  else res.status(403).json({ error: 'Admin access required' });
};

app.get('/api/admin/users/pending', authenticateToken, isAdmin, async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT id, username, name, email, created_at FROM users WHERE is_active = 0');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch pending users' });
  }
});

app.post('/api/admin/users/:id/approve', authenticateToken, isAdmin, async (req, res) => {
  try {
    await db.execute('UPDATE users SET is_active = 1 WHERE id = ?', [req.params.id]);
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: 'Approval failed' });
  }
});

app.delete('/api/admin/users/:id', authenticateToken, isAdmin, async (req, res) => {
  try {
    await db.execute('DELETE FROM users WHERE id = ? AND role != "admin"', [req.params.id]);
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: 'Deletion failed' });
  }
});

app.get('/api/admin/settings', authenticateToken, isAdmin, async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM site_settings');
    const settings = {};
    rows.forEach(r => settings[r.setting_key] = r.setting_value);
    res.json(settings);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch settings' });
  }
});

app.put('/api/admin/settings', authenticateToken, isAdmin, async (req, res) => {
  const { registration_enabled } = req.body;
  try {
    await db.execute(
      'INSERT INTO site_settings (setting_key, setting_value) VALUES (?, ?) ON DUPLICATE KEY UPDATE setting_value = ?',
      ['registration_enabled', registration_enabled, registration_enabled]
    );
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: 'Failed to update settings' });
  }
});

app.put('/api/user/profile', authenticateToken, async (req, res) => {
  const { name, email, google_ai_key, ai_batch_limit, ai_prompt } = req.body;
  try {
    await db.execute(
      'UPDATE users SET name = ?, email = ?, google_ai_key = ?, ai_batch_limit = ?, ai_prompt = ? WHERE id = ?', 
      [name, email, google_ai_key || null, ai_batch_limit || 5, ai_prompt || null, req.user.id]
    );
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: 'Profile update failed' });
  }
});

app.put('/api/user/password', authenticateToken, async (req, res) => {
  const { currentPassword, newPassword } = req.body;
  try {
    const [rows] = await db.execute('SELECT password FROM users WHERE id = ?', [req.user.id]);
    if (rows.length === 0) return res.status(404).json({ error: 'User not found' });
    
    const isMatch = await bcrypt.compare(currentPassword, rows[0].password);
    if (!isMatch) return res.status(400).json({ error: 'Current password incorrect' });
    
    const hashed = await bcrypt.hash(newPassword, 10);
    await db.execute('UPDATE users SET password = ? WHERE id = ?', [hashed, req.user.id]);
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: 'Password update failed' });
  }
});

app.post('/api/user/avatar', authenticateToken, uploadAvatar.single('avatar'), async (req, res) => {
  if (!req.file) return res.status(400).json({ error: 'No file uploaded' });
  
  const avatarUrl = `/uploads/avatars/${req.file.filename}`;
  try {
    await db.execute('UPDATE users SET avatar_url = ? WHERE id = ?', [avatarUrl, req.user.id]);
    res.json({ success: true, avatarUrl });
  } catch (err) {
    res.status(500).json({ error: 'Avatar update failed' });
  }
});

app.get('/api/unsplash/random-bg', async (req, res) => {
  const { query = 'nature,forest,dark' } = req.query;
  try {
    const response = await axios.get('https://api.unsplash.com/photos/random', { 
      params: { 
        query, 
        orientation: 'landscape', 
        client_id: UNSPLASH_ACCESS_KEY 
      },
      timeout: 5000 // 5 second timeout
    });
    
    const photo = response.data;
    
    // Unsplash requires UTM parameters on all links back to their site
    const utmParams = '?utm_source=pb_translation_hub&utm_medium=referral';
    
    res.json({ 
      url: photo.urls.regular, 
      source: 'unsplash',
      photographer: {
        name: photo.user.name,
        username: photo.user.username,
        link: `${photo.user.links.html}${utmParams}`
      },
      unsplash_link: `https://unsplash.com/${utmParams}`,
      download_location: photo.links.download_location
    });
  } catch (error) {
    console.warn('Unsplash API failed (possibly Rate Limit). Using fallback image.');
    
    // Fallback logic using Picsum Photos
    const seed = Buffer.from(query).toString('base64').substring(0, 10);
    const fallbackUrl = `https://picsum.photos/seed/${seed}/1920/1080`;
    
    res.json({ 
      url: fallbackUrl, 
      source: 'picsum',
      error: error.response?.status === 403 ? 'Rate limit exceeded' : 'API error'
    });
  }
});

app.post('/api/unsplash/track-download', async (req, res) => {
  const { download_location } = req.body;
  if (!download_location) return res.status(400).json({ error: 'Missing download_location' });
  
  try {
    await axios.get(download_location, {
      params: { client_id: UNSPLASH_ACCESS_KEY }
    });
    res.json({ success: true });
  } catch (error) {
    console.error('Unsplash download tracking failed:', error.message);
    res.status(500).json({ error: 'Tracking failed' });
  }
});

// --- AI Translation Service ---
app.post('/api/ai/translate-bulk', authenticateToken, async (req, res) => {
  const { machineNames, langcode } = req.body;
  if (!Array.isArray(machineNames)) return res.status(400).json({ error: 'Invalid machine names' });

    try {
    // 1. Get user AI settings
    const [uRows] = await db.execute('SELECT google_ai_key, ai_batch_limit, ai_prompt FROM users WHERE id = ?', [req.user.id]);
    const user = uRows[0];
    
    if (!user || !user.google_ai_key) {
      return res.status(400).json({ error: 'Missing Google AI Key in your profile.' });
    }

    const limit = Math.min(machineNames.length, user.ai_batch_limit || 10);
    const projectsToTranslate = machineNames.slice(0, limit);
    const results = [];

    const GEMINI_URL = `https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-flash-lite-preview:generateContent?key=${user.google_ai_key}`;

    const defaultPrompt = `Translate the following two HTML blocks (summary and main description) from the Drupal Project Browser to {{langcode}}.
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

    const userPromptTemplate = user.ai_prompt || defaultPrompt;

    console.log(`[AI] Starting bulk translation for user ${req.user.username} (${projectsToTranslate.length} projects)`);

    for (const machine_name of projectsToTranslate) {
      try {
        // Fetch project metadata
        const [pRows] = await db.execute('SELECT data, title FROM projects WHERE machine_name = ?', [machine_name]);
        if (pRows.length === 0) continue;
        
        const project = JSON.parse(pRows[0].data);
        const title = project.attributes.title || pRows[0].title;
        const summarySrc = project.attributes.body?.summary || '';
        const bodySrc = project.attributes.body?.value || '';

        // Prepare prompt with variables
        let targetLang = langcode === 'de' ? 'German' : langcode;
        if (langcode === 'fr') targetLang = 'French';
        if (langcode === 'es') targetLang = 'Spanish';

        let promptText = userPromptTemplate
          .replace(/{{langcode}}/g, targetLang)
          .replace(/{{summary}}/g, summarySrc)
          .replace(/{{body}}/g, bodySrc);

        const geminiRes = await axios.post(GEMINI_URL, {
          contents: [{ parts: [{ text: promptText }] }]
        });

        let aiText = geminiRes.data.candidates[0].content.parts[0].text;

        // Strip common AI fluff if it sneaks in despite the prompt
        aiText = aiText.replace(/^(Hier ist die Übersetzung|Hier sind die übersetzten|Übersetzung:|Hier ist die).*?\n+/gi, '').trim();

        const parts = aiText.split('---');
        const translatedSummary = (parts[0] || '').trim();
        const translatedBody = (parts[1] || '').trim();

        // Calculate source hash for stale detection
        const sourceStr = title + summarySrc + bodySrc;
        const sourceHash = crypto.createHash('md5').update(sourceStr).digest('hex');

        // Save translation
        const translationData = { 
          machine_name, 
          title, // Keep original title as requested
          body: { value: translatedBody, summary: translatedSummary }, 
          screenshot_alts: {}, 
          tags: '', 
          reviewed: false, 
          source_hash: sourceHash, 
          updated: Math.floor(Date.now() / 1000) 
        };

        await db.execute(`
          INSERT INTO translations (machine_name, langcode, title, summary, body, screenshot_alts, tags, source_hash) 
          VALUES (?, ?, ?, ?, ?, ?, ?, ?) 
          ON DUPLICATE KEY UPDATE 
            title=VALUES(title), 
            summary=VALUES(summary), 
            body=VALUES(body), 
            source_hash=VALUES(source_hash)
        `, [machine_name, langcode, title, translatedSummary, translatedBody, '{}', '', sourceHash]);

        await fs.ensureDir(path.join(TRANSLATIONS_DIR, langcode));
        await fs.writeJson(path.join(TRANSLATIONS_DIR, langcode, `${machine_name}.json`), translationData, { spaces: 2 });

        console.log(`[AI] Successfully translated: ${machine_name} (${langcode})`);
        results.push({ machine_name, success: true });
      } catch (err) {
        if (err.response) {
          console.error(`[AI] Gemini API Error (${err.response.status}):`, JSON.stringify(err.response.data));
        }
        console.error(`[AI] Failed to translate ${machine_name}:`, err.message);
        results.push({ machine_name, success: false, error: err.message });
      }
    }

    console.log(`[AI] Bulk translation finished. Success: ${results.filter(r => r.success).length}/${results.length}`);
    res.json({ results, count: results.filter(r => r.success).length });
  } catch (error) {
    console.error('Bulk AI Translation error:', error);
    res.status(500).json({ error: 'Bulk AI Translation process failed.' });
  }
});

// --- AI Token Counting ---
app.post('/api/ai/estimate-cost', authenticateToken, async (req, res) => {
  const { machineNames, langcode } = req.body;
  if (!Array.isArray(machineNames)) return res.status(400).json({ error: 'Invalid machine names' });

  try {
    const [uRows] = await db.execute('SELECT google_ai_key, ai_prompt FROM users WHERE id = ?', [req.user.id]);
    const user = uRows[0];
    
    if (!user || !user.google_ai_key) {
      return res.status(400).json({ error: 'Missing Google AI Key.' });
    }

    const COUNT_URL = `https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-flash-lite-preview:countTokens?key=${user.google_ai_key}`;
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

    // Cost calculation: $0.25 per 1M tokens (input). 
    // We double it to account for output tokens (which are usually similar or less in translation)
    const estimatedCost = (totalTokens / 1000000) * 0.25; 
    // Output tokens are $0.75 per 1M, let's be safe and estimate a bit higher
    const safeEstimate = estimatedCost * 4; 

    res.json({ totalTokens, estimatedCost: safeEstimate.toFixed(4) });
  } catch (error) {
    console.error('AI Cost Estimation error:', error);
    res.status(500).json({ error: 'Estimation failed.' });
  }
});

app.listen(PORT, () => {
  console.log(`PB Translation Hub Backend running on http://localhost:${PORT}`);
});
