#!/bin/bash
BLUE='\033[94m'
GREEN='\033[92m'
RESET='\033[0m'
RED='\033[91m'
YELLOW='\033[93m'

#passwords :
MARIADB_USER_PASSWORD=$(cat $FILE_PATH_MARIADB_PASS)

set -e

if [ ! -d /var/lib/mysql/${MARIADB_DATABASE_NAME} ]; then
    echo -e "${BLUE}First initialisation MariaDB ... ${RESET}"

mariadbd --user=mysql --bootstrap << EOF
FLUSH PRIVILEGES;
CREATE DATABASE ${MARIADB_DATABASE_NAME};
CREATE USER '${MARIADB_USER_NAME}'@'%' IDENTIFIED BY '${MARIADB_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE_NAME}.* TO '${MARIADB_USER_NAME}'@'%';
FLUSH PRIVILEGES;
EOF
else
    echo -e "${RED}[!] --------- Alredy exist --------- [!]${RESET}"
fi

exec "$@"