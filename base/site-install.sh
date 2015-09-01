#!/bin/sh
#cp settings.php.general sites/default/settings.php
cp sites/default/default.settings.php sites/default/settings.php
cp sites/default/default.services.yml sites/default/services.yml

# sleep some before mysql has time to come up
sleep 10

drush -y site-install --db-url=mysql://${DB_USER}:${DB_PASS}@${DB_HOST}/${DB_NAME} --account-name=admin --account-pass=admin --notify

