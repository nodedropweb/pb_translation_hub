#!/usr/bin/env bash
#
# restore.sh — Spielt ein mit backup.sh erstelltes Archiv wieder ein.
#
# Stellt BEIDES wieder her: die MariaDB-Datenbank UND den data/translations/-Baum
# (inkl. Kategorienamen). DESTRUKTIV — überschreibt vorhandene Daten.
#
# Verwendung:
#   ./restore.sh <archiv.tar.gz> [--target local|remote] [--yes]
#
#   --target local   (Standard)  lokale Instanz (mysql auf 127.0.0.1)
#   --target remote              Live-Server drupaltutorials.de per SSH
#   --yes                        Bestätigung überspringen (nicht-interaktiv)
#
# Nach dem Restore auf remote: Server-Container neu starten, damit Migrationen
# laufen:  ./deploy.sh --no-build   (oder docker compose restart server)

set -euo pipefail

# ── Konfiguration (analog deploy.sh / backup.sh) ──────────────────────────────
REMOTE_USER="joachim"
REMOTE_HOST="drupaltutorials.de"
REMOTE_DIR="/home/joachim/pb_translation_hub"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

DB_NAME="pb_translation_hub"
DB_USER="pb_hub"
# DB-Passwort wird wie in deploy.sh aus server/.env gelesen (Fallback: drupal).

TARGET="local"
ASSUME_YES="false"
ARCHIVE=""

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; BOLD='\033[1m'; NC='\033[0m'

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target) TARGET="${2:-}"; shift 2 ;;
    --yes|-y) ASSUME_YES="true"; shift ;;
    --help|-h)
      echo "Verwendung: ./restore.sh <archiv.tar.gz> [--target local|remote] [--yes]"
      exit 0 ;;
    *) ARCHIVE="$1"; shift ;;
  esac
done

[[ -z "$ARCHIVE" ]]        && { echo -e "${RED}Fehler: kein Archiv angegeben.${NC}"; exit 1; }
[[ ! -f "$ARCHIVE" ]]      && { echo -e "${RED}Fehler: Archiv nicht gefunden: $ARCHIVE${NC}"; exit 1; }
[[ "$TARGET" != "local" && "$TARGET" != "remote" ]] && { echo -e "${RED}Fehler: --target muss local oder remote sein.${NC}"; exit 1; }

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
tar xzf "$ARCHIVE" -C "$WORK"
[[ -f "${WORK}/db.sql.gz" && -f "${WORK}/translations.tar.gz" ]] \
  || { echo -e "${RED}Fehler: Archiv unvollständig (db.sql.gz / translations.tar.gz fehlt).${NC}"; exit 1; }

echo -e "${BOLD}Wiederherstellung nach: ${TARGET}${NC}"
[[ -f "${WORK}/manifest.txt" ]] && sed 's/^/  /' "${WORK}/manifest.txt"

if [[ "$ASSUME_YES" != "true" ]]; then
  echo -e "${YELLOW}Dies überschreibt die Datenbank UND data/translations/ am Ziel '${TARGET}'.${NC}"
  read -r -p "Fortfahren? (yes/NO) " reply
  [[ "$reply" == "yes" ]] || { echo "Abgebrochen."; exit 0; }
fi

if [[ "$TARGET" == "local" ]]; then
  echo -e "  → DB einspielen (lokal) …"
  DB_PASS=$(grep -E '^DB_PASSWORD=' "${SCRIPT_DIR}/server/.env" 2>/dev/null | cut -d= -f2- || true)
  DB_PASS="${DB_PASS:-drupal}"
  if command -v mariadb >/dev/null 2>&1; then CLIENT=mariadb; else CLIENT=mysql; fi
  gunzip < "${WORK}/db.sql.gz" | MYSQL_PWD="${DB_PASS}" "${CLIENT}" -h 127.0.0.1 -u ${DB_USER} ${DB_NAME}

  echo -e "  → Übersetzungs-/Kategorie-Dateien einspielen (lokal) …"
  tar xzf "${WORK}/translations.tar.gz" -C "${SCRIPT_DIR}/server/data"
  echo -e "  ${GREEN}✓ Restore abgeschlossen.${NC} Server ggf. neu starten."
else
  echo -e "  → DB einspielen auf ${REMOTE_HOST} …"
  # Passwort aus server/.env (wie deploy.sh), via MYSQL_PWD; mariadb-Client mit
  # Fallback auf mysql (MariaDB 11.x liefert nur 'mariadb' aus).
  cat "${WORK}/db.sql.gz" | ssh "${REMOTE_USER}@${REMOTE_HOST}" "
    cd '${REMOTE_DIR}'
    DB_PASS=\$(grep DB_PASSWORD server/.env | cut -d= -f2)
    gunzip | docker compose exec -T -e MYSQL_PWD=\"\${DB_PASS:-drupal}\" db \
      sh -c 'if command -v mariadb >/dev/null 2>&1; then mariadb -u ${DB_USER} ${DB_NAME}; else mysql -u ${DB_USER} ${DB_NAME}; fi'
  "

  echo -e "  → Übersetzungs-/Kategorie-Dateien einspielen auf ${REMOTE_HOST} …"
  cat "${WORK}/translations.tar.gz" | ssh "${REMOTE_USER}@${REMOTE_HOST}" \
    "tar xzf - -C '${REMOTE_DIR}/server/data'"

  echo -e "  ${GREEN}✓ Restore abgeschlossen.${NC}"
  echo -e "  ${YELLOW}Jetzt Server-Container neu starten:${NC} ./deploy.sh --no-build"
fi
