# /code-review — Review Code

Review the specified code or current branch diff for correctness, style, performance, and maintainability. Produce a prioritized finding list.

## What to do

1. **Read the full context** — understand what the code is supposed to do before judging it.
2. **Check correctness** — logic errors, off-by-one bugs, null/undefined handling, incorrect assumptions.
3. **Check style** — naming consistency, function length, unnecessary nesting, dead code.
4. **Check performance** — O(n²) patterns, redundant queries, missing indexes, blocking calls.
5. **Check security** — injection vectors, exposed secrets, missing auth checks, insecure defaults.
6. **Prioritize findings** — label each as Critical / High / Medium / Low. Explain the impact.
7. **Suggest fixes** — for each High+ finding, provide a concrete code snippet or approach.

## Behavior notes

- Do not rewrite the entire file — focus on the most impactful changes.
- Distinguish between "must fix" and "nice to have" findings.
- If `$ARGUMENTS` names a file or PR diff, review that. Otherwise review the current selection or latest diff.
