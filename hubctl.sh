#!/bin/bash
# hubctl.sh — PB Translation Hub dev launcher (Flutter client edition)
# Usage: ./hubctl.sh {start|stop|restart|status|logs}

# ── Config ────────────────────────────────────────────────────────────────────
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
SERVER_DIR="$BASE_DIR/server"
CLIENT_DIR="$BASE_DIR/flutter_client"

# Load nvm so node/flutter are available in non-interactive shells
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" --no-use
# Pick up the active nvm node if the PATH doesn't already have one
if ! command -v node &>/dev/null && [ -d "$NVM_DIR/versions/node" ]; then
  LATEST_NODE=$(ls -t "$NVM_DIR/versions/node" | head -1)
  export PATH="$NVM_DIR/versions/node/$LATEST_NODE/bin:$PATH"
fi
# Flutter
FLUTTER_BIN="${FLUTTER_BIN:-/home/drupal/flutter/bin}"
export PATH="$FLUTTER_BIN:$PATH"

SERVER_LOG="/tmp/pb_hub_server.log"
CLIENT_LOG="/tmp/pb_hub_client.log"

SERVER_PORT=9901
CLIENT_PORT=5173

# ── Colours ───────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# ── Helpers ───────────────────────────────────────────────────────────────────

# Returns the PID listening on a given port, or empty string
_port_pid() { lsof -ti:"$1" 2>/dev/null | head -1; }

# Returns 0 if something is serving HTTP on a port
_port_up() {
  curl -s -o /dev/null -w "%{http_code}" "http://localhost:$1" 2>/dev/null \
    | grep -qE "^[2-4]"
}

_wait_port() {
  local port=$1 label=$2 timeout=${3:-45}
  printf "  Waiting for %s on :%s " "$label" "$port"
  for _ in $(seq 1 $timeout); do
    if _port_up "$port"; then
      echo -e " ${GREEN}ready${NC}"
      return 0
    fi
    sleep 1
    printf "."
  done
  echo -e " ${YELLOW}timed out — check log${NC}"
  return 1
}

# Waits until flutter_bootstrap.js returns HTTP 200.
# Flutter's dev server starts serving the port immediately while still
# compiling — bootstrap.js returns 404 until compilation is done.
# Opening the browser during that window causes a stuck loading screen.
_wait_flutter_compiled() {
  local port=$1 timeout=${2:-120}
  printf "  Waiting for Flutter to finish compiling "
  for _ in $(seq 1 $timeout); do
    local code
    code=$(curl -s -o /dev/null -w "%{http_code}" \
      "http://localhost:${port}/flutter_bootstrap.js" 2>/dev/null)
    if [ "$code" = "200" ]; then
      echo -e " ${GREEN}compiled & ready${NC}"
      return 0
    fi
    sleep 1
    printf "."
  done
  echo -e " ${YELLOW}timed out — app may still be compiling${NC}"
  return 1
}

_kill_port() {
  local pid
  pid=$(_port_pid "$1")
  if [ -n "$pid" ]; then
    kill "$pid" 2>/dev/null
    # Wait up to 3 s for it to die
    for _ in 1 2 3; do
      sleep 1
      _port_pid "$1" > /dev/null 2>&1 || return 0
    done
    kill -9 "$pid" 2>/dev/null
  fi
}

# ── start ─────────────────────────────────────────────────────────────────────
start() {
  echo -e "${BOLD}Starting PB Translation Hub...${NC}"

  # ── Backend (Node) ────────────────────────────────────────────────────────
  if _port_up "$SERVER_PORT"; then
    echo -e "  Backend:  ${YELLOW}already running${NC} on :${SERVER_PORT}"
  else
    cd "$SERVER_DIR"
    nohup node index.js > "$SERVER_LOG" 2>&1 &
    disown
    echo -e "  Backend:  starting (PID $!)"
  fi

  # ── Flutter web client (release build) ───────────────────────────────────
  if _port_up "$CLIENT_PORT"; then
    echo -e "  Frontend: ${YELLOW}already running${NC} on :${CLIENT_PORT}"
  else
    echo -e "  Frontend: building release bundle…"
    echo -e "  ${CYAN}(Tipp: für Hot-Reload lieber ${BOLD}./hubctl.sh dev${CYAN} verwenden)${NC}"
    echo ""

    # --verbose zeigt alle dart2js-Schritte; grep filtert auf lesbare Zeilen
    (cd "$CLIENT_DIR" && flutter build web --release --verbose 2>&1 \
      | tee "$CLIENT_LOG" \
      | grep --line-buffered -E \
          "Compiling|dart2js|Building|Generating|Resolving|Tree|Minif|Bundl|Built|warning:|error:|Error:|✓|✗|second|MB" \
      || true)
    local build_status=${PIPESTATUS[0]}

    if [ $build_status -ne 0 ]; then
      echo -e "  Frontend: ${RED}build failed — check $CLIENT_LOG${NC}"
    else
      nohup serve -s "$CLIENT_DIR/build/web" -l "$CLIENT_PORT" >> "$CLIENT_LOG" 2>&1 &
      disown
      echo -e "  Frontend: ${GREEN}build OK${NC} — serving build/web on :${CLIENT_PORT} (PID $!)"
    fi
  fi

  echo ""
  _wait_port "$SERVER_PORT" "Backend"
  _wait_port "$CLIENT_PORT" "Frontend" 30

  echo ""
  echo -e "${GREEN}${BOLD}Hub is up!${NC}"
  echo -e "  ${CYAN}API   →  http://localhost:${SERVER_PORT}/api${NC}"
  echo -e "  ${CYAN}App   →  http://localhost:${CLIENT_PORT}${NC}"
  echo ""
  echo -e "  Für Hot-Reload: ${BOLD}./hubctl.sh dev${NC}"
  echo -e "  Logs live:      ${BOLD}./hubctl.sh logs${NC}"
}

