# /terraform-mod — Generate Terraform Module

Generate a Terraform module for the infrastructure described in `$ARGUMENTS`.

## What to do

1. **Understand the requirement** — parse `$ARGUMENTS` (e.g., "S3 bucket with versioning and lifecycle rules").
2. **Generate module files**:
   - `main.tf` — the core resources
   - `variables.tf` — all configurable values with descriptions and defaults
   - `outputs.tf` — useful outputs (ARN, URL, ID)
   - `versions.tf` — required Terraform and provider versions pinned
3. **Follow best practices** — use data sources over hardcoded IDs, tag all resources, enable encryption at rest.
4. **Add a usage example** in a comment block at the top of `main.tf`.

## Behavior notes

- Default to AWS unless `$ARGUMENTS` specifies GCP or Azure.
- Never put credentials in Terraform files — use variable references or provider env vars.
- For stateful resources (RDS, S3), add `lifecycle { prevent_destroy = true }`.
