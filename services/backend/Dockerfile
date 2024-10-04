FROM rust:1.81.0 AS builder
WORKDIR /app
COPY . .
RUN cargo build --release --package server-core

# FROM debian:bookworm-slim
FROM gcr.io/distroless/cc-debian12
COPY --from=builder /app/target/release/server-core /
EXPOSE 8080
CMD ["./server-core"]