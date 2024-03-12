#!/bin/bash

docker compose down;
docker volume rm mariadb_db wordPress_db;
docker rmi src-wordpress src-mariadb src-nginx;
sudo rm -r -- /home/rajae/data/mariadb /home/rajae/data/nginx /home/rajae/data/wp;
mkdir /home/rajae/data/mariadb /home/rajae/data/nginx /home/rajae/data/wp;