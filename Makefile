SHELL := /bin/bash
.SHELLFLAGS := -ec

# Load .env if present (shared with Docker Compose; values can be overridden by environment variables)
# NOTE: -include imports ALL lines as Make variables. Only add PG_* and COMPOSE_* variables to .env.
-include .env

OPEN_CMD := $(shell command -v open 2>/dev/null || command -v xdg-open 2>/dev/null || echo echo)
DEV_LOG_DIR := .dev-logs

# --- Dev server port defaults ---
CLIENT_PORT := 3000
ADMIN_PORT  := 3001
API_PORT    := 8080

# --- PostgreSQL connection defaults (override via .env or environment) ---
PG_HOST     ?= 127.0.0.1
PG_PORT     ?= 5432
PG_USER     ?= postgres
PG_PASSWORD ?= postgres
PG_DB       ?= postgres

.PHONY: all
all: help ;

.PHONY: help
help:
	@echo '=== Docker Operations ==='
	@echo
	@echo 'up'
	@echo '  - Start PostgreSQL + all local dev services'
	@echo
	@echo 'down'
	@echo '  - Stop and remove all containers (services + PostgreSQL)'
	@echo
	@echo 'run-pg'
	@echo '  - Start PostgreSQL only'
	@echo
	@echo 'stop-pg'
	@echo '  - Stop PostgreSQL'
	@echo
	@echo 'down-pg'
	@echo '  - Remove PostgreSQL containers'
	@echo
	@echo 'down-pg-clean'
	@echo '  - Remove PostgreSQL containers + volumes'
	@echo
	@echo 'restart-pg'
	@echo '  - make down-pg && make run-pg'
	@echo
	@echo 'ps'
	@echo '  - docker compose ps -a'
	@echo
	@echo 'logs'
	@echo '  - docker compose logs'
	@echo
	@echo 'logs-watch'
	@echo '  - docker compose logs --follow'
	@echo
	@echo '=== Local Development Services ==='
	@echo
	@echo 'dev-services'
	@echo '  - Start all local dev service emulators/mocks (profile: services)'
	@echo
	@echo 'dev-firebase'
	@echo '  - Start Firebase Emulator only'
	@echo
	@echo 'dev-blockchain'
	@echo '  - Start Anvil (local blockchain) only'
	@echo
	@echo 'dev-mail'
	@echo '  - Start Mailpit (SMTP catcher) only'
	@echo
	@echo 'dev-stripe'
	@echo '  - Start stripe-mock only'
	@echo
	@echo 'dev-contentful'
	@echo '  - Start Contentful mock server only'
	@echo
	@echo 'dev-gemini'
	@echo '  - Start Gemini mock server only'
	@echo
	@echo 'dev-sendgrid'
	@echo '  - Start SendGrid mock server only'
	@echo
	@echo 'dev-adminer'
	@echo '  - Start Adminer (DB管理GUI) only'
	@echo
	@echo 'stop-services'
	@echo '  - Stop all local dev services'
	@echo
	@echo 'down-services'
	@echo '  - Remove all local dev service containers'
	@echo
	@echo '=== Database - PostgreSQL ==='
	@echo
	@echo 'sql'
	@echo '  - Connect to PostgreSQL via psql'
	@echo
	@echo 'pgdump-schema'
	@echo '  - Dump database schema only (DDL)  (e.g. make pgdump-schema > schema.sql)'
	@echo
	@echo 'pgdump-full'
	@echo '  - Full dump (schema + data)  (e.g. make pgdump-full > dump.sql)'
	@echo
	@echo '=== Backend (Rust) ==='
	@echo
	@echo 'api-dev'
	@echo '  - Start backend with hot reload (cargo watch)'
	@echo
	@echo 'api'
	@echo '  - Start backend without hot reload'
	@echo
	@echo 'update-entities'
	@echo '  - Generate Sea-ORM entities from DB schema'
	@echo
	@echo 'update-models'
	@echo '  - Generate models and format Rust code'
	@echo
	@echo '=== WebUI (Next.js) ==='
	@echo
	@echo 'webui-client-dev'
	@echo '  - Start WebUI client dev server'
	@echo
	@echo 'webui-admin-dev'
	@echo '  - Start WebUI admin dev server'
	@echo
	@echo 'webui-build'
	@echo '  - pnpm build'
	@echo
	@echo 'webui-lint'
	@echo '  - pnpm lint'
	@echo
	@echo 'webui-format'
	@echo '  - pnpm format'
	@echo
	@echo '=== Background Dev Servers ==='
	@echo
	@echo 'dev-bg'
	@echo '  - Start webui-client, webui-admin, api in background (logs in .dev-logs/)'
	@echo
	@echo 'dev-stop'
	@echo '  - Stop all background dev servers'
	@echo
	@echo 'dev-status'
	@echo '  - Show running status of dev servers'
	@echo
	@echo 'dev-logs'
	@echo '  - Show recent logs from background dev servers (TAIL_LINES=N to customize)'
	@echo
	@echo '=== Mobile (Flutter) ==='
	@echo
	@echo 'mobile-dev'
	@echo '  - Start iOS simulator and run Flutter app'
	@echo
	@echo 'mobile-test'
	@echo '  - fvm dart run melos run test'
	@echo
	@echo 'mobile-analyze'
	@echo '  - fvm dart run melos run analyze'
	@echo
	@echo 'mobile-format'
	@echo '  - fvm dart run melos run format'
	@echo
	@echo '=== Smart Contracts (Solidity) ==='
	@echo
	@echo 'contract-build'
	@echo '  - pnpm build (Foundry)'
	@echo
	@echo 'contract-test'
	@echo '  - pnpm foundrytest'
	@echo
	@echo 'contract-lint'
	@echo '  - pnpm lint:sol'
	@echo
	@echo 'contract-format'
	@echo '  - pnpm format'
	@echo
	@echo '=== GraphQL ==='
	@echo
	@echo 'setup-gql'
	@echo '  - Copy schema and regenerate GraphQL code for all services'
	@echo
	@echo 'gql-webui'
	@echo '  - Regenerate GraphQL code for WebUI'
	@echo
	@echo 'gql-mobile'
	@echo '  - Regenerate GraphQL code for mobile apps'
	@echo
	@echo '=== Browser ==='
	@echo
	@echo 'open-client'
	@echo '  - http://localhost:3000 (WebUI Client)'
	@echo
	@echo 'open-admin'
	@echo '  - http://localhost:3001 (WebUI Admin)'
	@echo
	@echo 'open-api'
	@echo '  - http://localhost:8080/graphql (GraphQL API)'
	@echo
	@echo 'open-mail'
	@echo '  - http://127.0.0.1:8025 (Mailpit UI)'
	@echo
	@echo 'open-firebase'
	@echo '  - http://127.0.0.1:4000 (Firebase Emulator UI)'
	@echo
	@echo 'open-adminer'
	@echo '  - http://127.0.0.1:8081 (Adminer - DB管理GUI)'
	@echo
	@echo '=== Setup ==='
	@echo
	@echo 'setup'
	@echo '  - Install dependencies, start DB, create .env files'
	@echo
	@echo 'check-tools'
	@echo '  - Verify required tools and versions'
	@echo

