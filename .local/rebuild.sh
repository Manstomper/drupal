#!/bin/sh

cp -n ./.env.local ./.env

docker build . -f "$(pwd)/.local/php/Dockerfile" -t rig/php:8.1.12 \
    && docker compose up -d \
    && docker compose exec php sh -c \
        "cd /app-mount && composer install --no-interaction && ln -s /app-mount/vendor/bin/drush /bin/drush"
