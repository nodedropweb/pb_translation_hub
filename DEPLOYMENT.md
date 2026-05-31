# Deployment Guide: PB Translation Hub

This document describes the complete deployment process for the PB Translation Hub on the production server.

## Infrastructure Overview

| Component | Detail |
|---|---|
| **Production Server** | `drupaltutorials.de` |
| **App URL** | `https://pb.drupaltutorials.de` |
| **App Directory (Server)** | `/home/joachim/pb_translation_hub` |
| **Operating System** | Ubuntu 26.04 LTS |
| **Docker** | 29.4.2 |
| **Docker Compose** | v5.1.3 |
| **Nginx** | Let's Encrypt SSL via Certbot |
| **Systemd Service** | `pb-translation-hub.service` |

## Architecture (Docker)

```
Internet → Nginx (443 HTTPS) → localhost:5173 → [Flutter Web Container]
                                                       ↓ /api/ proxy
                                               [Node.js Server Container :9901]
                                                       ↓
                                               [MariaDB Container]
                                                 (Docker Volume: db_data)
```

### Containers
| Service | Image | Internal Port | Description |
|---|---|---|---|
| `db` | `mariadb:11.8` | 3306 | Database (persistent Docker volume) |
| `server` | built from `./server` | 9901 | Node.js/Express API (PM2 cluster) |
| `client` | built from `./flutter_client` | 80 | Flutter Web + Nginx proxy |

---

## 1. Prerequisites

- **Docker** ≥ 24 with **Docker Compose** (present on production server)
- **SSH access** to the server (key-based, no password required)
- `rsync` installed locally
- Valid API keys on the server (Unsplash, Gemini/Google AI)

---

## 2. Deployment via deploy.sh

The `deploy.sh` helper script in the project root automates the deployment process.

```bash
# Run from local WSL instance (from /var/www/pb_translation_hub)
./deploy.sh
```

### Rolling Restart

`deploy.sh` performs a **rolling restart** — the database container is never taken offline:

1. Files are transferred to the server via rsync (live data is never overwritten).
2. The **server container** is rebuilt and restarted. On startup, `db_migrate.js` automatically applies any pending DB migrations.
3. The **client container** is rebuilt and restarted afterward.
4. The **db container** stays online throughout the entire process.

This means the database is available during the entire deploy and there is no downtime window for the data layer.

### Optional: DB Backup Before Deploy

To create a database backup before applying schema changes:

```bash
./deploy.sh --db-backup
```

With the `--db-backup` flag, the script runs a `mysqldump` inside the `db` container and saves the compressed dump to `~/backups/pb_db_YYYYMMDD_HHMMSS.sql.gz` on the production server before any containers are rebuilt.

### Migrations Log

After the server container starts, the deploy script waits for the container log to confirm that migrations completed:

```
[Migration] ✓ 004_users_requested_role.sql applied
[Migration] Database is up to date — no pending migrations.
```

If a migration fails, the server exits with code 1 and the deploy script reports the error.

---

## 3. Manual rsync (Alternative)

```bash
rsync -avz --progress \
  --exclude '.git' \
  --exclude 'node_modules' \
  --exclude 'flutter_client/build' \
  --exclude 'flutter_client/.dart_tool' \
  --exclude 'flutter_client/.flutter-plugins*' \
  --exclude 'flutter_client/.metadata' \
  --exclude 'flutter_client/.idea' \
  --exclude 'flutter_client/android' \
  --exclude 'flutter_client/ios' \
  --exclude 'flutter_client/macos' \
  --exclude 'flutter_client/windows' \
  --exclude 'flutter_client/linux' \
  --exclude 'server/data' \
  --exclude 'server/uploads' \
  --exclude 'server/.env' \
  --exclude 'server/*.log' \
  --exclude 'server/*.pid' \
  --exclude 'scratch' \
  --exclude 'test-results' \
  --exclude 'tests' \
  /var/www/pb_translation_hub/ joachim@drupaltutorials.de:/home/joachim/pb_translation_hub/
```

---

## 4. Environment Configuration (`server/.env`)

The `.env` file exists **only on the production server** (`/home/joachim/pb_translation_hub/server/.env`) and is never committed to Git.

```env
# Unsplash API
UNSPLASH_APP_ID=...
UNSPLASH_ACCESS_KEY=...
UNSPLASH_SECRET_KEY=...

# Database (DB_HOST is overridden by docker-compose.yml to 'db')
DB_HOST=db
DB_USER=pb_hub
DB_PASSWORD=...
DB_NAME=pb_translation_hub

# Security
JWT_SECRET=...

# Google AI
GEMINI_API_KEY=...
```

**Note:** `DB_HOST` is set to `db` via the `environment:` section in `docker-compose.yml` and overrides the `.env` value automatically inside Docker.

---

## 5. DB Migration System

Schema changes are managed as numbered SQL files in `server/migrations/`. The migration runner `server/db_migrate.js` is called automatically every time the server container starts.

### How it works

