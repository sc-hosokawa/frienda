# What to do before finishing tasks
- Run relevant checks: backend `cargo test` (or `cargo nextest run`), web UI `pnpm -C services/webui lint` and `pnpm -C services/webui format`, contracts `pnpm -C services/contract test` or `forge test`, mobile `flutter test` when touched. Start DB via `make run-pg` if backend needs Postgres.
- Keep GraphQL schema in sync: after backend schema changes run `make setup-gql` then regenerate clients (`pnpm -C services/webui gql-codegen`, Flutter build_runner).
- Note schema/migration impacts in PRs; avoid committing secrets (.env). Follow commit message style `feat/fix/docs/...` with optional scope `[backend|client|admin|mobile|contract]-` to trigger CI jobs (`backend`, `client`, `contract`).
- PR hygiene: clear description, linked issues, screenshots for UI changes, reproduction steps; ensure local tests pass.
