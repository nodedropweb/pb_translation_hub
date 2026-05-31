# /secrets-scan — Scan for Hardcoded Secrets

Scan the codebase for hardcoded secrets — API keys, passwords, tokens, certificates, and private keys.

## What to do

1. **Search for patterns** — look for: strings matching `sk-`, `AKIA`, `ghp_`, `eyJ` (JWT), `BEGIN PRIVATE KEY`, and variable names like `password`, `secret`, `api_key`, `token` assigned literal strings.
2. **Check config files** — inspect `.env`, `config.yml`, `appsettings.json`, and any file not in `.gitignore`.
3. **Check git history** — run `git log -p --all -S <pattern>` for secrets that may have been committed and removed.
4. **Check test fixtures** — test files often contain real credentials copied for convenience.
5. **Report findings** — file path, line number, type of secret, and recommended remediation (rotate + move to env var or secrets manager).

## Behavior notes

- Flag only likely real secrets, not placeholder strings like `YOUR_API_KEY_HERE`.
- Do not print the secret value in the report — truncate to the first 6 characters followed by `***`.
- If `$ARGUMENTS` names a path, scan only there. Otherwise scan the entire working tree.
