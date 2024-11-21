ARG POSTGRES_VERSION=16
FROM postgres:${POSTGRES_VERSION}
COPY ./admin_Cloud_SQL_Export_2024-11-21.sql /docker-entrypoint-initdb.d/
# COPY ./seeds /docker-entrypoint-initdb.d/