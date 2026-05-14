const fs = require('fs');
const path = require('path');
const mysql = require('mysql2/promise');

const METADATA_DIR = '/var/www/drupalcms/pb_translation_hub/server/data/metadata';

async function run() {
  const db = await mysql.createConnection({
    host: 'localhost',
    user: 'pb_hub',
    password: 'drupal',
    database: 'pb_translation_hub'
  });

  const files = fs.readdirSync(METADATA_DIR);
  let count = 0;

  for (const file of files) {
    if (!file.endsWith('.json')) continue;
    
    try {
      const data = JSON.parse(fs.readFileSync(path.join(METADATA_DIR, file), 'utf8'));
      const machineName = file.replace('.json', '');
      const changed = data.attributes?.changed || null;

      if (changed) {
        await db.execute(
          'UPDATE projects SET changed = ? WHERE machine_name = ?',
          [changed, machineName]
        );
        count++;
      }
    } catch (e) {
      console.error(`Error processing ${file}: ${e.message}`);
    }
  }

  console.log(`Updated ${count} projects with 'changed' timestamp.`);
  await db.end();
}

run();
