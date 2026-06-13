#!/bin/bash
# deploy.sh — PB Translation Hub Produktions-Deployment
# Überträgt den Code per rsync auf drupaltutorials.de und startet die Docker-Container neu.
#
# Voraussetzung: SSH-Key-Auth zu joachim@drupaltutorials.de muss funktionieren.
#
# Aufruf:
#   ./deploy.sh                  — Vollständiges Deployment (Rolling Restart, DB bleibt live)
#   ./deploy.sh --client-only    — Nur Flutter-Client neu bauen (Server + DB bleiben online)
#   ./deploy.sh --no-build       — Code übertragen, Container nur neu starten (kein Build)
#   ./deploy.sh --db-backup      — Vor dem Deploy DB-Dump erstellen (empfohlen bei Migrationen)
#   ./deploy.sh --dry-run        — rsync-Vorschau ohne Übertragung
#
# Migrations-Strategie:
#   Neue SQL-Migrationen liegen in server/migrations/NNN_*.sql.
#   Der Server-Container führt beim Start runMigrations() aus — automatisch, idempotent.
#   Es wird KEIN docker compose down mehr gemacht (Rolling Restart: Server neu, DB bleibt).

set -euo pipefail

# ── Konfiguration ─────────────────────────────────────────────────────────────
REMOTE_USER="joachim"
REMOTE_HOST="drupaltutorials.de"
REMOTE_DIR="/home/joachim/pb_translation_hub"
LOCAL_DIR="$(cd "$(dirname "$0")" && pwd)"

# Optionen
CLIENT_ONLY=false
NO_BUILD=false
DRY_RUN=false
DB_BACKUP=false

# ── Farben ────────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# ── Argumente parsen ──────────────────────────────────────────────────────────
for arg in "$@"; do
  case $arg in
    --client-only) CLIENT_ONLY=true ;;
    --no-build)    NO_BUILD=true    ;;
    --dry-run)     DRY_RUN=true     ;;
    --db-backup)   DB_BACKUP=true   ;;
    --help|-h)
      echo "Verwendung: ./deploy.sh [OPTION]"
      echo ""
      echo "  (kein Flag)      Rolling Restart: Server neu gebaut, DB bleibt live"
      echo "                   → Migrationen laufen automatisch beim Server-Start"
      echo "  --client-only    Nur Flutter-Client: Server + DB bleiben live"
      echo "  --no-build       Code übertragen, Container nur neu starten (kein Docker-Build)"
      echo "  --db-backup      DB-Dump vor dem Deploy erstellen (empfohlen bei Migrationen)"
      echo "  --dry-run        rsync-Vorschau ohne tatsächliche Übertragung"
      echo ""
      echo "Migrations-Workflow:"
      echo "  1. Neue Datei in server/migrations/NNN_beschreibung.sql anlegen"
      echo "  2. ./deploy.sh --db-backup   (Sicherungskopie vor Migration)"
      echo "  3. Migration läuft beim nächsten Server-Start automatisch"
      echo ""
      echo "Typischer Workflow:"
      echo "  Flutter-UI geändert       →  ./deploy.sh --client-only"
      echo "  Server-Code geändert      →  ./deploy.sh"
      echo "  Schema-Änderung (neu)     →  ./deploy.sh --db-backup"
      exit 0
      ;;
  esac
done

# ── Header ────────────────────────────────────────────────────────────────────
echo -e "${BOLD}╔══════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}║   PB Translation Hub — Production Deploy     ║${NC}"
echo -e "${BOLD}╚══════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  Quelle:  ${CYAN}${LOCAL_DIR}${NC}"
echo -e "  Ziel:    ${CYAN}${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}${NC}"
if $CLIENT_ONLY; then
  echo -e "  ${YELLOW}★ CLIENT-ONLY: Nur Flutter-Client wird neu gebaut${NC}"
fi
if $DB_BACKUP; then
  echo -e "  ${YELLOW}★ DB-BACKUP: Datenbank-Dump wird vor Deploy erstellt${NC}"
fi
if $DRY_RUN; then
  echo -e "  ${YELLOW}★ DRY-RUN: Keine Dateien werden übertragen${NC}"
fi
echo ""

