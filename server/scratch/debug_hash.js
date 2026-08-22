require('dotenv').config({ path: require('path').join(__dirname, '..', '.env') });
const mysql = require('mysql2/promise');
const crypto = require('crypto');

async function debugHash() {
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

  try {
    const [rows] = await db.execute(`
      SELECT t.machine_name, t.source_hash, p.data 
      FROM translations t
      JOIN projects p ON t.machine_name = p.machine_name
      WHERE t.source_hash != '' AND t.source_hash IS NOT NULL
      LIMIT 5
    `);

    for (const row of rows) {
      const item = JSON.parse(row.data);
      const title = item.attributes.title || '';
      const summary = item.attributes.body?.summary || '';
      const value = item.attributes.body?.value || '';
      
      const source = title + summary + value;
      const calculatedHash = crypto.createHash('md5').update(source).digest('hex');
      
      console.log(`Project: ${row.machine_name}`);
      console.log(`  Stored:     ${row.source_hash}`);
      console.log(`  Calculated: ${calculatedHash}`);
      console.log(`  Match:      ${row.source_hash === calculatedHash}`);
      if (row.source_hash !== calculatedHash) {
        console.log(`  Title: "${title}"`);
        console.log(`  Summary length: ${summary.length}`);
        console.log(`  Value length: ${value.length}`);
      }
      console.log('---');
    }
  } finally {
    await db.end();
  }
}

debugHash();
