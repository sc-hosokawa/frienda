ARG POSTGRES_VERSION=16
FROM postgres:${POSTGRES_VERSION}

# COPY ./export_frienda_pg_prd_241214.sql /docker-entrypoint-initdb.d/
# COPY ./admin_Cloud_SQL_Export_2024-11-08.sql /docker-entrypoint-initdb.d/
COPY ./seeds /docker-entrypoint-initdb.d/
