# Development Workflow

Use a strict `plan -> work -> review -> commit` flow.

## Core Rules

- Plan the work before starting a new task.
- Implement one approved sub-phase at a time.
- Review the current slice before any commit.
- Commit only after review.
- Never start new work until current work is reviewed and committed.
- This rule applies to both `jj` and `git` repos.

## Planning

- Break large work into small reviewable phases.
- Break each phase into concrete sub-phases.
- Each sub-phase must be one commit.
- If the task is small, use one phase with one sub-phase.
- Gather missing context before planning when real ambiguity exists.
- Do not scaffold future work just in case.

## Working

- Implement only the approved sub-phase.
- Do not pull in future phases, optional cleanup, or unrelated refactors.
- In `jj` repos, create a fresh working commit for a new approved sub-phase only after the previous slice is done and committed.
- In `git` repos, do not start a new slice on top of unfinished work.

## Review

- Review the current slice before commit.
- Look for bugs, missed requirements, dead code, weak cleanup, regressions, missing tests, missed edge cases, and simpler or better approaches.
- Be practical. Do not fixate on tiny unrealistic edge cases that make the code worse.
- Report findings to the user and wait for confirmation.

## Commit

- One sub-phase equals one commit.
- Commit only the current approved sub-phase.
- Do not bundle unrelated work.
- Commit subject: one short plain line.
- Commit body: short plain sentences.
- Explain what changed.
- If the code exists because of a quirk or non-obvious constraint, explain the problem, why the code exists, and how it solves it.
- Mention what was tested.

## Completion

After a successful commit, print:

```
PHASE COMPLETE
Commit: <hash/id> <subject>
Diff: ~<N> lines / <M> files
Changed:
- <bullets>
Tested:
- <bullets>
Deferred:
- <bullets>
Next: <one line>
Waiting for approval.
```

Then stop.

## Anti-patterns

- Starting new work on top of unfinished work
- Scaffolding future work just in case
- Combining multiple sub-phases into one commit
- Refactoring earlier phases without being asked
- Adding unrelated changes because nearby code is already open
- Vague commit subjects like `updates`, `wip`, or `phase 2 changes`
- Overengineering for tiny unrealistic edge cases
