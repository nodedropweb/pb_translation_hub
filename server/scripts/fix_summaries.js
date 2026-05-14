const mysql = require('mysql2/promise');
const fs = require('fs-extra');
const path = require('path');

async function fix() {
  const db = await mysql.createConnection({
    host: '127.0.0.1',
    user: 'pb_hub',
    password: 'drupal',
    database: 'pb_translation_hub'
  });

  const [rows] = await db.execute('SELECT * FROM translations WHERE langcode = "de"');
  console.log(`Prüfe ${rows.length} deutsche Übersetzungen...`);

  let fixedCount = 0;

  for (const row of rows) {
    // Check if summary looks English or is same as original English while body is German
    // Typical English summary starters: "Provides", "The ", "Allows", "Integration", "A "
    const englishIndicators = ['Provides', 'The ', 'Allows', 'Integration', 'A ', 'This module'];
    const isEnglish = englishIndicators.some(ind => row.summary && row.summary.startsWith(ind));
    
    // We only fix if body is already German (contains "bietet", "ermöglicht", "ist", "Modul" etc.)
    const isGermanBody = row.body && (row.body.includes('bietet') || row.body.includes('ermöglicht') || row.body.includes('ist ') || row.body.includes('Modul'));

    if (isEnglish && isGermanBody) {
      console.log(`Fixe Summary für: ${row.machine_name}`);
      
      // Extract first sentence/paragraph from German body as new summary
      let firstSentence = row.body
        .split('</p>')[0]
        .replace(/<[^>]*>/g, '')
        .split('. ')[0]
        .trim();
        
      if (firstSentence.length > 200) {
        firstSentence = firstSentence.substring(0, 197) + '...';
      } else if (!firstSentence.endsWith('.')) {
        firstSentence += '.';
      }
      
      // Update DB
      await db.execute('UPDATE translations SET summary = ? WHERE machine_name = ? AND langcode = "de"', [firstSentence, row.machine_name]);
      
      // Update JSON file
      const filePath = path.join(__dirname, '../data/translations/de', `${row.machine_name}.json`);
      if (fs.existsSync(filePath)) {
        try {
          const json = fs.readJsonSync(filePath);
          if (json.body) {
             json.body.summary = firstSentence;
          } else {
             json.summary = firstSentence;
          }
          fs.writeJsonSync(filePath, json, { spaces: 4 });
        } catch (e) {
          console.error(`Fehler beim Schreiben von ${row.machine_name}.json: ${e.message}`);
        }
      }
      fixedCount++;
    }
  }
  
  console.log(`Fertig! ${fixedCount} Zusammenfassungen wurden korrigiert.`);
  await db.end();
}

fix().catch(err => {
  console.error(err);
  process.exit(1);
});
