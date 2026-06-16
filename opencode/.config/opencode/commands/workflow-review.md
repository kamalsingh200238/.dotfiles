---
description: Review the current workflow slice before commit
agent: plan
---

Review the current workflow slice before commit.

Optional scope:

$ARGUMENTS

- Review only the current slice. Inspect the changes and the local context needed to understand them.
- Look for bugs, missed requirements, dead code, weak cleanup, simpler approaches, regressions, missing tests, and
  missed edge cases.
- Be practical. Prefer clarity over defensive complexity for unlikely cases.
- Group findings: must fix before commit, optional improvements, not worth doing now.
- If there are no findings, say so clearly.
- Do not edit code or commit.

Output:

## Review

### Must Fix Before Commit

- <finding or "None">

### Optional Improvements

- <finding or "None">

### Not Worth Doing Now

- <finding or "None">

### Summary

- <short summary of quality, risk, and test coverage>

Stop after the review. Wait for the user.
