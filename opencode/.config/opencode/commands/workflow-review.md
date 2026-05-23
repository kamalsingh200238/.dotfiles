---
description: Review the current workflow slice before commit
agent: plan
---

Review the current workflow slice before commit.

Optional scope from the user:

$ARGUMENTS

Follow this workflow strictly:

- Review only the current slice of work.
- Inspect the current changes and the local context needed to understand them.
- Focus on bugs, missed requirements, dead code created during the change, weak cleanup, simpler or better approaches, architecture issues, regressions, missing tests, and missed edge cases.
- Be practical. Do not fixate on tiny unrealistic edge cases that would add noise, loops, or worse code.
- Prefer code clarity over defensive complexity for cases that are not likely to happen.
- Report findings to the user.
- Separate findings into three groups: must fix before commit, optional improvements, and not worth doing now.
- If there are no findings, say that clearly.
- Do not edit code.
- Do not commit.
- Wait for the user to confirm what to do next.

Output format:

## Review

### Must Fix Before Commit
- <finding or "None">

### Optional Improvements
- <finding or "None">

### Not Worth Doing Now
- <finding or "None">

### Summary
- <short summary of quality, risk, and test coverage>

Stop after the review. Do not make changes until the user asks.
