# /commit-msg — Generate Commit Message

Generate a well-structured commit message for the current staged changes following the project's commit conventions.

## What to do

1. **Read the diff** — run `git diff --staged` to see exactly what's changing.
2. **Detect the convention** — check recent `git log --oneline` to see if the project uses Conventional Commits, gitmoji, or a custom format.
3. **Write the message** — subject line (imperative, ≤72 chars), blank line, then a body explaining *why* the change was made (not what — the diff shows that).
4. **Reference issues** — if there's a ticket number in the branch name or context, add `Closes #123` in the footer.
5. **Output the message only** — ready to paste into `git commit -m`.

## Behavior notes

- Subject line must be imperative: "Add feature" not "Added feature" or "Adding feature".
- Body explains motivation, not implementation. "Fixes crash when user logs out while request is in flight" not "Changed null check in handler".
- If `$ARGUMENTS` provides a ticket number or context, incorporate it.
