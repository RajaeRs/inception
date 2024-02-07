#!/bin/bash

BLUE='\033[94m'
GREEN='\033[92m'
RESET='\033[0m'

set -e

if [ ! -d /var/lib/mysql/db ]; then
    echo -e "${BLUE}First initialisation MariaDB ... ${RESET}"

    mariadbd --user=mysql --bootstrap << EOF
    FLUSH PRIVILEGES;
    CREATE DATABASE d_name;
    CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
    FLUSH PRIVILEGES;
EOF
    echo -e "${GREEN}MariaDB initialized Succusfely :) ${RESET}"
fi

exec "$@"