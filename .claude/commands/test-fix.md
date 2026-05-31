# /test-fix — Fix Failing Tests

Diagnose why the tests are failing and apply the correct fix — either to the implementation or to the test itself.

## What to do

1. **Run the failing tests** — use the project's test command to get the current failure output.
2. **Classify the failure** — is this a broken implementation, an outdated test expectation, a missing mock, or an environment issue?
3. **Fix the right side** — fix the implementation if the behavior is wrong; fix the test only if the expectation was incorrect.
4. **Never delete failing tests** — comment with a TODO and open a follow-up if a test must be skipped temporarily.
5. **Run tests again** — confirm all previously failing tests now pass and no new failures were introduced.

## Behavior notes

- Changing a test to make it pass is only valid if the original expectation was wrong.
- Flaky tests (intermittent failures) need a root cause analysis, not a retry loop.
- If `$ARGUMENTS` names a specific test file or test name, focus there. Otherwise fix all currently failing tests.
