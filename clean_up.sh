#!/bin/bash

docker compose down;
docker volume rm mariadb-db nginx_db wordPress-db;
docker rmi inseption_v1-wordpress inseption_v1-mariadb inseption_v1-nginx;
rm -r -- ../../data/mariadb ../../data/nginx ../../data/wp ;
mkdir ../../data/mariadb ../../data/nginx ../../data/wp ;