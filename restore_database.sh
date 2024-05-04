#/bin/sh
echo "DROP DATABASE trash; CREATE DATABASE trash" | psql -h 127.0.0.1 -p 5432 -U postgres
psql -h 127.0.0.1 -p 5432 -U postgres trash < backup.sql
