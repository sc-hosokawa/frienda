# Task Completion Checklist
Before marking a task as complete and notifying the user, ensure the following:
1. **Formatting**:
    - Backend: Run `cargo fmt` in `services/backend`.
    - Frontend/Web: Run `pnpm format` (if available) or ensure prettier rules are followed.
2. **Linting**:
    - Backend: Run `cargo clippy --fix`.
    - Frontend: Run `pnpm lint` in the relevant app directory.
3. **GraphQL Sync**:
    - If the API schema changed, run `make setup-gql` to update frontend and mobile types.
4. **Database Migration**:
    - If the schema changed, ensure database entities are updated via `make update-entities`.
5. **Verification**:
    - Run the dev server (`make api-dev` / `make webui-client-dev`) and verify changes locally.
6. **Documentation**:
    - Update relevant `README.md` or memory files if new patterns or commands are introduced.
    - Create a detailed `walkthrough.md` with proof of work (recordings/screenshots).