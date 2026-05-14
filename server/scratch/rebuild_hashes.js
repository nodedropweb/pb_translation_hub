const mysql = require('mysql2/promise');
const crypto = require('crypto');

async function fixHashes() {
  const db = await mysql.createConnection({
    host: '127.0.0.1',
    user: 'pb_hub',
    password: 'drupal',
    database: 'pb_translation_hub'
  });

  try {
    console.log('Fetching translations with missing or empty source_hash...');
    const [translations] = await db.execute(`
      SELECT t.machine_name, t.langcode, p.data 
      FROM translations t
      JOIN projects p ON t.machine_name = p.machine_name
      WHERE t.source_hash = '' OR t.source_hash IS NULL
    `);

    console.log(`Found ${translations.length} translations to process.`);

    let updated = 0;
    for (const trans of translations) {
      try {
        const item = JSON.parse(trans.data);
        const source = item.attributes.title + (item.attributes.body?.summary || '') + (item.attributes.body?.value || '');
        const sourceHash = crypto.createHash('md5').update(source).digest('hex');

        await db.execute(
          'UPDATE translations SET source_hash = ? WHERE machine_name = ? AND langcode = ?',
          [sourceHash, trans.machine_name, trans.langcode]
        );
        updated++;
        if (updated % 100 === 0) console.log(`  Updated ${updated} hashes...`);
      } catch (err) {
        console.error(`Error processing ${trans.machine_name}:`, err.message);
      }
    }

    console.log(`Finished. Updated ${updated} translations.`);
  } catch (err) {
    console.error('Task failed:', err);
  } finally {
    await db.end();
  }
}

fixHashes();
