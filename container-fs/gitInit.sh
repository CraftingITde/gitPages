#!/bin/bash

repository="http://$GIT_TOKEN@$GIT_SERVER/$GIT_OWNER/$GIT_REPO.git"

localFolder="/tmp/html"

git clone -b $GIT_BRANCH --single-branch $repository $localFolder

cp -rf /tmp/html/. /var/www/html
