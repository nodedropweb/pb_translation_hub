const fs = require('fs-extra');
const path = require('path');
const mysql = require('mysql2/promise');

const TRANSLATIONS_DIR = path.join(__dirname, '..', 'data', 'translations');

async function sync() {
  if (!process.env.DB_PASSWORD) {
    console.error('FATAL: DB_PASSWORD environment variable is not set.');
    process.exit(1);
  }
  const db = await mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME || 'pb_hub'
  });

  const langcodes = await fs.readdir(TRANSLATIONS_DIR);
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
      const summary = data.body?.summary || '';
      const body = data.body?.value || '';
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
          source_hash=VALUES(source_hash)
      `, [machine_name, langcode, title, summary, body, screenshot_alts, source_hash]);
      console.log(`Synced translation for ${machine_name} (${langcode})`);
    }
  }
  await db.end();
}

sync().catch(console.error);
