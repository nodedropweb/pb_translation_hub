# /docstring — Add Docstrings

Add documentation comments to the selected or specified functions, classes, or modules using the project's established format.

## What to do

1. **Detect the doc format** — check existing comments for JSDoc, Python docstrings (Google/NumPy/reStructuredText), Go doc comments, or Rustdoc.
2. **Write the doc comment** — include: one-line summary, parameter descriptions (type + purpose), return value, and any thrown exceptions.
3. **Focus on the "why"** — document intent, assumptions, and non-obvious constraints. Skip restating the function name in prose.
4. **Skip trivial functions** — simple getters/setters and self-evident one-liners do not need documentation.
5. **Preserve existing docs** — update stale comments rather than deleting them.

## Behavior notes

- Do not document every line — only document at the function/class/module boundary.
- If `$ARGUMENTS` names a file, add docs to all exported symbols. Otherwise document the current selection.
- Write in the language of the codebase — English unless the project uses another language.
