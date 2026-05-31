# /schema-doc — Document Database Schema

Generate a readable Markdown reference document from the project's database schema.

## What to do

1. **Locate schema sources** — find migration files (Alembic, Flyway, Rails migrations), ORM models (SQLAlchemy, Prisma, ActiveRecord, Drizzle), or raw SQL DDL.
2. **Extract tables** — for each table: name, columns (name + type + constraints), primary key, and foreign keys.
3. **Generate the doc** — produce a `docs/schema.md` with: one table per section, a column reference table, and relationship descriptions (has-many, belongs-to, many-to-many).
4. **Add a Mermaid ERD** — include a ```mermaid erDiagram``` block showing the entity relationships.
5. **Note indexes** — list non-obvious indexes and explain why they exist.

## Behavior notes

- Focus on tables with business logic — skip purely technical tables (migrations, sessions) unless asked.
- If `$ARGUMENTS` names a specific table or module, document only that scope.
