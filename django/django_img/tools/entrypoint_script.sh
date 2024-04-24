#!/bin/sh

if [ ! -d "/var/www/html/demo" ]; then
    django-admin startproject demo && cd demo;
    python3 ./demo/manage.py migrate;
fi

echo "finish script";

exec "$@"