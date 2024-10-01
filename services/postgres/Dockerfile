ARG POSTGRES_VERSION=16

FROM postgres:${POSTGRES_VERSION}

ARG POSTGRES_VERSION=16
ARG TARGETARCH
ARG PGX_ULID_VERSION=0.1.5

RUN apt-get update && apt-get install -y \
    curl \
    dpkg \
    && rm -rf /var/lib/apt/lists/* \
    && curl -L -o pgx_ulid.deb https://github.com/pksunkara/pgx_ulid/releases/download/v${PGX_ULID_VERSION}/pgx_ulid-v${PGX_ULID_VERSION}-pg${POSTGRES_VERSION}-${TARGETARCH}-linux-gnu.deb \
    && dpkg -i pgx_ulid.deb \
    && rm pgx_ulid.deb

COPY ./seeds /docker-entrypoint-initdb.d/