# /pr-desc — Generate PR Description

Generate a complete pull request title, summary, and test plan from the current branch's changes.

## What to do

1. **Gather changes** — run `git log main..HEAD --oneline` and `git diff main...HEAD` to understand what's on this branch.
2. **Write the PR title** — short (≤70 chars), imperative, descriptive.
3. **Write the summary** — 2-4 bullets covering: what changed, why, and any architectural decisions made.
4. **Write the test plan** — checklist of manual or automated steps a reviewer can run to verify correctness.
5. **Note breaking changes** — flag any API changes, schema migrations, or env var additions in a "Breaking Changes" section.

## Behavior notes

- Focus on *why* the change was made, not a line-by-line rehash of the diff.
- If the branch has a ticket/issue prefix (e.g., `feat/PROJ-123-...`), link it.
- Output formatted Markdown suitable for GitHub/GitLab PR body.
