# /conflict-resolve — Resolve Merge Conflicts

Find and resolve all merge conflict markers in the working tree, preserving the correct intent from both sides.

## What to do

1. **List conflicts** — run `git diff --name-only --diff-filter=U` to find all conflicted files.
2. **For each conflict**:
   - Read both `<<<<<<< HEAD` and `>>>>>>> branch` sides in full context.
   - Understand what each side was trying to achieve.
   - Produce a merged result that satisfies both intents — not just picking one side.
3. **Explain each resolution** — one line per file: what you kept and why.
4. **Stage resolved files** — run `git add` on each resolved file.
5. **Run tests** — confirm the resolution didn't break anything.

## Behavior notes

- Never silently discard one side without analysis. If the intent is unclear, ask.
- Flag conflicts where both sides modified the same logic differently — these need human judgment.
- If `$ARGUMENTS` names a specific file, resolve only that file's conflicts.
