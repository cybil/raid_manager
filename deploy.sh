#!/bin/bash

git push -f heroku master
heroku run rake db:migrate
