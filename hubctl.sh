#!/bin/bash

# Configuration
BASE_DIR=$(pwd)
SERVER_DIR="$BASE_DIR/server"
CLIENT_DIR="$BASE_DIR/client"
SERVER_PID_FILE="$SERVER_DIR/server.pid"
CLIENT_PID_FILE="$CLIENT_DIR/client.pid"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

start() {
    echo -e "${GREEN}Starting PB Translation Hub...${NC}"
    
    # Start Server
    cd "$SERVER_DIR"
    node index.js > server.log 2>&1 &
    echo $! > "$SERVER_PID_FILE"
    echo -e "  Backend started (PID: $(cat "$SERVER_PID_FILE"))"
    
    # Start Client
    cd "$CLIENT_DIR"
    npm run dev -- --host 0.0.0.0 --force > client.log 2>&1 &
    echo $! > "$CLIENT_PID_FILE"
    echo -e "  Frontend started (PID: $(cat "$CLIENT_PID_FILE"))"
    
    echo -e "${GREEN}Hub is up and running!${NC}"
}

stop() {
    echo -e "${RED}Stopping PB Translation Hub...${NC}"
    
    if [ -f "$SERVER_PID_FILE" ]; then
        PID=$(cat "$SERVER_PID_FILE")
        kill $PID 2>/dev/null
        rm "$SERVER_PID_FILE"
        echo "  Backend stopped."
    else
        echo "  Backend PID file not found."
    fi
    
    if [ -f "$CLIENT_PID_FILE" ]; then
        PID=$(cat "$CLIENT_PID_FILE")
        kill $PID 2>/dev/null
        rm "$CLIENT_PID_FILE"
        echo "  Frontend stopped."
    else
        echo "  Frontend PID file not found."
    fi
    
    # Fallback: pkill any remaining processes in these directories
    pkill -f "node index.js"
    pkill -f "vite"
}

status() {
    echo "Current Status:"
    if [ -f "$SERVER_PID_FILE" ] && ps -p $(cat "$SERVER_PID_FILE") > /dev/null; then
        echo -e "  Backend: ${GREEN}RUNNING${NC} (PID: $(cat "$SERVER_PID_FILE"))"
    else
        echo -e "  Backend: ${RED}STOPPED${NC}"
    fi
    
    if [ -f "$CLIENT_PID_FILE" ] && ps -p $(cat "$CLIENT_PID_FILE") > /dev/null; then
        echo -e "  Frontend: ${GREEN}RUNNING${NC} (PID: $(cat "$CLIENT_PID_FILE"))"
    else
        echo -e "  Frontend: ${RED}STOPPED${NC}"
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        sleep 1
        start
        ;;
    status)
        status
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
esac
