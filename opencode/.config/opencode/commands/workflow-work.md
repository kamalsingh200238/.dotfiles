---
description: Implement one approved workflow sub-phase
agent: build
---

Implement the approved workflow slice:

$ARGUMENTS

Follow this workflow strictly:

- First inspect the repo state.
- Detect whether the repo uses `jj` or `git`. Use the repo's real workflow. Do not assume both.
- Never start new work on top of unfinished work.
- If there is uncommitted, unreviewed, or ambiguous current work, stop and tell the user to finish review and commit first.
- If the repo uses `jj` and the current slice is already finished and committed, create a fresh working commit for this approved sub-phase before editing files.
- If the repo uses `git`, make sure the worktree and index are clean enough for a new slice. Do not create empty placeholder commits or branches unless the user asked.
- Implement only the approved sub-phase. Do not pull in future phases, optional cleanup, or nearby unrelated refactors.
- Follow the existing code style, tests, and patterns in the repo.
- Run focused verification for this slice.
- Do not commit.
- Stop when the approved sub-phase is implemented and verified.

Final response format:

WORK COMPLETE
Slice: <phase or sub-phase>
Changed: <short bullets>
Tested: <short bullets>
Deferred: <short bullets>
Next: Run /workflow-review
