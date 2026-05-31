# Database Schema — PB Translation Hub

MariaDB 11.8 · Datenbank: `pb_translation_hub` · User: `pb_hub`

---

## Tabellen-Übersicht

| Tabelle | Zweck |
|---|---|
| `projects` | Gespiegelte Modul-Metadaten von Drupal.org |
| `translations` | Übersetzte Inhalte (multi-language) |
| `priority_projects` | Priorisierungslisten (z.B. Drupal 11 Focus) |
| `ignored_projects` | Dauerhaft aus Warteschlangen ausgeblendete Module |
| `site_settings` | Globale App-Einstellungen (Key-Value) |
| `users` | Benutzerkonten mit Rollen, API-Keys, Sprachzuordnung |
| `schema_migrations` | Versionierungsprotokoll ausgeführter DB-Migrationen |

---

## Tabelle: `projects`

Lokaler Spiegel der Drupal.org JSON:API-Metadaten.

| Feld | Typ | Null | Beschreibung |
|---|---|---|---|
| `machine_name` | VARCHAR(255) | NO PK | Eindeutiger Drupal-Maschinenname (z.B. `ctools`) |
| `title` | VARCHAR(255) | YES | Lesbarer Modulname |
| `data` | LONGTEXT | YES | Vollständiges JSON:API-Objekt (Kategorien, Maintainer, Bilder etc.) |
| `updated_at` | TIMESTAMP | NO | Automatisch aktualisiert bei jedem Sync |

---

## Tabelle: `translations`

Alle lokalisierten Inhalte. Primärschlüssel ist `(machine_name, langcode)`.

| Feld | Typ | Null | Beschreibung |
|---|---|---|---|
| `machine_name` | VARCHAR(255) | NO PK | FK → `projects.machine_name` |
| `langcode` | VARCHAR(10) | NO PK | Sprachcode (z.B. `de`, `fr`, `ja`) |
| `title` | VARCHAR(255) | YES | Übersetzter Modultitel |
| `summary` | TEXT | YES | Kurzbeschreibung (HTML) |
| `body` | LONGTEXT | YES | Vollbeschreibung (HTML) |
| `screenshot_alts` | TEXT | YES | JSON: UUID → Alt-Text-Mapping |
| `source_hash` | VARCHAR(32) | YES | MD5 des englischen Quelltexts zum Zeitpunkt der Übersetzung |
| `is_reviewed` | TINYINT(1) | NO (0) | 0 = in Review-Queue · 1 = freigegeben |
| `reviewed_by` | VARCHAR(50) | YES | Username des Reviewers |
| `updated_at` | TIMESTAMP | NO | Letzter Speicherzeitpunkt |

**Stale-Detection:** Ändert sich der englische Quelltext in `projects`, weicht `source_hash` vom aktuellen MD5 ab → das Modul erscheint als „veraltet" im Dashboard.

---

## Tabelle: `priority_projects`

Definiert Priorisierungslisten für den Übersetzungsworkflow.

| Feld | Typ | Beschreibung |
|---|---|---|
| `machine_name` | VARCHAR(255) PK | Modulname |
| `list_name` | VARCHAR(50) PK | Listenkenner (Standard: `drupal11`) |

---

## Tabelle: `ignored_projects`

Module, die dauerhaft aus Review- und Fehlend-Listen ausgeblendet sind.

| Feld | Typ | Beschreibung |
|---|---|---|
| `machine_name` | VARCHAR(255) PK | Modulname |
| `langcode` | VARCHAR(10) PK | Sprachcode |

---

## Tabelle: `site_settings`

Key-Value-Store für globale Einstellungen.

| Feld | Typ | Beschreibung |
|---|---|---|
| `setting_key` | VARCHAR(100) PK | Einstellungsname |
| `setting_value` | TEXT | Wert |

**Bekannte Keys:**

| Key | Werte | Bedeutung |
|---|---|---|
| `registration_enabled` | `'1'` / `'0'` | Registrierungsformular global an/aus |

---

## Tabelle: `users`

Benutzerkonten mit Rollen, Sprachen und API-Keys.

| Feld | Typ | Null | Beschreibung |
|---|---|---|---|
| `id` | INT AUTO_INCREMENT | NO PK | Interne ID |
| `username` | VARCHAR(50) | NO UNIQUE | Anmeldename |
| `password` | VARCHAR(255) | NO | bcrypt-Hash |
| `name` | VARCHAR(100) | YES | Anzeigename |
| `email` | VARCHAR(100) | YES | E-Mail-Adresse |
| `target_languages` | LONGTEXT | YES | JSON-Array der Zielsprachen (z.B. `["de","fr"]`) |
| `user_type` | ENUM('translator','reviewer') | NO ('translator') | Rolle: Übersetzer hat keinen Review-Queue-Zugriff |
| `avatar_url` | VARCHAR(255) | YES | Relativer Pfad zu `/uploads/avatars/` |
| `created_at` | TIMESTAMP | YES | Registrierungszeitpunkt |
| `role` | VARCHAR(20) | YES ('user') | `'admin'` oder `'user'` |
| `is_active` | TINYINT(4) | YES (0) | 0 = wartend auf Freischaltung · 1 = aktiv |
| `google_ai_key` | VARCHAR(255) | YES | Eigener Google Gemini API-Key |
| `ai_batch_limit` | INT(11) | YES (5) | Max. Module pro KI-Massenübersetzung |
| `ai_prompt` | TEXT | YES | Individueller AI-Übersetzungsprompt |
| `deepl_api_key` | VARCHAR(255) | YES | Eigener DeepL API-Key |
| `last_reviewed_project` | VARCHAR(255) | YES | Zuletzt reviewtes Modul |

