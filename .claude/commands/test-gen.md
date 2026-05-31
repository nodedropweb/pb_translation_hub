# /test-gen — Generate Tests

Generate comprehensive tests for the selected or specified code using the project's existing test framework and conventions.

## What to do

1. **Detect the test framework** — check package.json, existing test files, or config (Jest, Vitest, pytest, Go test, etc.).
2. **Identify test cases** — cover: happy path, boundary values, invalid inputs, empty/null cases, and error handling.
3. **Write the tests** — use the project's existing test style, file naming, and assertion patterns.
4. **Place the file** — follow the project's convention (co-located `*.test.ts`, `__tests__/` folder, or `*_test.go`).
5. **Note coverage gaps** — flag any scenarios that are hard to test without mocks or integration setup.

## Behavior notes

- Generate real, runnable tests — not pseudocode or placeholder TODOs.
- Prefer testing behavior over implementation details; avoid mocking internals unless necessary.
- If the code has no existing tests, establish a pattern others can follow.
- If `$ARGUMENTS` names a file or function, target that. Otherwise test the current selection.

## Quick recipes

| Goal | Command |
|------|---------|
| Generate tests for a file | `/test-gen src/utils/parser.ts` |
| Generate only edge-case tests | `/test-gen --edge-cases` |
