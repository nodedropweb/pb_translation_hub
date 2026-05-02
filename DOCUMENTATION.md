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

---

## Deployment Guide

### Requirements
- **Node.js** (v18 or higher)
- **NPM**
- **MariaDB** (v10.5 or higher)
- **Git** (to clone the hub)
- **Apache/Nginx** (optional, for reverse proxying)

### Step-by-Step Deployment
1. **Clone the repository:**
   ```bash
   git clone <repository-url> pb_translation_hub
   cd pb_translation_hub
   ```

2. **Install Dependencies:**
   ```bash
   cd client && npm install
   cd ../server && npm install
   ```

3. **Configure Environment:**
   - The backend runs on port `3001` by default.
   - The frontend (dev) runs on port `5173`.
   - Update `server/index.js` if you have a specific Unsplash API key.

4. **Start the Hub:**
   ```bash
   chmod +x hubctl.sh
   ./hubctl.sh start
   ```

5. **Perform Initial Sync:**
   - Go to the Dashboard in the UI.
   - Click **"Full Sync"**. This will take some time as it pulls ~40,000 module entries from Drupal.org.

6. **Add Single Modules Manually:**
   - If a module is missing or newly created on Drupal.org, use the **"Add Single Module"** feature on the Dashboard.
   - Enter the `machine_name` (from the Drupal.org URL, e.g., `doc_to_html`).
   - The Hub will fetch the data, resolve images, and automatically persist it to both the MariaDB `projects` table and the `server/data/metadata/` directory.
   - Once added, the module is immediately available for translation.

7. **Connect Drupal to the Hub:**
   - In your Drupal site, configure the `pb_localizer` module (or relevant configuration) to use your Hub's URL as the API endpoint instead of `https://www.drupal.org`.
   - Example Mirror URL: `http://your-server-ip:3001`

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
