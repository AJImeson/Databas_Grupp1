#!/usr/bin/env bash

set -e 

until mariadb-admin ping -h"$MARIADB_HOST" --silent; do sleep 1; done

for file in migrations/*.sql; do
  echo "testing file: $file"
  mariadb -h"$MARIADB_HOST" -u root -p"$MARIADB_ROOT_PASSWORD" "$MARIADB_DATABASE" --abort-source-on-error < "$file"
done
