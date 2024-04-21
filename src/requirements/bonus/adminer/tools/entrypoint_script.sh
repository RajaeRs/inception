#!/bin/sh

if [ ! -d "/var/www/html/adminer/install.txt" ]; then
    chown -R www-data:www-data /var/www/html/adminer/adminer.php
    chmod 755 /var/www/html/adminer/adminer.php
    touch install.txt
    echo add permission successfuly
fi

echo "finish script";

exec "$@"