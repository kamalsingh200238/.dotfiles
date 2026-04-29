# Development Workflow

Work in small, reviewable slices. Never ship a full feature in one pass.

## How to work

- Start with a plan that breaks the work into phases and sub-phases.
- Keep each phase as a small, independently reviewable feature slice.
- Keep each sub-phase as the smallest commit-sized unit.
- Build only what the current sub-phase needs.
- Treat each phase like a careful developer checkpoint, not a generated dump.

## How to split work

Split by feature, then split each feature into concrete implementation steps.

Example for a REST API:

- **Phase 1** — one endpoint or one coherent slice
  - **1.1** — DB migration + route map + controller + validation + request/response wiring
  - **1.2** — tests for that slice
- **Phase 2** — the next endpoint or slice
  - **2.1** — implementation
  - **2.2** — tests for that slice

Finish one slice before starting the next. Do not scaffold the entire API, all routes, or all controllers up front.

## How to commit

- **One sub-phase = one commit.**
- Commit subject: short, imperative, and specific.
- Commit description: what changed and what was tested.

Example:

```
add user repo with create/get

- CreateUser, GetUserByID on userRepo
- unit tests against testcontainers postgres
- update/delete until those RPCs land
```

## What to print after each phase

End every phase with exactly:

```
PHASE COMPLETE
Commit: <hash/id> <subject>
Diff: ~<N> lines / <M> files
Changed: <bullets>
Tested: <bullets>
Deferred: <bullets>
Next: <one line>
Waiting for approval.
```

Then stop.

## Anti-patterns

- Scaffolding future work “just in case”
- Combining multiple sub-phases into one commit
- Writing all migrations, routes, controllers, or validators at once
- Refactoring earlier phases without being asked
- Adding unrelated changes because you are already editing nearby code
- Vague commit subjects like `updates`, `wip`, or `phase 2 changes`
- Squashing multiple phases into one commit