**Zugriffslogik:**

| `role` | `user_type` | Review-Queue | Admin-Panel |
|---|---|---|---|
| `admin` | – | ✓ | ✓ |
| `user` | `reviewer` | ✓ | ✗ |
| `user` | `translator` | ✗ | ✗ |

---

## Tabelle: `schema_migrations`

Protokolliert alle ausgeführten DB-Migrationen. Wird von `db_migrate.js` verwaltet.

| Feld | Typ | Beschreibung |
|---|---|---|
| `version` | VARCHAR(20) PK | Nummerische Version (z.B. `003`) |
| `filename` | VARCHAR(255) | Dateiname der Migration |
| `applied_at` | TIMESTAMP | Zeitpunkt der Ausführung |

---

## Migrations-System

Schema-Änderungen werden als nummerierte SQL-Dateien in `server/migrations/` verwaltet:

```
server/migrations/
  001_initial_schema.sql          — Basis-Schema (alle Kern-Tabellen)
  002_users_deepl_key.sql         — deepl_api_key-Spalte
  003_users_registration_fields.sql — target_languages + user_type
```

### Neue Migration anlegen

```bash
# Nächste freie Nummer wählen und Datei anlegen:
cat > server/migrations/004_meine_aenderung.sql << 'EOF'
-- Migration 004: Beschreibung
ALTER TABLE translations ADD COLUMN IF NOT EXISTS reviewer_note TEXT DEFAULT NULL;
EOF
```

**Regeln:**
- Dateiname immer `NNN_beschreibung.sql` (führende Nullen, snake_case)
- Nur additive Änderungen: `ADD COLUMN IF NOT EXISTS`, `CREATE TABLE IF NOT EXISTS`
- Keine `DROP`- oder `RENAME`-Operationen ohne explizite Koordination
- Jede Migration wird in einer **Transaktion** ausgeführt — schlägt sie fehl, wird rollback durchgeführt

### Automatische Ausführung

Beim Server-Start (`node index.js` bzw. Docker-Container-Start) ruft `db_migrate.js` automatisch alle ausstehenden Migrationen auf:

```
[Migration] ✓ 003_users_registration_fields.sql angewendet
[Migration] Datenbank ist aktuell — keine ausstehenden Migrationen.
```

Schlägt eine Migration fehl, bricht der Server mit `process.exit(1)` ab — es gibt kein stilles Ignorieren.

### Migration auf dem Produktionsserver deployen

```bash
# Empfohlen: DB-Backup vor Schema-Änderung
./deploy.sh --db-backup

# Oder explizit mit Backup-Flag
./deploy.sh --db-backup
```

Das Deploy-Script führt einen **Rolling Restart** durch:
1. DB-Container bleibt die ganze Zeit online
2. Server-Container wird neu gebaut und gestartet
3. Migrationen laufen beim Server-Start automatisch
4. Client-Container wird danach neu gebaut

---

## Nützliche SQL-Abfragen

### Fehlende Übersetzungen für eine Sprache

```sql
SELECT p.machine_name, p.title
FROM projects p
LEFT JOIN translations t ON p.machine_name = t.machine_name AND t.langcode = 'de'
WHERE t.machine_name IS NULL;
```

### Veraltete Übersetzungen (source_hash stimmt nicht mehr)

```sql
SELECT t.machine_name, t.langcode, t.source_hash
FROM translations t
JOIN projects p ON t.machine_name = p.machine_name
WHERE t.source_hash != MD5(p.data);
```

### Migrations-Status prüfen

```sql
SELECT * FROM schema_migrations ORDER BY version;
```

### Aktive Benutzer nach Typ

```sql
SELECT username, email, user_type,
       JSON_UNQUOTE(target_languages) AS sprachen
FROM users
WHERE is_active = 1
ORDER BY user_type, username;
```

---

## Backup & Wiederherstellung

### Backup erstellen (Produktion)

```bash
# Manuell auf dem Server
docker exec pb_translation_hub-db-1 \
  mysqldump -u pb_hub -p'PASSWORD' pb_translation_hub \
  | gzip > ~/backups/pb_db_$(date +%Y%m%d_%H%M%S).sql.gz

# Via deploy.sh
./deploy.sh --db-backup
```

### Wiederherstellung

```bash
# Dump einspielen
gunzip < backup.sql.gz | docker exec -i pb_translation_hub-db-1 \
  mysql -u pb_hub -p'PASSWORD' pb_translation_hub
```

### Erstinitialisierung (leeres Volume)

Beim ersten `docker compose up` auf einem neuen Server spielt MariaDB automatisch `server/data/db_export.sql.gz` ein (via `docker-entrypoint-initdb.d`). Danach laufen die Migrationen darüber.

> **Wichtig:** Der `db_export.sql.gz` enthält das Schema zum Zeitpunkt des Exports. Migrationen bringen ihn auf den aktuellen Stand. Beide zusammen garantieren eine konsistente Datenbank auf jedem neuen Server.
