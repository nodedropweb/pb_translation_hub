# PB Translation Hub

[![Drupal](https://img.shields.io/badge/Drupal-10.x%20%7C%2011.x-blue.svg)](https://drupal.org)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green.svg)](https://nodejs.org)
[![Flutter](https://img.shields.io/badge/Flutter-stable-54C5F8.svg)](https://flutter.dev)
[![MariaDB](https://img.shields.io/badge/MariaDB-10.5+-003545.svg)](https://mariadb.org)

A self-hosted translation server that provides localized Drupal Project Browser metadata to the [Project Browser Localizer](https://drupal.org/project/pb_localizer) Drupal module.

---

## Architecture

```
┌─────────────────────────────────────────────┐
│                  Drupal Site                │
│  Project Browser → pb_localizer module      │
│           │ JSON request                    │
└───────────┼─────────────────────────────────┘
            │
┌───────────▼─────────────────────────────────┐
│              PB Translation Hub             │
│                                             │
│  Flutter Admin UI  ←→  Node.js Server       │
│       :5173               :9901             │
│                            │                │
│                      ┌─────▼──────┐         │
│                      │  MariaDB   │         │
│                      └────────────┘         │
│                       + JSON backups        │
└─────────────────────────────────────────────┘
            │
┌───────────▼─────────────────────────────────┐
│             drupal.org JSON:API              │
│   Source of truth for module metadata       │
└─────────────────────────────────────────────┘
```

---

## Features

- **AI Bulk Translation** — translate thousands of modules via Google Gemini with cost estimation and stop-any-time support
- **Shadow API** — serves translated module metadata as a drop-in replacement for the Drupal.org JSON:API
- **Human Review Queue** — side-by-side split diff (original above, corrected below), one-click production approval; accessible only to users with the `reviewer` or `admin` role
- **Role-Based Access Control** — `translator` users work exclusively in the editor; `reviewer` and `admin` users have access to the review queue
- **User Management** — admin panel for activating pending users (with role selection), managing active users (deactivate / delete), and a 4-step self-registration flow
- **Stale Detection** — MD5-based detection of upstream English changes that invalidate translations
- **Intelligent Search** — SQL-scored search (exact > prefix > contains) with status filters (Priority, Review, Stale, Translated)
- **Single-project Sync** — instant refresh of one module's metadata from Drupal.org without a full sync
- **Sync Progress** — live progress bar showing total module count fetched from the first Drupal.org API response
- **DB Migration System** — numbered SQL migrations in `server/migrations/`, automatically applied on server start
- **Confetti Celebrations** — optional animated confetti on save/approve (toggle in settings), with 900 ms delay before navigation so the effect is visible
- **Splash Screen** — branded HTML preloader with minimum 2200 ms display time
- **Glassmorphism UI** — dark-mode-first Flutter interface with dynamic Unsplash backgrounds and multiple color themes
- **Bilingual Filter Labels** — each dashboard filter shows the German label (bold, 13 px) and the English label (smaller, 10 px) stacked
- **Keyboard-first workflow** — `Ctrl+Alt+S` save & next, `Ctrl+Enter` approve, and more
- **GDPR-compliant help center** — consent-gated video embeds, no external requests without user action

---

## Getting Started

### Requirements
- Docker + Docker Compose (recommended)
- *Or:* Node.js ≥ 18, MariaDB ≥ 10.5, Flutter stable SDK

### Docker (recommended)
```bash
cd /var/www/pb_translation_hub
docker compose up -d --build
```
App available at `http://localhost:5173`. Backend API at `http://localhost:9901`.

### Manual dev startup
```bash
./hubctl.sh start
```
Use `./hubctl.sh stop | restart | status | logs` to manage services.

See [FLUTTER_DOCUMENTATION.md](./FLUTTER_DOCUMENTATION.md) for Flutter-specific dev instructions.

---

## Configuration

Copy `server/.env.example` to `server/.env` and set:

```ini
UNSPLASH_ACCESS_KEY=...
UNSPLASH_SECRET_KEY=...
DB_HOST=127.0.0.1
DB_USER=pb_hub
DB_PASSWORD=...
DB_NAME=pb_translation_hub
JWT_SECRET=...
GEMINI_API_KEY=...
```

---

## Ports

| Service | Port |
|---|---|
| Flutter frontend (dev) | 5173 |
| Flutter frontend (Docker) | 5173 → nginx:80 |
| Node.js backend | 9901 |

To change the Docker host port, edit `docker-compose.yml` under the `client:` service.

---

## Documentation

| File | Contents |
|---|---|
| [FLUTTER_DOCUMENTATION.md](./FLUTTER_DOCUMENTATION.md) | Flutter client deep-dive: screens, Quill editors, image loading, CORS, Android, themes, Docker build |
| [AGENTS.md](./AGENTS.md) | AI agent / developer technical reference: layout, DB schema, API endpoints, widget patterns |
| [DATABASE.md](./DATABASE.md) | MariaDB schema, migration system, backup strategy |
| [DATA_STRUCTURE.md](./DATA_STRUCTURE.md) | JSON data shapes for projects and translations |
| [DOCUMENTATION.md](./DOCUMENTATION.md) | Architecture, workflow, and feature overview |
| [DEPLOYMENT.md](./DEPLOYMENT.md) | Production deployment with Docker + rsync, rolling restart, DB backup |
| [CONTRIBUTING.md](./CONTRIBUTING.md) | Contribution guidelines |
| [CHANGELOG.md](./CHANGELOG.md) | Version history and change log |
