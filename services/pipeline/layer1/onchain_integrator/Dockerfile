FROM rust:1.81.0 AS builder
WORKDIR /app
COPY . .
RUN cargo build --release

FROM gcr.io/distroless/cc-debian12
COPY --from=builder /app/target/release/onchain_integrator /
EXPOSE 8080
CMD ["./onchain_integrator"]