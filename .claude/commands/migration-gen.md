# /migration-gen — Generate Database Migration

Generate an `up` and `down` migration for the schema change described in `$ARGUMENTS`.

## What to do

1. **Detect the migration framework** — Flyway, Liquibase, Alembic, Rails, Prisma, Drizzle, or raw SQL.
2. **Name the file** — follow the project's naming convention (e.g., `V20240115__add_user_role.sql` or `20240115_add_user_role.py`).
3. **Write the `up` migration** — the schema change with all constraints.
4. **Write the `down` migration** — the exact reversal (DROP, ALTER to previous state).
5. **Check for safe migration** — flag if the change is unsafe on a live table (adding NOT NULL without default, dropping columns, renaming).
6. **Suggest a backfill** — if the migration adds a column with existing rows, include the UPDATE statement.

## Behavior notes

- Never drop columns in the same migration as the code change — deploy code first (backward-compatible), then drop.
- If the table has >1M rows, note that the migration may require `CONCURRENTLY` or online schema change tooling.
