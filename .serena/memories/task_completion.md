# Task Completion Checklist

When a coding task is completed, run the appropriate checks depending on which service was modified:

## Backend (Rust)
1. `cd services/backend && cargo fmt` — Format code
2. `cd services/backend && cargo clippy` — Lint
3. `cd services/backend && cargo test` — Run tests

## WebUI (Next.js)
1. `cd services/webui && pnpm format` — Format with Prettier
2. `cd services/webui && pnpm lint` — Lint with ESLint
3. `cd services/webui && pnpm build` — Verify build succeeds

## Mobile (Flutter)
1. `cd services/mobile && melos run format` — Format
2. `cd services/mobile && melos run analyze` — Analyze
3. `cd services/mobile && melos run test` — Run tests

## Smart Contracts (Solidity)
1. `cd services/contract && pnpm format` — Format
2. `cd services/contract && pnpm lint:sol` — Lint
3. `cd services/contract && pnpm foundrytest` — Run Foundry tests

## GraphQL Schema Changes
If the GraphQL schema was modified:
1. `make setup-gql` — Copy schema and regenerate types for all services

## Git
- Source `.envrc` before any remote git operations: `source .envrc`
- Follow commit message conventions from `.gitmessage.txt`
