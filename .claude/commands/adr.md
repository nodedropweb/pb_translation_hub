# /adr — Write Architecture Decision Record

Create a well-structured Architecture Decision Record (ADR) for the decision described in `$ARGUMENTS`.

## What to do

1. **Understand the decision** — parse `$ARGUMENTS` for the topic (e.g., "switch from REST to GraphQL").
2. **Write the ADR** using this structure:
   - **Title** — short imperative (e.g., "Use PostgreSQL for primary storage")
   - **Status** — Proposed / Accepted / Deprecated / Superseded
   - **Context** — the forces at play that make this decision necessary
   - **Decision** — the change we are making and why
   - **Options considered** — 2-3 alternatives with brief pros/cons
   - **Consequences** — what becomes easier, what becomes harder
3. **Save to** `docs/adr/NNN-<slug>.md` following the project's existing numbering.

## Behavior notes

- Be concise — an ADR is a decision log, not a design doc. Aim for under 400 words.
- Write in past tense for Accepted ADRs ("We chose..."), present for Proposed.
- If relevant ADRs already exist in the project, reference them.
