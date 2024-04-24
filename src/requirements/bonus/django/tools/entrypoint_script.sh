#!/bin/sh

if [ ! -d "/var/www/html/demo" ]; then
    git clone https://github.com/RajaeRs/django_database_testing.git demo;
fi

echo "finish script";

exec "$@"