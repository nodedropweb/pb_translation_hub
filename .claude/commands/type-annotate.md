# /type-annotate — Add Type Annotations

Add accurate type annotations to the specified code using the project's type system (TypeScript, Python mypy/pyright).

## What to do

1. **Detect the type system** — TypeScript, Python with mypy/pyright, or Go (already typed — note this).
2. **Infer types from usage** — trace how values flow through the code to determine correct types.
3. **Annotate function signatures first** — parameter types and return types before internal variables.
4. **Use precise types** — prefer `string[]` over `any[]`, `Record<string, User>` over `object`.
5. **Introduce type aliases** — if a shape appears more than once, define an `interface` or `type`.
6. **Avoid `any`** — if a type is truly unknown, use `unknown` and add a narrowing guard.

## Behavior notes

- Do not change runtime behavior — types are annotations only.
- If a genuine type mismatch is found, flag it rather than silently casting.
- If `$ARGUMENTS` names a file, annotate all exported functions. Otherwise annotate the current selection.
