# /changelog — Generate Changelog

Generate a CHANGELOG.md entry for the next release based on commits since the last version tag.

## What to do

1. **Find the last tag** — run `git describe --tags --abbrev=0` to get the last release.
2. **Collect commits** — run `git log <last-tag>..HEAD --pretty=format:"%s %h"` for all commits since then.
3. **Categorize changes** — group into: Added, Changed, Fixed, Removed, Security (Keep a Changelog format).
4. **Write the entry** — use the format `## [Unreleased] - YYYY-MM-DD` at the top of CHANGELOG.md.
5. **Prepend to the file** — insert above the previous entry, preserving all history.

## Behavior notes

- Skip merge commits and chore/ci commits unless they describe a user-visible change.
- Use the project's version numbering (semver implied by Conventional Commits types).
- If `$ARGUMENTS` provides a version number (e.g., `1.4.0`), use it instead of "Unreleased".