1. Creates the `schema_migrations` table if it does not exist.
2. Reads all `.sql` files in `server/migrations/` sorted numerically.
3. Skips migrations already recorded in `schema_migrations`.
4. Executes pending migrations inside a transaction (rolled back on failure).
5. Exits the Node.js process with code `1` on failure — no silent skipping.

### Adding a new migration

```bash
# Choose the next available number and create the file:
cat > server/migrations/005_my_change.sql << 'EOF'
-- Migration 005: Description
ALTER TABLE translations ADD COLUMN IF NOT EXISTS reviewer_note TEXT DEFAULT NULL;
EOF
```

**Rules:**
- Filename must be `NNN_description.sql` (zero-padded, snake_case).
- Only additive changes: `ADD COLUMN IF NOT EXISTS`, `CREATE TABLE IF NOT EXISTS`.
- No `DROP` or `RENAME` operations without explicit coordination.
- Each migration runs in a transaction.

### Deploying a migration to production

```bash
# Recommended: back up the DB before schema changes
./deploy.sh --db-backup
```

The rolling restart ensures the DB container stays online while the server container is rebuilt. Migrations run automatically on server startup.

---

## 6. Systemd Service

The `pb-translation-hub.service` systemd unit starts the Docker containers automatically at boot.

```bash
# Check status
sudo systemctl status pb-translation-hub

# Start / Stop / Restart
sudo systemctl start pb-translation-hub
sudo systemctl stop pb-translation-hub
sudo systemctl restart pb-translation-hub

# Enable at boot
sudo systemctl enable pb-translation-hub
```

The service file is located at `/etc/systemd/system/pb-translation-hub.service`.

---

## 7. Nginx Configuration (already present)

Nginx is already configured on the production server and proxies `pb.drupaltutorials.de` → `localhost:5173`:

```nginx
server {
    server_name pb.drupaltutorials.de;

    location / {
        proxy_pass http://localhost:5173;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # SSL via Certbot (Let's Encrypt)
    listen 443 ssl;
    ssl_certificate /etc/letsencrypt/live/pb.drupaltutorials.de/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/pb.drupaltutorials.de/privkey.pem;
}
```

> For avatar uploads: add `client_max_body_size 10M;` to the Nginx server block if not already present.

---

## 8. Docker Build Process

### Server Container (Node.js)

```
server/Dockerfile → node:22-alpine → npm install --production → PM2 cluster
```

PM2 runs in cluster mode (`-i max`), using all available CPU cores.

The `server/.dockerignore` excludes: `node_modules`, `data/`, `uploads/`, `.env`, `*.log`, dev scripts.

### Client Container (Flutter Web)

```
flutter_client/Dockerfile → ghcr.io/cirruslabs/flutter:stable → flutter build web --release → nginx:alpine
```

The Flutter build may take 3–10 minutes (dart2js compilation). With the rolling restart, the server and database remain available during this build.

The `flutter_client/.dockerignore` excludes: `build/`, `.dart_tool/`, all mobile platform directories (`android/`, `ios/`, `macos/`, `windows/`, `linux/`).

---

## 9. Database Backup

The database runs in a Docker volume (`db_data`).

### Create a backup manually (on production server)

```bash
docker exec pb_translation_hub-db-1 \
  mysqldump -u pb_hub -p'PASSWORD' pb_translation_hub \
  | gzip > ~/backups/pb_db_$(date +%Y%m%d_%H%M%S).sql.gz
```

### Create a backup via deploy.sh

```bash
./deploy.sh --db-backup
# Saves to ~/backups/ on the production server
```

### Restore from backup

```bash
gunzip < backup.sql.gz | docker exec -i pb_translation_hub-db-1 \
  mysql -u pb_hub -p'PASSWORD' pb_translation_hub
```

### Initial setup on a new server (empty volume)

On the first `docker compose up`, MariaDB automatically imports `server/data/db_export.sql.gz` (via `docker-entrypoint-initdb.d`). Migrations then run on top of the exported schema to bring it to the current state. Both together guarantee a consistent database on any new server.

---

## 10. Troubleshooting

```bash
# Container logs
docker compose logs -f server
docker compose logs -f client

# Container status
docker compose ps

# Enter a container
docker exec -it pb_translation_hub-server-1 sh
docker exec -it pb_translation_hub-db-1 bash

# Rebuild without cache (after major dependency changes)
docker compose build --no-cache
docker compose up -d
```

**Common issues:**

- **Unsplash API unreachable:** Rate limit (50 req/h in sandbox mode) or incorrect key → check `docker compose logs server`.
- **Avatars not persisted:** Verify volume mount `./server/uploads:/app/uploads` in `docker-compose.yml`.
- **Flutter build fails:** Check `docker compose logs client` — usually missing pub packages or a Dart SDK incompatibility.
- **Migration failure on startup:** Server exits with code 1. Check `docker compose logs server` for the specific SQL error. Fix the migration file and redeploy.

---

## 11. Connect Drupal pb_localizer

After deployment, connect Drupal sites to the Hub:

```bash
drush config:set pb_localizer.settings hub_url "https://pb.drupaltutorials.de" --yes
drush config:set pb_localizer.settings hub_port "443" --yes
```
