const express = require('express');
const axios = require('axios');
const cors = require('cors');
const bodyParser = require('body-parser');
const fs = require('fs-extra');
const path = require('path');
const crypto = require('crypto');

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
const SEARCH_API = 'https://www.drupal.org/jsonapi/index/project_modules';
const DETAIL_API = 'https://www.drupal.org/jsonapi/node/project_module';
const CATEGORIES_API = 'https://www.drupal.org/jsonapi/taxonomy_term/module_categories';

// --- Helper: Fix Relative URLs in HTML ---
function fixRelativeUrls(html) {
  if (typeof html !== 'string') return '';
  // Convert relative src and href to absolute drupal.org URLs
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

// --- Sync Service ---
async function syncProjects(sinceTimestamp = null) {
  if (syncStatus.active) return;
  
  syncStatus.active = true;
  syncStatus.shouldStop = false;
  syncStatus.error = null;

  if (!sinceTimestamp) {
    // Check if we can resume
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
    // Quick sync: Reset progress for this run
    syncStatus.current = 0;
    syncStatus.total = 100; // Placeholder
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

      // Create a map of included files for quick lookup
      const fileMap = {};
      included.forEach(inc => {
        if (inc.type === 'file--file') {
          fileMap[inc.id] = inc.attributes.uri.url;
        }
      });

      for (const item of data) {
        const machineName = item.attributes.field_project_machine_name;
        if (machineName) {
          // Flatten image URLs into the item for easier frontend access
          if (item.relationships?.field_project_images?.data) {
            item.meta = item.meta || {};
            item.meta.screenshot_urls = item.relationships.field_project_images.data.map(img => ({
              id: img.id,
              url: `https://www.drupal.org${fileMap[img.id] || ''}`,
              alt: img.meta?.alt || ''
            }));
          }

          await fs.writeJson(path.join(METADATA_DIR, `${machineName}.json`), item);
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

// --- API Endpoints ---

app.get('/api/languages', async (req, res) => {
  if (await fs.pathExists(LANGUAGES_FILE)) {
    const languages = await fs.readJson(LANGUAGES_FILE);
    res.json(languages);
  } else {
    res.status(500).json({ error: 'Languages file missing' });
  }
});

app.get('/api/sync/status', (req, res) => {
  res.json(syncStatus);
});

app.post('/api/sync/start', (req, res) => {
  syncProjects();
  res.json({ success: true });
});

app.post('/api/sync/quick', (req, res) => {
  const { days = 7 } = req.body;
  const since = new Date();
  since.setDate(since.getDate() - days);
  syncProjects(since.toISOString().split('.')[0] + 'Z');
  res.json({ success: true });
});

app.post('/api/sync/stop', (req, res) => {
  syncStatus.shouldStop = true;
  res.json({ success: true });
});

app.get('/api/projects', async (req, res) => {
  const { search, limit = 50, offset = 0, langcode = 'de', filter } = req.query;
  
  try {
    let results = [];
    let totalCount = 0;

    // Always use local index for performance and consistent filtering
    if (!global.projectIndex) {
      console.log('Building search index...');
      const files = await fs.readdir(METADATA_DIR);
      global.projectIndex = files
        .filter(f => f.endsWith('.json'))
        .map(f => ({ machineName: f.replace('.json', '') }));
    }
    const { search, filter, langcode = 'de', offset = 0, limit = 50 } = req.query;
    console.log(`[API] Fetching projects. Filter: ${filter}, Lang: ${langcode}, Search: ${search}`);
    
    let filteredIndex = global.projectIndex;

    // 1. Search Filter
    if (search) {
      const searchTerm = search.toLowerCase();
      filteredIndex = filteredIndex
        .map(p => {
          let score = 10;
          if (p.machineName === searchTerm) score = 0;
          else if (p.machineName.startsWith(searchTerm)) score = 1;
          else if (p.machineName.includes(searchTerm)) score = 2;
          return { ...p, score };
        })
        .filter(p => p.score < 10)
        .sort((a, b) => a.score - b.score || a.machineName.localeCompare(b.machineName));
    } else {
      filteredIndex.sort((a, b) => a.machineName.localeCompare(b.machineName));
    }

    // 2. Status Pre-Calculation (Optimized)
    const transDir = path.join(TRANSLATIONS_DIR, langcode);
    const translatedFiles = await fs.readdir(transDir);
    const translatedSet = new Set(translatedFiles.map(f => f.replace('.json', '')));
    console.log(`[API] Found ${translatedSet.size} translated files in ${transDir}`);
    
    // 3. Apply Status Filter
    if (filter && filter !== 'all') {
      if (filter === 'translated' || filter === 'stale') {
        filteredIndex = filteredIndex.filter(p => translatedSet.has(p.machineName));
        console.log(`[API] Filtered to ${filteredIndex.length} translated items`);
      } else if (filter === 'missing') {
        filteredIndex = filteredIndex.filter(p => !translatedSet.has(p.machineName));
        console.log(`[API] Filtered to ${filteredIndex.length} missing items`);
      }
    }

    totalCount = filteredIndex.length;
    const paginated = filteredIndex.slice(parseInt(offset), parseInt(offset) + parseInt(limit));
    
    const enrichedData = [];
    for (const match of paginated) {
      const item = await fs.readJson(path.join(METADATA_DIR, `${match.machineName}.json`));
      
      // Calculate status reliably
      const transPath = path.join(TRANSLATIONS_DIR, langcode, `${match.machineName}.json`);
      let status = 'missing';

      if (await fs.pathExists(transPath)) {
        const trans = await fs.readJson(transPath);
        status = 'translated';
        
        const source = item.attributes.title + (item.attributes.body?.summary || '') + (item.attributes.body?.value || '');
        const sourceHash = crypto.createHash('md5').update(source).digest('hex');
        
        if (trans.source_hash && trans.source_hash !== sourceHash) {
          status = 'stale';
        }

        if (trans.title) item.attributes.title = trans.title;
        
        if (trans.body && typeof trans.body === 'object') {
          if (!item.attributes.body) item.attributes.body = {};
          if (trans.body.summary !== undefined) item.attributes.body.summary = fixRelativeUrls(trans.body.summary);
          if (trans.body.value !== undefined) item.attributes.body.value = fixRelativeUrls(trans.body.value);
        } else if (trans.body) {
          if (!item.attributes.body) item.attributes.body = {};
          item.attributes.body.value = fixRelativeUrls(trans.body);
          if (trans.summary) item.attributes.body.summary = fixRelativeUrls(trans.summary);
        }
      }

      if (!item.attributes.body?.summary && item.attributes.body?.value) {
        item.attributes.body.summary = getExcerpt(item.attributes.body.value);
      }

      // Extract Logo URL
      let logoUrl = null;
      if (item.attributes?.field_logo_url?.uri) logoUrl = item.attributes.field_logo_url.uri;
      else if (item.meta?.screenshot_urls?.length > 0) logoUrl = item.meta.screenshot_urls[0].url;

      item.meta = item.meta || {};
      item.meta.translation_status = status;
      item.meta.logo_url = logoUrl;

      // Double check filter (safety net)
      if (!filter || filter === 'all' || filter === status || (filter === 'translated' && status === 'stale')) {
        enrichedData.push(item);
      }
    }

    res.json({
      data: enrichedData,
      meta: { count: totalCount }
    });
  } catch (error) {
    console.error('Project fetch error:', error.message);
    res.status(500).json({ error: 'Failed to fetch projects' });
  }
});

app.get('/api/projects/:machine_name', async (req, res) => {
  const { machine_name } = req.params;
  const { langcode = 'de' } = req.query;
  const metadataPath = path.join(METADATA_DIR, `${machine_name}.json`);

  try {
    let item;
    if (await fs.pathExists(metadataPath)) {
      item = await fs.readJson(metadataPath);
      // On-the-fly image resolution if missing (for projects synced before image support)
      if (!item.meta?.screenshot_urls && item.relationships?.field_project_images?.data) {
        try {
          const response = await axios.get(DETAIL_API, {
            params: { 'filter[field_project_machine_name]': machine_name, 'include': 'field_project_images' }
          });
          const included = response.data.included || [];
          const fileMap = {};
          included.forEach(inc => {
            if (inc.type === 'file--file') fileMap[inc.id] = inc.attributes.uri.url;
          });
          item.meta = item.meta || {};
          item.meta.screenshot_urls = item.relationships.field_project_images.data.map(img => ({
            id: img.id,
            url: `https://www.drupal.org${fileMap[img.id] || ''}`,
            alt: img.meta?.alt || ''
          }));
          // Save back to cache
          await fs.writeJson(metadataPath, item);
        } catch (e) {
          console.error('Failed on-the-fly image fetch:', e.message);
        }
      }
    } else {
      // Fallback to API if not synced yet
      const response = await axios.get(DETAIL_API, {
        params: { 'filter[field_project_machine_name]': machine_name, 'include': 'field_module_categories,field_maintenance_status,field_development_status,uid,field_project_images' }
      });
      item = response.data.data[0];
    }

    if (!item) return res.status(404).json({ error: 'Project not found' });

    // Enrich with translation status
    const transPath = path.join(TRANSLATIONS_DIR, langcode, `${machine_name}.json`);
    let status = 'missing';

    if (await fs.pathExists(transPath)) {
      const trans = await fs.readJson(transPath);
      status = 'translated';
      const source = item.attributes.title + (item.attributes.body?.summary || '') + (item.attributes.body?.value || '');
      const sourceHash = crypto.createHash('md5').update(source).digest('hex');
      
      if (trans.source_hash && trans.source_hash !== sourceHash) {
        status = 'stale';
      }

      // Merge translations for the editor
      if (trans.title) item.attributes.title = trans.title;
      if (trans.body && typeof trans.body === 'object') {
        if (!item.attributes.body) item.attributes.body = {};
        if (trans.body.summary !== undefined) item.attributes.body.summary = fixRelativeUrls(trans.body.summary);
        if (trans.body.value !== undefined) item.attributes.body.value = fixRelativeUrls(trans.body.value);
      } else if (trans.body) {
        if (!item.attributes.body) item.attributes.body = {};
        item.attributes.body.value = fixRelativeUrls(trans.body);
        if (trans.summary) item.attributes.body.summary = fixRelativeUrls(trans.summary);
      }
    }
    
    item.meta = item.meta || {};
    // Fix relative URLs in body
    if (item.attributes?.body) {
      if (item.attributes.body.value) {
        item.attributes.body.value = fixRelativeUrls(item.attributes.body.value);
      }
      if (item.attributes.body.processed) {
        item.attributes.body.processed = fixRelativeUrls(item.attributes.body.processed);
      }
    }

    res.json(item);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch project details' });
  }
});

app.get('/api/categories', async (req, res) => {
  const { langcode = 'de' } = req.query;
  try {
    const response = await axios.get(CATEGORIES_API, {
      params: {
        'sort': 'name',
        'filter[status]': 1,
        'fields[taxonomy_term--module_categories]': 'name'
      }
    });
    
    const categories = response.data;
    const transPath = path.join(TRANSLATIONS_DIR, langcode, 'categories.json');
    let trans = {};
    if (await fs.pathExists(transPath)) {
      trans = await fs.readJson(transPath);
    }

    for (let item of categories.data) {
      item.meta = item.meta || {};
      item.meta.translated_name = trans[item.id] || null;
    }

    res.json(categories);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch categories' });
  }
});

app.post('/api/categories/translate', async (req, res) => {
  const { langcode = 'de', translations } = req.body;
  const transPath = path.join(TRANSLATIONS_DIR, langcode, 'categories.json');
  try {
    let existing = {};
    if (await fs.pathExists(transPath)) {
      existing = await fs.readJson(transPath);
    }
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
    if (!await fs.pathExists(sourcePath)) {
      return res.status(404).json({ error: 'Source file not found' });
    }
    
    const sourceData = await fs.readJson(sourcePath);
    let targetData = {};
    if (await fs.pathExists(targetPath)) {
      targetData = await fs.readJson(targetPath);
    }
    
    const merged = { ...targetData, ...sourceData };
    await fs.writeJson(targetPath, merged, { spaces: 4 });
    
    res.json({ success: true, count: Object.keys(sourceData).length });
  } catch (error) {
    res.status(500).json({ error: 'Failed to import categories' });
  }
});

app.get('/api/translations/:langcode/:machine_name', async (req, res) => {
  const { langcode, machine_name } = req.params;
  const filePath = path.join(TRANSLATIONS_DIR, langcode, `${machine_name}.json`);
  
  if (await fs.pathExists(filePath)) {
    res.json(await fs.readJson(filePath));
  } else {
    res.status(404).json({ error: 'Not found' });
  }
});

app.post('/api/translations/:langcode/:machine_name', async (req, res) => {
  const { langcode, machine_name } = req.params;
  const { title, summary, body, screenshot_alts } = req.body;
  
  try {
    // 1. Get current metadata for hashing
    const metadataPath = path.join(METADATA_DIR, `${machine_name}.json`);
    let sourceHash = '';
    if (await fs.pathExists(metadataPath)) {
      const item = await fs.readJson(metadataPath);
      const source = item.attributes.title + (item.attributes.body?.summary || '') + (item.attributes.body?.value || '');
      sourceHash = crypto.createHash('md5').update(source).digest('hex');
    }

    // 2. Prepare standardized structure
    const translationData = {
      machine_name,
      title,
      body: {
        value: body,
        summary: summary
      },
      screenshot_alts,
      reviewed: false,
      source_hash: sourceHash,
      updated: Math.floor(Date.now() / 1000)
    };
    
    await fs.ensureDir(path.join(TRANSLATIONS_DIR, langcode));
    await fs.writeJson(path.join(TRANSLATIONS_DIR, langcode, `${machine_name}.json`), translationData, { spaces: 2 });
    res.json({ success: true, source_hash: sourceHash });
  } catch (error) {
    console.error('Save translation error:', error.message);
    res.status(500).json({ error: 'Failed to save translation' });
  }
});

app.post('/api/import-local', async (req, res) => {
  const drupalEnDir = '/var/www/drupalcms/web/sites/default/files/pb_localizer/en';
  if (!await fs.pathExists(drupalEnDir)) {
    return res.status(404).json({ error: 'Local Drupal metadata directory not found' });
  }

  try {
    const files = await fs.readdir(drupalEnDir);
    const jsonFiles = files.filter(f => f.endsWith('.json'));
    
    for (const file of jsonFiles) {
      await fs.copy(path.join(drupalEnDir, file), path.join(METADATA_DIR, file));
    }
    
    res.json({ success: true, count: jsonFiles.length });
  } catch (error) {
    res.status(500).json({ error: 'Failed to import local files' });
  }
});

app.get('/:langcode/:filename', async (req, res) => {
  const { langcode, filename } = req.params;
  const filePath = path.join(TRANSLATIONS_DIR, langcode, filename);
  
  if (await fs.pathExists(filePath)) {
    res.sendFile(filePath);
  } else {
    res.status(404).json({ error: 'File not found' });
  }
});

app.get('/api/unsplash/random-bg', async (req, res) => {
  console.log('[API] Random Background Request received');
  try {
    const response = await axios.get('https://api.unsplash.com/photos/random', {
      params: {
        query: 'nature,forest,dark',
        orientation: 'landscape',
        client_id: UNSPLASH_ACCESS_KEY
      }
    });
    console.log('[API] Unsplash returned:', response.data.urls.regular);
    res.json({ url: response.data.urls.regular });
  } catch (error) {
    console.error('Unsplash Error:', error.response?.data || error.message);
    res.status(500).json({ error: 'Failed to fetch image' });
  }
});

app.listen(PORT, () => {
  console.log(`PB Translation Hub Backend running on http://localhost:${PORT}`);
});
