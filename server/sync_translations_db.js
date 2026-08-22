const fs = require('fs-extra');
const path = require('path');
const mysql = require('mysql2/promise');

const TRANSLATIONS_DIR = path.join(__dirname, 'data', 'translations');

async function sync() {
  if (!process.env.DB_PASSWORD) {
    console.error('FATAL: DB_PASSWORD environment variable is not set.');
    process.exit(1);
  }
  const db = await mysql.createConnection({
    host: process.env.DB_HOST || '127.0.0.1',
    user: process.env.DB_USER || 'pb_hub',
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME || 'pb_translation_hub'
  });

  if (!await fs.pathExists(TRANSLATIONS_DIR)) {
    console.log("No translations directory found.");
    await db.end();
    return;
  }

  const langcodes = await fs.readdir(TRANSLATIONS_DIR);
  let synced = 0;
  let skipped = 0;

  for (const langcode of langcodes) {
    const langPath = path.join(TRANSLATIONS_DIR, langcode);
    const stat = await fs.stat(langPath);
    if (!stat.isDirectory()) continue;

    const files = await fs.readdir(langPath);
    for (const file of files) {
      if (!file.endsWith('.json') || file === 'categories.json') continue;
      
      const filePath = path.join(langPath, file);
      const fileStat = await fs.stat(filePath);
      const machine_name = file.replace('.json', '');
      
      // Check if DB already has a newer or equal version
      const [existing] = await db.execute(
        'SELECT updated_at FROM translations WHERE machine_name = ? AND langcode = ?',
        [machine_name, langcode]
      );

      if (existing.length > 0) {
        const dbTime = new Date(existing[0].updated_at).getTime();
        if (fileStat.mtimeMs <= dbTime) {
          skipped++;
          continue;
        }
      }

      const data = await fs.readJson(filePath);
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

      await db.execute(`
        INSERT INTO translations (machine_name, langcode, title, summary, body, screenshot_alts, source_hash) 
        VALUES (?, ?, ?, ?, ?, ?, ?) 
        ON DUPLICATE KEY UPDATE 
          title=VALUES(title), 
          summary=VALUES(summary), 
          body=VALUES(body), 
          screenshot_alts=VALUES(screenshot_alts), 
          source_hash=VALUES(source_hash),
          updated_at = CURRENT_TIMESTAMP
      `, [machine_name, langcode, title, summary, body, screenshot_alts, source_hash]);
      synced++;
    }
  }
  console.log(`Sync complete: ${synced} updated, ${skipped} skipped.`);
  await db.end();
}

sync().catch(console.error);
