ARG POSTGRES_VERSION=16
FROM postgres:${POSTGRES_VERSION}

# COPY ./seeds /docker-entrypoint-initdb.d/
COPY ./01_full_schema.sql /schema/01_full_schema.sql
COPY ./initdb/00_apply_full_schema.sh /docker-entrypoint-initdb.d/00_apply_full_schema.sh
COPY ./migrations/20260507_mobile_graphql_artist_access.sql /docker-entrypoint-initdb.d/01_mobile_graphql_artist_access.sql
RUN chmod +x /docker-entrypoint-initdb.d/00_apply_full_schema.sh
