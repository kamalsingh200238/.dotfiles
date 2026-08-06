---
description: Implement one approved workflow phase
---

Implement the approved workflow phase:

$ARGUMENTS

- Inspect repo state first. Follow the version control rules in CLAUDE.md.
- Start the phase from a clean working commit that holds no prior work. If current work is uncommitted, unreviewed, or
  ambiguous, stop and tell the user to finish review and commit first.
- Implement the entire approved phase as one complete feature. No splitting into sub-commits.
- Follow existing code style, tests, and patterns.
- Run focused verification for this phase.
- Do not commit.

Final response:

WORK COMPLETE Phase: <phase name> Changed: <bullets> Tested: <bullets> Deferred: <bullets> Next: Run
/workflow-review
