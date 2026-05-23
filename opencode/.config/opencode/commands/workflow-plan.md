---
description: Plan work in phases and commit-sized sub-phases
agent: plan
---

Plan this work request:

$ARGUMENTS

Follow this workflow strictly:

- First gather any missing context from the user before planning. Ask only the questions needed to remove real ambiguity.
- Check the repo state before planning new work.
- If there is unfinished or uncommitted work in progress, stop and tell the user that current work must be reviewed and committed before new work starts.
- Detect whether the repo uses `jj` or `git`. Use the repo's real workflow. Do not assume both.
- Decide whether this is a large feature that needs multiple phases, or a small change that should be one phase with one sub-phase.
- Break the work into small reviewable phases.
- Break each phase into concrete sub-phases.
- Each sub-phase must be one commit.
- Build only what the current phase needs. Do not plan future scaffolding just in case.
- Call out any missing product, API, data, UX, migration, rollout, or testing details that would change the plan.
- Do not write code.
- Do not edit files.
- Do not commit anything.

Output format:

## Scope

- <what is being built>

## Open Questions

- <only if needed>

## Workflow Decision

- <multi-phase feature or single-slice change>

## Plan

### Phase 1 - <name>

- 1.1 - <commit-sized sub-phase>
- 1.2 - <commit-sized sub-phase>

### Phase 2 - <name>

- 2.1 - <commit-sized sub-phase>

## Notes

- <important constraints, dependencies, or risks>

End by waiting for approval. Do not start implementation.
