#!/bin/sh

set -e

host="$1"
shift
cmd="$@"

until PGPASSWORD=mysecretpassword psql -h "db" -U "crud" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

python manage.py migrate

>&2 echo "Postgres is up - executing command"

exec $cmd
