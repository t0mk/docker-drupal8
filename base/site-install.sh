#!/bin/sh
#cp settings.php.general sites/default/settings.php
cp sites/default/default.settings.php sites/default/settings.php
cp sites/default/default.services.yml sites/default/services.yml

COUNTER=0
# sleep some before mysql has time to come up
until nc -z $DB_HOST 3306; do
   echo "DB not ready yet. Sleeping 5s."
   COUNTER=$((COUNTER+1))
   if [ $COUNTER -gt 10 ]; then
       echo "Couldn't connect to DB"
       exit 1
   fi
   sleep 5
done
   
drush -y site-install --db-url=mysql://${DB_USER}:${DB_PASS}@${DB_HOST}/${DB_NAME} --account-name=admin --account-pass=admin --notify

