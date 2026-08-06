---
description: Plan work in feature-sized phases
---

Plan this work request:

$ARGUMENTS

## Planning process

- Use the question tool to gather any missing context before planning. Ask only what removes real ambiguity.
- Check repo state. If there is unfinished or uncommitted work, stop and tell the user to review and commit it first.
- Read the files that will be touched. Understand existing patterns, types, and naming so the plan references real
  things, not guesses.
- Break work into feature-sized phases. One phase = one logical feature = one commit.
  Example: "add auth" becomes Phase 1: register, Phase 2: login, Phase 3: logout, Phase 4: middleware.
  Each phase should be a complete, reviewable unit that makes sense on its own.
- Do NOT break phases into sub-phases or commit-sized slices. The phase IS the slice.
- Build only what the current phase needs. No future scaffolding.
- Call out missing product, API, data, UX, migration, rollout, or testing details that would change the plan.
- Do not write code, edit files, or commit.

## Writing phases

This plan will be executed by a fast model with less reasoning depth. It will follow instructions but will not infer
gaps. Write each phase so it knows what to build, what pieces to create, and how they connect - without writing
the actual code.

Each phase needs:

- **Goal** - one line: what this feature achieves.
- **Files** - which files to create or change.
- **Steps** - action items for the whole feature. Say what to do and what it should handle, name the helpers or
  components to create and describe their job, mention how pieces connect to each other and to existing code. Reference
  real names from the codebase (existing functions, types, routes, patterns) so the executor can orient.
- **Verify** - how to confirm the feature works (test command, type-check, or manual check).

Aim for the sweet spot: enough detail that someone can implement the whole feature without guessing, but not so
micro that you're dictating every line.

Keep the plan file moderate length. Be descriptive with fewer words.

## Saving the plan

After producing the plan, save it to `.claude/plans/<slug>.md` in the project root, where `<slug>` is a short kebab-case
name you derive from the work request. Create the `.claude/plans/` directory if it does not exist. If a plan with the
same slug already exists, ask the user whether to overwrite, pick a new slug, or abort. Print the saved path on the last
line.

Use this exact format in the file so `/workflow-run` can track progress by ticking phase checkboxes:

```
## Scope
- <what is being built>

## Open Questions
- <only if needed>

## Plan

### Phase 1 - <feature name>
- [ ] **Goal:** <what this feature achieves>
  **Files:** `path/to/file`, `path/to/other`
  **Steps:**
  1. <do this - create/change what, it should handle X and return Y>
  2. <make a helper for Z that does A and B, used by the above>
  3. <wire it into existing `handlerName` so it calls the new piece when ...>
  **Verify:** <how to confirm it works>

### Phase 2 - <feature name>
- [ ] **Goal:** <what this feature achieves>
  ...

## Notes
- <constraints, dependencies, or risks>
```

Print the same content to chat, then the saved path. Wait for approval. Do not start implementation.