# ── Schritt 1: SSH-Verbindung prüfen ──────────────────────────────────────────
echo -e "${BOLD}[1/4] SSH-Verbindung prüfen...${NC}"
if ! ssh -o ConnectTimeout=10 -o BatchMode=yes "${REMOTE_USER}@${REMOTE_HOST}" "echo OK" &>/dev/null; then
  echo -e "  ${RED}FEHLER: SSH-Verbindung zu ${REMOTE_HOST} fehlgeschlagen.${NC}"
  echo -e "  Prüfe SSH-Key oder Netzwerkverbindung."
  exit 1
fi
echo -e "  ${GREEN}SSH OK${NC}"
echo ""

# ── Schritt 1b: DB-Backup (optional) ─────────────────────────────────────────
if $DB_BACKUP && ! $DRY_RUN; then
  BACKUP_STAMP=$(date +%Y%m%d_%H%M%S)
  BACKUP_FILE="pb_db_backup_${BACKUP_STAMP}.sql.gz"
  echo -e "${BOLD}[1b/4] Datenbank-Backup erstellen...${NC}"
  ssh "${REMOTE_USER}@${REMOTE_HOST}" "
    cd ${REMOTE_DIR}
    DB_PASS=\$(grep DB_PASSWORD server/.env | cut -d= -f2)
    docker compose exec -T db mysqldump -u pb_hub -p\"\${DB_PASS}\" pb_translation_hub \
      | gzip > ~/backups/${BACKUP_FILE} 2>/dev/null \
      || docker compose exec -T db mysqldump -u pb_hub -pdrupal pb_translation_hub \
           | gzip > ~/backups/${BACKUP_FILE}
    echo 'Backup: ~/backups/${BACKUP_FILE}'
  " && echo -e "  ${GREEN}Backup erstellt: ~/backups/${BACKUP_FILE}${NC}" \
    || echo -e "  ${YELLOW}Backup fehlgeschlagen (non-fatal) — bitte manuell prüfen${NC}"
  echo ""
fi

# ── Schritt 2: rsync ──────────────────────────────────────────────────────────
echo -e "${BOLD}[2/4] Code übertragen (rsync)...${NC}"
RSYNC_OPTS="-avz --progress --delete"
if $DRY_RUN; then
  RSYNC_OPTS="${RSYNC_OPTS} --dry-run"
fi

# Gemeinsame Excludes (gelten immer)
COMMON_EXCLUDES=(
  --exclude '.git'
  --exclude 'node_modules'
  --exclude 'flutter_client/build'
  --exclude 'flutter_client/.dart_tool'
  --exclude 'flutter_client/.flutter-plugins*'
  --exclude 'flutter_client/.metadata'
  --exclude 'flutter_client/.idea'
  --exclude 'flutter_client/android'
  --exclude 'flutter_client/ios'
  --exclude 'flutter_client/macos'
  --exclude 'flutter_client/windows'
  --exclude 'flutter_client/linux'
  --exclude 'server/data'
  --exclude 'server/uploads'
  --exclude 'server/.env'
  --exclude 'server/*.log'
  --exclude 'server/*.pid'
  --exclude 'server/scratch'
  --exclude 'server/check_pass.js'
  --exclude 'server/webform_data.json'
  --exclude 'server/migrate_to_mysql.js'
  --exclude 'scratch'
  --exclude 'test-results'
  --exclude 'tests'
  --exclude 'playwright.config.js'
  --exclude 'readme-shot-*.png'
)

if $CLIENT_ONLY; then
  # ── Client-Only: nur flutter_client/ übertragen ──────────────────────────
  rsync ${RSYNC_OPTS} \
    "${COMMON_EXCLUDES[@]}" \
    --filter='+ /flutter_client/***' \
    --filter='+ /docker-compose.yml' \
    --filter='- /*' \
    "${LOCAL_DIR}/" \
    "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/"
else
  # ── Vollständig: ganzes Projekt übertragen ───────────────────────────────
  rsync ${RSYNC_OPTS} \
    "${COMMON_EXCLUDES[@]}" \
    "${LOCAL_DIR}/" \
    "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/"
fi

if $DRY_RUN; then
  echo ""
  echo -e "  ${YELLOW}DRY-RUN abgeschlossen — keine Dateien übertragen.${NC}"
  echo -e "  Starte ohne --dry-run für das echte Deployment."
  exit 0
