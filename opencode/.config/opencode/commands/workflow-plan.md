---
description: Plan work in phases and commit-sized sub-phases
agent: plan
---

Plan this work request:

$ARGUMENTS

## Planning process

- Use the question tool to gather any missing context before planning. Ask only what removes real ambiguity.
- Check repo state. If there is unfinished or uncommitted work, stop and tell the user to review and commit it first.
- Read the files that will be touched. Understand existing patterns, types, and naming so the plan references real
  things, not guesses.
- Decide: multi-phase feature, or one phase with one sub-phase.
- Break work into small reviewable phases, each phase into commit-sized sub-phases. One sub-phase = one commit.
- Build only what the current phase needs. No future scaffolding.
- Call out missing product, API, data, UX, migration, rollout, or testing details that would change the plan.
- Do not write code, edit files, or commit.

## Writing sub-phases

This plan will be executed by a fast model with less reasoning depth. It will follow instructions but will not infer
gaps. Write each sub-phase so it knows what to build, what pieces to create, and how they connect - without writing
the actual code.

Each sub-phase needs:
- **Goal** - one line: what this achieves.
- **Files** - which files to create or change.
- **Steps** - short action items. Say what to do and what it should handle, name the helpers or components to create
  and describe their job, mention how pieces connect to each other and to existing code. Reference real names from the
  codebase (existing functions, types, routes, patterns) so the executor can orient.
- **Verify** - one line: how to confirm it works.

Aim for the sweet spot: "make a helper that validates X against Y and returns Z, then wire it into the existing
handler" - not "add `validateX(input: string): boolean`" (too micro), and not "add validation" (too vague).

Keep the plan file moderate length. Be descriptive with fewer words.

## Saving the plan

After producing the plan, save it to `.claude/plans/<slug>.md` in the project root, where `<slug>` is a short
kebab-case name you derive from the work request. Create the `.claude/plans/` directory if it does not exist. If a
plan with the same slug already exists, ask the user whether to overwrite, pick a new slug, or abort. Print the saved
path on the last line.

Use this exact format in the file so `/workflow-run` can track progress by ticking sub-phase checkboxes:

```
## Scope
- <what is being built>

## Open Questions
- <only if needed>

## Workflow Decision
- <multi-phase feature or single-slice change>

## Plan

### Phase 1 - <name>

- [ ] 1.1 - <title>
  **Goal:** <what and why>
  **Files:** `path/to/file`, `path/to/other`
  **Steps:**
  1. <do this - create/change what, it should handle X and return Y>
  2. <make a helper for Z that does A and B, used by the above>
  3. <wire it into existing `handlerName` so it calls the new piece when ...>
  **Verify:** <one-liner: test command, type-check, or manual check>

- [ ] 1.2 - <title>
  ...

### Phase 2 - <name>
- [ ] 2.1 - <title>
  ...

## Notes
- <constraints, dependencies, or risks>
```

Print the same content to chat, then the saved path. Wait for approval. Do not start implementation.
