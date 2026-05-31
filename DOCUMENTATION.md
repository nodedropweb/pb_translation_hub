# Project Browser Translation Hub — Documentation

*See also: [DATABASE.md](./DATABASE.md) for technical schema details.*

## Overview: What is this?

The **PB Translation Hub** is a central server application that solves the problem of non-localized module metadata in the Drupal Project Browser.

Traditionally, the Project Browser fetches data directly from Drupal.org via JSON:API. That data is exclusively in English. This Hub acts as the translation backend:

1. It **syncs** metadata for all ~40,000 Drupal modules locally.
2. It provides a premium, AI-assisted **editor** to translate this metadata.
3. It serves the translated data as a **Shadow API**. The Drupal module (named **Project Browser Localizer**) acts as a proxy, fetching live data from Drupal.org and overlaying it with translations hosted on this central server.

## Why use it? "Language is Trust"

Based on the influential CSA Research study "Can't Read, Won't Buy", language is a pivotal factor in adoption decisions:

- **Preference:** 72.4% of users are more likely to engage with products in their native language.
- **Necessity:** 52.4% buy only at websites presented in their own language.
- **Trust & Quality:** 67% consider localized information essential.
- **Value over Price:** 56.2% value language more than a lower price point.

By translating the Project Browser metadata, you build trust and remove the "English-only" barrier for global site builders.

---

## Technical Architecture

### The Proxy & "Shadow API" Concept

The Hub mimics the Drupal.org JSON:API structure. When the **Project Browser Localizer** module (installed on a client Drupal site) requests data:

1. The module intercepts the standard Drupal.org request.
2. It fetches the corresponding translated fields from this Hub.
3. It overlays the original English fields with the translated ones.
4. The site builder sees a seamless, localized Project Browser experience.

### Privacy-First Design

The Hub includes a built-in help center with a 100% GDPR-compliant YouTube widget. It uses a "Consent Wall" with a blurred, theme-aware placeholder, ensuring absolutely no connection to Google servers is made until the user explicitly clicks "Consent & Load Video".

### Stale Detection

Every translation stores a `source_hash` (MD5) of the original English content. During a sync, if the Hub detects that the content on Drupal.org has changed, the hash will not match, and the translation is flagged as **"Stale"**. This alerts translators that the translation needs updating.

### AI Auto-Run (Bulk Translation)

The Hub features a powerful AI Auto-Run engine that can translate hundreds of modules in minutes:

1. **Selection:** The engine targets the next X missing modules based on your current search and filter settings. The limit is capped at 150 per run to ensure server stability.
2. **Cost Estimation:** Before starting, the Hub provides a detailed token and cost estimation based on Google Gemini pricing.
3. **Drafting:** AI translations are saved as **Suggestions**, ensuring they do not overwrite manual work without a second look.
4. **Safety:** A **Stop** button allows you to interrupt the process at any time, saving the progress made so far.

### Human Review & Suggestion Engine

To ensure translation quality, the Hub implements a strict "Human-in-the-Loop" workflow:

- **Multiple Suggestions:** Every module can have multiple translation versions (e.g. from different AI models or users). These are stored in a dedicated suggestions database.
- **Split Diff View:** The **Review Screen** shows the original text above (red) and the corrected text below (green) in a side-by-side split layout. No overlapping text, no confusion.
- **Production Approval:** A translation is only marked as `is_reviewed: true` and delivered to end-users (via the JSON files) after a human explicitly confirms it.
- **Review Queue Access:** Only users with the `reviewer` or `admin` role can access the review queue. Users with the `translator` role are redirected away by both the router guard (client) and a server-side middleware guard.
- **Optimistic Navigation:** When a reviewer approves a translation, the app navigates to the next module immediately while the save POST runs in the background. This keeps the workflow fast.

### Role-Based Access Control

The Hub supports three user types that determine which parts of the application are accessible:

