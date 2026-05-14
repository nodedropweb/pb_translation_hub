# Project Browser Translation Hub - Documentation

*See also: [DATABASE.md](./DATABASE.md) for technical schema details.*

## Overview: What is this?
The **Project Description Browser** is a central server hub application that solves the problem of non-localized module metadata in the Drupal Project Browser. 

Traditionally, the Project Browser fetches data directly from Drupal.org via JSON:API. This data is exclusively in English. This Hub acts as the translation backend:
1. It **syncs** metadata for all ~40,000 Drupal modules locally.
2. It provides a premium, AI-assisted **editor** to translate this metadata.
3. It serves the translated data as a **Shadow API**. The Drupal module (named **Project Browser Localizer**) acts as a proxy, fetching the live data from Drupal.org and overlaying it with the translations hosted on this central server.

## Why use it? "Language is Trust"
Based on the influential CSA Research study "Can't Read, Won't Buy", language is a pivotal factor in adoption decisions:
- **Preference:** 72.4% of users are more likely to engage with products in their native language.
- **Necessity:** 52.4% buy only at websites presented in their own language.
- **Trust & Quality:** 67% consider localized info essential.
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
Every translation stores a `source_hash` (MD5) of the original English content. During a sync, if the Hub detects that the content on Drupal.org has changed, the hash won't match, and the translation is flagged as **"Stale"** (Veraltet). This alerts translators that they need to update the translation.

### 🤖 AI Auto-Run (Bulk Translation)
The Hub features a powerful AI Auto-Run engine that can translate hundreds of modules in minutes:
1. **Selection:** The engine targets the next X missing modules based on your current search and filter settings.
2. **Cost Estimation:** Before starting, the Hub provides a detailed token and cost estimation (based on Google Gemini pricing).
3. **Execution:** It processes modules one by one, providing real-time progress updates.
4. **Safety:** A **Stop** button allows you to interrupt the process at any time, saving the progress made so far.

### ⚡ Keyboard Shortcuts (Productivity)
The Editor is optimized for professional translators with several power-user shortcuts:
- `Ctrl + Alt + S`: **Save & Next** (Saves current work and jumps to the next untranslated project).
- `Ctrl + Alt + K`: **Copy AI Prompt** (Copies a pre-formatted prompt for manual AI use).
- `Ctrl + Alt + P`: **Toggle Preview** (Switches between Editor and Live Preview).
- `Ctrl + Alt + O`: **Open Project** (Opens the original project page on Drupal.org).
- `Ctrl + Alt + D`: **Skip Project** (Jumps to the next project without saving).

---

## 🛠️ Workflow Modes

The Hub supports three specialized workflow modes to focus your efforts:

1. **All Projects:** Shows everything in the system.
2. **Review Mode:** Shows only projects you have already translated. Perfect for a second pass or proofreading.
3. **Drupal 11 Focus (Priority):** Filters the list to only show modules that are explicitly compatible with Drupal 11. This ensures that the most relevant modules are translated first.

---

## Deployment Guide

### Requirements
- **Docker** (v24 or higher) with **Docker Compose**
- **SSH Access** to the production server
- **rsync** for codebase synchronization

### Step-by-Step Deployment
1. **Sync Codebase:**
   Use `rsync` to push the code to your server while preserving existing data:
   ```bash
   rsync -avz --progress --exclude 'node_modules' --exclude '.git' --exclude 'server/data' --exclude 'server/uploads' ./ user@your-server.com:/path/to/app/
   ```

2. **Configure Environment:**
   Ensure a `.env` file exists in the `server/` directory on the server with your Unsplash keys and database credentials.

3. **Start Containers:**
   ```bash
   ssh user@your-server.com "cd /path/to/app && docker compose build && docker compose up -d"
   ```

4. **Connect Drupal to the Hub:**
   In your Drupal site, set the Hub URL as the API endpoint:
   ```bash
   drush config:set pb_localizer.settings translation_mirror_url "https://your-hub-domain.com" --yes
   ```

## 🎨 Client Architecture & Modularization

The Translation Hub Client follows a modern, component-based React architecture designed for "snackability" and maintainability.

### Key Directories
- **`src/views/`**: Top-level route components (Dashboard, Editor, Profile, etc.).
- **`src/components/`**: Atomic and molecular UI components, split into `layout`, `shared`, and `ui` (including reusable modal overlays).
- **`src/context/`**: State management using the React Context API (Auth, Theme, Language, etc.).
- **`src/utils/`**: Shared constants, helpers, and API configuration.

### Design Principles
- **Aesthetic Excellence (Unified Glassmorphism)**: The application features a standardized, high-end Glassmorphic UI with dynamic, theme-agnostic styling. All visual variations (like 'Glassy' or 'Nature' themes) are driven globally via CSS variables in `index.css`, avoiding hardcoded, theme-conditional logic within individual components.
- **Accessibility**: Support for multiple languages (i18n ready) and keyboard shortcuts.
- **Performance**: Optimized rendering with conditional loading and efficient state propagation.
- **Modern Overlays**: Instead of dedicated pages, supplementary interfaces (like the Help Center) utilize a reusable, fully responsive, glassmorphic `Modal` component with custom entrance animations for a premium feel.

### 📸 Unsplash API Compliance
All integrations with the Unsplash API strictly adhere to their mandatory guidelines:
- **UTM Referral Tracking**: Every link to an Unsplash image or photographer profile must include `?utm_source=pb_translation_hub&utm_medium=referral`.
- **Photographer Attribution**: Clear and visible attribution to the photographer is required on any view displaying Unsplash imagery.
- **API Security**: All Unsplash access keys are secured via server-side `.env` variables and are never exposed to the frontend client.

---

## Maintenance & Operations

### Starting and Stopping
Use the included `hubctl.sh` script for easy management:
- `./hubctl.sh start`: Starts both backend and frontend in the background.
- `./hubctl.sh stop`: Stops all processes and cleans up PID files.
- `./hubctl.sh restart`: Performs a stop and start.
- `./hubctl.sh status`: Shows if the processes are running.

### Building for Production
If you want to serve the frontend via a production web server (like Nginx/Apache):
1. Build the assets:
   ```bash
   cd client && npm run build
   ```
2. Configure your web server to serve the `client/dist` directory.
3. Ensure the backend (Node) is running (e.g., via PM2 or systemd).

### Data Persistence & Backup
- **Primary Storage:** MariaDB database `pb_translation_hub`.
- **File-based Backup:** The system automatically mirrors all metadata and translations to `server/data/`.
  - `server/data/metadata/`: Original Drupal.org data backups.
  - `server/data/translations/`: Local translation backups.
  
**Important:** While the DB is the source of truth for the API, keeping the `server/data` folder ensures you have a portable version of your translations that can be re-imported into a new database using `node migrate_to_mysql.js`.
