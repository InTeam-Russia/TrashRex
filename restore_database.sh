#/bin/sh
echo "DROP DATABASE logistic; CREATE DATABASE logistic" | psql -h 127.0.0.1 -p 5432 -U postgres
psql -h 127.0.0.1 -p 5432 -U postgres logistic < backup.sql
