require('dotenv').config();
const express = require('express');
const axios = require('axios');
const cors = require('cors');
const helmet = require('helmet');
const bodyParser = require('body-parser');
const fs = require('fs-extra');
const path = require('path');
const crypto = require('crypto');
const mysql = require('mysql2/promise');
const multer = require('multer');
const jwt = require('jsonwebtoken');
const { registerUnsplashRoutes } = require('./unsplash');
const { runMigrations }          = require('./db_migrate');

// No insecure fallback: a guessable default secret would let anyone forge
// valid JWTs if the env var is ever missing on a fresh deployment.
if (!process.env.JWT_SECRET) {
  console.error('FATAL: JWT_SECRET environment variable is not set. Refusing to start.');
  process.exit(1);
}
const JWT_SECRET = process.env.JWT_SECRET;

// Restrict the generic upload endpoint (currently used only for
// POST /api/upload-backup) to archive files and cap its size — an
// unrestricted multer() accepted any file of any size from any logged-in user.
const upload = multer({
  dest: 'uploads/',
  limits: { fileSize: 100 * 1024 * 1024 }, // 100 MB — generous for a data backup archive
  fileFilter: (req, file, cb) => {
    const ext = path.extname(file.originalname).toLowerCase();
    if (['.zip', '.gz', '.tgz'].includes(ext)) cb(null, true);
    else cb(new Error('Only .zip, .gz or .tgz archives are allowed'));
  },
});
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
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME || 'pb_translation_hub',
  // mysql2 returns DECIMAL columns (e.g. SUM(CASE WHEN ... THEN 1 ELSE 0 END))
  // as strings by default to avoid precision loss. The Flutter client's
  // FilterCounts model expects real ints, so a string there throws during
  // JSON parsing — silently swallowed by the client's catch-all, making all
  // filter counts show 0. Cast DECIMAL results to JS numbers globally.
  decimalNumbers: true,
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

// Origin allowlist instead of reflecting every caller: the API is only ever
// called from the admin Flutter app (web build) and local dev. Falls back to
// allowing all origins only if no allowlist is configured, so this cannot
// brick a deployment that forgot to set the env var — but every real
// deployment should set CORS_ALLOWED_ORIGINS.
const allowedOrigins = (process.env.CORS_ALLOWED_ORIGINS || '')
  .split(',')
  .map((o) => o.trim())
  .filter(Boolean);
