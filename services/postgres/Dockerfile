ARG POSTGRES_VERSION=15
ARG TARGETARCH
ARG PGX_ULID_VERSION=0.1.5

FROM postgres:${POSTGRES_VERSION}

RUN echo "POSTGRES_VERSION: ${POSTGRES_VERSION}" && \
    echo "TARGETARCH: ${TARGETARCH}" && \
    echo "PGX_ULID_VERSION: ${PGX_ULID_VERSION}"

RUN apt-get update && apt-get install -y \
    curl \
    dpkg \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L -o pgx_ulid.deb https://github.com/pksunkara/pgx_ulid/releases/download/v0.1.5/pgx_ulid-v0.1.5-pg15-arm64-linux-gnu.deb \
    && dpkg -i pgx_ulid.deb \
    && rm pgx_ulid.deb

COPY ./seeds /docker-entrypoint-initdb.d/