fi

echo -e "  ${GREEN}rsync abgeschlossen${NC}"
echo ""

# ── Schritt 3: Backup-Verzeichnis sicherstellen ──────────────────────────────
if $DB_BACKUP && ! $DRY_RUN; then
  ssh "${REMOTE_USER}@${REMOTE_HOST}" "mkdir -p ~/backups" 2>/dev/null || true
fi

# ── Schritt 4: Docker (Rolling Restart — DB bleibt immer live) ───────────────
if $CLIENT_ONLY; then
  # ── Client-Only: nur 'client', Server + DB bleiben live ──────────────────
  echo -e "${BOLD}[4/4] Flutter-Client neu bauen (hot-swap)...${NC}"
  echo -e "  ${YELLOW}Flutter-Build kann 3–10 Minuten dauern.${NC}"
  echo -e "  ${GREEN}Server und Datenbank bleiben online.${NC}"
  echo ""
  ssh "${REMOTE_USER}@${REMOTE_HOST}" "
    cd ${REMOTE_DIR}
    echo '>>> Baue Client-Image (Server läuft weiter)...'
    docker compose build client
    echo '>>> Hot-swap Client-Container...'
    docker compose up -d --no-deps client
    echo '>>> Container-Status:'
    docker compose ps
  "
elif $NO_BUILD; then
  # ── Nur neu starten, kein Build ───────────────────────────────────────────
  echo -e "${BOLD}[4/4] Container neu starten (kein Build)...${NC}"
  ssh "${REMOTE_USER}@${REMOTE_HOST}" "
    cd ${REMOTE_DIR}
    docker compose up -d --no-deps server client
    docker compose ps
  "
else
  # ── Vollständig: Server + Client neu bauen, DB bleibt live ───────────────
  echo -e "${BOLD}[4/4] Server + Client neu bauen (Rolling Restart)...${NC}"
  echo -e "  ${YELLOW}Flutter-Build kann 3–10 Minuten dauern.${NC}"
  echo -e "  ${GREEN}Datenbank bleibt die ganze Zeit online.${NC}"
  echo -e "  ${GREEN}Migrationen werden beim Server-Start automatisch ausgeführt.${NC}"
  echo ""
  ssh "${REMOTE_USER}@${REMOTE_HOST}" "
    cd ${REMOTE_DIR}
    echo '>>> Baue Server-Image neu...'
    docker compose build server
    echo '>>> Starte Server neu (Migrationen laufen automatisch)...'
    docker compose up -d --no-deps server
    echo ''
    echo '>>> Warte auf Server-Start und Migrationen...'
    sleep 8
    echo '>>> Migrations-Log:'
    docker compose logs --no-log-prefix --since=30s server | grep -E 'Migration|Startup|KRITISCH' || true
    echo ''
    echo '>>> Baue Client-Image neu...'
    docker compose build client
    echo '>>> Starte Client neu...'
    docker compose up -d --no-deps client
    echo '>>> Container-Status:'
    docker compose ps
  "
fi

# ── Ergebnis ──────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}${BOLD}╔══════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}${BOLD}║   Deployment erfolgreich abgeschlossen!      ║${NC}"
echo -e "${GREEN}${BOLD}╚══════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  ${CYAN}App:    https://pb.drupaltutorials.de${NC}"
echo -e "  ${CYAN}API:    https://pb.drupaltutorials.de/api${NC}"
echo ""
echo -e "  Logs verfolgen:"
echo -e "    ${BOLD}ssh ${REMOTE_USER}@${REMOTE_HOST} \"cd ${REMOTE_DIR} && docker compose logs -f\"${NC}"
if $CLIENT_ONLY; then
  echo -e "    ${BOLD}ssh ${REMOTE_USER}@${REMOTE_HOST} \"cd ${REMOTE_DIR} && docker compose logs -f client\"${NC}"
fi
echo -e ""
echo -e "  Migrationen prüfen:"
echo -e "    ${BOLD}ssh ${REMOTE_USER}@${REMOTE_HOST} \"cd ${REMOTE_DIR} && docker compose exec db mysql -u pb_hub -p'...' pb_translation_hub -e 'SELECT * FROM schema_migrations;'\"${NC}"
