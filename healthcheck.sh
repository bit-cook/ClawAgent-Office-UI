#!/bin/bash
# Star Office UI Health Check
# Checks if backend is responding, restarts if not

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OFFICE_PORT="${OFFICE_PORT:-19000}"
BACKEND_URL="http://127.0.0.1:${OFFICE_PORT}/health"
LOG_FILE="${SCRIPT_DIR}/healthcheck.log"

# Log timestamp
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Health check starting..." >> "$LOG_FILE"

# Check backend
if curl -fsS --max-time 5 "$BACKEND_URL" > /dev/null 2>&1; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backend is healthy" >> "$LOG_FILE"
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backend is NOT healthy - restarting..." >> "$LOG_FILE"
    systemctl restart star-office-backend.service
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backend restarted" >> "$LOG_FILE"
fi
