#!/bin/sh

docker compose exec -w /app-mount/public php sh -c 'printf "\nYou should now be inside the PHP container. You can run commands such as \"drush list\".\nType exit to quit.\n\n"; sh'
