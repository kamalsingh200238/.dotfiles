---
description: Plan work in phases and commit-sized sub-phases
agent: plan
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
- [ ] 1.1 - <sub-phase>
- [ ] 1.2 - <sub-phase>

### Phase 2 - <name>
- [ ] 2.1 - <sub-phase>

## Notes
- <constraints, dependencies, or risks>
```

Print the same content to chat, then the saved path. Wait for approval. Do not start implementation.
