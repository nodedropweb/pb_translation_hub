# Project Browser Translation Hub

[![Drupal](https://img.shields.io/badge/Drupal-10.x%20%7C%2011.x-blue.svg)](https://drupal.org)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green.svg)](https://nodejs.org)
[![MariaDB](https://img.shields.io/badge/MariaDB-10.5+-003545.svg?logo=mariadb&logoColor=white)](https://mariadb.org)
[![React](https://img.shields.io/badge/React-18-61dafb.svg)](https://reactjs.org)

> [!NOTE]
> **Living Documentation:** This repository is managed as part of the PB Translation Ecosystem. 
> Last Scan: 2026-05-08

---

## 🏛 Ecosystem Architecture

```mermaid
graph TD
    subgraph "Drupal Side"
        A[Project Browser] -- "TranslatedDrupalDotOrgSource" --> B[pb_translator module]
    end
    subgraph "Hub Side (Shadow API)"
        B -- "JSON Request" --> C[Node.js Server]
        C -- "Query" --> D[(MariaDB)]
        E[AI Worker] -- "Gemini API" --> C
        F[React Admin] -- "Editor UI" --> C
    end
```

---

## 🇺🇸 English

### What is this?
The **Project Description Browser** is the central server hub designed to bridge the language gap in the Drupal ecosystem. While the Drupal Project Browser allows users to discover modules directly within their site, much of the data remains in English. This Hub acts as a translation server that provides localized data to the **Project Browser Localizer** Drupal module. 

### Key Features
- **AI-Powered Translation:** Bulk translate modules using Google Gemini with specialized Drupal context prompts and real-time cost estimation.
- **AI Auto-Run with Stop-Support:** Process large batches of modules with the ability to pause or stop at any time without data loss.
- **Shadow API:** Intercepts live data from Drupal.org and overlays it with high-quality local translations.
- **Workflow Management:** Specialized modes for "Reviewing" existing translations and focusing on "Drupal 11" compatible modules.
- **Robust Search:** Intelligent search engine with auto-trimming and case-insensitive matching across machine names and titles.
- **Stale Detection:** Automatically tracks English source changes via hashing to alert when updates are needed.
- **Modern UI:** "Acrylic/Glassy" design with dynamic Unsplash backgrounds and productivity-focused keyboard shortcuts.
- **Privacy-First:** GDPR-compliant help center with consent-based media loading.
- **Snackable Architecture:** Modularized React codebase for optimal performance and AI-assisted maintenance.
- **Unsplash Compliance:** Fully compliant with Unsplash API Technical Guidelines (Hotlinking, Download Tracking, and UTM Attribution).

### 🐳 Docker Deployment (Recommended)
The easiest and most performant way to run the PB Translation Hub is via **Docker & Docker Compose**. It solves dependency issues and automatically uses all CPU cores for maximum performance.

#### Step 1: Install Docker on Ubuntu (For Beginners)
If Docker is not yet installed on your Ubuntu server, run these commands:
```bash
# Remove old versions (if any)
sudo apt-get remove docker docker-engine docker.io containerd runc

# Update package lists
sudo apt-get update

# Install Docker & Docker Compose
sudo apt-get install -y docker.io docker-compose-plugin

# Add your user to the docker group (to avoid typing 'sudo' every time)
sudo usermod -aG docker $USER
# Important: Log out and log back in for this to take effect!
```

#### Step 2: Start the App
Navigate to the app directory and start everything:
```bash
cd /var/www/drupalcms/pb_translation_hub
docker compose up -d --build
```
That's it! The app is now accessible at `http://localhost:5173` (Frontend) and the backend API runs on `http://localhost:9901`.

#### 💾 How do Docker "Volumes" work?
A Docker container is naturally "ephemeral" – if the container is deleted, all modified files inside are lost. To ensure our database and translations are not lost, we use **Volumes** in `docker-compose.yml`.

- **Database Volume (`db_data:/var/lib/mysql`):** Docker creates an internal, secure storage area on your Ubuntu system. All MariaDB database entries land in this persistent volume. Whether you stop, update, or delete the container – your database remains safe forever.
- **File Volume (`./server/data:/app/data`):** We use a "Bind Mount" here. We link the regular folder `server/data` (in this project directory) to the path `/app/data` inside the running Node.js container. *Why?* The Hub additionally saves all translations as `.json` files. Because we "bind" this folder directly to your server, you can view, copy, SCP, or commit these JSON backups to Git normally using Ubuntu.

#### ⚙️ Changing Ports
If port 5173 is already in use on your server, simply open `docker-compose.yml` with an editor (e.g., `nano docker-compose.yml`) and change the entry under `client`:
```yaml
  client:
    ports:
      - "8080:80"  # Change 5173 to 8080 or any free port
```
Then run `docker compose up -d` again to apply the change without data loss.

### 🛠️ Manual Commands (Without Docker)

| Action | Command |
| :--- | :--- |
| **Start** | `./hubctl.sh start` |
| **Stop** | `./hubctl.sh stop` |
| **Restart** | `./hubctl.sh restart` |
| **Status** | `./hubctl.sh status` |
| **Build Frontend** | `cd client && npm run build` |
| **Install Dependencies** | `npm install` (in `client` & `server`) |

---

## 🇩🇪 Deutsch

![Project Browser Translation Hub Oberfläche](./readme-shot-de.png)

### Was ist das?
Der **Project Description Browser** ist der zentrale Übersetzungs-Hub, der die Sprachbarriere im Drupal-Ökosystem überbrückt. Er liefert die lokalisierten Daten für das Drupal-Modul **Project Browser Localizer**. 

### Hauptfunktionen
- **KI-gestützte Übersetzung:** Massenübersetzung von Modulbeschreibungen via Google Gemini mit spezialisierten Drupal-Prompts und Echtzeit-Kostenschätzung.
- **KI-Auto-Lauf mit Stopp-Funktion:** Verarbeitet große Mengen an Modulen mit der Möglichkeit, den Prozess jederzeit zu unterbrechen, ohne Daten zu verlieren.
- **Shadow API:** Fängt Live-Daten von Drupal.org ab und überlagert sie mit hochwertigen lokalen Übersetzungen.
- **Workflow-Management:** Spezialisierte Modi für die "Revision" bestehender Übersetzungen und den Fokus auf "Drupal 11"-kompatible Module.
- **Intelligente Suche:** Suchmaschine mit automatischer Bereinigung (Trimming) und Case-Insensitive-Abgleich über Titel und Machine-Names.
- **Stale Detection:** Erkennt automatisch Änderungen an der englischen Originalquelle mittels Hashing.
- **Premium Design:** Modernes "Acrylic/Glassmorphism"-Design mit dynamischen Unsplash-Hintergründen und Fokus auf Produktivität.
- **Datenschutz:** DSGVO-konformes Hilfe-Center mit Consent-basiertem Laden von Medien.
- **Unsplash API Compliance:** Vollständige Einhaltung der Unsplash API Richtlinien (Hotlinking, Download-Tracking und UTM-Attribution).

### 🐳 Docker Deployment (Empfohlen)
Die einfachste und performanteste Methode, um den PB Translation Hub zu betreiben, ist über **Docker & Docker Compose**. Das löst Abhängigkeitsprobleme und nutzt automatisch alle CPU-Kerne für höchste Leistung.

#### Schritt 1: Docker unter Ubuntu installieren (für Anfänger)
Wenn Docker noch nicht auf Ihrem Ubuntu-Server installiert ist, führen Sie diese Befehle im Terminal aus:
```bash
# Alte Versionen entfernen (falls vorhanden)
sudo apt-get remove docker docker-engine docker.io containerd runc

# Paketquellen aktualisieren
sudo apt-get update

# Docker & Docker Compose installieren
sudo apt-get install -y docker.io docker-compose-plugin

# Den eigenen Nutzer zur Docker-Gruppe hinzufügen (damit man nicht immer 'sudo' tippen muss)
sudo usermod -aG docker $USER
# Wichtig: Danach einmal abmelden und wieder anmelden!
```

#### Schritt 2: App starten
Wechseln Sie in das Verzeichnis der App und starten Sie alles:
```bash
cd /var/www/drupalcms/pb_translation_hub
docker compose up -d --build
```
Das war's! Die App ist jetzt unter `http://localhost:5173` (Frontend) erreichbar, während die Backend-API auf Port `9901` läuft.

#### 💾 Wie funktionieren die "Volumes" in Docker?
Ein Docker-Container ist von Natur aus "flüchtig" – wenn der Container gelöscht wird, sind alle darin geänderten Dateien weg. Damit unsere Datenbank und unsere Übersetzungen nicht verloren gehen, nutzen wir in der `docker-compose.yml` sogenannte **Volumes** (virtuelle Laufwerke).

- **Datenbank-Volume (`db_data:/var/lib/mysql`):** Docker erstellt hierbei einen internen, sicheren Speicherbereich (`db_data`) auf Ihrem Ubuntu-System. Alle MariaDB-Datenbank-Einträge landen in diesem persistenten Docker-Volume. Egal ob Sie den Container stoppen, updaten oder löschen – Ihre Datenbank bleibt sicher erhalten.
- **Datei-Volume (`./server/data:/app/data`):** Hier nutzen wir ein sogenanntes "Bind Mount". Das bedeutet, wir verknüpfen den ganz normalen Ordner `server/data` (der sich in diesem Projekt-Verzeichnis befindet) mit dem Pfad `/app/data` innerhalb des laufenden Node.js-Containers. *Warum machen wir das so?* Der Hub speichert zur Sicherheit alle Übersetzungen zusätzlich als `.json`-Dateien ab. Da wir diesen Ordner direkt nach außen auf den Server "binden" (durchschleifen), können Sie die JSON-Backups jederzeit ganz normal im Ubuntu-Dateimanager ansehen, kopieren, per SCP herunterladen oder in Git einchecken. 

#### ⚙️ Ports ändern
Falls der Port 5173 auf Ihrem Server bereits belegt ist, öffnen Sie einfach die Datei `docker-compose.yml` mit einem Editor (z.B. `nano docker-compose.yml`) und ändern ganz unten den Eintrag unter `client`:
```yaml
  client:
    ports:
      - "8080:80"  # Ändern Sie 5173 zu 8080 oder jedem beliebigen freien Port
```
Anschließend einfach wieder `docker compose up -d` ausführen, um die Änderung ohne Datenverlust anzuwenden.

### 🛠️ Manuelle Commands / Befehle (ohne Docker)

| Action | Command |
| :--- | :--- |
| **Start** | `./hubctl.sh start` |
| **Stop** | `./hubctl.sh stop` |
| **Restart** | `./hubctl.sh restart` |
| **Status** | `./hubctl.sh status` |
| **Build Frontend** | `cd client && npm run build` |
| **Install Dependencies** | `npm install` (in `client` & `server`) |

---

For more details, see [DOCUMENTATION.md](./DOCUMENTATION.md), [DATA_STRUCTURE.md](./DATA_STRUCTURE.md), [DATABASE.md](./DATABASE.md) and [AGENTS.md](./AGENTS.md).
