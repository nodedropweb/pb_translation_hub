# /sql-gen — Generate SQL

Translate the described data need into a correct, readable SQL query for the project's database dialect.

## What to do

1. **Identify the schema** — find table definitions in migration files, ORM models, or schema dumps.
2. **Understand the request** — parse `$ARGUMENTS` as a plain-English description of what data is needed.
3. **Write the query** — produce valid SQL that retrieves exactly what was described, no more.
4. **Optimize** — add appropriate indexes (as comments/suggestions) if the query would do a full table scan on a large table.
5. **Add comments** — one-line comment above complex JOINs or subqueries explaining intent.

## Behavior notes

- Default to the project's dialect (PostgreSQL, MySQL, SQLite, MSSQL) — infer from dependencies or config.
- Use CTEs instead of deeply nested subqueries for readability.
- Never use `SELECT *` — enumerate the columns explicitly.
- If the schema isn't found, ask the user to provide it rather than inventing table names.

## Examples

`/sql-gen all users who placed an order in the last 30 days and have not opted out of email`
