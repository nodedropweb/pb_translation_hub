const mysql = require('mysql2/promise');
const fs = require('fs-extra');
const path = require('path');

const DATA_DIR = path.join(__dirname, 'data');
const METADATA_DIR = path.join(DATA_DIR, 'metadata');
const TRANSLATIONS_DIR = path.join(DATA_DIR, 'translations');

async function migrate() {
  console.log('Starting migration to MariaDB...');
  
  const connection = await mysql.createConnection({
    socketPath: '/var/run/mysqld/mysqld.sock',
    user: 'root',
    password: '',
    database: 'pb_translation_hub'
  });

  try {
    // 1. Create Tables
    console.log('Creating tables...');
    await connection.execute(`
      CREATE TABLE IF NOT EXISTS projects (
        machine_name VARCHAR(255) PRIMARY KEY,
        title VARCHAR(255),
        data LONGTEXT,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
      )
    `);

    await connection.execute(`
      CREATE TABLE IF NOT EXISTS translations (
        machine_name VARCHAR(255),
        langcode VARCHAR(10),
        title VARCHAR(255),
        summary TEXT,
        body LONGTEXT,
        screenshot_alts TEXT,
        source_hash VARCHAR(32),
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (machine_name, langcode)
      )
    `);

    // 2. Migrate Metadata (Projects)
    console.log('Migrating projects...');
    const projectFiles = (await fs.readdir(METADATA_DIR)).filter(f => f.endsWith('.json'));
    console.log(`Found ${projectFiles.length} projects.`);

    let count = 0;
    const batchSize = 100;
    
    for (let i = 0; i < projectFiles.length; i += batchSize) {
      const batch = projectFiles.slice(i, i + batchSize);
      const values = [];
      const placeholders = [];

      for (const file of batch) {
        try {
          const data = await fs.readJson(path.join(METADATA_DIR, file));
          const machineName = data.attributes.field_project_machine_name || file.replace('.json', '');
          const title = data.attributes.title || machineName;
          
          values.push(machineName, title, JSON.stringify(data));
          placeholders.push('(?, ?, ?)');
          count++;
        } catch (e) {
          console.error(`Error reading ${file}:`, e.message);
        }
      }

      if (values.length > 0) {
        await connection.query(
          `INSERT INTO projects (machine_name, title, data) VALUES ${placeholders.join(',')} 
           ON DUPLICATE KEY UPDATE title=VALUES(title), data=VALUES(data)`,
          values
        );
      }
      
      if (count % 1000 === 0) {
        console.log(`  Migrated ${count} projects...`);
      }
    }
    console.log(`Finished projects migration. Total: ${count}`);

    // 3. Migrate Translations
    console.log('Migrating translations...');
    const langcodes = await fs.readdir(TRANSLATIONS_DIR);
    let transCount = 0;

    for (const langcode of langcodes) {
      const langDir = path.join(TRANSLATIONS_DIR, langcode);
      if (!(await fs.lstat(langDir)).isDirectory()) continue;

      const transFiles = (await fs.readdir(langDir)).filter(f => f.endsWith('.json') && f !== 'categories.json');
      console.log(`  Processing ${langcode} (${transFiles.length} files)...`);

      for (let i = 0; i < transFiles.length; i += batchSize) {
        const batch = transFiles.slice(i, i + batchSize);
        const values = [];
        const placeholders = [];

        for (const file of batch) {
          try {
            const data = await fs.readJson(path.join(langDir, file));
            const machineName = data.machine_name || file.replace('.json', '');
            
            values.push(
              machineName,
              langcode,
              data.title || '',
              data.body?.summary || data.summary || '',
              data.body?.value || data.body || '',
              JSON.stringify(data.screenshot_alts || {}),
              data.source_hash || ''
            );
            placeholders.push('(?, ?, ?, ?, ?, ?, ?)');
            transCount++;
          } catch (e) {
            console.error(`Error reading translation ${file}:`, e.message);
          }
        }

        if (values.length > 0) {
          await connection.query(
            `INSERT INTO translations (machine_name, langcode, title, summary, body, screenshot_alts, source_hash) 
             VALUES ${placeholders.join(',')} 
             ON DUPLICATE KEY UPDATE title=VALUES(title), summary=VALUES(summary), body=VALUES(body), screenshot_alts=VALUES(screenshot_alts), source_hash=VALUES(source_hash)`,
            values
          );
        }
      }
    }
    console.log(`Finished translations migration. Total: ${transCount}`);

  } catch (error) {
    console.error('Migration failed:', error);
  } finally {
    await connection.end();
  }
}

migrate();
