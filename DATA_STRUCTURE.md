# Data Structure & Sync Logic

This document explains the JSON data structures used in the PB Translation Hub and how they facilitate synchronization and "stale" translation detection.

## 1. Source Metadata (Drupal.org)

Stored in `server/data/metadata/*.json`. These files are mirrors of the Drupal.org JSON:API responses.

| Key | Type | Description | Purpose in Hub |
| :--- | :--- | :--- | :--- |
| `attributes.title` | String | Original English title. | Source for translation. |
| `attributes.changed` | Unix timestamp | Last update time on Drupal.org. | **Critical for Sync.** Stored in `projects.changed` column. Used to detect if the source has changed since the last translation. |
| `attributes.body.value` | HTML | Full project description. | Source for translation. |
| `attributes.body.summary` | Text | Short project summary. | Source for translation. |
| `field_project_machine_name` | String | Unique machine name (e.g., `webform`). | Primary key for linking data. |

## 2. Hub-Internal Translations

Stored in `server/data/translations/[langcode]/*.json` (file-system backup layer).
The MariaDB `translations` table is the authoritative source for the API.

| Key | Type | Description | Purpose in Hub |
| :--- | :--- | :--- | :--- |
| `machine_name` | String | Reference to the project. | Linking. |
| `title`, `summary`, `body` | Localized | The translated content. | Target data. |
| `langcode` | String | Target language code, e.g. `de`. | Language routing. |
| `updated_at` | Timestamp | Last save time in the Hub. | Versioning. |
| `source_hash` | MD5 Hash | Hash of the English source (Title + Body). | **Stale Detection.** Ensures the translation matches the exact content version it was made against. |
| `is_reviewed` | Boolean (0/1) | Production approval status. | Quality control. Only `is_reviewed = 1` records are served to Drupal sites via the Shadow API. |
| `reviewed_by` | String | Username of the approving reviewer. | Audit trail. |

## 3. Synchronization & Stale Detection Logic

### A. Incremental Database Sync
When syncing module data from Drupal.org into MariaDB, the Hub stores the `attributes.changed` timestamp in `projects.changed`. During each sync pass, only modules whose `changed` value has increased are updated. This avoids rewriting records for unchanged modules.

### B. Smart Stale Detection
A translation is marked as **Stale** only if the calculated MD5 hash of the current English source (`projects.data`) does not match the `source_hash` stored in the translation at the time it was created. This two-step verification prevents marking translations as stale when only non-textual metadata changes (like a maintainer reassignment) are pushed to Drupal.org.

The stale query:
```sql
SELECT t.machine_name, t.langcode
FROM translations t
JOIN projects p ON t.machine_name = p.machine_name
WHERE t.source_hash != MD5(p.data);
```

## 4. Shadow API Response Shape

When the `pb_localizer` Drupal module requests a translated module listing, the Hub returns a JSON structure that mirrors the Drupal.org JSON:API format, with the following fields overridden by the Hub's translations when available:

```json
{
  "data": [
    {
      "id": "...",
      "attributes": {
        "title": "<translated title>",
        "body": {
          "value": "<translated body HTML>",
          "summary": "<translated summary>"
        }
      },
      "meta": {
        "translation": {
          "title": "<translated title>",
          "summary": "<translated summary>",
          "body": "<translated body HTML>",
          "is_reviewed": true,
          "langcode": "de"
        }
      }
    }
  ]
}
```

The `meta.translation` block is used by the Flutter review list screen to display translated titles and summaries in the review queue, so reviewers read the target-language content rather than the original English.
