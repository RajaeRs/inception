#!/bin/sh

if [ ! -d "/var/www/html/demo" ]; then
    django-admin startproject demo
fi

echo "finish script";

exec "$@"