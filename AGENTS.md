# Repository Guidelines

## Project Structure & Module Organization
- `services/backend/server-core`: Rust (Actix + async-graphql). Shared crates in `services/backend/{shared,application,domain,infrastracture,presentation,registry}`.
- `services/webui`: pnpm + turbo monorepo. Apps in `apps/{client,admin}`, shared packages in `packages/`.
- `services/mobile`: Flutter (melos workspace). Apps in `apps/{client,admin}`.
- `services/contract`: Solidity (Hardhat + Foundry). Contracts in `contracts/`, tests in `test/`.
- Infra & docs: `services/postgres`, `docker-compose.yaml`, `terraform/`, `docs/`.

## Build, Test, and Development Commands
- Start DB: `make run-pg` (up Postgres via Docker). Stop with `make stop-pg` or `make down-pg`.
- Backend dev: `make api-dev` (watches and runs server). One-off run: `make api`.
- GraphQL codegen: `make setup-gql` (copies schema to web/mobile) then `pnpm -C services/webui gql-codegen` and Flutter build_runner.
- Web UI dev: `make webui-client-dev` or `make webui-admin-dev`.
- Mobile dev: `make mobile-dev` (opens iOS Simulator then runs).
- Backend tests: `cd services/backend/server-core && cargo test`.
- Contract tests: `pnpm -C services/contract test` (Hardhat) or `forge test`.

## Coding Style & Naming Conventions
- Rust: `cargo fmt` (run via `make update-models` or directly). Use snake_case for modules/files, PascalCase for types.
- Web UI: ESLint + Prettier. Format with `pnpm -C services/webui format`; lint with `pnpm -C services/webui lint`.
- Solidity/TS (contracts): `pnpm -C services/contract lint:sol` and `lint:es`. Contracts PascalCase; files snake/kebab-case.
- General: Use pnpm (Node >= 18, pnpm >= 9); avoid npm/yarn here.

## Testing Guidelines
- Rust: place integration tests in `services/backend/server-core/tests/`. Run `cargo test`.
- Contracts: place TS tests in `services/contract/test/*.ts`; Foundry tests in `test/foundry`. Run coverage with `forge coverage`.
- Mobile: add tests under `services/mobile/apps/*/test/`; run `flutter test`.
- Web UI: add unit tests under `services/webui/apps/*/tests` (Jest/Vitest); integrate with Turbo if added.

## Commit & Pull Request Guidelines
- Message style: Conventional prefixes from `.gitmessage.txt` (e.g., `feat:`, `fix:`, `docs:`). Suggested: `[scope]-prefix: message` (scope: backend/client/admin/mobile/contract).
- CI hints: Including `backend`, `client`, or `contract` in the commit message triggers corresponding CI jobs.
- PRs: clear description, linked issues, screenshots for UI, and steps to reproduce. Note schema or migration impacts. Ensure `make run-pg` + local tests pass.

## Security & Configuration Tips
- Do not commit secrets. Use `.env.example` (see `services/contract/.env.example`) as a guide.
- Backend envs follow GitHub Actions deploy vars (e.g., `DATABASE_URL`, `GEMINI_API_KEY`).
- Keep GraphQL schema in sync via `make setup-gql` after backend changes.
