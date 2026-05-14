const fs = require('fs');
const path = require('path');
const mysql = require('mysql2/promise');

const TRANSLATIONS_DIR = '/var/www/drupalcms/pb_translation_hub/server/data/translations';

async function run() {
  const db = await mysql.createConnection({
    host: 'localhost',
    user: 'pb_hub',
    password: 'drupal',
    database: 'pb_translation_hub'
  });

  const langcodes = fs.readdirSync(TRANSLATIONS_DIR);
  let updatedCount = 0;

  for (const langcode of langcodes) {
    const langPath = path.join(TRANSLATIONS_DIR, langcode);
    if (!fs.statSync(langPath).isDirectory()) continue;

    const files = fs.readdirSync(langPath);
    for (const file of files) {
      if (!file.endsWith('.json') || file === 'categories.json') continue;
      
      const filePath = path.join(langPath, file);
      const machineName = file.replace('.json', '');
      
      try {
        const stats = fs.statSync(filePath);
        const data = JSON.parse(fs.readFileSync(filePath, 'utf8'));
        
        let needsSave = false;
        if (!data.updated) {
          // Use mtime as the baseline updated timestamp (in seconds)
          data.updated = Math.floor(stats.mtimeMs / 1000);
          needsSave = true;
        }

        // Update Database to match file mtime for sync consistency
        const dbTime = new Date(stats.mtimeMs).toISOString().slice(0, 19).replace('T', ' ');
        await db.execute(
          'UPDATE translations SET updated_at = ? WHERE machine_name = ? AND langcode = ?',
          [dbTime, machineName, langcode]
        );

        if (needsSave) {
          fs.writeFileSync(filePath, JSON.stringify(data, null, 4));
          updatedCount++;
        }
      } catch (e) {
        console.error(`Error processing ${filePath}: ${e.message}`);
      }
    }
  }

  console.log(`Cleanup complete. Added 'updated' key to ${updatedCount} files and synchronized DB timestamps.`);
  await db.end();
}

run();
