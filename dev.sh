#!/bin/sh

if [[ $(docker compose ps -q php 2>&1) =~ "no such service" ]]; then
    echo "Container does not appear to exist. Building and starting..."
    cp -n ./.env.local ./.env

    docker build . -f "$(pwd)/dev/nginx/Dockerfile" -t rig/nginx:1.23.2 \
        && docker build . -f "$(pwd)/dev/php/Dockerfile" -t rig/php:8.1.12 \
        && docker compose up -d \
        && docker compose run --rm -v "$(pwd):/app-mount" -w /app-mount php sh -c "composer install --no-interaction"
else
    echo "Container appears to exist. Restarting..."
    docker compose restart
fi
