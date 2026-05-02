# Project Browser Translation Hub

[![Drupal](https://img.shields.io/badge/Drupal-10.x-blue.svg)](https://drupal.org)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green.svg)](https://nodejs.org)
[![React](https://img.shields.io/badge/React-18-61dafb.svg)](https://reactjs.org)

> **EN:** A specialized middleware and editor for translating the Drupal Project Browser ecosystem.
> 
> **DE:** Ein spezialisiertes Middleware- und Editor-Tool zur Übersetzung des Drupal Project Browser Ökosystems.

---

## 🇺🇸 English

### What is this?
The **Project Browser Translation Hub** is a powerful tool designed to bridge the language gap in the Drupal ecosystem. While the Drupal Project Browser allows users to discover modules directly within their site, much of the data (titles, summaries, descriptions) remains in English. This Hub acts as a "Shadow API" that syncs data from Drupal.org and allows translators to provide localized content.

### Key Features
- **Shadow API:** Intercepts live data and overlays it with local translations.
- **Stale Detection:** Automatically detects when the original English source on Drupal.org has changed.
- **AI-Powered Workflow:** Specialized prompts for LLMs (Gemini/ChatGPT) to translate HTML blocks while preserving links.
- **Productivity First:** Full keyboard shortcut support and bulk import capabilities.
- **Stunning UI:** Modern glassmorphism design with dynamic Unsplash backgrounds.

### Quick Start
1. **Start the Hub:** `./hubctl.sh start`
2. **Access UI:** `http://localhost:5173`
3. **Backend API:** `http://localhost:3001`

---

## 🇩🇪 Deutsch

### Was ist das?
Der **Project Browser Translation Hub** ist ein Werkzeug, das die Sprachbarriere im Drupal-Ökosystem überbrückt. Während der Project Browser es Nutzern ermöglicht, Module direkt in ihrer Website zu entdecken, bleiben viele Daten (Titel, Zusammenfassungen, Beschreibungen) auf Englisch. Dieser Hub fungiert als "Shadow API", die Daten von Drupal.org synchronisiert und es Übersetzern ermöglicht, lokalisierte Inhalte bereitzustellen.

### Hauptfunktionen
- **Shadow API:** Fängt Live-Daten ab und überlagert sie mit lokalen Übersetzungen.
* **Stale Detection:** Erkennt automatisch, wenn sich die englische Originalquelle auf Drupal.org geändert hat.
* **KI-gestützter Workflow:** Spezielle Prompts für LLMs (Gemini/ChatGPT), um HTML-Blöcke unter Beibehaltung von Links zu übersetzen.
* **Produktivität:** Volle Unterstützung für Tastaturkürzel und Bulk-Import-Funktionen.
* **Premium Design:** Modernes Glassmorphism-Design mit dynamischen Unsplash-Hintergründen.

### Schnellstart
1. **Hub starten:** `./hubctl.sh start`
2. **UI aufrufen:** `http://localhost:5173`
3. **Backend API:** `http://localhost:3001`

---

## Commands / Befehle

| Action | Command |
| :--- | :--- |
| **Start** | `./hubctl.sh start` |
| **Stop** | `./hubctl.sh stop` |
| **Restart** | `./hubctl.sh restart` |
| **Status** | `./hubctl.sh status` |
| **Build Frontend** | `cd client && npm run build` |
| **Install Dependencies** | `npm install` (in both `client` and `server`) |

---

For more details, see [DOCUMENTATION.md](./DOCUMENTATION.md) and [AGENTS.md](./AGENTS.md).
