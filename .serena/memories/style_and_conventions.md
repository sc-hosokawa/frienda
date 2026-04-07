# Style and Conventions

## General
- GraphQL-first API design with centralized schema
- Use workspace dependencies in Cargo.toml for consistent versioning
- TypeScript strict mode for all frontend code
- Flutter material design patterns for mobile UI

## Backend (Rust)
- Clean architecture layers: domain, application, presentation, infrastructure
- Error handling with Result types
- Sea-ORM for database access
- async-graphql for GraphQL API
- Format with `cargo fmt`, lint with `cargo clippy`

## Frontend (WebUI)
- Next.js with TypeScript
- Tailwind CSS for styling
- Apollo Client for GraphQL
- Turborepo monorepo with pnpm workspaces
- ESLint for linting, Prettier for formatting
- Node >= 18, pnpm >= 9 (npm/yarn explicitly disallowed)

## Mobile (Flutter)
- Dart language
- Melos for monorepo management
- GraphQL with build_runner code generation

## Smart Contracts (Solidity)
- Foundry for testing and gas optimization
- Hardhat as alternative test framework
- OpenZeppelin base contracts
- Solhint for linting

## Git
- `.envrc` for git identity and SSH config per project
- Always source `.envrc` before git remote operations
