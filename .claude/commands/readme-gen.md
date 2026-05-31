# /readme-gen — Generate README

Generate or update the project README based on what the code actually does — not a generic template.

## What to do

1. **Scan the project** — read package.json/pyproject.toml, entry points, and existing docs to understand the project.
2. **Write the README** — include: project name + one-line description, prerequisites, installation, quick-start example, configuration, and API overview (if a library).
3. **Generate real examples** — pull actual function signatures, CLI flags, and config keys from the code.
4. **Add badges** if CI, coverage, or npm/PyPI configs are present.
5. **Output to README.md** at the repo root (or update it in-place if it exists).

## Behavior notes

- Write for the first-time user: they have cloned the repo and need to run it in under 5 minutes.
- Do not invent features that don't exist in the code.
- Keep it concise — long READMEs are not read.