# --- Docker / PostgreSQL ---

.PHONY: run-pg
run-pg:
	docker compose up -d --build

.PHONY: up
up: run-pg dev-services ;

.PHONY: stop-pg
stop-pg:
	docker compose stop

.PHONY: down-pg
down-pg:
	docker compose down

.PHONY: down
down: down-services down-pg ;

.PHONY: down-pg-clean
down-pg-clean:
	docker compose down --volumes --remove-orphans

.PHONY: restart-pg
restart-pg: down-pg run-pg ;

.PHONY: ps
ps:
	docker compose ps -a

.PHONY: logs
logs:
	docker compose logs

.PHONY: logs-watch
logs-watch:
	docker compose logs --follow

# --- Local Development Services ---

.PHONY: dev-services
dev-services:
	docker compose --profile services up -d --build

.PHONY: dev-firebase
dev-firebase:
	docker compose --profile firebase up -d --build

.PHONY: dev-blockchain
dev-blockchain:
	docker compose --profile blockchain up -d

.PHONY: dev-mail
dev-mail:
	docker compose --profile mail up -d

.PHONY: dev-stripe
dev-stripe:
	docker compose --profile stripe up -d

.PHONY: dev-contentful
dev-contentful:
	docker compose --profile contentful up -d --build

.PHONY: dev-gemini
dev-gemini:
	docker compose --profile gemini up -d --build

.PHONY: dev-sendgrid
dev-sendgrid:
	docker compose --profile sendgrid up -d --build

.PHONY: dev-adminer
dev-adminer:
	docker compose --profile adminer up -d

