#!/bin/sh

if [ ! -d "/var/www/html/demo" ]; then
    echo "cloning repo" ;
    git clone https://github.com/RajaeRs/django_database_testing.git demo;
    cd demo ;
    python3 manage.py migrate;
else
    cd demo
fi

echo "finish script";

exec "$@"