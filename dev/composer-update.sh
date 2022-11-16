#!/bin/sh

docker compose run --rm -v "$(pwd):/app-mount" -w /app-mount php sh -c "composer update --no-interaction"