.PHONY: stop-services
stop-services:
	docker compose --profile services --profile firebase --profile blockchain --profile mail --profile stripe --profile sendgrid --profile contentful --profile gemini --profile adminer stop

.PHONY: down-services
down-services:
	docker compose --profile services --profile firebase --profile blockchain --profile mail --profile stripe --profile sendgrid --profile contentful --profile gemini --profile adminer down


# --- Database - PostgreSQL ---

.PHONY: sql
sql:
	PGPASSWORD=$(PG_PASSWORD) psql -h $(PG_HOST) -p $(PG_PORT) -U $(PG_USER) -d $(PG_DB)

.PHONY: pgdump-schema
pgdump-schema:
	PGPASSWORD=$(PG_PASSWORD) pg_dump -h $(PG_HOST) -p $(PG_PORT) -U $(PG_USER) -d $(PG_DB) --schema-only --no-owner --no-privileges

.PHONY: pgdump-full
pgdump-full:
	PGPASSWORD=$(PG_PASSWORD) pg_dump -h $(PG_HOST) -p $(PG_PORT) -U $(PG_USER) -d $(PG_DB) --no-owner --no-privileges

# --- Backend (Rust) ---

.PHONY: api-dev
api-dev:
	docker compose up -d --build && \
	cd services/backend/server-core && cargo watch -x run

.PHONY: api
api:
	docker compose up -d --build && \
	cd services/backend/server-core && cargo run

.PHONY: update-entities
update-entities:
	cd services/backend/server-core && \
	sea-orm-cli generate entity -u postgres://$(PG_USER):$(PG_PASSWORD)@$(PG_HOST):$(PG_PORT)/$(PG_DB) -o domain/src/entities

.PHONY: update-models
update-models:
	cd services/backend/server-core && cargo run --bin generate-models
	cd services/backend && cargo fmt

# --- WebUI (Next.js) ---

.PHONY: webui-client-dev
webui-client-dev:
	cd services/webui && pnpm --filter=client dev

.PHONY: webui-admin-dev
webui-admin-dev:
	cd services/webui && pnpm --filter=admin dev

.PHONY: webui-build
webui-build:
	cd services/webui && pnpm build

.PHONY: webui-lint
webui-lint:
	cd services/webui && pnpm lint

.PHONY: webui-format
webui-format:
	cd services/webui && pnpm format

# --- Background Dev Servers ---

.PHONY: dev-bg
dev-bg:
	@# Guard: stop existing servers if already running
	@has_running=false; \
	for port in $(CLIENT_PORT) $(ADMIN_PORT) $(API_PORT); do \
		if lsof -ti :$$port -sTCP:LISTEN >/dev/null 2>&1; then \
			has_running=true; break; \
		fi; \
	done; \
	if [ "$$has_running" = "true" ]; then \
		echo "Dev servers already running. Stopping first..."; \
		$(MAKE) --no-print-directory dev-stop; \
	fi
	@echo "Starting all development servers in background..."
	@mkdir -p $(DEV_LOG_DIR)
	@if [ -n "$(APPEND)" ]; then redir=">>"; else redir=">"; fi; \
	eval "nohup sh -c 'cd services/webui && exec pnpm --filter=client dev' $$redir $(DEV_LOG_DIR)/webui-client.log 2>&1 < /dev/null" & \
	eval "nohup sh -c 'cd services/webui && exec pnpm --filter=admin dev' $$redir $(DEV_LOG_DIR)/webui-admin.log 2>&1 < /dev/null" & \
	eval "nohup sh -c 'docker compose up -d --build && cd services/backend/server-core && exec cargo watch -x run' $$redir $(DEV_LOG_DIR)/api.log 2>&1 < /dev/null" &
	@echo ""
	@echo "All servers started in background."
	@echo "  Client: http://localhost:$(CLIENT_PORT)"
	@echo "  Admin:  http://localhost:$(ADMIN_PORT)"
	@echo "  API:    http://localhost:$(API_PORT)/graphql"
	@echo ""
	@echo "  Logs:   $(DEV_LOG_DIR)/*.log (overwritten on each start, use APPEND=1 to append)"
	@echo "  Status: make dev-status"
	@echo "  Logs:   make dev-logs [TAIL_LINES=N]"
	@echo "  Stop:   make dev-stop"
	@echo ""
	@sleep 3
	@echo "(Servers may still be starting up)"
	@$(MAKE) --no-print-directory dev-status

