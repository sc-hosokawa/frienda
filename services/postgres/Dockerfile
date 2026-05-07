ARG POSTGRES_VERSION=16
FROM postgres:${POSTGRES_VERSION}

COPY ./seeds/01_full_schema.sql /schema/01_full_schema.sql
COPY ./seeds/00_apply_full_schema.sh /docker-entrypoint-initdb.d/00_apply_full_schema.sh
COPY ./seeds/02_phase1_mobile_graphql_artist_access.sql /docker-entrypoint-initdb.d/02_phase1_mobile_graphql_artist_access.sql
COPY ./seeds/03_dummy_mobile_graphql_artist_access.sql /docker-entrypoint-initdb.d/03_dummy_mobile_graphql_artist_access.sql
RUN chmod +x /docker-entrypoint-initdb.d/00_apply_full_schema.sh
