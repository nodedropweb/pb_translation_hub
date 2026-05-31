# /debug — Debug Issue

Systematically diagnose the described bug or error: reproduce it, isolate the root cause, and apply the minimal fix.

## What to do

1. **Understand the symptom** — restate what the user described (actual vs. expected behavior, error message, stack trace).
2. **Reproduce** — identify the smallest input or code path that triggers the bug.
3. **Isolate** — trace execution to the first point where state diverges from expectation.
4. **Explain the root cause** — one clear sentence: what assumption was wrong, what invariant was violated.
5. **Apply the fix** — make the minimal change that addresses the root cause without introducing new assumptions.
6. **Verify** — run tests or suggest a quick manual check to confirm the fix works.

## Behavior notes

- Fix the root cause, not the symptom. Masking errors with try/catch or null guards is not a fix.
- If the bug is in a dependency or external system, say so and suggest a workaround, not a vendored patch.
- If `$ARGUMENTS` contains an error message or stack trace, use that as the starting point.
- Ask clarifying questions only if you genuinely cannot proceed — show your reasoning first.
