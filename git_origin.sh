#!/usr/bin/env bash
git remote rm origin
git remote add origin $1
git pull origin main
git push -u origin main
git branch --set-upstream-to=origin/main main