| Role | `user_type` | Review Queue | Admin Panel |
|---|---|---|---|
| `admin` | — | Yes | Yes |
| `user` | `reviewer` | Yes | No |
| `user` | `translator` | No | No |

Access is enforced at two levels:
- **Router guard** in the Flutter client redirects `translator` users away from `/review*` routes.
- **Server middleware** returns HTTP 403 for any `translator` user calling review-related endpoints.

### User Management

Administrators manage the user lifecycle from the admin panel:

- **Pending Users:** New registrations start as inactive (`is_active = 0`). An admin sees the list of pending users, assigns them a role (`translator` or `reviewer`), and activates their account.
- **Active Users:** Admins can deactivate (ban) or permanently delete active users.
- **Reviewer Badge:** If a user requested the `reviewer` role during registration, a badge is shown next to their name in the pending list.

### Self-Registration Flow

New users register through a 4-step wizard:

1. **Account** — username, email, password
2. **Role** — choose `translator` or `reviewer` (stored as `requested_role`)
3. **Languages** — select target translation languages
4. **API Keys** — optionally provide a personal Google Gemini API key

Registration can be disabled globally via `site_settings.registration_enabled = '0'`.

### DB Migration System

Schema changes are managed as numbered SQL files in `server/migrations/`. The migration runner `server/db_migrate.js` is called automatically on server start. It:

1. Creates the `schema_migrations` table if it does not exist.
2. Reads all `.sql` files in `server/migrations/` sorted numerically.
3. Skips migrations already recorded in `schema_migrations`.
4. Executes pending migrations inside a transaction.
5. Exits with code 1 on failure — no silent skipping.

### Keyboard Shortcuts (Productivity)

The Editor is optimized for professional translators with power-user shortcuts:

- `Ctrl+Alt+S` — **Save & Next** (save current translation and jump to next untranslated project)
- `Alt+P` — **Toggle Preview** (switch between Editor and Live Preview)
- `Ctrl+Alt+D` — **Skip Project** (jump to next project without saving)

---

## Workflow Modes

The Hub supports specialized workflow modes to focus your efforts:

1. **All Projects:** Shows everything in the system.
2. **Review Queue:** Shows translated projects awaiting human approval (reviewer/admin only).
3. **Drupal 11 Focus (Priority):** Filters the list to only show modules explicitly compatible with Drupal 11.
4. **Stale:** Shows translations where the English source has changed since the translation was made.

---

## Maintenance & Operations

### Starting and Stopping

Use the included `hubctl.sh` script for easy management:

- `./hubctl.sh start` — starts both backend and frontend in the background
- `./hubctl.sh stop` — stops all processes and cleans up PID files
- `./hubctl.sh restart` — performs a stop followed by a start
- `./hubctl.sh status` — shows if the processes are running and their PIDs
- `./hubctl.sh logs` — tails both service logs live

### Building for Production

See [DEPLOYMENT.md](./DEPLOYMENT.md) for the full production deployment guide including the rolling restart procedure and database backup workflow.

### Data Persistence & Backup

- **Primary Storage:** MariaDB database `pb_translation_hub`.
- **File-based Backup:** The system automatically mirrors all metadata and translations to `server/data/`.
  - `server/data/metadata/` — original Drupal.org data snapshots
  - `server/data/translations/` — per-language translation backups

The `server/data/` folder provides a portable version of your translations that can be re-imported into a new database using `node migrate_to_mysql.js`.

---

## Deployment Guide

See [DEPLOYMENT.md](./DEPLOYMENT.md) for the complete step-by-step production deployment procedure, including the `deploy.sh` rolling restart script, the `--db-backup` flag, Nginx configuration, and the systemd service setup.

To connect a Drupal site to the Hub after deployment:

```bash
drush config:set pb_localizer.settings hub_url "https://pb.drupaltutorials.de" --yes
drush config:set pb_localizer.settings hub_port "443" --yes
```
