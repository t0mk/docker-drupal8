#!/bin/sh

COUNTER=0
# sleep some before mysql has time to come up
until nc -z $DB_HOST 3306; do
   echo "DB not ready yet. Sleeping 5s."
   COUNTER=$((COUNTER+1))
   if [ $COUNTER -gt 20 ]; then
       echo "Couldn't connect to DB"
       exit 1
   fi
   sleep 5
done

