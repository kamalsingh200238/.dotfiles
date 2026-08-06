---
description: Autonomously run workflow phases up to a target, with review-and-fix between each commit
---

Run the workflow autonomously up to and including a target phase:

$ARGUMENTS

Argument forms (parse from $ARGUMENTS):

- `<target>` - e.g. `3`. Uses the most-recently-modified plan in `.claude/plans/` (error if none or more than one).
- `<plan-slug> <target>` - e.g. `add-auth 3`. Reads `.claude/plans/<plan-slug>.md`.

## Pre-flight

- **Load the rule files into context first.** Read all three of these before doing anything else:
  - `~/.claude/commands/workflow-work.md`
  - `~/.claude/commands/workflow-review.md`
  - `~/.claude/commands/workflow-commit.md`

  Their bodies are the source of truth for the Work / Review / Commit steps below. Do not paraphrase from memory. If any
  file fails to read, STOP and report it.

- Follow the version control rules in CLAUDE.md. Detect jj vs git.
- If the working copy has uncommitted or unreviewed work, STOP. Print what's there and tell the user to finish or stash
  it. Do not start the loop.
- Read the plan file. Parse its phase list (lines like `- [ ] **Goal:**` under `### Phase N` headings, or `- [x]` for
  completed phases).
- Find the first unchecked phase. Call this `current`.
- Validate that `current` phase number <= `target` phase number. If `current` is already past `target`, print
  "Nothing to do" and exit.
- Print the phase list you intend to run, the target, and "Starting".

## Loop

For each phase from `current` up to and including `target`:

1. **Work**: implement the phase. Use the same rules as `/workflow-work`: clean working commit first, implement the
   entire feature, follow existing style, run focused verification, do not commit. Inline the phase text from the plan
   as the feature description.

2. **Review**: review the phase using the same rules as `/workflow-review`. Produce `Must Fix Before Commit`,
   `Optional Improvements`, `Not Worth Doing Now`.

3. **Fix-and-recheck loop (max 2 rounds)**:
   - Round 1: if `Must Fix Before Commit` is empty, proceed to commit.
   - Otherwise: apply ONLY the `Must Fix Before Commit` items. Do not touch `Optional Improvements` or
     `Not Worth Doing Now`. Re-run review.
   - Round 2: same. If review still finds must-fixes after Round 2, STOP the loop. Print the remaining must-fixes, the
     failed phase number, the list of phases already committed in this run, and exit.

4. **Verify**: run focused verification one more time (tests, type-check, lint as appropriate to the phase). If
   verification fails, STOP the loop with the same surfacing as above.

5. **Commit**: commit the phase using the same rules as `/workflow-commit`. One commit per phase. Leave a fresh
   working commit on top per CLAUDE.md.

6. **Tick the plan**: edit the plan file to change `- [ ]` to `- [x]` for the just-committed phase. This is how
   progress survives session restarts. Do this AFTER the commit so the tick edit stays in the working copy and is never
   bundled into the phase commit.

7. **Advance**: move to the next unchecked phase. If it is past `target`, exit the loop.

## Final report

Print this on exit, whether the loop completed or stopped early:

```
WORKFLOW RUN COMPLETE
Plan: <path>
Target: <target>
Status: completed | stopped
Stopped at: <phase number if stopped, else "n/a">
Reason: <one line if stopped, else "n/a">

Commits this run:
- <hash/id> <subject>   (Phase 1 - <name>)
- <hash/id> <subject>   (Phase 2 - <name>)
...

To review each commit yourself:
- jj: `jj edit <id>`   then  `jj diff`
- git: `git checkout <hash>`   then  `git show`
- back to tip: `jj edit @-` followed by `jj new`, or `git checkout <branch>`
```

## Hard rules

- Never skip the review-and-fix step.
- Never commit the plan file. The plan in `.claude/plans/` is not version-controlled work; it is a local checklist.
  Tick checkboxes in it freely, but exclude it from every phase commit. If your VCS would auto-stage it, exclude it
  explicitly.
- Never bundle multiple phases into one commit.
- Never apply Optional or Not-Worth-Now findings in autonomous mode.
- Never continue past a failed verification or an unresolved Must-Fix after 2 rounds.
- Never edit phases other than the current one. No "while I'm here" cleanup.
- If anything is genuinely ambiguous mid-phase (missing requirement, unclear API), STOP and surface it. Do not guess.
