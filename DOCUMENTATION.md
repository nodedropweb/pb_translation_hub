# Project Browser Translation Hub - Documentation

## Overview: What is this?
The **Project Browser Translation Hub** is a middleware application that solves the problem of non-localized module metadata in the Drupal Project Browser. 

Traditionally, the Project Browser fetches data directly from Drupal.org via JSON:API. This data is exclusively in English. The Translation Hub acts as a proxy:
1. It **syncs** metadata for all ~40,000 Drupal modules locally.
2. It provides an **editor** to translate this metadata.
3. It serves the translated data as a **Shadow API** that the Drupal site can use instead of the original Drupal.org API.

## Why use it?
- **Trust & Accessibility:** 72% of users are more likely to use software if it's in their native language.
- **Offline Capability:** Once synced, you can translate modules even with limited connectivity to Drupal.org.
- **Consistency:** Ensures that the module discovery experience feels native to the site builder's language.
- **AI Integration:** Optimized for modern translation workflows using Large Language Models.

---

## Technical Architecture

### The "Shadow API" Concept
The Hub mimics the Drupal.org JSON:API structure. When a Drupal site requests data from the Hub, the Hub:
1. Fetches the local metadata.
2. Checks if a translation exists for the requested language.
3. Overlays the original English fields with translated ones.
4. Returns the result in a format the Project Browser module understands.

### Stale Detection
Every translation stores a `source_hash` (MD5) of the original English content. During a sync, if the Hub detects that the content on Drupal.org has changed, the hash won't match, and the translation is flagged as **"Stale"** (Veraltet). This alerts translators that they need to update the translation.

---

## Deployment Guide

### Requirements
- **Node.js** (v18 or higher)
- **NPM**
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

6. **Connect Drupal to the Hub:**
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

### Data Backup
All data is stored in the `server/data` directory:
- `server/data/metadata/`: Original Drupal.org data.
- `server/data/translations/`: Your hard-earned translations.
**Always backup the `translations` folder!**
