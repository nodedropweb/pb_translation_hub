# /api-docs — Document API Endpoints

Generate API documentation for the project's HTTP endpoints, RPC methods, or SDK exports.

## What to do

1. **Find the routes** — locate route definitions (Express, FastAPI, Django, gRPC proto files, etc.).
2. **Extract the contract** — for each endpoint: method, path, path params, query params, request body schema, response schema, and error codes.
3. **Generate docs** — produce either an OpenAPI 3.0 YAML spec or clean Markdown tables, depending on what the project already uses.
4. **Include examples** — add at least one request/response example per endpoint.
5. **Place the output** — write to `docs/api.md` or `openapi.yaml` at the repo root.

## Behavior notes

- Infer schemas from TypeScript types, Pydantic models, or Zod schemas where possible.
- If authentication is required, document the auth scheme (Bearer, API key, OAuth).
- If `$ARGUMENTS` names a router file or prefix, document only that subset.
