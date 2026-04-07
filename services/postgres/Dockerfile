ARG POSTGRES_VERSION=16
FROM postgres:${POSTGRES_VERSION}

COPY ./seeds /docker-entrypoint-initdb.d/
