# Developer & Agent Guidance (AGENTS.md)

This document provides a technical map of the Project Browser Translation Hub to assist AI agents and developers in extending or debugging the application.

## Directory Structure & Responsibilities

- **`/client`**: React (Vite) Frontend.
  - `src/App.jsx`: Main entry point. Contains all views (Dashboard, Editor, Categories, Help).
  - `src/App.css`: Global styles including theme definitions (Glassmorphism, Liquid, etc.).
- **`/server`**: Node.js (Express) Backend.
  - `index.js`: The heart of the Hub. Handles sync logic, API endpoints, and file storage.
  - `languages.json`: List of supported target languages.
- **`/server/data`**: Flat-file database.
  - `/metadata`: JSON files representing original Drupal.org module data. Filename format: `{machine_name}.json`.
  - `/translations/{langcode}`: Local translation files. Format: `{machine_name}.json`.
  - `status.json`: Persisted sync progress and stats.

## Core Services & Workflows

### 1. Sync Service (`syncProjects`)
- **Location:** `server/index.js`
- **Logic:** Paginated fetch from `https://www.drupal.org/jsonapi/index/project_modules`.
- **Filtering:** Uses `machine_name` waterfall sort for resumeable sync.
- **Data Enrichment:** Flattens image URLs and resolves file IDs to absolute URLs.

### 2. Shadow API Endpoint (`/api/projects`)
- **Logic:** 
  1. Builds a memory index of all metadata files on first request.
  2. Applies search scoring (exact match > prefix > includes).
  3. Merges local translations on-the-fly.
  4. Calculates `stale` status by comparing `source_hash` with current metadata.

### 3. Translation Storage Schema
Translations are stored in `/server/data/translations/{langcode}/{machine_name}.json` with the following structure:
```json
{
  "machine_name": "string",
  "title": "string",
  "body": {
    "value": "HTML string",
    "summary": "HTML string"
  },
  "screenshot_alts": {
    "file-uuid": "alt text"
  },
  "source_hash": "MD5 of source title + body + summary",
  "updated": "Timestamp"
}
```

## Adding New Features

### To add a new UI Theme:
1. Open `client/src/App.css`.
2. Define a new `.theme-name` class with CSS variables for `--primary`, `--bg-app`, `--bg-card`, etc.
3. Add the theme to the `themes` array in `AppContent` inside `client/src/App.jsx`.

### To add a new API Endpoint:
1. Add the route to `server/index.js`.
2. Ensure it handles `fs-extra` calls for file manipulation.
3. Restart the server using `./hubctl.sh restart`.

## Guardrails
- **File System:** Do not use a heavy database. Stick to JSON files in `data/` for portability.
- **Port Conflicts:** Backend defaults to 3001, Frontend to 5173.
- **Drupal.org Rate Limiting:** The sync service includes a `100ms` delay between pages to be a good citizen. Do not remove this without reason.
