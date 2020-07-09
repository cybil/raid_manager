#!/bin/bash

git checkout heroku-deploy
git rebase master
cd raid_manager_front
npm build
cp dist/* ../public
cd ..
git add .
git commit -m "deploy"
git push -f heroku heroku-deploy:master
heroku run rake db:migrate

git checkout master
