# Postgres

## Documentation
- [dbdocs](https://dbdocs.io/naoki9akazawa/FRIENDA)

## ER Diagram
[ER Diagram](https://dbdocs.io/naoki9akazawa/FRIENDA?view=relationships)

## Local Seed Data

`docker compose up -d --build` initializes Postgres from `services/postgres/seeds` in this order:

1. `00_apply_full_schema.sh`
2. `02_mobile_graphql_artist_access.sql`
3. `03_dummy_mobile_graphql_artist_access.sql`

The staging schema dump is kept at `seeds/01_full_schema.sql` and is applied by `00_apply_full_schema.sh`.

Useful local IDs for mobile GraphQL artist access testing:

| Purpose | ID |
| --- | --- |
| Superadmin operator | `usr_superadmin_0001` |
| Artist representative | `usr_artist_admin_01` |
| Accepted member | `usr_artist_member_01` |
| Pending request user | `usr_pending_000001` |
| Rejected request user | `usr_rejected_00001` |
| Canceled request user | `usr_canceled_00001` |
| Fallback default user | `usr_fallback_00001` |
| User without mappings | `usr_outsider_00001` |
| Artist Alpha | `artist_alpha_0001` |
| Artist Beta | `artist_beta_0001` |
| Artist Gamma | `artist_gamma_0001` |