# ── dev ───────────────────────────────────────────────────────────────────────
dev() {
  echo -e "${BOLD}Starting PB Translation Hub (Dev / Hot-Reload mode)...${NC}"

  # ── Backend (Node) ────────────────────────────────────────────────────────
  if _port_up "$SERVER_PORT"; then
    echo -e "  Backend:  ${YELLOW}already running${NC} on :${SERVER_PORT}"
  else
    cd "$SERVER_DIR"
    nohup node index.js > "$SERVER_LOG" 2>&1 &
    disown
    echo -e "  Backend:  starting (PID $!)"
    _wait_port "$SERVER_PORT" "Backend"
  fi

  echo ""
  echo -e "  ${GREEN}${BOLD}Flutter Dev Server startet auf :${CLIENT_PORT}${NC}"
  echo -e "  ${CYAN}App   →  http://localhost:${CLIENT_PORT}${NC}"
  echo -e "  ${CYAN}API   →  http://localhost:${SERVER_PORT}/api${NC}"
  echo ""
  echo -e "  Tastenkürzel im laufenden Flutter-Prozess:"
  echo -e "    ${BOLD}r${NC}  → Hot Reload  (Sekunden, State bleibt)"
  echo -e "    ${BOLD}R${NC}  → Hot Restart (State wird zurückgesetzt)"
  echo -e "    ${BOLD}q${NC}  → Beenden"
  echo ""

  # Port freimachen falls noch ein alter serve/flutter-Prozess läuft
  if _port_pid "$CLIENT_PORT" > /dev/null 2>&1; then
    echo -e "  Frontend: Port :${CLIENT_PORT} belegt — stoppe alten Prozess…"
    _kill_port "$CLIENT_PORT"
    sleep 1
  fi

  # Flutter run im Vordergrund — gibt alle Compiler-Phasen aus und erlaubt r/R/q
  cd "$CLIENT_DIR" && flutter run \
    -d web-server \
    --web-port "$CLIENT_PORT" \
    --web-hostname 0.0.0.0 \
    --no-pub
}

# ── stop ──────────────────────────────────────────────────────────────────────
stop() {
  echo -e "${BOLD}Stopping PB Translation Hub...${NC}"

  # Kill by port — works even when the flutter wrapper has already exec'd dart
  if _port_pid "$SERVER_PORT" > /dev/null 2>&1; then
    _kill_port "$SERVER_PORT"
    echo -e "  Backend:  ${RED}stopped${NC}"
  else
    echo "  Backend:  not running"
  fi

  if _port_pid "$CLIENT_PORT" > /dev/null 2>&1; then
    _kill_port "$CLIENT_PORT"
    echo -e "  Frontend: ${RED}stopped${NC}"
  else
    echo "  Frontend: not running"
  fi

  # Safety net for any leftover processes
  pkill -f "flutter_tools.snapshot run" 2>/dev/null || true
  pkill -f "node $SERVER_DIR/index.js"  2>/dev/null || true

  echo -e "${BOLD}Done.${NC}"
}

# ── status ────────────────────────────────────────────────────────────────────
status() {
  echo -e "${BOLD}PB Translation Hub — status${NC}"
  echo ""

  local spid
  spid=$(_port_pid "$SERVER_PORT")
  if [ -n "$spid" ]; then
    echo -e "  Backend:  ${GREEN}RUNNING${NC}  (PID $spid)  →  http://localhost:${SERVER_PORT}/api"
  else
    echo -e "  Backend:  ${RED}STOPPED${NC}"
  fi

  local cpid
  cpid=$(_port_pid "$CLIENT_PORT")
  if [ -n "$cpid" ]; then
    echo -e "  Frontend: ${GREEN}RUNNING${NC}  (PID $cpid)  →  http://localhost:${CLIENT_PORT}"
  else
    echo -e "  Frontend: ${RED}STOPPED${NC}"
  fi
  echo ""
}

# ── logs ──────────────────────────────────────────────────────────────────────
logs() {
  echo -e "${BOLD}Tailing logs — Ctrl+C to exit${NC}"
  echo -e "  ${CYAN}server: $SERVER_LOG${NC}"
  echo -e "  ${CYAN}client: $CLIENT_LOG${NC}"
  echo ""
  tail -f "$SERVER_LOG" "$CLIENT_LOG"
}

# ── dispatch ──────────────────────────────────────────────────────────────────
case "${1:-}" in
  start)   start   ;;
  dev)     dev     ;;
  stop)    stop    ;;
  restart) stop; sleep 2; start ;;
  status)  status  ;;
  logs)    logs    ;;
  *)
    echo -e "${BOLD}Usage:${NC} ./hubctl.sh {start|stop|restart|dev|status|logs}"
    echo ""
    echo -e "  ${BOLD}start${NC}    — Production-Build (Release) + statischer Server"
    echo -e "  ${BOLD}dev${NC}      — Dev-Modus mit Hot-Reload (flutter run, interaktiv)"
    echo -e "  ${BOLD}stop${NC}     — Alle Prozesse beenden"
    echo -e "  ${BOLD}restart${NC}  — stop + start"
    echo -e "  ${BOLD}status${NC}   — Laufende Prozesse anzeigen"
    echo -e "  ${BOLD}logs${NC}     — Logs live verfolgen"
    exit 1
    ;;
esac
