# /dep-audit — Audit Dependencies

Scan the project's dependency tree for known vulnerabilities and critically outdated packages.

## What to do

1. **Run the audit tool** — `npm audit`, `pip-audit`, `cargo audit`, `bundle audit`, or `go list -m -json all` depending on the stack.
2. **Parse the output** — extract all High and Critical CVEs.
3. **For each finding**: package name, installed version, fixed version, CVE ID, and a one-line description of the vulnerability.
4. **Check for major version outdatedness** — flag packages more than 2 major versions behind.
5. **Recommend fixes** — provide the exact command to upgrade each package (`npm install pkg@latest`, etc.).
6. **Warn about breaking changes** — for major version bumps, check the package's CHANGELOG for breaking changes.

## Behavior notes

- Separate "fix available" from "no fix yet" vulnerabilities.
- Do not auto-upgrade without user confirmation — major version bumps can break the project.
- If `$ARGUMENTS` names a specific package, focus the audit there.
