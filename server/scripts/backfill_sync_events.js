// Einmaliger Backfill der Tabelle sync_events aus vorhandenen Zeitstempeln.
//
// Da bisher kein Verlauf existiert, wird er näherungsweise rekonstruiert:
//   - "description_changed" je Modul aus projects.changed (letzter Änderungs-
//     zeitpunkt auf Drupal.org). Eine Trennung "neu vs. nur geändert" ist
//     rückwirkend nicht möglich — alles wird als description_changed gebucht.
//   - "stale" je aktuell veralteter Übersetzung (MD5-Mismatch), datiert auf die
//     Woche der letzten Quelländerung (projects.changed).
//
// Idempotent: nutzt INSERT IGNORE gegen den UNIQUE-Key. Mehrfaches Ausführen
// fügt nichts doppelt hinzu.
//
// Ausführen (im server/-Verzeichnis):  node scripts/backfill_sync_events.js

require('dotenv').config();
const mysql = require('mysql2/promise');

async function main() {
  if (!process.env.DB_PASSWORD) {
    console.error('FATAL: DB_PASSWORD environment variable is not set.');
    process.exit(1);
  }
  const db = await mysql.createConnection({
    host:     process.env.DB_HOST || '127.0.0.1',
    user:     process.env.DB_USER || 'pb_hub',
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME || 'pb_translation_hub',
  });

  console.log('[backfill] Buche description_changed aus projects.changed …');
  // projects.changed ist ein ISO-8601-String (VARCHAR), z. B. "2026-03-03T21:15:17+00:00".
  // Die ersten 10 Zeichen sind das Datum (YYYY-MM-DD).
  const [descRes] = await db.execute(`
    INSERT IGNORE INTO sync_events (machine_name, event_type, langcode, event_date)
    SELECT machine_name, 'description_changed', NULL, DATE(LEFT(changed, 10))
    FROM projects
    WHERE changed IS NOT NULL AND changed != ''
  `);
  console.log(`[backfill] description_changed: ${descRes.affectedRows} Zeilen eingefügt.`);

  console.log('[backfill] Buche stale für aktuell veraltete Übersetzungen …');
  const [staleRes] = await db.execute(`
    INSERT IGNORE INTO sync_events (machine_name, event_type, langcode, event_date)
    SELECT t.machine_name, 'stale', t.langcode, DATE(LEFT(p.changed, 10))
    FROM translations t
    JOIN projects p ON t.machine_name = p.machine_name
    WHERE t.source_hash IS NOT NULL AND t.source_hash != ''
      AND p.changed IS NOT NULL AND p.changed != ''
      AND MD5(CONCAT(
        IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.title')), ''),
        IFNULL(NULLIF(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.body.summary')), 'null'), ''),
        IFNULL(JSON_UNQUOTE(JSON_EXTRACT(p.data, '$.attributes.body.value')), '')
      )) != t.source_hash
  `);
  console.log(`[backfill] stale: ${staleRes.affectedRows} Zeilen eingefügt.`);

  const [[{ total }]] = await db.execute('SELECT COUNT(*) AS total FROM sync_events');
  console.log(`[backfill] Fertig. sync_events enthält jetzt ${total} Zeilen.`);

  await db.end();
}

main().catch(err => {
  console.error('[backfill] Fehler:', err);
  process.exit(1);
});
