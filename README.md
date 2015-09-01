# Drupal 8 bootstrap with Docker

## Basic bootstrap

- clone this repo and install Docker
- in the reop: `cp -r base www`
- modify `www/d8.make.yml` to newest beta
- build the Apache image: 

```
cd apache
docker build -t t0mk/d8-apache
cd ..
```

- bootstrap Drupal 8 in `./www/`:

```
docker run -v `pwd`/www:/app -w /app d8-apache  drush -y make d8.make.yml
```

At this point you can run `docker-compose up -d` and you will see vanilla Drupal without profile in DOCKER\_HOST:5555

## Install a site:

I prepared very simple script that installs a default site: `cat www/site-install.sh`

As `drush site-install` is touching the database too, you need to have the whole setup ready. Just run it with docker-compose:

```
docker-compose run drupal ./site-install.sh
```
