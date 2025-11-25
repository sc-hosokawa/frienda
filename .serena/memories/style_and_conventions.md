# Style and conventions
- General: use pnpm (Node >=18, pnpm >=9); avoid npm/yarn. Keep secrets out of repo; follow `.env.example` patterns. Conventional commit prefixes from `.gitmessage.txt` (e.g., `feat:`, `fix:`) with optional scope `[backend|client|admin|mobile|contract]-`.
- Rust backend: format with `cargo fmt` (also run via `make update-models`), modules/files snake_case, types PascalCase. Actix + async-graphql stack; keep schema synced to web/mobile via `make setup-gql`.
- Web UI (services/webui): ESLint + Prettier; format via `pnpm -C services/webui format`, lint via `pnpm -C services/webui lint`. Turborepo; use TypeScript configs from workspace.
- Mobile (Flutter): melos workspace; use `flutter` tooling; add tests under `services/mobile/apps/*/test/`.
- Contracts: Solidity/TS lint via `pnpm -C services/contract lint:sol` and `pnpm -C services/contract lint:es`. Contracts PascalCase; files snake/kebab-case. TypeChain generated types present.
- Backend tests: Rust `cargo test` (or `cargo nextest run` noted in backend README); integration tests under `services/backend/server-core/tests/`.
