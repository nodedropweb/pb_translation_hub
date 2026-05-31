# /security-audit — Security Audit

Audit the specified code or the current branch's changes for security vulnerabilities, focusing on the OWASP Top 10.

## What to do

1. **Check for injection** — SQL/NoSQL injection, command injection, LDAP injection. Verify all user input is parameterized or properly escaped.
2. **Check authentication & session management** — token expiry, secret storage (no hardcoded keys), session fixation, JWT validation.
3. **Check access control** — IDOR, missing authorization checks, privilege escalation paths.
4. **Check for XSS** — reflected, stored, and DOM-based. Verify output encoding and Content Security Policy.
5. **Check data exposure** — sensitive fields in logs, verbose error messages, unencrypted PII.
6. **Check dependencies** — run `npm audit` / `pip-audit` / `cargo audit` to surface known CVEs.
7. **Report findings** — for each issue: severity (Critical/High/Medium/Low), location (file:line), description, and recommended fix.

## Behavior notes

- Report findings even if they require specific conditions to exploit — severity should reflect worst-case impact.
- Do not auto-fix security issues without user confirmation; some fixes have behavior implications.
- If `$ARGUMENTS` names a file, audit that file. Otherwise audit all changed files on the current branch.
