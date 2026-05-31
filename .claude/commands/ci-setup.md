# /ci-setup — Generate CI Workflow

Generate a GitHub Actions workflow (or other CI config) that runs lint, test, and build with proper caching.

## What to do

1. **Detect the stack** — read package.json, pyproject.toml, or go.mod to identify language, test command, and lint command.
2. **Write the workflow** — create `.github/workflows/ci.yml` with jobs for: lint, test, and build.
3. **Add caching** — cache node_modules, pip, or Go module cache keyed on the lock file hash.
4. **Add concurrency guard** — cancel in-progress runs on the same branch to avoid wasted compute.
5. **Run on correct triggers** — `push` to main, `pull_request` to main, and optionally `workflow_dispatch`.
6. **Add status badge** — output the Markdown badge snippet for the README.

## Behavior notes

- Prefer `ubuntu-latest` as the runner unless the project requires macOS or Windows.
- Use pinned action versions (e.g., `actions/checkout@v4`) for security.
- If `$ARGUMENTS` names a CI provider (gitlab, circle, bitbucket), generate that format instead of GitHub Actions.
