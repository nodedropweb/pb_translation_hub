require('dotenv').config();
const fs = require('fs-extra');
const path = require('path');
const mysql = require('mysql2/promise');

const DATA_DIR = path.join(__dirname, 'data');
const TRANSLATIONS_DIR = path.join(DATA_DIR, 'translations');

async function runCleanup() {
  console.log('Starting data cleanup for is_reviewed flag...');

  const db = await mysql.createConnection({
    host: process.env.DB_HOST || '127.0.0.1',
    user: process.env.DB_USER || 'pb_hub',
    password: process.env.DB_PASSWORD || 'drupal',
    database: process.env.DB_NAME || 'pb_translation_hub'
  });

  try {
    // 1. Database Cleanup
    console.log('Cleaning up database (Hard Reset)...');
    // Force all values to 0 for a clean start
    const [dbRes] = await db.execute('UPDATE translations SET is_reviewed = 0');
    console.log(`Reset ${dbRes.affectedRows} rows in database to "Not Reviewed".`);

    // 2. File System Cleanup
    if (await fs.pathExists(TRANSLATIONS_DIR)) {
      const languages = await fs.readdir(TRANSLATIONS_DIR);
      
      for (const lang of languages) {
        const langPath = path.join(TRANSLATIONS_DIR, lang);
        if (!(await fs.stat(langPath)).isDirectory()) continue;

        console.log(`Processing language: ${lang}...`);
        const files = await fs.readdir(langPath);
        let updatedFiles = 0;

        for (const file of files) {
          if (!file.endsWith('.json')) continue;

          const filePath = path.join(langPath, file);
          try {
            const data = await fs.readJson(filePath);
            
            // Force is_reviewed to false for a clean start
            if (data.is_reviewed !== false) {
              data.is_reviewed = false;
              await fs.writeJson(filePath, data, { spaces: 2 });
              updatedFiles++;
            }
          } catch (e) {
            console.error(`Error processing ${file}:`, e.message);
          }
        }
        console.log(`Updated ${updatedFiles} files for language ${lang}.`);
      }
    }

    console.log('Cleanup finished successfully.');
  } catch (error) {
    console.error('Cleanup failed:', error);
  } finally {
    await db.end();
  }
}

runCleanup();
