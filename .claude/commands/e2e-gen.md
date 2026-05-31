# /e2e-gen — Generate E2E Tests

Generate end-to-end tests for the specified user flow using the project's E2E framework.

## What to do

1. **Detect the framework** — check for Playwright (`playwright.config.*`) or Cypress (`cypress.config.*`).
2. **Identify the flow** — parse `$ARGUMENTS` as a user journey (e.g., "sign up → verify email → dashboard").
3. **Write the test** — cover: happy path, invalid inputs, loading states, and error states.
4. **Use page objects** — if the project has a page-object pattern, follow it; otherwise create one.
5. **Add assertions** — assert URL, visible text, element state, and network requests where relevant.
6. **Place the file** — follow the project's E2E directory convention (`e2e/`, `cypress/e2e/`, `tests/`).

## Behavior notes

- Use `data-testid` selectors over CSS classes or XPath — they survive UI refactors.
- Do not hard-code sleep() — use framework waitFor/expect polling instead.
- If `$ARGUMENTS` names a page or route, generate tests for that page's critical flows.
