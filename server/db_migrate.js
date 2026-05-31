'use strict';
/**
 * db_migrate.js — Versioniertes DB-Migrations-System
 *
 * - Liest nummerierte SQL-Dateien aus ./migrations/ (001_*.sql, 002_*.sql, …)
 * - Trackt ausgeführte Migrationen in der Tabelle `schema_migrations`
 * - Jede Migration wird in einer Transaktion ausgeführt (Atomarität)
 * - Idempotent: bereits ausgeführte Migrationen werden übersprungen
 * - Wird beim Server-Start von index.js aufgerufen
 */

const fs   = require('fs');
const path = require('path');

const MIGRATIONS_DIR = path.join(__dirname, 'migrations');

/**
 * Erstellt die schema_migrations-Tabelle falls sie noch nicht existiert.
 */
async function ensureMigrationsTable(db) {
  await db.execute(`
    CREATE TABLE IF NOT EXISTS schema_migrations (
      version     VARCHAR(20)  NOT NULL,
      filename    VARCHAR(255) NOT NULL,
      applied_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY (version)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
  `);
}

/**
 * Gibt die Versionsnummer aus einem Dateinamen zurück.
 * '003_users_registration_fields.sql' → '003'
 */
function parseVersion(filename) {
  const match = filename.match(/^(\d+)_/);
  return match ? match[1] : null;
}

/**
 * Führt alle ausstehenden Migrationen in der richtigen Reihenfolge aus.
 * Gibt die Anzahl der neu angewendeten Migrationen zurück.
 */
async function runMigrations(db) {
  await ensureMigrationsTable(db);

  // Bereits angewendete Versionen laden
  const [appliedRows] = await db.execute('SELECT version FROM schema_migrations');
  const applied = new Set(appliedRows.map(r => r.version));

  // Alle .sql-Dateien einlesen und sortieren
  let files;
  try {
    files = fs.readdirSync(MIGRATIONS_DIR)
      .filter(f => f.endsWith('.sql'))
      .sort();
  } catch {
    console.warn('[Migration] migrations/ directory not found — skipping.');
    return 0;
  }

  let count = 0;

  for (const file of files) {
    const version = parseVersion(file);
    if (!version) {
      console.warn(`[Migration] Unbekanntes Dateinamenmuster übersprungen: ${file}`);
      continue;
    }

    if (applied.has(version)) {
      continue; // bereits angewendet
    }

    const sql = fs.readFileSync(path.join(MIGRATIONS_DIR, file), 'utf8');

    // Kommentare und leere Zeilen entfernen, dann in Einzel-Statements aufteilen
    const statements = sql
      .split('\n')
      .filter(line => !line.trim().startsWith('--') && line.trim() !== '')
      .join('\n')
      .split(/;\s*\n/)
      .map(s => s.trim())
      .filter(s => s.length > 0);

    const conn = await db.getConnection();
    try {
      await conn.beginTransaction();

      for (const stmt of statements) {
        await conn.execute(stmt);
      }

      await conn.execute(
        'INSERT IGNORE INTO schema_migrations (version, filename) VALUES (?, ?)',
        [version, file]
      );

      await conn.commit();
      console.log(`[Migration] ✓ ${file} angewendet`);
      count++;
    } catch (err) {
      await conn.rollback();
      console.error(`[Migration] ✗ ${file} fehlgeschlagen: ${err.message}`);
      // Nicht-fataler Fehler bei ADD COLUMN IF NOT EXISTS auf MariaDB <10.3 —
      // trotzdem als angewendet markieren damit kein Re-Run erfolgt
      if (err.message.includes('Duplicate column')) {
        await db.execute(
          'INSERT IGNORE INTO schema_migrations (version, filename) VALUES (?, ?)',
          [version, file]
        );
        console.warn(`[Migration] → Spalte bereits vorhanden, als angewendet markiert.`);
        count++;
      } else {
        throw err; // Echte Fehler weiterwerfen → Server-Start schlägt fehl
      }
    } finally {
      conn.release();
    }
  }

  if (count === 0) {
    console.log('[Migration] Datenbank ist aktuell — keine ausstehenden Migrationen.');
  } else {
    console.log(`[Migration] ${count} Migration(en) erfolgreich angewendet.`);
  }

  return count;
}

module.exports = { runMigrations };
