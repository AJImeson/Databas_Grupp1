#!/usr/bin/env bash

set -e 
shopt -s nullglob

files=(migrations/*.sql)

if [ ${files[@]} -eq 0 ]; then
  echo "No sql files found..."
fi 

until mariadb-admin ping -h"$MARIADB_HOST" --silent; do sleep 1; done

for file in migrations/*.sql; do
  echo "testing file: $file"
  mariadb -h"$MARIADB_HOST" -u root -p"$MARIADB_ROOT_PASSWORD" "$MARIADB_DATABASE" --abort-source-on-error < "$file"
done



