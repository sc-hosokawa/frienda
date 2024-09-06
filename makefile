.PHONY: setup-gql gql-webui gql-mobile api-dev api webui-client-dev webui-admin-dev mobile-dev

# GraphQL Schema
setup-gql: copy-schema .WAIT gql-webui gql-mobile

copy-schema:
	cp services/backend/schema.graphql services/webui/
	cp services/backend/schema.graphql services/mobile/

gql-webui:
	cd services/webui && pnpm gql-codegen

gql-mobile:
	cd services/mobile && flutter pub run build_runner build --delete-conflicting-outputs 

# Backend
api-dev:
	docker compose up
	cd services/backend/server-core && cargo watch -x run

api:
	docker compose up -d
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

# Contract
