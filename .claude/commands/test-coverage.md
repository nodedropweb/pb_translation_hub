# /test-coverage — Improve Test Coverage

Analyze the specified file or module for untested paths and generate tests to cover them.

## What to do

1. **Run coverage** — execute `npx jest --coverage`, `pytest --cov`, or `go test -cover` to get the baseline.
2. **Identify gaps** — find uncovered lines, branches (if/else), and error paths.
3. **Prioritize** — focus on business-critical paths and error handling over trivial getters.
4. **Write targeted tests** — one test per uncovered branch, named to describe the scenario.
5. **Re-run coverage** — confirm the new tests raise coverage on the target file.

## Behavior notes

- 100% coverage is not the goal — meaningful coverage is. Skip generated code, migrations, and trivial wrappers.
- If `$ARGUMENTS` names a file, target that file's coverage. Otherwise analyze the whole project.
