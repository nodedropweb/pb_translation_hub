# /helm-chart — Generate Helm Chart

Generate a production-ready Helm chart for deploying this service to Kubernetes.

## What to do

1. **Detect service type** — infer from the codebase: HTTP service, worker, cron job, or stateful set.
2. **Generate chart structure**:
   - `Chart.yaml` — name, description, version
   - `values.yaml` — image, replicas, resources, env vars, ingress config
   - `templates/deployment.yaml` — with liveness/readiness probes
   - `templates/service.yaml`
   - `templates/ingress.yaml` (if HTTP)
   - `templates/hpa.yaml` (horizontal pod autoscaler)
   - `templates/serviceaccount.yaml` + RBAC if needed
3. **Set resource limits** — include sensible default CPU/memory requests and limits.
4. **Add health checks** — infer the health endpoint from the codebase (e.g., `/health`, `/api/health`).

## Behavior notes

- Use `{{ .Values.* }}` for all environment-specific values — nothing hardcoded.
- If `$ARGUMENTS` specifies a namespace or image registry, use it.
- Prefer `apps/v1` Deployment over older API versions.