.PHONY: dev-stop
dev-stop:
	@echo "Stopping dev server processes..."
	@all_pids=""; all_pgids=""; \
	for entry in "$(CLIENT_PORT):WebUI Client" "$(ADMIN_PORT):WebUI Admin" "$(API_PORT):API Server"; do \
		port=$${entry%%:*}; name=$${entry#*:}; \
		pids=$$(lsof -ti :$$port -sTCP:LISTEN 2>/dev/null); \
		if [ -n "$$pids" ]; then \
			printf "  Stopping %s (%s) PID: %s\n" "$$name" "$$port" "$$(echo $$pids | tr '\n' ' ')"; \
			for p in $$pids; do \
				all_pids="$$all_pids $$p"; \
				pgid=$$(ps -o pgid= -p $$p 2>/dev/null | tr -d ' '); \
				if [ -n "$$pgid" ] && [ "$$pgid" != "0" ]; then \
					all_pgids="$$all_pgids $$pgid"; \
				fi; \
			done; \
		fi; \
	done; \
	if [ -n "$$all_pids" ]; then \
		killed_pgids=""; \
		for pgid in $$all_pgids; do \
			case " $$killed_pgids " in \
				*" $$pgid "*) ;; \
				*) kill -- -$$pgid 2>/dev/null || true; killed_pgids="$$killed_pgids $$pgid" ;; \
			esac; \
		done; \
		sleep 1; \
		for p in $$all_pids; do \
			kill -9 $$p 2>/dev/null || true; \
		done; \
	else \
		echo "  No dev servers running."; \
	fi
	@echo "Done."

