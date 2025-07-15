#!/usr/bin/env bash

set -e

# Signal handler for graceful shutdown
cleanup() {
    echo ""
    echo "Received signal, stopping git pull loop..."
    exit 0
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM

echo "Starting git pull loop (every 30 seconds)..."
echo "Press Ctrl+C to stop"

while true; do
    echo "$(date): Pulling from git repository..."
    if git pull; then
        echo "$(date): Git pull successful"
    else
        echo "$(date): Git pull failed" >&2
    fi
    sleep 30
done
