#!/bin/sh

cp -n ./.local/.env.local ./.env

docker build . -f "$(pwd)/.local/php/Dockerfile" -t drupal/php:8.1.12 \
    && docker compose up -d \
    && docker compose exec -w /app-mount php sh -c "composer install --no-interaction" \
    && cp -n ./public/sites/example.settings.local.php ./public/sites/default/settings.local.php \
    && cp -n ./.local/drupal/development.services.yml ./public/sites/ \
    && printf '\nif (file_exists(\"{$app_root}/{$site_path}/settings.local.php\")) { include \"{$app_root}/{$site_path}/settings.local.php\"; }\n\n' >> ./public/sites/default/default.settings.php
