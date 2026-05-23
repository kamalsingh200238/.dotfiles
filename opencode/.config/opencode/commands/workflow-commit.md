---
description: Commit one approved workflow sub-phase
agent: build
---

Commit the current approved workflow sub-phase.

Optional commit subject from the user:

$ARGUMENTS

Follow this workflow strictly:

- Commit only the current approved sub-phase.
- Never bundle unrelated work.
- First inspect the repo state and make sure the current slice is ready to commit.
- Detect whether the repo uses `jj` or `git`. Use the repo's real workflow. Do not assume both.
- If the current changes were not reviewed yet, stop and tell the user to run `/workflow-review` first.
- Draft a commit message that matches this format:
- Subject line: one short plain line that names the change.
- Body: short plain sentences.
- Explain what changed.
- If the code exists because of a quirky behavior, edge condition, or non-obvious constraint, explain the problem, why this code exists, and how it solves it.
- Do not add AI footers or extra metadata.
- After the commit, print the completion summary and stop.

Completion format:

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
