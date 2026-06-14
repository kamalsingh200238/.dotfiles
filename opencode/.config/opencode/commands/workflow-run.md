---
description: Autonomously run workflow sub-phases up to a target, with review-and-fix between each commit
agent: build
---

Run the workflow autonomously up to and including a target sub-phase:

$ARGUMENTS

Argument forms (parse from $ARGUMENTS):

- `<target>` - e.g. `2.3`. Uses the most-recently-modified plan in `.claude/plans/` (error if none or more than one).
- `<plan-slug> <target>` - e.g. `add-dark-mode 2.3`. Reads `.cluade/plans/<plan-slug>.md`.

## Pre-flight

- **Load the rule files into context first.** Read all three of these before doing anything else:
  - `~/.config/opencode/commands/workflow-work.md`
  - `~/.config/opencode/commands/workflow-review.md`
  - `~/.config/opencode/commands/workflow-commit.md`

  Their bodies are the source of truth for the Work / Review / Commit steps below. Do not paraphrase from memory. If any file fails to read, STOP and report it.

- Follow the version control rules in AGENTS.md. Detect jj vs git.
- If the working copy has uncommitted or unreviewed work, STOP. Print what's there and tell the user to finish or stash it. Do not start the loop.
- Read the plan file. Parse its sub-phase list (lines like `- [ ] 1.1 - ...` or `- [x] 1.1 - ...`).
- Find the first unchecked sub-phase. Call this `current`.
- Validate that `current.id <= target.id` (lexicographic by phase.major then sub.minor as numbers). If `current` is already past `target`, print "Nothing to do" and exit.
- Print the slice list you intend to run, the target, and "Starting".

## Loop

For each sub-phase from `current` up to and including `target`:

1. **Work**: implement the sub-phase. Use the rules loaded from `workflow-work.md`: clean working commit first, only the approved slice, follow existing style, run focused verification, do not commit. Inline the sub-phase text from the plan as the slice description.

2. **Review**: review the slice using the rules loaded from `workflow-review.md`. Produce `Must Fix Before Commit`, `Optional Improvements`, `Not Worth Doing Now`.

3. **Fix-and-recheck loop (max 2 rounds)**:
   - Round 1: if `Must Fix Before Commit` is empty, proceed to commit.
   - Otherwise: apply ONLY the `Must Fix Before Commit` items. Do not touch `Optional Improvements` or `Not Worth Doing Now`. Re-run review.
   - Round 2: same. If review still finds must-fixes after Round 2, STOP the loop. Print the remaining must-fixes, the failed sub-phase id, the list of sub-phases already committed in this run, and exit.

4. **Verify**: run focused verification one more time (tests, type-check, lint as appropriate to the slice). If verification fails, STOP the loop with the same surfacing as above.

5. **Commit**: commit the slice using the rules loaded from `workflow-commit.md`. One commit per sub-phase. Leave a fresh working commit on top per AGENTS.md.

6. **Tick the plan**: edit the plan file to change `- [ ] <id> - ...` to `- [x] <id> - ...` for the just-committed sub-phase. This is how progress survives session restarts.

7. **Advance**: move to the next unchecked sub-phase. If it is past `target`, exit the loop.

## Final report

Print this on exit, whether the loop completed or stopped early:

```
WORKFLOW RUN COMPLETE
Plan: <path>
Target: <target>
Status: completed | stopped
Stopped at: <sub-phase id if stopped, else "n/a">
Reason: <one line if stopped, else "n/a">

Commits this run:
- <hash/id> <subject>   (1.1)
- <hash/id> <subject>   (1.2)
...

To review each commit yourself:
- jj: `jj edit <id>`   then  `jj diff`
- git: `git checkout <hash>`   then  `git show`
- back to tip: `jj edit @-` followed by `jj new`, or `git checkout <branch>`
```

## Hard rules

- Never skip the review-and-fix step.
- Never bundle multiple sub-phases into one commit.
- Never apply Optional or Not-Worth-Now findings in autonomous mode.
- Never continue past a failed verification or an unresolved Must-Fix after 2 rounds.
- Never edit sub-phases other than the current one. No "while I'm here" cleanup.
- If anything is genuinely ambiguous mid-slice (missing requirement, unclear API), STOP and surface it. Do not guess.
