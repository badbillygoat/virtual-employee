#!/bin/bash
# Auto-Deploy Script for Phelix
# ================================
# Runs as a systemd service. Every 5 minutes, checks if GitHub has
# new commits. If so, pulls the latest code and restarts Phelix.
#
# This means: push to GitHub = Phelix updates automatically within 5 min.
# No SSH login required for routine code changes.

REPO_DIR="$HOME/virtual-employee"
SERVICE="virtual-employee"
LOG="$REPO_DIR/logs/auto_deploy.log"
CHECK_INTERVAL=300  # 5 minutes

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S')  $1" | tee -a "$LOG"
}

log "Auto-deploy watcher started"

while true; do
    sleep "$CHECK_INTERVAL"

    cd "$REPO_DIR" || continue

    # Fetch latest without merging
    git fetch origin main --quiet 2>/dev/null

    LOCAL=$(git rev-parse HEAD 2>/dev/null)
    REMOTE=$(git rev-parse origin/main 2>/dev/null)

    if [ "$LOCAL" != "$REMOTE" ]; then
        log "New code detected (${LOCAL:0:7} → ${REMOTE:0:7}). Pulling and restarting..."

        git pull origin main --quiet

        if sudo /bin/systemctl restart "$SERVICE"; then
            log "✓ $SERVICE restarted successfully"
        else
            log "✗ Failed to restart $SERVICE"
        fi
    fi
done
