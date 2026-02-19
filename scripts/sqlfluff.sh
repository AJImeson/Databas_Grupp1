#!/usr/bin/env bash

set -e 

if [ -d "migrations" ]; then
  sqlfluff lint migrations/ --dialect mariadb --ignore parsing
else 
  echo "No directory migrations exists..."
  exit 0
fi 
