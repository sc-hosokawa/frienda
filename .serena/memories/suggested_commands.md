# Suggested Commands

## Backend (Rust)
```bash
make api-dev                    # Start dev server with hot reload (also starts DB)
make api                        # Start server without hot reload
make update-entities            # Generate Sea-ORM entities from DB schema
make update-models              # Generate models and format code
cd services/backend && cargo test    # Run tests
cd services/backend && cargo clippy  # Lint
cd services/backend && cargo fmt     # Format
```

## WebUI (Next.js / pnpm / Turborepo)
```bash
cd services/webui && pnpm install     # Install dependencies
make webui-client-dev                  # Dev server for client app
make webui-admin-dev                   # Dev server for admin app
cd services/webui && pnpm build        # Build all apps
cd services/webui && pnpm lint         # Lint all apps
cd services/webui && pnpm format       # Format with Prettier
```

## Mobile (Flutter / melos)
```bash
make mobile-dev                        # Open simulator and run app
cd services/mobile && melos bootstrap  # Bootstrap packages
cd services/mobile && melos run test   # Run tests
cd services/mobile && melos run analyze # Analyze code
cd services/mobile && melos run format  # Format code
```

## Smart Contracts (Solidity / Foundry / Hardhat)
```bash
cd services/contract && pnpm install      # Install deps
cd services/contract && pnpm build        # Build contracts
cd services/contract && pnpm foundrytest  # Foundry tests
cd services/contract && pnpm test         # Hardhat tests
cd services/contract && pnpm coverage     # Coverage report
cd services/contract && pnpm lint:sol     # Lint Solidity
cd services/contract && pnpm format       # Format code
```

## Database
```bash
make run-pg       # Start PostgreSQL (docker compose up)
make stop-pg      # Stop PostgreSQL
make down-pg      # Remove PostgreSQL containers
```

## GraphQL Code Generation
```bash
make setup-gql    # Copy schema + generate types for all services
make gql-webui    # Generate WebUI types only
make gql-mobile   # Generate mobile types only
```

## System Utilities (macOS/Darwin)
```bash
git, ls, cd, grep, find   # Standard unix commands
open -a Simulator          # Open iOS Simulator
docker compose             # Docker management
```
