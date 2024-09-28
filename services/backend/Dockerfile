FROM rust:1.81.0 AS builder
WORKDIR /app
COPY . .
RUN cargo build --release --package server-core

FROM debian:bookworm-slim
COPY --from=builder /app/target/release/server-core /usr/local/bin/
CMD ["server-core"]