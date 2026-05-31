# /optimize — Optimize Performance

Identify and fix performance bottlenecks in the specified code. Prioritize algorithmic improvements over micro-optimizations.

## What to do

1. **Identify the bottleneck** — look for O(n²) loops, redundant computations, unnecessary allocations, or blocking I/O.
2. **Propose the fix** — explain the approach before touching code (algorithm swap, caching, batching, parallelism, etc.).
3. **Implement** — apply the improvement, preserving all existing behavior and tests.
4. **Measure if possible** — add a quick benchmark or timing log so the improvement is visible.
5. **Document the trade-off** — note any increased complexity, memory use, or correctness constraints introduced.

## Behavior notes

- Algorithmic improvements (O(n²) → O(n log n)) are always preferred over language-level tweaks.
- Do not optimize code that isn't a bottleneck — premature optimization is a bug.
- If `$ARGUMENTS` names a file, function, or "hot path", focus there. Otherwise analyze the current selection.
- Keep readability; add a comment only if the optimization would otherwise be mystifying.
