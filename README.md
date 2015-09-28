# Drupal 8 bootstrap with Docker

## Basic bootstrap

- clone this repo and install Docker
- modify `base/d8.make.yml` to newest beta
- run init.sh (it will create ./www for webroot, build apache container, get Drupal 8, and it will install a site)

```
./init.sh
```

when everything is done, you should have the mysql container running. To put up the Apache/Drupal, do

```
docker-compose up -d
```

and go to http://localhost:5555

## Drupal container with burned-in code

The Drupal container mounts host volume by default. If you want to create a container with burned-in code, run in the root of this repo:

```
docker build -t t0mk/d8burnedin ./
```
