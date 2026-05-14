# Data Structure & Sync Logic

This document explains the JSON data structures used in the PB Translation Hub and how they facilitate synchronization and "stale" translation detection.

## 1. Source Metadata (Drupal.org)
Stored in `server/data/metadata/*.json`. These files are mirrors of the Drupal.org JSON:API responses.

| Key | Type | Description | Purpose in Hub |
| :--- | :--- | :--- | :--- |
| `attributes.title` | String | Original English title. | Source for translation. |
| `attributes.changed` | ISO8601 | Last update time on Drupal.org. | **Critical for Sync.** Used to detect if the source has changed since the last translation. |
| `attributes.body.value` | HTML | Full project description. | Source for translation. |
| `attributes.body.summary`| Text | Short project summary. | Source for translation. |
| `field_project_machine_name`| String | Unique machine name (e.g., `webform`). | Primary key for linking data. |

## 2. Hub-Internal Translations
Stored in `server/data/translations/[langcode]/*.json`.

| Key | Type | Description | Purpose in Hub |
| :--- | :--- | :--- | :--- |
| `machine_name` | String | Reference to the project. | Linking. |
| `title`, `body.value`, etc.| Localized | The translated content. | Target data. |
| `updated` | Unix TS | Last save time in the Hub. | **Stale Detection.** Compared against `attributes.changed`. |
| `source_hash` | MD5 Hash | Hash of the English source (Title + Body). | **Validation.** Ensures the translation matches the exact content version. |
| `reviewed` | Boolean | Manual review status. | Quality control. |

## 3. Synchronization & Stale Detection Logic

To ensure high performance and avoid redundant work, the Hub follows these rules:

### A. Incremental Database Sync
When syncing JSON files into the MariaDB database, the Hub compares the file's modification time (`mtime`) with the `updated_at` column in the database. Only newer files are processed.

### B. Smart Stale Detection
A translation is marked as **Stale** (veraltet) only if:
1. `attributes.changed` (Source) is **newer** than `updated` (Translation).
2. **AND** the calculated MD5 hash of the current source does not match the `source_hash` stored in the translation.

This two-step verification prevents marking translations as stale if only non-relevant metadata (like a maintainer change) was updated on Drupal.org.
