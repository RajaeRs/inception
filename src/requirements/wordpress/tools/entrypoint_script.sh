#!/bin/bash

BLUE='\033[94m'
GREEN='\033[92m'
RESET='\033[0m'
RED='\033[91m'
YELLOW='\033[93m'

#passwords:
MARIADB_USER_PASSWORD=$(cat $FILE_PATH_MARIADB_PASS)
ADMIN_PASSWORD=$(cat $FILE_PATH_ADMIN_PASS)
USER_PASS=$(cat $FILE_PATH_USER_PASS)

set -e

if [ ! -f /var/www/html/wp-config.php ]; then
    echo -e "${BLUE}First initialisation WordPress ... ${RESET}"
    wp core download --allow-root;
    wp config create --allow-root --dbname=${MARIADB_DATABASE_NAME} --dbuser=${MARIADB_USER_NAME} --dbpass=${MARIADB_USER_PASSWORD} --dbhost=mariadb:3306;
    wp config shuffle-salts --allow-root;
    wp core install --allow-root  --url=${DOMAIN_NAME} --title=${TITLE} --admin_user=${ADMIN_NAME} --admin_password=${ADMIN_PASSWORD} --admin_email=${ADMIN_EMAIL};
    wp user create --allow-root ${USER_NAME} ${USER_EMAIL} --user_pass=${USER_PASS} --role=editor --porcelain;

    wp --allow-root config set WP_REDIS_HOST redis;
    wp --allow-root config set WP_REDIS_PORT 6379;
    wp --allow-root config set WP_CACHE true;
    wp --allow-root plugin install redis-cache --activate;
    wp --allow-root redis enable;

    adduser --home /var/www/html/ --shell /bin/false --ingroup www-data --disabled-password --gecos "" ${FTP_USER_NAME}
    chmod -R g+rw /var/www/html
    chown -R www-data:www-data /var/www/html/
else
    echo -e "${RED}[!] --------- Alredy exist --------- [!]${RESET}"
fi

exec "$@"