#!/usr/bin/env bash

set -e

# Check if parameter is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <git-remote-url>"
    echo "Example: $0 https://github.com/user/repo.git"
    exit 1
fi

# Check if parameter is not empty
if [ -z "$1" ]; then
    echo "Error: Git remote URL cannot be empty"
    exit 1
fi

echo "Removing existing origin..."
git remote rm origin 2>/dev/null || echo "No existing origin to remove"

echo "Adding new origin: $1"
git remote add origin "$1"

echo "Pulling from origin main..."
git pull origin main

echo "Pushing to origin main..."
git push -u origin main

echo "Setting upstream branch..."
git branch --set-upstream-to=origin/main main

echo "Git origin updated successfully!"
