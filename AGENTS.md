# Developer & Agent Guidance (AGENTS.md)

This document provides a technical map of the Project Browser Translation Hub to assist AI agents and developers in extending or debugging the application.

## Core Stack
- **Frontend:** React (Vite)
- **Backend:** Node.js (Express)
- **Database:** MariaDB (Primary Storage)
- **Legacy/Backup:** Flat JSON files in `data/`

## Directory Structure & Responsibilities

- **`/client`**: React (Vite) Frontend.
  - `src/App.jsx`: Main entry point. Contains all views (Dashboard, Editor, Categories, Help).
  - `src/App.css`: Global styles including theme definitions (Glassmorphism, Liquid, etc.).
- **`/server`**: Node.js (Express) Backend.
  - `index.js`: The heart of the Hub. Handles sync logic, API endpoints, and MariaDB integration.
  - `migrate_to_mysql.js`: Utility script to move data from JSON to MariaDB.
  - `languages.json`: List of supported target languages.
- **`/server/data` (Legacy/Backup Layer)**: 
  - `/metadata`: JSON files representing original Drupal.org module data.
  - `/translations/{langcode}`: Local translation JSON files.
  - *Note:* The application now writes to both MariaDB and these files, but reads primarily from MariaDB.

## Database Schema (MariaDB)

### 1. Table `projects`
- `machine_name` (PK): Unique module identifier.
- `title`: Original English title.
- `data`: Full JSON metadata blob.

### 2. Table `translations`
- `machine_name`, `langcode` (Composite PK): Links to project and language.
- `title`, `summary`, `body`: Localized content.
- `screenshot_alts`: JSON blob for image descriptions.
- `source_hash`: MD5 hash of original content for stale detection.

## Core Services & Workflows

### 1. Sync Service (`syncProjects`)
- **Location:** `server/index.js`
- **Logic:** Paginated fetch from `https://www.drupal.org/jsonapi/index/project_modules`.
- **Storage:** Updates both MariaDB and local JSON files.

### 2. Shadow API Endpoint (`/api/projects`)
- **Logic:** 
  1. Uses SQL joins to efficiently filter by status (missing/translated).
  2. Applies search scoring directly in SQL (Exact > Prefix > Includes).
  3. Merges local translations on-the-fly from the `translations` table.

### 3. Single Project Sync (`/api/sync/project/:machine_name`)
- **Logic:**
  1. Fetches a single JSON:API entry from Drupal.org.
  2. Resolves and flattens image relationships.
  3. Persists the result to MariaDB (`projects` table) and File System.
  4. Instant availability as it bypasses the need for a full index rebuild.

## Adding New Features

### To add a new UI Theme:
1. Open `client/src/App.css`.
2. Define a new `.theme-name` class with CSS variables for `--primary`, `--bg-app`, `--bg-card`, etc.
3. Add the theme to the `themes` array in `AppContent` inside `client/src/App.jsx`.

### To add a new API Endpoint:
1. Add the route to `server/index.js`.
2. Use the `db` connection pool for MariaDB queries.
3. Restart the server using `./hubctl.sh restart`.

## Guardrails
- **Database:** Always use the `db` pool for MariaDB access.
- **Redundancy:** When saving data, ensure it's written to both DB and File System if possible to maintain backup integrity.
- **Port Conflicts:** Backend defaults to 3001, Frontend to 5173.
- **Drupal.org Rate Limiting:** The sync service includes a `100ms` delay between pages. Do not remove this without reason.
