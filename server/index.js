require('dotenv').config();
const express = require('express');
const axios = require('axios');
const cors = require('cors');
const bodyParser = require('body-parser');
const fs = require('fs-extra');
const path = require('path');
const crypto = require('crypto');
const mysql = require('mysql2/promise');
const multer = require('multer');
const jwt = require('jsonwebtoken');
const { registerUnsplashRoutes } = require('./unsplash');
const { runMigrations }          = require('./db_migrate');

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

// Middleware to optionally authenticate (for public/private view logic)
const optionalAuth = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  
  if (!token) {
    req.user = null;
    return next();
  }
  
  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) req.user = null;
    else req.user = user;
    next();
  });
};

// Middleware to check admin role
const isAdmin = (req, res, next) => {
  if (req.user && req.user.role === 'admin') next();
  else res.status(403).json({ error: 'Admin access required' });
};

// Middleware to block translators from review queue
const isReviewerOrAdmin = (req, res, next) => {
  if (!req.user) return res.status(401).json({ error: 'Authentication required' });
  if (req.user.role === 'admin' || req.user.user_type === 'reviewer') next();
  else res.status(403).json({ error: 'Review access is restricted to reviewers and admins.' });
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

// Ensure directories exist
fs.ensureDirSync(METADATA_DIR);
fs.ensureDirSync(TRANSLATIONS_DIR);
fs.ensureDirSync(path.join(__dirname, 'uploads'));

app.use(cors());
app.use(bodyParser.json({ limit: '50mb' }));
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// --- Unsplash Service ---
registerUnsplashRoutes(app);

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
  const base = 'https://www.drupal.org';
  html = html.replace(
    /(src|href)=["']\/\/(?:www\.)?drupal\.org(\/[^"']+)["']/g,
    `$1="${base}$2"`
  );
  html = html.replace(
    /(src|href)=["']\/(sites|files|core|themes|modules|node|user|media|libraries)\/([^"']+)["']/g,
    `$1="${base}/$2/$3"`
  );
  html = html.replace(
    /(src|href)=["'](sites|files|core|themes|modules)\/([^"']+)["']/g,
    `$1="${base}/$2/$3"`
  );
  return html;
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
async function getFilteredIndex(filter, search, langcode, limit = null, offset = 0, machine_names = null, prioritize_priority = false) {
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
      t.source_hash as t_source_hash,
      t.updated_at as t_updated_at,
      t.is_reviewed,
      p.changed as p_changed
    FROM projects p
    LEFT JOIN translations t ON p.machine_name = t.machine_name AND t.langcode = ?
    WHERE ${filter === 'ignored' ? 'p.machine_name IN (SELECT machine_name FROM ignored_projects)' : 'p.machine_name NOT IN (SELECT machine_name FROM ignored_projects)'}
  `;
  const params = [langcode];

  if (Array.isArray(machine_names) && machine_names.length > 0) {
    const placeholders = machine_names.map(() => '?').join(',');
    query += ` AND p.machine_name IN (${placeholders}) `;
    params.push(...machine_names);
  }

  if (search) {
    query += ` AND (
      p.machine_name LIKE ? OR
      p.title LIKE ? OR
      p.machine_name IN (SELECT machine_name FROM translations WHERE langcode = ? AND title LIKE ?)
    ) `;
    params.push(`%${search}%`, `%${search}%`, langcode, `%${search}%`);
  }

  if (filter === 'missing') {
    query += ` AND t.machine_name IS NULL `;
  } else if (filter === 'translated') {
    query += ` AND t.machine_name IS NOT NULL `;
  } else if (filter === 'stale') {
    query += ` AND t.machine_name IS NOT NULL AND p.changed > t.updated_at `;
  } else if (filter === 'review') {
    query += ` AND t.machine_name IS NOT NULL AND t.is_reviewed = FALSE `;
  } else if (filter === 'released') {
    query += ` AND t.machine_name IS NOT NULL AND t.is_reviewed = TRUE `;
  } else if (filter === 'priority') {
    query += ` AND p.machine_name IN (SELECT machine_name FROM priority_projects) AND t.machine_name IS NULL `;
  }

  let orderClause = '';
  const orderParams = [];

  if (prioritize_priority) {
    orderClause += ` (p.machine_name IN (SELECT machine_name FROM priority_projects)) DESC, `;
  }

  if (search) {
    orderClause += `
      CASE 
        WHEN p.machine_name = ? THEN 0
        WHEN p.title = ? THEN 0
        WHEN p.machine_name LIKE ? THEN 1
        WHEN p.title LIKE ? THEN 1
        ELSE 2
      END,
    `;
    orderParams.push(search, search, `${search}%`, `${search}%`);
  }

  query += ` ORDER BY ${orderClause} p.machine_name ASC `;
  params.push(...orderParams);

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
    syncStatus.total = 0; // wird aus erster Drupal.org API-Antwort befüllt
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
        'page[offset]': page * 50,
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

      // Gesamtanzahl aus der ersten API-Antwort holen — gilt für Quick- und Full-Sync
      if (response.data.meta?.count) {
        syncStatus.total = response.data.meta.count;
      }

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

// --- Context of dependencies to share with routes ---
const ctx = {
  db,
  authenticateToken,
  optionalAuth,
  isAdmin,
  isReviewerOrAdmin,
  syncStatus,
  saveStatus,
  syncProjects,
  JWT_SECRET,
  DATA_DIR,
  METADATA_DIR,
  TRANSLATIONS_DIR,
  fixRelativeUrls,
  fixDrupalUrl,
  getExcerpt,
  getFilteredIndex,
  upload,
  uploadAvatar
};

// --- Modular Routers ---
// NOTE: admin and ai must be registered BEFORE translations because
// translations.js contains a catch-all wildcard route (GET /:langcode/:filename)
// that would otherwise intercept e.g. GET /api/admin/settings.
app.use('/api', require('./routes/auth')(ctx));
app.use('/api', require('./routes/sync')(ctx));
app.use('/api', require('./routes/projects')(ctx));
app.use('/api', require('./routes/categories')(ctx));
app.use('/api', require('./routes/admin')(ctx));
app.use('/api', require('./routes/ai')(ctx));
app.use('/api', require('./routes/glossary')(ctx));
app.use('/api', require('./routes/translations')(ctx));

// ── Startup: ensure translation files exist on the filesystem ─────────────────
//
// Two passes run sequentially at startup (both idempotent / non-fatal):
//
//  1. ensureTranslationFilesFromDb()
//     If the translations directory is empty (e.g. after a fresh deployment
//     where server/data is a new Docker volume), regenerate every JSON file
//     from the `translations` DB table so the public API can serve them.
//
//  2. backfillIsReviewedInFiles()
//     Legacy migration: add the `is_reviewed` field to older JSON files that
//     were written before that field existed.

async function ensureTranslationFilesFromDb() {
  try {
    // Count existing files across all language subdirs
    const langcodes = await fs.readdir(TRANSLATIONS_DIR).catch(() => []);
    let existingCount = 0;
    for (const lc of langcodes) {
      const lcPath = path.join(TRANSLATIONS_DIR, lc);
      if (!(await fs.stat(lcPath).catch(() => null))?.isDirectory()) continue;
      const files = await fs.readdir(lcPath).catch(() => []);
      existingCount += files.filter(f => f.endsWith('.json')).length;
    }

    if (existingCount > 0) {
      console.log(`[Startup] Translation files present (${existingCount}). Skipping DB regeneration.`);
      return;
    }

    // Directory is empty — regenerate from DB
    console.log('[Startup] Translation files missing. Regenerating from DB…');
    const [rows] = await db.execute(
      'SELECT machine_name, langcode, title, summary, body, screenshot_alts, source_hash, is_reviewed, updated_at FROM translations'
    );

    let written = 0;
    for (const row of rows) {
      let screenshotAlts = [];
      try { if (row.screenshot_alts) screenshotAlts = JSON.parse(row.screenshot_alts); } catch (_) {}

      const data = {
        machine_name:    row.machine_name,
        title:           row.title || '',
        body:            { value: row.body || '', summary: row.summary || '' },
        screenshot_alts: screenshotAlts,
        is_reviewed:     row.is_reviewed === 1,
        source_hash:     row.source_hash || '',
        updated: row.updated_at
          ? Math.floor(new Date(row.updated_at).getTime() / 1000)
          : Math.floor(Date.now() / 1000),
      };

      const dir  = path.join(TRANSLATIONS_DIR, row.langcode);
      const file = path.join(dir, `${row.machine_name}.json`);
      try {
        await fs.ensureDir(dir);
        await fs.writeJson(file, data, { spaces: 2 });
        written++;
      } catch (e) {
        console.error(`[Startup] Could not write ${file}: ${e.message}`);
      }
    }

    console.log(`[Startup] Regenerated ${written} translation file(s) from DB.`);
  } catch (e) {
    console.error('[Startup] Translation file regeneration failed (non-fatal):', e.message);
  }
}

// ── Legacy file migration: backfill is_reviewed into JSON files that predate the field ──
// Runs once at startup, idempotent (skips files that already have the field).
async function backfillIsReviewedInFiles() {
  try {
    const langcodes = await fs.readdir(TRANSLATIONS_DIR).catch(() => []);
    let patched = 0;
    for (const langcode of langcodes) {
      const langPath = path.join(TRANSLATIONS_DIR, langcode);
      if (!(await fs.stat(langPath).catch(() => null))?.isDirectory()) continue;

      const files = await fs.readdir(langPath);
      for (const file of files) {
        if (!file.endsWith('.json')) continue;
        const filePath = path.join(langPath, file);
        try {
          const data = await fs.readJson(filePath);
          if (!Object.prototype.hasOwnProperty.call(data, 'is_reviewed')) {
            const machine_name = file.replace('.json', '');
            const [rows] = await db.execute(
              'SELECT is_reviewed FROM translations WHERE machine_name = ? AND langcode = ?',
              [machine_name, langcode]
            );
            const dbValue = rows.length > 0 ? rows[0].is_reviewed === 1 : false;
            data.is_reviewed = dbValue;
            await fs.writeJson(filePath, data, { spaces: 2 });
            patched++;
          }
        } catch (e) {
          // Skip unreadable files
        }
      }
    }
    if (patched > 0) {
      console.log(`[Startup] Backfilled is_reviewed field into ${patched} legacy translation file(s).`);
    }
  } catch (e) {
    console.error('[Startup] is_reviewed backfill failed (non-fatal):', e.message);
  }
}

app.listen(PORT, async () => {
  console.log(`PB Translation Hub Backend running on http://localhost:${PORT}`);

  // ── Schema migrations ──────────────────────────────────────────────────────
  // runMigrations() ist idempotent und sicher bei jedem Start.
  // Neue Spalten/Tabellen werden automatisch erkannt und angewendet.
  try {
    await runMigrations(db);
  } catch (e) {
    console.error('[Startup] KRITISCH: DB-Migration fehlgeschlagen:', e.message);
    process.exit(1); // Hard fail — Server darf nicht mit falschem Schema laufen
  }

  // Run startup tasks sequentially so backfill sees freshly generated files.
  await ensureTranslationFilesFromDb();
  backfillIsReviewedInFiles();
});
