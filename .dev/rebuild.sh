#!/bin/sh

cp -n ./.dev/.env.local ./.env

docker build . -f "$(pwd)/.dev/php/Dockerfile" -t drupal/php:8.1.12 \
    && docker compose up -d \
    && docker compose exec -w /app-mount php sh -c "composer install --no-interaction"

printf 'if (file_exists(\"{$app_root}/{$site_path}/settings.local.php\")) { include \"{$app_root}/{$site_path}/settings.local.php\"; }\n\n' >> ./public/sites/default/default.settings.php

cp -n ./.dev/drupal/development.services.yml ./public/sites/

echo "\$settings['cache']['bins']['render']='cache.backend.null';\$settings['cache']['bins']['discovery_migration']='cache.backend.memory';\$settings['cache']['bins']['dynamic_page_cache']='cache.backend.null';" >> ./public/sites/example.settings.local.php
cp -n ./public/sites/example.settings.local.php ./public/sites/default/settings.local.php
