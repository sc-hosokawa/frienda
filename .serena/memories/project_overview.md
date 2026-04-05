# FRIENDA Project Overview

## Purpose
FRIENDA is a multi-service application built with a microservices architecture. It appears to be a social/friendship-related platform with web, mobile, and blockchain components.

## Tech Stack
- **Backend**: Rust (Actix-web, Sea-ORM, async-graphql) with PostgreSQL
- **Frontend (WebUI)**: Next.js, React, TypeScript, Tailwind CSS, Apollo Client — monorepo with Turborepo + pnpm
- **Mobile**: Flutter/Dart with melos monorepo
- **Smart Contracts**: Solidity with Foundry + Hardhat, OpenZeppelin
- **Infrastructure**: Docker, Google Cloud Run, Terraform
- **Auth**: Firebase Authentication with JWT tokens

## Architecture
GraphQL-first API design. The GraphQL schema is centrally managed in the backend and copied to frontend services for code generation.

### Directory Structure
```
services/
├── backend/           # Rust microservices
│   ├── server-core/   # Main API (domain, application, presentation, infrastructure layers)
│   ├── server-extension/  # Extension service
│   └── shared/        # Shared crates
├── webui/            # Next.js monorepo (Turborepo + pnpm)
│   ├── apps/client/  # Client-facing web app
│   ├── apps/admin/   # Admin web app
│   └── packages/     # Shared packages (ui, eslint-config, typescript-config)
├── mobile/           # Flutter monorepo (melos)
│   ├── apps/         # Mobile apps (client, admin)
│   └── packages/     # Shared Flutter packages
├── contract/         # Solidity smart contracts (Foundry + Hardhat)
├── postgres/         # Database setup and migrations
└── terraform/        # Infrastructure as code
```

## CI/CD
- GitHub Actions workflows for CI, dev deployment, and production deployment
- Dev: auto-deploy on push to `main`
- Prod: auto-deploy on push to `release` branch
- Separate test actions for backend, frontend (Next.js), and contracts

## Package Managers
- Cargo (Rust), pnpm (Node.js/WebUI/Contracts), melos (Flutter)
