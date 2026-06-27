#!/usr/bin/env bash
#
# backup.sh — Vollständiges, wiederherstellbares Backup des PB Translation Hub.
#
# Sichert BEIDES in ein einziges Archiv:
#   1. Komplette MariaDB-Datenbank (mysqldump, gzip)  — projects, translations,
#      users, glossary_terms, priority_projects, ignored_projects, site_settings, …
#   2. Den gesamten data/translations/-Baum            — alle JSON-Übersetzungen
#      UND die Kategorienamen (_categories.json), die ausschließlich als Dateien
#      existieren und im DB-Dump NICHT enthalten sind.
#
# Verwendung:
#   ./backup.sh            — Backup vom Live-Server (drupaltutorials.de) per SSH
#   ./backup.sh --local    — Backup der lokalen Instanz (mysql auf 127.0.0.1)
#   ./backup.sh --help
#
# Ergebnis:  backups/pb_hub_backup_<YYYYMMDD_HHMMSS>.tar.gz
# Wiederherstellung:  ./restore.sh <archiv>  (siehe restore.sh --help)

set -euo pipefail

# ── Konfiguration (analog deploy.sh) ──────────────────────────────────────────
REMOTE_USER="joachim"
REMOTE_HOST="drupaltutorials.de"
REMOTE_DIR="/home/joachim/pb_translation_hub"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="${SCRIPT_DIR}/backups"

DB_NAME="pb_translation_hub"
DB_USER="pb_hub"
# DB-Passwort wird wie in deploy.sh aus server/.env gelesen (Fallback: drupal).

MODE="remote"

# ── Farben ────────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; BOLD='\033[1m'; NC='\033[0m'

for arg in "$@"; do
  case $arg in
    --local) MODE="local" ;;
    --help|-h)
      echo "Verwendung: ./backup.sh [--local]"
      echo "  (kein Flag)  Backup vom Live-Server ${REMOTE_HOST} per SSH"
      echo "  --local      Backup der lokalen Instanz (mysqldump auf 127.0.0.1)"
      exit 0 ;;
    *) echo -e "${RED}Unbekannte Option: $arg${NC}"; exit 1 ;;
  esac
done

STAMP="$(date +%Y%m%d_%H%M%S)"
WORK="${BACKUP_DIR}/.tmp_${STAMP}"
ARCHIVE="${BACKUP_DIR}/pb_hub_backup_${STAMP}.tar.gz"
mkdir -p "$WORK"
trap 'rm -rf "$WORK"' EXIT

echo -e "${BOLD}PB Translation Hub — Backup (${MODE})${NC}"

if [[ "$MODE" == "remote" ]]; then
  echo -e "  → DB-Dump von ${REMOTE_HOST} …"
  # Passwort auf dem Server aus server/.env lesen (wie deploy.sh), Fallback drupal.
  # Passwort via MYSQL_PWD (kein Quoting auf der Kommandozeile). MariaDB 11.x
  # liefert nur 'mariadb-dump' aus — Fallback auf 'mysqldump' für ältere Images.
  ssh "${REMOTE_USER}@${REMOTE_HOST}" "
    cd '${REMOTE_DIR}'
    DB_PASS=\$(grep DB_PASSWORD server/.env | cut -d= -f2)
    docker compose exec -T -e MYSQL_PWD=\"\${DB_PASS:-drupal}\" db \
      sh -c 'if command -v mariadb-dump >/dev/null 2>&1; then mariadb-dump -u ${DB_USER} ${DB_NAME}; else mysqldump -u ${DB_USER} ${DB_NAME}; fi'
  " | gzip > "${WORK}/db.sql.gz"

  echo -e "  → Übersetzungs-/Kategorie-Dateien von ${REMOTE_HOST} …"
  ssh "${REMOTE_USER}@${REMOTE_HOST}" \
    "tar czf - -C '${REMOTE_DIR}/server/data' translations" \
    > "${WORK}/translations.tar.gz"
else
  echo -e "  → DB-Dump (lokal) …"
  DB_PASS=$(grep -E '^DB_PASSWORD=' "${SCRIPT_DIR}/server/.env" 2>/dev/null | cut -d= -f2- || true)
  DB_PASS="${DB_PASS:-drupal}"
  if command -v mariadb-dump >/dev/null 2>&1; then DUMP=mariadb-dump; else DUMP=mysqldump; fi
  MYSQL_PWD="${DB_PASS}" "${DUMP}" -h 127.0.0.1 -u ${DB_USER} ${DB_NAME} | gzip > "${WORK}/db.sql.gz"

  echo -e "  → Übersetzungs-/Kategorie-Dateien (lokal) …"
  tar czf "${WORK}/translations.tar.gz" -C "${SCRIPT_DIR}/server/data" translations
fi

# DB-Dump-Plausibilität prüfen (mind. 1 KB — fängt fehlgeschlagene Dumps ab).
if [[ "$(stat -c%s "${WORK}/db.sql.gz")" -lt 1024 ]]; then
  echo -e "${RED}✗ DB-Dump ist verdächtig klein — Abbruch (kein Archiv erzeugt).${NC}"
  exit 1
fi

# ── Manifest ──────────────────────────────────────────────────────────────────
DB_BYTES=$(stat -c%s "${WORK}/db.sql.gz")
TR_BYTES=$(stat -c%s "${WORK}/translations.tar.gz")
TR_FILES=$(tar tzf "${WORK}/translations.tar.gz" | grep -c '\.json$' || true)
HAS_CATS=$(tar tzf "${WORK}/translations.tar.gz" | grep -c '_categories\.json$' || true)
cat > "${WORK}/manifest.txt" <<EOF
PB Translation Hub Backup
created:        $(date -Iseconds)
source:         ${MODE}$( [[ "$MODE" == remote ]] && echo " (${REMOTE_HOST})" )
db.sql.gz:      ${DB_BYTES} bytes
translations:   ${TR_BYTES} bytes, ${TR_FILES} JSON-Dateien, ${HAS_CATS} _categories.json
EOF

# ── Bündeln ───────────────────────────────────────────────────────────────────
tar czf "$ARCHIVE" -C "$WORK" db.sql.gz translations.tar.gz manifest.txt

echo -e "  ${GREEN}✓ Backup erstellt:${NC} ${ARCHIVE}"
echo -e "    DB: $(numfmt --to=iec ${DB_BYTES} 2>/dev/null || echo ${DB_BYTES}B) · Übersetzungen: ${TR_FILES} Dateien · Kategorien-Maps: ${HAS_CATS}"
if [[ "$HAS_CATS" -eq 0 ]]; then
  echo -e "  ${YELLOW}⚠ Achtung: keine _categories.json im Backup gefunden.${NC}"
fi
echo -e "  Wiederherstellen mit:  ./restore.sh \"${ARCHIVE}\" --target ${MODE} --yes"
