# Developer & Agent Guidance (AGENTS.md)

This document provides a technical map of the Project Browser Translation Hub to assist AI agents and developers in extending or debugging the application.

## Core Stack
- **Frontend:** React (Vite)
- **Backend:** Node.js (Express)
- **Database:** MariaDB (Primary Storage)
- **Legacy/Backup:** Flat JSON files in `data/`

## Directory Structure & Responsibilities

- **`/client`**: React (Vite) Frontend. Modularized for scalability and AI efficiency.
  - `src/App.jsx`: Main entry point. Wraps the app in Context Providers.
  - `src/components/layout/AppContent.jsx`: Main UI shell including Sidebar, TopBar, and Routing.
  - `src/views/`: Individual page views (Dashboard, Editor, Settings, etc.).
  - `src/components/`: Reusable components split into `layout`, `shared`, and `ui`.
  - `src/context/`: Centralized state management (Auth, Language, Theme, Toast, Workflow).
  - `src/utils/`: Global constants (`constants.js`) and helper functions (`helpers.js`).
  - `src/index.css`: Global styles and theme definitions (Glassmorphism, Liquid, etc.).
- **`/server`**: Node.js (Express) Backend.
  - `index.js`: Core Hub logic. Handles sync, API endpoints, and MariaDB integration.
  - `migrate_to_mysql.js`: Migration utility for legacy JSON data.
  - `languages.json`: Supported target languages.
- **`/server/data` (Persistence Layer)**: 
  - `/metadata`: JSON backups of original Drupal.org module data.
  - `/translations/{langcode}`: JSON backups of local translations.
  - *Note:* The DB is the primary source of truth; JSON files act as a portable backup.

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

### 4. AI Bulk Translation Service (`/api/ai/translate-bulk`)
- **Logic:** 
  1. Accepts an array of `machineNames` and a `langcode`.
  2. Orchestrates the Gemini AI to translate title, summary, and body.
  3. Automatically strips absolute URLs to maintain relative path integrity.
  4. Supports **Cancellation** via a frontend-side `isCancelledRef` which breaks the request loop.

### 5. Workflow Engine (Priority & Review)
- **Priority Mode:** Filters projects against the `priority_projects` table (e.g., Drupal 11 focus).
- **Review Mode:** Specifically filters for projects where a translation exists but needs verification.
- **Stale Tracking:** Comparison of `source_hash` in `translations` vs current content hash.

## Adding New Features

### To add a new View:
1. Create a new component in `client/src/views/`.
2. Add the route to `client/src/components/layout/AppContent.jsx`.

### To add a new UI Theme:
1. Open `client/src/index.css`.
2. Define a new `.theme-name` class with CSS variables for `--primary`, `--bg-app`, `--bg-card`, etc.
3. Add the theme configuration to `THEMES` in `client/src/utils/constants.js`.

### To add a new API Endpoint:
1. Add the route to `server/index.js`.
2. Use the `db` connection pool for MariaDB queries.
3. Restart the server using `./hubctl.sh restart`.

## 📸 Unsplash API Compliance

To maintain our Production rate limit, all Unsplash integrations must follow these rules:

1. **Hotlinking:** Always use the `photo.urls` (e.g., `regular`) directly for `<img>` tags or CSS backgrounds. Do not proxy or re-host images.
2. **Download Tracking:** When a background is set, the app MUST trigger the `photo.links.download_location` endpoint. In this app, the frontend calls `/api/unsplash/track-download` which proxies the request to Unsplash.
3. **Attribution:** All links to Unsplash or photographers MUST include UTM parameters:
   - `utm_source=pb_translation_hub`
   - `utm_medium=referral`

## 🤖 Snackable Codebase
The codebase is intentionally fragmented into small, specialized files (< 500 lines where possible). This ensures:
- **Low Context Overhead:** Agents only need to read a few files to understand a feature.
- **Precise Edits:** Reduced risk of breaking unrelated logic.
- **Fast Build Times:** Efficient HMR and faster IDE performance.

## Guardrails
- **Database:** Always use the `db` pool for MariaDB access.
- **Redundancy:** When saving data, ensure it's written to both DB and File System if possible to maintain backup integrity.
- **Port Conflicts:** Backend defaults to 3001, Frontend to 5173.
- **Drupal.org Rate Limiting:** The sync service includes a `100ms` delay between pages. Do not remove this without reason.