app.use(cors(allowedOrigins.length ? {
  origin: allowedOrigins,
} : undefined));
app.use(helmet({
  // The admin UI is a Flutter-web SPA served from this same origin/behind
  // the same reverse proxy in some deployments — a strict default CSP would
  // block its own inline bootstrap script. Other Helmet protections
  // (X-Content-Type-Options, X-Frame-Options, etc.) stay on.
  contentSecurityPolicy: false,
}));
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
  lastFullSync: null,
  syncType: null, // 'quick' | 'full' | null
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
const DRUPAL_API_TIMEOUT = 15000; // ms — prevents a stalled drupal.org response from wedging the sync loop forever

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
async function getFilteredIndex(filter, search, langcode, limit = null, offset = 0, machine_names = null, prioritize_priority = false, core_version = null) {
  if (search === 'undefined' || search === 'null') search = '';
  if (typeof search === 'string') search = search.trim();
  if (filter === 'undefined' || filter === 'null' || typeof filter === 'object') filter = 'all';
  const coreVer = core_version ? parseInt(core_version) : null;

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
    query += ` AND t.machine_name IS NOT NULL
      AND t.source_hash IS NOT NULL AND t.source_hash != ''
      AND MD5(CONCAT(
        IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.title')), ''),
        IFNULL(NULLIF(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.body.summary')), 'null'), ''),
        IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.body.value')), '')
      )) != t.source_hash `;
  } else if (filter === 'review') {
    query += ` AND t.machine_name IS NOT NULL AND t.is_reviewed = FALSE `;
  } else if (filter === 'released') {
    query += ` AND t.machine_name IS NOT NULL AND t.is_reviewed = TRUE `;
  } else if (filter === 'priority') {
    // "Priority" now means: on the curated priority list, but not yet
    // Drupal-12-compatible (semver_max < 12000000). Driven from projects p
    // (not translations), so it can never show a nonzero count with an empty
    // list — unlike the old "priority-listed AND untranslated" definition,
    // which silently dropped priority modules never synced into `projects`.
    query += ` AND p.machine_name IN (SELECT machine_name FROM priority_projects) AND p.semver_max < 12000000 `;
  }

  if (coreVer !== null) {
    const vMin = coreVer * 1000000;
    const vMax = coreVer * 1000000 + 999999;
    query += ` AND p.semver_min <= ${vMax} AND p.semver_max >= ${vMin} `;
  }

  let orderClause = '';
  const orderParams = [];

  if (prioritize_priority) {
    // Matches the 'priority' filter's meaning: surface priority-listed
    // modules that still lack Drupal 12 support first.
    orderClause += ` (p.machine_name IN (SELECT machine_name FROM priority_projects) AND p.semver_max < 12000000) DESC, `;
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

// --- Sync-Event-Protokollierung ------------------------------------------------
//
// Erkennt während des Syncs (VOR dem projects-Upsert), ob ein Modul neu ist,
// seine Beschreibung sich geändert hat, und welche Übersetzungen dadurch
// veraltet werden. Speist die Tabelle sync_events (Migration 009) für das
// Analyse-Dashboard.

// Extrahiert die übersetzungsrelevanten Beschreibungsfelder aus einem
// JSON:API-Objekt (entspricht den Feldern der Stale-MD5-Formel).
function extractDesc(dataObj) {
  const a = (dataObj && dataObj.attributes) || {};
  return {
    title:   a.title || '',
    summary: (a.body && a.body.summary != null) ? a.body.summary : '',
    body:    (a.body && a.body.value   != null) ? a.body.value   : '',
  };
}

function descriptionChanged(oldData, newItem) {
  const o = extractDesc(oldData);
  const n = extractDesc(newItem);
  return o.title !== n.title || o.summary !== n.summary || o.body !== n.body;
}

// Muss VOR dem projects-Upsert aufgerufen werden (nutzt die alte p.data in der DB).
// Fehler dürfen den Sync niemals abbrechen — daher try/catch + nur loggen.
async function recordSyncEvents(machineName, newItem) {
  try {
    const today = new Date().toISOString().slice(0, 10); // YYYY-MM-DD
    const [rows] = await db.execute('SELECT data FROM projects WHERE machine_name = ?', [machineName]);

    if (rows.length === 0) {
      await db.execute(
        `INSERT IGNORE INTO sync_events (machine_name, event_type, langcode, event_date)
         VALUES (?, 'new_module', NULL, ?)`,
        [machineName, today]
      );
      return;
    }

    let oldData = null;
    try {
      oldData = typeof rows[0].data === 'string' ? JSON.parse(rows[0].data) : rows[0].data;
    } catch (_) { /* korrupte alte Daten → wie geändert behandeln */ }

    if (!descriptionChanged(oldData, newItem)) return;

    await db.execute(
      `INSERT IGNORE INTO sync_events (machine_name, event_type, langcode, event_date)
       VALUES (?, 'description_changed', NULL, ?)`,
      [machineName, today]
    );

    // Übersetzungen, die VOR der Quelländerung aktuell waren (source_hash == aktuelle
    // MD5 der alten Daten), werden durch die Textänderung jetzt veraltet.
    const [trows] = await db.execute(
      `SELECT t.langcode FROM translations t
       JOIN projects p ON t.machine_name = p.machine_name
       WHERE t.machine_name = ?
         AND t.source_hash IS NOT NULL AND t.source_hash != ''
         AND MD5(CONCAT(
           IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.title')), ''),
           IFNULL(NULLIF(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.body.summary')), 'null'), ''),
           IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.body.value')), '')
         )) = t.source_hash`,
      [machineName]
    );

    for (const tr of trows) {
      await db.execute(
        `INSERT IGNORE INTO sync_events (machine_name, event_type, langcode, event_date)
         VALUES (?, 'stale', ?, ?)`,
        [machineName, tr.langcode, today]
      );
    }
  } catch (e) {
    console.error(`[sync_events] recordSyncEvents fehlgeschlagen für ${machineName}:`, e.message);
  }
}

// --- Sync Service ---
let syncAbortController = null;

// Called by POST /sync/stop. Setting shouldStop alone isn't enough to unstick
// the loop while it's parked inside an in-flight axios.get() — this also
// aborts that request immediately so Stop takes effect right away instead of
// waiting for the request to time out on its own.
function stopSync() {
  syncStatus.shouldStop = true;
  if (syncAbortController) syncAbortController.abort();
}

async function syncProjects(sinceTimestamp = null) {
  if (syncStatus.active) return;

  syncStatus.active = true;
  syncStatus.shouldStop = false;
  syncStatus.error = null;
  syncStatus.syncType = sinceTimestamp ? 'quick' : 'full';

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
    // Quick sync: reset counters and clear stale lastMachineName from previous full sync
    // so the UI doesn't show a misleading "zxcvbn"-style full-sync indicator.
    syncStatus.current = 0;
    syncStatus.total = 0;
    syncStatus.lastMachineName = '';
  }

  console.log(sinceTimestamp ? `Starting quick update since ${sinceTimestamp}...` : 'Starting full metadata sync...');
  let page = 0;

  while (syncStatus.active && !syncStatus.shouldStop) {
    try {
      const query = {
        'filter[status]': 1,
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

      // Quick sync needs node endpoint (supports filter[changed]); full sync uses index endpoint
      const apiUrl = sinceTimestamp ? DETAIL_API : DRUPAL_ORG_API;
      syncAbortController = new AbortController();
      const response = await axios.get(apiUrl, {
        params: query,
        timeout: DRUPAL_API_TIMEOUT,
        signal: syncAbortController.signal,
      });
      syncAbortController = null;
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

          await recordSyncEvents(machineName, item);
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
      syncAbortController = null;
      if (syncStatus.shouldStop || axios.isCancel(error)) {
        // Aborted via the Stop button — not a real failure.
        break;
      }
      console.error('Sync error:', error.message);
      syncStatus.error = error.message;
      syncStatus.active = false;
    }
  }

  syncAbortController = null;

  if (!syncStatus.shouldStop && !syncStatus.error) {
    // Only full syncs update lastFullSync — quick syncs don't reset the baseline
    // (the auto-sync scheduler uses lastFullSync as the 'since' cutoff).
    if (syncStatus.syncType === 'full') {
      syncStatus.lastFullSync = new Date().toISOString();
    }
  }

  syncStatus.active = false;
  syncStatus.syncType = null;
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
  stopSync,
  recordSyncEvents,
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

// --- Health endpoint (circuit breaker probe for pb_localizer) ---
app.get('/api/health', (_req, res) => res.json({ status: 'ok' }));

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
app.use('/api', require('./routes/dashboard')(ctx));
app.use('/api', require('./routes/translations')(ctx));

// Catches multer file-validation errors (e.g. the upload-backup file-type
// filter) and any other error passed to next() so clients get clean JSON
// instead of Express's default HTML/stack-trace response.
app.use((err, req, res, next) => {
  if (res.headersSent) return next(err);
  console.error('[Unhandled request error]', err.message);
  res.status(400).json({ error: err.message || 'Request failed' });
});

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

// ── Automatic quick sync every 7.5 days ───────────────────────────────────────
// Uses setInterval so no extra dependency is needed.  The interval is only
// started after the server is fully up (inside app.listen callback).
// A quick sync fetches only modules changed since the last full sync timestamp,
// so it is fast and Drupal.org-friendly.
const QUICK_SYNC_INTERVAL_MS = 7.5 * 24 * 60 * 60 * 1000; // 7.5 days

function scheduleQuickSync() {
  setInterval(async () => {
    if (syncStatus.active) {
      console.log('[AutoSync] Skipping scheduled quick sync — a sync is already running.');
      return;
    }
    const since = syncStatus.lastFullSync;
    if (!since) {
      console.log('[AutoSync] Skipping scheduled quick sync — no lastFullSync timestamp yet.');
      return;
    }
    console.log(`[AutoSync] Starting scheduled quick sync (changed since ${since})…`);
    syncStatus.active = true;
    syncStatus.shouldStop = false;
    syncStatus.error = null;
    try {
      await syncProjects(since);
      console.log('[AutoSync] Scheduled quick sync completed.');
    } catch (e) {
      console.error('[AutoSync] Scheduled quick sync failed:', e.message);
      syncStatus.active = false;
    }
  }, QUICK_SYNC_INTERVAL_MS);
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

  // Start the automatic 7.5-day quick sync scheduler.
  scheduleQuickSync();
  console.log(`[AutoSync] Scheduled quick sync every 7.5 days (${QUICK_SYNC_INTERVAL_MS / 1000 / 3600}h).`);
});
