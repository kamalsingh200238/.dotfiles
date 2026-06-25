---
description: Commit one approved workflow sub-phase
agent: build
---

Commit the current approved workflow sub-phase.

Optional commit subject:

$ARGUMENTS

- Inspect repo state. Follow the version control rules in AGENTS.md.
- Commit only the current approved sub-phase. Never bundle unrelated work.
- Never commit the plan file in `.claude/plans/`. It is a local checklist, not version-controlled work. Exclude it from
  the commit even if it has been edited (e.g. checkbox ticks).
- If the changes were not reviewed, stop and tell the user to run /workflow-review first.
- Record the work and leave a fresh working commit present on top for the next slice (see AGENTS.md).
- Commit message: one short plain subject line; body in short plain sentences.
- Describe what the change does in plain terms, by effect, not by code. Say what the user or system now sees or can do
  (e.g. "elements now appear side by side"), not the functions, fields, or classes involved.
- Explain why only if the user asked for it. Otherwise state only what changed.
- No AI footers or extra metadata.

After committing, print:

PHASE COMPLETE Commit: <hash/id> <subject> Diff: ~<N> lines / <M> files Changed:

- <bullets>
  Tested:
- <bullets>
  Deferred:
- <bullets>
  Next: <one line>
  Waiting for approval.
