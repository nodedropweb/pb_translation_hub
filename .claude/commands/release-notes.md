# /release-notes — Generate Release Notes

Generate polished, user-facing release notes for the next version from commits and PR titles since the last tag.

## What to do

1. **Find the base** — run `git describe --tags --abbrev=0` for the last tag.
2. **Collect changes** — `git log <tag>..HEAD --pretty=format:"%s (%h)"`.
3. **Translate to user language** — convert technical commit messages into plain benefits ("Fixed crash on logout" not "null-deref in auth handler").
4. **Group into sections**: ✨ New Features, 🐛 Bug Fixes, ⚡ Performance, 🔒 Security, 💥 Breaking Changes.
5. **Write in Markdown** — formatted for GitHub Releases or a CHANGELOG entry.
6. **If `$ARGUMENTS` provides a version number**, use it in the header.

## Behavior notes

- Omit purely internal changes (CI, deps, test fixes) unless they affect the user.
- For breaking changes, include a migration note showing what changed and how to update.
