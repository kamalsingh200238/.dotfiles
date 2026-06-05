---
name: jj-resolve
description:
  Resolve jj rebase/merge conflicts one commit at a time. For each conflicted commit, creates a child commit, resolves
  the conflict there (asking the user when the resolution is non-obvious), then squashes the fix back into the original
  commit so the conflict and its fix live together. Use after a jj rebase/merge/new that produced conflicts, or whenever
  the user asks to resolve jj conflicts.
allowed-tools:
  - Bash(jj status)
  - Bash(jj log:*)
  - Bash(jj diff:*)
  - Bash(jj show:*)
  - Bash(jj evolog:*)
  - Bash(jj new:*)
  - Bash(jj resolve:*)
  - Bash(jj describe:*)
  - Bash(jj edit:*)
  - Bash(jj next:*)
  - Bash(jj prev:*)
  - Bash(jj bookmark list:*)
  - Bash(jj file show:*)
  - Bash(jj file list:*)
  - Read
  - Edit
  - Write
  - Grep
  - Glob
---

# jj-resolve

Resolve jj conflicts one commit at a time, keeping each fix inside the commit that introduced it.

## Hard rules

- NEVER run `jj squash`, `jj abandon`, `jj restore`, `jj undo`, `jj op restore` without explicit user approval in this
  turn. They are intentionally NOT in `allowed-tools`.
- NEVER guess when both sides have real semantic changes. STOP and ask, showing both sides verbatim.
- Resolve oldest first; resolving an ancestor often clears descendant conflicts automatically.
- One commit at a time. Finish it (resolve + verify + squash) before moving on.

## Procedure

### 1. Survey

`jj log -r 'conflict()' --no-graph -T 'change_id.short() ++ " " ++ description.first_line() ++ "\n"'`. If empty, report
no conflicts and stop. Otherwise list them oldest-first and name the one to tackle.

### 2. Inspect target commit `C`

Show `jj show <C>` and the conflicted file list from `jj resolve --list -r <C>`.

### 3. Create the fix commit

`jj new <C>`. The working copy now inherits `C`'s conflict markers. This child is the "fix commit" that will later be
squashed into `C`.

### 4. Walk each conflicted file

For each file:

1. Read it; find each `<<<<<<<` / `=======` / `>>>>>>>` block.
2. Decide:
   - **Obvious** (formatting, rename already applied on one side, deleted-on-one-side where the other is live): resolve
     with `Edit`.
   - **Non-obvious**: STOP and ask. Show both sides verbatim, label them by their commit (use `jj evolog` / `jj log` to
     identify), and only propose a side if you have a real reason.
3. Re-read; confirm zero markers remain.

### 4a. Generated files: regenerate, do not hand-merge

Some files are produced by a tool and must not be merged line-by-line. Examples that cover the common shapes:

- **Schema dumps / codegen output** (e.g. `schema.sql`, generated Prisma/GraphQL/proto types).
- **npm-style lock files** (`package-lock.json` and the same idea applies to `pnpm-lock.yaml`, `yarn.lock`,
  `Cargo.lock`, `poetry.lock`, `uv.lock`).
- **Go checksum file** (`go.sum`), regenerated via `go mod tidy`.

**Schema / codegen workflow**: pick the side whose source inputs are correct (migrations folder, `.graphql`, `.proto`,
model files). If both sides changed the inputs, that source conflict is the real conflict; resolve it via step 4 first.
Then overwrite the generated file from either parent with `jj file show -r <parent> <path> > <path>` and re-run the
project's generator. The generator command is not pre-approved, so the user is prompted -- that is the gate.

**Lock file workflow** (this is the supply-chain-sensitive case). Do NOT `rm` and reinstall: a naive reinstall silently
pulls fresh transitive versions, which is exactly what malicious patch releases target.

1. Identify which side has the intentional manifest change (`package.json`, `go.mod`, etc.).
2. Start from the OTHER side's lock file -- usually base/main, already audited and CI'd. Use
   `jj file show -r <base-side> <lockfile> > <lockfile>`. Do not delete the lock.
3. Run the package manager in a lockfile-only / minimal-update mode so only the entries the new manifest requires move:
   - `npm install --package-lock-only` (never `rm` + `npm install`, never `npm update`).
   - `go mod tidy` (preserves existing `go.sum`; adds/removes only for changed direct deps).
   - For other ecosystems use the equivalent: pnpm `--lockfile-only`, yarn `--mode update-lockfile`,
     `cargo update -p <specific pkgs>`, `poetry lock --no-update`, `uv lock`, `bundle lock --update <gems>`. These
     commands are not pre-approved; the user prompt is the gate.
4. `jj diff <lockfile>`: only direct deps whose manifest range moved (plus genuinely-required transitives) should
   change. Unrelated transitive shifts = STOP, show the diff, do not squash.
5. For any newly-bumped version, surface its publish date (`npm view <pkg>@<ver> time`, crates.io, PyPI page, etc.).
   Anything published within the last few days against an established package deserves a second look before squashing.

If the lock conflicted only on formatting / ordering and no manifest changed, take either side verbatim and run the
strict-install mode (`npm ci`, `pnpm install --frozen-lockfile`, `cargo build --locked`, `uv sync --frozen`,
`go mod verify`) to confirm nothing drifted.

### 5. Verify the fix commit

- `jj diff`: should contain only resolution edits.
- `jj resolve --list -r @`: should be empty.
- State: "Fix commit looks clean, ready to squash into `<C>`."

### 6. Ask, then squash

Ask: "Squash this fix into `<C>`?" On approval, `jj squash --into <C>`. This is gated; the harness will also prompt --
do not bypass.

After squash: `jj log -r <C>` should no longer show `conflict`, and `jj show <C>` should reflect the fix. If `<C>` still
shows conflicted, STOP and surface the unexpected state.

### 7. Re-survey and continue

Re-run step 1. Resolving `C` often clears descendants. Continue until no conflicts remain.

### 8. Final report

When `jj log -r 'conflict()'` is empty, list each resolved commit with a one-line summary of how it was fixed (and
whether the user was asked). Suggest reviewing `jj log` / `jj evolog` before push.

## Asking the user well

```
Conflict in <path>:<approx line>

--- side A (from <change id / description>) ---
<verbatim side A>

--- side B (from <change id / description>) ---
<verbatim side B>

Surrounding context:
<a few lines above and below>

I cannot tell which is intended because <specific reason>.
Which side should win, or do you want a manual merge?
```

Do not dress a guess as a recommendation.
