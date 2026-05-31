# /seed-gen — Generate Seed / Fixture Data

Generate realistic seed data for the specified table or model, suitable for development and automated testing.

## What to do

1. **Find the schema** — locate the table definition, ORM model, or Zod/Pydantic schema.
2. **Generate realistic data** — use domain-appropriate values (real-looking names, valid emails, proper enums).
3. **Respect constraints** — foreign keys reference seeded parent records; unique fields do not repeat.
4. **Output format** — match the project's seeding pattern:
   - SQL: `INSERT INTO...` statements
   - JS/TS: factory function or array literal compatible with the ORM
   - Python: fixtures dict or factory_boy factories
5. **Volume** — generate enough rows to exercise pagination and edge cases (typically 20-50 per entity).

## Behavior notes

- Never use production data as a base — generate synthetic data only.
- If `$ARGUMENTS` names a model or table, seed that entity and its required dependencies.
- For date fields, distribute values across a realistic range rather than all using today.
