#!/bin/bash

BLUE='\033[94m'
GREEN='\033[92m'
RESET='\033[0m'
RED='\033[91m'
YELLOW='\033[93m'

set -e

if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
    echo -e "${BLUE}First initialisation MariaDB ... ${RESET}"
    wp core download --allow-root;
    wp config create --allow-root --dbname={$MARIADB_DATABASE_NAME} --dbuser={$MARIADB_USER_NAME} --dbhost=localhost ;
    wp config shuffle-salts --allow-root;
    wp core install --allow-root  --url="{$DOMAIN_NAME}" --title="{$TITLE}" --admin_user="{$ADMIN_NAME}" --admin_password="{$ADMIN_PASSWORD}" --admin_email="{$ADMIN_EMAIL}" --skip-email ;
    wp user create --allow-root $USER_NAME $USER_EMAIL --role=administrator --porcelain;
    echo -e "${GREEN}WordPress initialized Succusfely :) ${RESET}"
else
    echo -e "${RED}[!] --------- Alredy exist --------- [!]${RESET}"
fi

exec "$@"