#!/bin/sh
docker-compose kill
docker-compose rm -f
sudo rm -rf ./www

cp -r base www
cd apache
docker build -t d8-apache ./
cd ..
docker run -v `pwd`/www:/app -w /app d8-apache  drush -y make d8.make.yml
docker-compose run drupal ./site-install.sh


