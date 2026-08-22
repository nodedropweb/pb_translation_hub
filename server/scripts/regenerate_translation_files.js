#!/usr/bin/env node
/**
 * regenerate_translation_files.js
 *
 * Reads all translations from the DB and writes them as JSON files to
 * data/translations/{langcode}/{machine_name}.json
 *
 * Run inside the server container:
 *   docker exec pb_translation_hub-server-1 node scripts/regenerate_translation_files.js
 *
 * Or locally (requires .env with DB credentials):
 *   node server/scripts/regenerate_translation_files.js
 */

'use strict';

require('dotenv').config({ path: require('path').join(__dirname, '..', '.env') });

const path = require('path');
const fs   = require('fs-extra');
const mysql = require('mysql2/promise');

const TRANSLATIONS_DIR = path.join(__dirname, '..', 'data', 'translations');

async function main() {
  if (!process.env.DB_PASSWORD) {
    console.error('FATAL: DB_PASSWORD environment variable is not set.');
    process.exit(1);
  }
  const db = await mysql.createConnection({
    host:     process.env.DB_HOST     || 'localhost',
    user:     process.env.DB_USER     || 'pb_hub',
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME     || 'pb_translation_hub',
  });

  console.log('Connected to DB.');

  const [rows] = await db.execute(`
    SELECT machine_name, langcode, title, summary, body,
           screenshot_alts, source_hash, is_reviewed, updated_at
    FROM translations
  `);

  console.log(`Found ${rows.length} translations.`);

  let written = 0;
  let skipped = 0;

  for (const row of rows) {
    let screenshotAlts = [];
    try {
      if (row.screenshot_alts) {
        screenshotAlts = JSON.parse(row.screenshot_alts);
      }
    } catch (_) {
      screenshotAlts = [];
    }

    const translationData = {
      machine_name:    row.machine_name,
      title:           row.title || '',
      body:            { value: row.body || '', summary: row.summary || '' },
      screenshot_alts: screenshotAlts,
      is_reviewed:     row.is_reviewed === 1,
      source_hash:     row.source_hash || '',
      updated:         row.updated_at
                         ? Math.floor(new Date(row.updated_at).getTime() / 1000)
                         : Math.floor(Date.now() / 1000),
    };

    const dir  = path.join(TRANSLATIONS_DIR, row.langcode);
    const file = path.join(dir, `${row.machine_name}.json`);

    try {
      await fs.ensureDir(dir);
      await fs.writeJson(file, translationData, { spaces: 2 });
      written++;
    } catch (e) {
      console.error(`  ERROR writing ${file}: ${e.message}`);
      skipped++;
    }
  }

  await db.end();

  console.log(`Done. Written: ${written}, Errors: ${skipped}`);
  const langs = await fs.readdir(TRANSLATIONS_DIR).catch(() => []);
  for (const lang of langs) {
    const files = await fs.readdir(path.join(TRANSLATIONS_DIR, lang)).catch(() => []);
    console.log(`  ${lang}: ${files.length} files`);
  }
}

main().catch(err => {
  console.error('Fatal:', err.message);
  process.exit(1);
});
