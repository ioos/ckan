#!/bin/bash
db_q="SELECT 1 FROM pg_database WHERE datname='pycsw'"
if [[ -z "$(psql -U "$POSTGRES_USER" -tAc "$db_q" postgres)" ]]; then
   createdb -U "$POSTGRES_USER" pycsw -E utf-8
fi

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" pycsw <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS postgis;
    ALTER VIEW geometry_columns OWNER TO ckan;
    ALTER TABLE spatial_ref_sys OWNER TO ckan;
EOSQL
