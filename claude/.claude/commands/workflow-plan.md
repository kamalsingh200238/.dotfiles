---
description: Plan work in phases and commit-sized sub-phases
---

Plan this work request:

$ARGUMENTS

- Use the question tool to gather any missing context before planning. Ask only what removes real ambiguity.
- Check repo state. If there is unfinished or uncommitted work, stop and tell the user to review and commit it first.
- Decide: multi-phase feature, or one phase with one sub-phase.
- Break work into small reviewable phases, each phase into commit-sized sub-phases. One sub-phase = one commit.
- Build only what the current phase needs. No future scaffolding.
- Call out missing product, API, data, UX, migration, rollout, or testing details that would change the plan.
- Do not write code, edit files, or commit.

Output:

## Scope
- <what is being built>

## Open Questions
- <only if needed>

## Workflow Decision
- <multi-phase feature or single-slice change>

## Plan

### Phase 1 - <name>
- 1.1 - <sub-phase>
- 1.2 - <sub-phase>

## Notes
- <constraints, dependencies, or risks>

Wait for approval. Do not start implementation.
