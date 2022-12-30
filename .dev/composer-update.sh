#!/bin/sh

docker compose exec -w /app-mount php sh -c "composer update --no-interaction"