.PHONY: dev-status
dev-status:
	@echo "=== Dev Server Status ==="
	@running=0; \
	for entry in "$(CLIENT_PORT):WebUI Client " "$(ADMIN_PORT):WebUI Admin  " "$(API_PORT):API Server    "; do \
		port=$${entry%%:*}; name=$${entry#*:}; \
		pid=$$(lsof -ti :$$port -sTCP:LISTEN 2>/dev/null | head -1); \
		if [ -n "$$pid" ]; then \
			printf "  %s (%s): \033[32m✓ Running\033[0m (PID: %s)\n" "$$name" "$$port" "$$pid"; \
			running=$$((running + 1)); \
		else \
			printf "  %s (%s): \033[31m✗ Not running\033[0m\n" "$$name" "$$port"; \
		fi; \
	done; \
	echo "========================="; \
	if [ $$running -eq 0 ]; then \
		echo "No dev servers running."; \
	else \
		echo "$$running server(s) running."; \
	fi

.PHONY: dev-logs
dev-logs:
	@if [ ! -d "$(DEV_LOG_DIR)" ]; then \
		echo "No log directory found. Run 'make dev-bg' first."; \
		exit 0; \
	fi
	@for entry in "webui-client:WebUI Client" "webui-admin:WebUI Admin" "api:API Server"; do \
		name=$${entry%%:*}; label=$${entry#*:}; \
		logfile="$(DEV_LOG_DIR)/$$name.log"; \
		if [ -f "$$logfile" ] && [ -s "$$logfile" ]; then \
			printf "\n\033[1;36m=== %s (%s) ===\033[0m\n" "$$label" "$$logfile"; \
			tail -$(or $(TAIL_LINES),20) "$$logfile"; \
		elif [ -f "$$logfile" ]; then \
			printf "\n\033[1;33m=== %s (empty log) ===\033[0m\n" "$$label"; \
		fi; \
	done

# --- Mobile (Flutter) ---

.PHONY: mobile-dev
mobile-dev:
	open -a Simulator
	cd services/mobile && fvm flutter run

.PHONY: mobile-test
mobile-test:
	cd services/mobile && fvm dart run melos run test

.PHONY: mobile-analyze
mobile-analyze:
	cd services/mobile && fvm dart run melos run analyze

.PHONY: mobile-format
mobile-format:
	cd services/mobile && fvm dart run melos run format

# --- Smart Contracts (Solidity) ---

.PHONY: contract-build
contract-build:
	cd services/contract && pnpm build

.PHONY: contract-test
contract-test:
	cd services/contract && pnpm foundrytest

.PHONY: contract-lint
contract-lint:
	cd services/contract && pnpm lint:sol

.PHONY: contract-format
contract-format:
	cd services/contract && pnpm format

# --- GraphQL ---

.PHONY: setup-gql
setup-gql: copy-schema
	$(MAKE) gql-webui gql-mobile

# Internal target used by setup-gql
.PHONY: copy-schema
copy-schema:
	cp services/backend/server-core/presentation/src/graphql/schema.graphql services/webui/
	cp services/backend/server-core/presentation/src/graphql/schema.graphql services/mobile/
	cp services/backend/server-core/presentation/src/graphql/schema.graphql services/mobile/apps/admin/lib/graphql/
	cp services/backend/server-core/presentation/src/graphql/schema.graphql services/mobile/apps/client/lib/data/graphql/

.PHONY: gql-webui
gql-webui:
	cd services/webui && pnpm --filter=client codegen

.PHONY: gql-mobile
gql-mobile:
	cd services/mobile/apps/client && fvm dart run build_runner build --delete-conflicting-outputs
	cd services/mobile/apps/admin && fvm dart run build_runner build --delete-conflicting-outputs

# --- Browser ---

.PHONY: open-client
open-client:
	$(OPEN_CMD) http://localhost:$(CLIENT_PORT)

.PHONY: open-admin
open-admin:
	$(OPEN_CMD) http://localhost:$(ADMIN_PORT)

.PHONY: open-api
open-api:
	$(OPEN_CMD) http://localhost:$(API_PORT)/graphql

.PHONY: open-mail
open-mail:
	$(OPEN_CMD) http://127.0.0.1:8025

.PHONY: open-firebase
open-firebase:
	$(OPEN_CMD) http://127.0.0.1:4000

.PHONY: open-adminer
open-adminer:
	$(OPEN_CMD) "http://127.0.0.1:8081/?pgsql=postgres&username=$(PG_USER)&db=$(PG_DB)"

# --- Setup ---

.PHONY: setup
setup: check-tools
	@echo "=== Environment files ==="
	@test -f .env || (cp .env.example .env && echo "Created .env")
	@test -f services/backend/.env || (cp services/backend/.env.example services/backend/.env && echo "Created services/backend/.env")
	@test -f services/webui/apps/client/.env.local || (cp services/webui/apps/client/.env.example services/webui/apps/client/.env.local && echo "Created services/webui/apps/client/.env.local")
	@test -f services/webui/apps/admin/.env.local || (cp services/webui/apps/admin/.env.example services/webui/apps/admin/.env.local && echo "Created services/webui/apps/admin/.env.local")
	@test -f services/contract/.env || (test -f services/contract/.env.example && cp services/contract/.env.example services/contract/.env && echo "Created services/contract/.env" || echo "Skipped services/contract/.env (no .env.example found)")
	@echo "=== PostgreSQL ==="
	@$(MAKE) run-pg
	@echo "  Started (via run-pg)"
	@echo "=== Backend dependencies ==="
	@cd services/backend && cargo fetch
	@echo "=== WebUI dependencies ==="
	@cd services/webui && pnpm install
	@echo "=== Contract dependencies ==="
	@cd services/contract && pnpm install
	@echo "=== Mobile dependencies ==="
	@command -v fvm >/dev/null 2>&1 && (cd services/mobile && echo "y" | fvm use && fvm dart run melos bootstrap) || echo "Skipped (fvm not installed — optional for mobile dev)"
	@echo ""
	@echo "Setup complete! Next steps:"
	@echo "  1. Edit .env files with your credentials"
	@echo "  2. Run 'make api-dev' to start the backend"
	@echo "  3. Run 'make webui-client-dev' to start the client"
	@echo ""
	@echo "Note: DB schema is auto-initialized on first 'docker compose up --build'."
	@echo "      To reset DB: 'make down-pg && make run-pg'"
	@echo "      'make setup' is safe to run multiple times."

.PHONY: check-tools
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
	@command -v fvm >/dev/null 2>&1 && (cd services/mobile && fvm dart run melos --version >/dev/null 2>&1 && echo "  melos: installed (via fvm)" || echo "  melos: NOT FOUND (run 'fvm dart pub get' in services/mobile)") || echo "  melos: skipped (fvm not installed)"
	@command -v docker >/dev/null 2>&1 && echo "  docker: $$(docker --version)" || (echo "  docker: NOT FOUND (install Docker Desktop)" && exit 1)
	@command -v forge >/dev/null 2>&1 && echo "  forge: $$(forge --version 2>/dev/null | head -1)" || echo "  forge: NOT FOUND (optional for contract dev: https://getfoundry.sh)"
	@echo ""
