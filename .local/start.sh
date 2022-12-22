#!/bin/sh

if [[ $(docker compose ps -q php 2>&1) =~ "no such service" ]]; then
    echo "Container does not appear to exist. Building and starting..."

    "${BASH_SOURCE%/*}/rebuild.sh"
else
    echo "Container appears to exist. Restarting..."

    docker compose restart
fi

source .env && echo "The site should work from http://localhost:$NGINX_PORT"
