#!/bin/sh
docker-compose kill
docker-compose rm -f
sudo rm -rf ./www

cp -r base www
cd apache-dev
docker build -t d8-apache-dev ./
cd ..
docker run -v `pwd`/www:/app -w /app t0mk/d8-apache-dev  drush -y make d8.make.yml
docker-compose run drupal ./site-install.sh


