#!/usr/bin/env bash

set -e

# Display usage information
usage() {
    echo "Usage: $0 <process_name>"
    echo "Kill a process by name"
    echo ""
    echo "Example:"
    echo "  $0 python"
    echo "  $0 node"
    exit 1
}

killBz() {
    local process_name="$1"
    
    # Find process ID, excluding grep, this script, and vim
    local pid=$(ps -ef | grep "$process_name" | grep -v grep | grep -v "$(basename "$0")" | grep -v vim | awk '{print $2}' | head -1)
    
    if [[ -n "$pid" ]]; then
        echo "Killing process '$process_name' with PID=$pid"
        if kill "$pid"; then
            echo "Process '$process_name' (PID=$pid) killed successfully"
        else
            echo "Failed to kill process '$process_name' (PID=$pid)" >&2
            exit 1
        fi
    else
        echo "Process '$process_name' not found or not running"
        exit 1
    fi
}

# Check if parameter is provided
if [ $# -eq 0 ]; then
    echo "Error: No process name provided"
    usage
fi

# Check if parameter is not empty
if [ -z "$1" ]; then
    echo "Error: Process name cannot be empty"
    usage
fi

killBz "$1"
