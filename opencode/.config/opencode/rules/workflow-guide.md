# Development Workflow

Work in small, reviewable slices. Never ship a full feature in one pass.

## Rules

- **Stop after every phase.** Wait for explicit approval before continuing.
- **One phase = one commit.** Small, focused, reviewable on its own.
- **No speculative code.** Don't scaffold anything the current phase doesn't use.
- **Target ~150 lines of meaningful diff per phase.** If a phase will exceed that, split it and ask.
- **Build like a developer, not a generator.** Each phase should be a natural checkpoint a careful engineer would commit at.

## Phasing principle

Split features so each phase is independently reviewable:

1. **Plan** — list phases with one-line descriptions and rough diff sizes. Stop for approval.
2. **Skeleton** — minimal runnable scaffold. No business logic, no per-feature code.
3. **Foundation** — shared infra (DB wiring, config, etc.) with no feature logic on top.
4. **Per-feature slices** — for each feature/endpoint/RPC, split into:
   - **Data layer** — schema, migrations, repo methods, unit tests
   - **Interface layer** — public API (proto/HTTP/etc.), handler, validation, error mapping, tests

   Do one feature fully (data → interface) before starting the next.

5. **Polish** — logging, metrics, docs. Only if needed, split by concern.

Example (3-RPC gRPC server): Plan → Skeleton → DB foundation → RPC1 data → RPC1 handler → RPC2 data → RPC2 handler → RPC3 data → RPC3 handler. Each is one commit.

## Per-phase checklist

Before handing back:

- Build passes
- Tests pass
- Working tree is clean of unintended changes
- One commit for the phase

## Commit format

Each phase is a single commit with:

- **Subject:** short, imperative, to the point. No fluff, no scope beyond the phase.
  `add user repo with create/get` — not `phase 3: various changes for user stuff`
- **Blank line, then description:** what was done, what was tested, what was deferred. Short bullets are fine.

Example:

```
add user repo with create/get

- CreateUser, GetUserByID on userRepo
- unit tests against testcontainers postgres
- deferred: update/delete until those RPCs land
```

No phase numbers in subjects — the description carries context, the subject stands on its own if cherry-picked or searched later.

## Stop format

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

- Scaffolding all features upfront "since we know them"
- Combining data + interface layers in one commit
- Writing all migrations at once
- Refactoring earlier phases unprompted
- "While I was in there, I also..."
- Vague commit subjects (`updates`, `wip`, `phase 2 changes`)
- Squashing multiple phases into one commit
