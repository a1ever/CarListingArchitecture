#!/bin/bash

psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "CREATE ROLE Reader login password 'rpass';"
psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "CREATE ROLE Writer login password 'wpass';"
psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "GRANT SELECT ON ALL TABLES in schema public TO Reader;"
psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "GRANT SELECT, UPDATE, INSERT ON ALL TABLES in schema public TO Writer;"

psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "CREATE USER analytic password 'analytic';"
psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "GRANT SELECT ON \"listing\" to analytic;"

psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "CREATE ROLE no_login_admin superuser nologin inherit;"
psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "GRANT ALL PRIVILEGES ON ALL TABLES in schema public TO no_login_admin;"

psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "CREATE GROUP group_role;"
psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "GRANT no_login_admin TO group_role;"

for user in $NAMES; do
    psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "CREATE USER \"$user\" LOGIN PASSWORD '$user';"
    psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "GRANT group_role TO \"$user\";"
done
