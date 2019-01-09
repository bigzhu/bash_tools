#! /bin/bash
git remote rm origin 
git remote add origin $1
git pull origin master
git push -u origin master
git branch --set-upstream-to=origin/master master
