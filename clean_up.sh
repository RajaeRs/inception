#!/bin/bash

docker compose down;
docker volume rm inception_mariadb-db inception_nginx_db inception_wordPress-db;
docker rmi inception-wordpress inception-mariadb inception-nginx;
rm -r -- ../../data/mariadb ../../data/nginx ../../data/wp ;
mkdir ../../data/mariadb ../../data/nginx ../../data/wp ;