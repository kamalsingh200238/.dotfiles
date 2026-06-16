---
description: Implement one approved workflow sub-phase
---

Implement the approved workflow slice:

$ARGUMENTS

- Inspect repo state first. Follow the version control rules in CLAUDE.md.
- Start the slice from a clean working commit that holds no prior work. If current work is uncommitted, unreviewed, or
  ambiguous, stop and tell the user to finish review and commit first.
- Implement only the approved sub-phase. No future phases, optional cleanup, or unrelated refactors.
- Follow existing code style, tests, and patterns.
- Run focused verification for this slice.
- Do not commit.

Final response:

WORK COMPLETE Slice: <phase or sub-phase> Changed: <bullets> Tested: <bullets> Deferred: <bullets> Next: Run
/workflow-review
