.PHONY: setup check-tools setup-gql gql-webui gql-mobile api-dev api webui-client-dev webui-admin-dev mobile-dev update-entities update-models run-pg down-pg stop-pg

# GraphQL Schema
setup-gql: copy-schema .WAIT gql-webui gql-mobile

copy-schema:
	cp services/backend/server-core/presentation/src/graphql/schema.graphql services/webui/
	cp services/backend/server-core/presentation/src/graphql/schema.graphql services/mobile/

gql-webui:
	cd services/webui && pnpm --filter client codegen

gql-mobile:
	cd services/mobile && flutter pub run build_runner build --delete-conflicting-outputs 

# Postgres
run-pg:
	docker compose up -d --build

down-pg:
	docker compose down

stop-pg:
	docker compose stop

# Backend
update-entities:
	cd services/backend/server-core && \
	sea-orm-cli generate entity -u postgres://postgres:postgres@localhost:5432/postgres -o domain/src/entities

update-models:
	cd services/backend/server-core && \
	cargo run --bin generate-models
	cd services/backend && \
	cargo fmt

api-dev:
	docker compose up -d --build && \
	cd services/backend/server-core && cargo watch -x run

api:
	docker compose up -d --build && \
	cd services/backend/server-core && cargo run

# WebUI
webui-client-dev:
	cd services/webui && pnpm dev --filter=client

webui-admin-dev:
	cd services/webui && pnpm dev --filter=admin

# Mobile
mobile-dev:
	open -a Simulator
	cd services/mobile && flutter run

# Setup
setup: check-tools
	@echo "=== PostgreSQL ==="
	@test -f docker-compose.yaml || test -f docker-compose.yml || test -f compose.yaml || (echo "ERROR: docker-compose.yaml not found" && exit 1)
	docker compose up -d --build
	@echo "=== Backend dependencies ==="
	cd services/backend && cargo check
	@echo "=== WebUI dependencies ==="
	cd services/webui && pnpm install
	@echo "=== Contract dependencies ==="
	cd services/contract && pnpm install
	@echo "=== Mobile dependencies ==="
	cd services/mobile && melos bootstrap
	@echo "=== Environment files ==="
	@test -f services/backend/.env || (cp services/backend/.env.example services/backend/.env && echo "Created services/backend/.env")
	@test -f services/webui/apps/client/.env.local || (cp services/webui/apps/client/.env.example services/webui/apps/client/.env.local && echo "Created services/webui/apps/client/.env.local")
	@test -f services/webui/apps/admin/.env.local || (cp services/webui/apps/admin/.env.example services/webui/apps/admin/.env.local && echo "Created services/webui/apps/admin/.env.local")
	@test -f services/contract/.env || (test -f services/contract/.env.example && cp services/contract/.env.example services/contract/.env && echo "Created services/contract/.env" || echo "Skipped services/contract/.env (no .env.example found)")
	@echo ""
	@echo "Setup complete! Next steps:"
	@echo "  1. Edit .env files with your credentials"
	@echo "  2. Run 'make api-dev' to start the backend"
	@echo "  3. Run 'make webui-client-dev' to start the client"

check-tools:
	@echo "=== Checking required tools ==="
	@command -v rustc >/dev/null 2>&1 && echo "  rustc: $$(rustc --version)" || (echo "  rustc: NOT FOUND (install from https://rustup.rs)" && exit 1)
	@command -v cargo >/dev/null 2>&1 && echo "  cargo: $$(cargo --version)" || (echo "  cargo: NOT FOUND" && exit 1)
	@command -v cargo-watch >/dev/null 2>&1 && echo "  cargo-watch: installed" || echo "  cargo-watch: NOT FOUND (optional: cargo install cargo-watch)"
	@command -v node >/dev/null 2>&1 && echo "  node: $$(node --version)" || (echo "  node: NOT FOUND (install Node.js 18+)" && exit 1)
	@command -v pnpm >/dev/null 2>&1 && echo "  pnpm: $$(pnpm --version)" || (echo "  pnpm: NOT FOUND (npm install -g pnpm)" && exit 1)
	@command -v flutter >/dev/null 2>&1 && echo "  flutter: $$(flutter --version 2>/dev/null | head -1)" || echo "  flutter: NOT FOUND (optional for mobile dev)"
	@command -v melos >/dev/null 2>&1 && echo "  melos: installed" || echo "  melos: NOT FOUND (optional: dart pub global activate melos)"
	@command -v docker >/dev/null 2>&1 && echo "  docker: $$(docker --version)" || (echo "  docker: NOT FOUND (install Docker Desktop)" && exit 1)
	@command -v forge >/dev/null 2>&1 && echo "  forge: $$(forge --version 2>/dev/null | head -1)" || echo "  forge: NOT FOUND (optional for contract dev: https://getfoundry.sh)"
	@echo ""

# Contract
