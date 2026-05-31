# /dockerfile — Generate Dockerfile

Generate a production-ready Dockerfile for this project, using multi-stage builds to minimize final image size.

## What to do

1. **Detect the runtime** — identify language, runtime version, and package manager from lock files (package-lock.json, poetry.lock, go.sum, Cargo.lock).
2. **Write multi-stage build** — build stage installs deps and compiles; runtime stage copies only the artifacts needed to run.
3. **Pin base image versions** — use specific digest or tag (e.g., `node:20-alpine`, not `node:latest`).
4. **Optimize layer caching** — copy dependency manifests first, install deps, then copy source. This way a source change doesn't invalidate the dep cache.
5. **Run as non-root** — add a `USER` instruction with a non-privileged user in the runtime stage.
6. **Add health check** — include a `HEALTHCHECK` if the service exposes HTTP.
7. **Add .dockerignore** — generate `.dockerignore` alongside the Dockerfile to exclude node_modules, .git, etc.

## Behavior notes

- Prefer `alpine` or `distroless` base images for smaller attack surface.
- Use `COPY --chown` to avoid permission issues.
- If `$ARGUMENTS` specifies a port or entry command, use it. Otherwise infer from package.json scripts or main entry point.
