# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Architecture

FRIENDA is a multi-service application built with a microservices architecture:

### Core Services
- **Backend**: Rust-based GraphQL API server with Sea-ORM, PostgreSQL database
- **WebUI**: Next.js applications (client and admin) with TypeScript and pnpm
- **Mobile**: Flutter applications (client and admin) with Dart and melos
- **Smart Contracts**: Solidity contracts with Foundry and Hardhat frameworks
- **Infrastructure**: PostgreSQL database with Docker, deployed on Google Cloud Run

### Directory Structure
```
├── services/
│   ├── backend/       # Rust microservices (server-core, server-extension, shared)
│   ├── webui/         # Next.js web applications (client, admin)
│   ├── mobile/        # Flutter mobile applications (client, admin)
│   ├── contract/      # Solidity smart contracts
│   └── postgres/      # Database setup and migrations
├── terraform/         # Infrastructure as code
└── docs/              # Project documentation
```

## Initial Setup

```bash
# Check required tools and install all dependencies
make setup
```

This will: verify tool versions, start PostgreSQL, install dependencies for all services, and copy `.env.example` files. After setup, edit the `.env` files with your credentials.

### Prerequisites
- Rust (stable) — https://rustup.rs
- Node.js 20+ — https://nodejs.org
- pnpm 9+ — `npm install -g pnpm`
- Docker — https://www.docker.com
- Flutter 3.3.1+ (mobile dev) — https://flutter.dev
- Foundry (contract dev) — https://getfoundry.sh

## Development Commands

### Backend (Rust)
```bash
# Start development server with hot reload
make api-dev

# Run without hot reload
make api

# Update database entities from schema
make update-entities

# Update models and format code
make update-models

# Test and lint
cd services/backend && cargo test
cd services/backend && cargo clippy
cd services/backend && cargo fmt
```

### WebUI (Next.js)
```bash
# Install dependencies
cd services/webui && pnpm install

# Start development servers
make webui-client-dev    # Client app
make webui-admin-dev     # Admin app

# Build and lint
cd services/webui && pnpm build
cd services/webui && pnpm lint
cd services/webui && pnpm format
```

### Mobile (Flutter)
```bash
# Start iOS simulator and run app
make mobile-dev

# Flutter commands via melos (fvm経由で実行)
cd services/mobile && fvm dart run melos bootstrap
cd services/mobile && fvm dart run melos run test
cd services/mobile && fvm dart run melos run analyze
cd services/mobile && fvm dart run melos run format
```

### Smart Contracts (Solidity)
```bash
# Install dependencies
cd services/contract && pnpm install

# Build and test with Foundry
cd services/contract && pnpm build
cd services/contract && pnpm foundrytest
cd services/contract && pnpm coverage

# Hardhat testing (alternative)
cd services/contract && pnpm test

# Lint and format
cd services/contract && pnpm lint:sol
cd services/contract && pnpm format

# Deploy to Sepolia testnet
cd services/contract && pnpm deploy:credentialProxy-sepolia
```

### Database
```bash
# Start PostgreSQL container
make run-pg

# Stop database
make stop-pg

# Remove database containers
make down-pg
```

### Local Development Services (External Service Emulators/Mocks)
```bash
# Start all emulators/mocks (Firebase, Anvil, Mailpit, stripe-mock, etc.)
make dev-all

# Start individual services
make dev-firebase      # Firebase Auth/Storage Emulator (ports 9099, 9199, UI: 4000)
make dev-blockchain    # Anvil local blockchain (port 8545)
make dev-mail          # Mailpit SMTP catcher (SMTP: 1025, UI: 8025)
make dev-stripe        # stripe-mock (HTTP: 12111, HTTPS: 12112)
make dev-bigquery      # BigQuery Emulator (port 9050)
make dev-contentful    # Contentful mock (port 3100)
make dev-gemini        # Gemini mock (port 3101)
make dev-sendgrid      # SendGrid mock + Mailpit (port 3102, Mailpit UI: 8025)

# Stop/remove all dev services
make stop-services
make down-services
```

### GraphQL Code Generation
```bash
# Generate GraphQL types for all services
make setup-gql

# Generate for specific service
make gql-webui    # Web UI
make gql-mobile   # Mobile apps
```

## Key Technologies

- **Backend**: Rust, Actix-web, Sea-ORM, PostgreSQL, GraphQL (async-graphql)
- **Frontend**: Next.js, React, TypeScript, Tailwind CSS, Apollo Client
- **Mobile**: Flutter, Dart, GraphQL
- **Contracts**: Solidity, Foundry, Hardhat, OpenZeppelin
- **Infrastructure**: Docker, Google Cloud Run, Terraform
- **Package Managers**: Cargo (Rust), pnpm (Node.js), melos (Flutter)

## GraphQL Schema Management

The GraphQL schema is centrally managed in `services/backend/server-core/presentation/src/graphql/schema.graphql` and automatically copied to frontend services. Always regenerate client code after schema changes using `make setup-gql`.

## Authentication & Security

The application uses Firebase Authentication with JWT tokens. Backend services validate tokens using Firebase Admin SDK. Always handle authentication in the shared backend crates.

## Testing Strategy

- **Backend**: Unit tests with `cargo test`, integration tests in each service
- **Frontend**: Component tests and linting with pnpm
- **Mobile**: Flutter tests with melos
- **Contracts**: Foundry tests for gas optimization, Hardhat for integration

## Deployment

- **Development**: Automated deployment to Google Cloud Run on push to main branch
- **Production**: Automated deployment on push to release branch
- **Contracts**: Manual deployment to Sepolia testnet via scripts

## Common Patterns

- Use workspace dependencies in Cargo.toml for consistent versioning
- Follow GraphQL-first API design with centralized schema
- Implement proper error handling using Result types in Rust
- Use TypeScript strict mode for all frontend code
- Follow Flutter material design patterns for mobile UI