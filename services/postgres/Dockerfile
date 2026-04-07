ARG POSTGRES_VERSION=16
FROM postgres:${POSTGRES_VERSION}

COPY ./seeds /docker-entrypoint-initdb.d/
# COPY ./20250603_export_sql_schemas.sql /docker-entrypoint-initdb.d/