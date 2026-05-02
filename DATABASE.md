# Database Schema - PB Translation Hub

This document provides a detailed specification of the MariaDB database structure used by the Project Browser Translation Hub. 

## Connection Information

- **Database Name:** `pb_translation_hub`
- **Default User:** `pb_hub`
- **Tables:** `projects`, `translations`

---

## Tables Overview

### 1. Table: `projects`
This table acts as the local mirror for metadata fetched from Drupal.org. It contains the "Source of Truth" for the English version of the modules.

| Field | Type | Null | Key | Default | Description |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `machine_name` | VARCHAR(255) | NO | PRI | NULL | The unique Drupal.org machine name (e.g., `ctools`). |
| `title` | VARCHAR(255) | YES | | NULL | The human-readable title of the module. |
| `data` | LONGTEXT | YES | | NULL | Full JSON:API response blob from Drupal.org. |
| `updated_at` | TIMESTAMP | NO | | CURRENT_TIMESTAMP | Auto-updated whenever the project metadata is synced. |

**Purpose:** 
Used for searching and as the source for generating translation forms. The `data` field contains complex attributes like categories, maintainer info, and image URLs.

---

### 2. Table: `translations`
This table stores all localized content created within the Hub. It supports multi-language setups via the `langcode` field.

| Field | Type | Null | Key | Default | Description |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `machine_name` | VARCHAR(255) | NO | PRI | NULL | Foreign key reference to `projects.machine_name`. |
| `langcode` | VARCHAR(10) | NO | PRI | NULL | The language code (e.g., `de`, `fr`, `es`). |
| `title` | VARCHAR(255) | YES | | NULL | The translated module title. |
| `summary` | TEXT | YES | | NULL | The translated short summary (HTML supported). |
| `body` | LONGTEXT | YES | | NULL | The translated full description (HTML supported). |
| `screenshot_alts` | TEXT | YES | | NULL | JSON object mapping file UUIDs to translated Alt-texts. |
| `source_hash` | VARCHAR(32) | YES | | NULL | MD5 hash of the English source at the time of translation. |
| `updated_at` | TIMESTAMP | NO | | CURRENT_TIMESTAMP | Timestamp of the last translation edit. |

**Primary Key:** Composite key of `(machine_name, langcode)`.

**Purpose:**
Stores the actual translation work. The `source_hash` is critical for "Stale Detection": if the English content in `projects` changes, its hash will no longer match this field.

---

## Multi-Language Support

The hub is designed to handle multiple languages. To add a new language:
1. Add the language to `server/languages.json`.
2. The Hub will automatically start querying for that `langcode` in the `translations` table.

### Query for Untranslated Modules (New Language)
To see how much work is left for a new language (e.g., French `fr`):
```sql
SELECT p.machine_name, p.title 
FROM projects p
LEFT JOIN translations t ON p.machine_name = t.machine_name AND t.langcode = 'fr'
WHERE t.machine_name IS NULL;
```

---

## Technical Maintenance

### Migration from JSON
If the database needs to be rebuilt from the flat-file backups in `server/data`, run:
```bash
node server/migrate_to_mysql.js
```

### Manual Backups
While the flat-files serve as a real-time backup, a standard SQL dump is recommended:
```bash
mysqldump -u pb_hub -p pb_translation_hub > backup.sql
```
