SHELL := /bin/bash
.SHELLFLAGS := -ec

.PHONY: help setup check-tools setup-gql gql-webui gql-mobile api-dev api webui-client-dev webui-admin-dev mobile-dev update-entities update-models run-pg down-pg stop-pg

.DEFAULT_GOAL := help

help: ## Show this help
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  setup              Install dependencies, start DB, create .env files"
	@echo "  check-tools        Verify required tools and versions"
	@echo ""
	@echo "  api-dev            Start backend with hot reload (cargo watch)"
	@echo "  api                Start backend without hot reload"
	@echo "  webui-client-dev   Start WebUI client dev server"
	@echo "  webui-admin-dev    Start WebUI admin dev server"
	@echo "  mobile-dev         Start iOS simulator and run Flutter app"
	@echo ""
	@echo "  setup-gql          Copy schema and regenerate GraphQL code for all services"
	@echo "  gql-webui          Regenerate GraphQL code for WebUI"
	@echo "  gql-mobile         Regenerate GraphQL code for mobile apps"
	@echo ""
	@echo "  run-pg             Start PostgreSQL container"
	@echo "  stop-pg            Stop PostgreSQL container"
	@echo "  down-pg            Remove PostgreSQL container"
	@echo ""
	@echo "  update-entities    Generate Sea-ORM entities from DB schema"
	@echo "  update-models      Generate models and format Rust code"

# GraphQL Schema
setup-gql: copy-schema
	$(MAKE) gql-webui gql-mobile

copy-schema:
	cp services/backend/server-core/presentation/src/graphql/schema.graphql services/webui/
	cp services/backend/server-core/presentation/src/graphql/schema.graphql services/mobile/
	cp services/backend/server-core/presentation/src/graphql/schema.graphql services/mobile/apps/admin/lib/graphql/
	cp services/backend/server-core/presentation/src/graphql/schema.graphql services/mobile/apps/client/lib/data/graphql/

gql-webui:
	cd services/webui && pnpm --filter=client codegen

gql-mobile:
	cd services/mobile/apps/client && fvm dart run build_runner build --delete-conflicting-outputs
	cd services/mobile/apps/admin && fvm dart run build_runner build --delete-conflicting-outputs

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
	cargo run --bin generate-models && \
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
	cd services/webui && pnpm --filter=client dev

webui-admin-dev:
	cd services/webui && pnpm --filter=admin dev

# Mobile
mobile-dev:
	open -a Simulator
	cd services/mobile && fvm flutter run

# Setup
setup: check-tools run-pg
	@echo "=== PostgreSQL ==="
	@echo "  Started (via run-pg)"
	@echo "=== Backend dependencies ==="
	@cd services/backend && cargo fetch
	@echo "=== WebUI dependencies ==="
	@cd services/webui && pnpm install
	@echo "=== Contract dependencies ==="
	@cd services/contract && pnpm install
	@echo "=== Mobile dependencies ==="
	@command -v melos >/dev/null 2>&1 && (cd services/mobile && melos bootstrap) || echo "Skipped (melos not installed — optional for mobile dev)"
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
	@echo ""
	@echo "Note: DB schema is auto-initialized on first 'docker compose up --build'."
	@echo "      To reset DB: 'make down-pg && make run-pg'"
	@echo "      'make setup' is safe to run multiple times."

check-tools:
	@echo "=== Checking required tools ==="
	@command -v rustc >/dev/null 2>&1 && echo "  rustc: $$(rustc --version)" || (echo "  rustc: NOT FOUND (install from https://rustup.rs)" && exit 1)
	@command -v cargo >/dev/null 2>&1 && echo "  cargo: $$(cargo --version)" || (echo "  cargo: NOT FOUND" && exit 1)
	@command -v cargo-watch >/dev/null 2>&1 && echo "  cargo-watch: installed" || echo "  cargo-watch: NOT FOUND (optional: cargo install cargo-watch)"
	@command -v node >/dev/null 2>&1 \
		&& (echo "  node: $$(node --version)"; NODE_MAJOR=$$(node --version | sed 's/v\([0-9]*\).*/\1/'); [ "$$NODE_MAJOR" -ge 20 ] || echo "  WARNING: Node.js 20+ recommended") \
		|| (echo "  node: NOT FOUND (install Node.js 20+)" && exit 1)
	@command -v pnpm >/dev/null 2>&1 \
		&& (echo "  pnpm: $$(pnpm --version)"; PNPM_MAJOR=$$(pnpm --version | sed 's/\([0-9]*\).*/\1/'); [ "$$PNPM_MAJOR" -ge 9 ] || echo "  WARNING: pnpm 9+ recommended") \
		|| (echo "  pnpm: NOT FOUND (npm install -g pnpm)" && exit 1)
	@# flutter --version is slow (SDK integrity check), so only show path
	@command -v fvm >/dev/null 2>&1 && echo "  fvm: installed ($$(fvm --version))" || echo "  fvm: NOT FOUND (optional for mobile dev: dart pub global activate fvm)"
	@command -v fvm >/dev/null 2>&1 && echo "  flutter (via fvm): $$(fvm flutter --version 2>/dev/null | head -1)" || echo "  flutter: NOT FOUND (install fvm first)"
	@command -v melos >/dev/null 2>&1 && echo "  melos: installed" || echo "  melos: NOT FOUND (optional: fvm dart pub global activate melos)"
	@command -v docker >/dev/null 2>&1 && echo "  docker: $$(docker --version)" || (echo "  docker: NOT FOUND (install Docker Desktop)" && exit 1)
	@command -v forge >/dev/null 2>&1 && echo "  forge: $$(forge --version 2>/dev/null | head -1)" || echo "  forge: NOT FOUND (optional for contract dev: https://getfoundry.sh)"
	@echo ""
