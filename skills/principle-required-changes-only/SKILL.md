---
name: principle-required-changes-only
description: "Apply to code changes when strict scope control matters. Change only the lines required to achieve the stated goal. Do not refactor, clean up, reformat, or pre-optimize unrelated code."
---

# Required changes only

Make the smallest code change that achieves the stated goal and satisfies its acceptance criteria.

## Rule

Every changed, added, or removed line must be necessary for at least one of these reasons:

- It directly implements the requested behavior.
- It keeps the code compiling, type-checking, or running after that behavior changes.
- It adds or updates verification required to prove the requested behavior.
- It is the smallest enabling change without which the goal cannot be achieved.

If a line does not meet one of those conditions, do not change it.

## Working method

1. State the exact behavior that must change.
2. Find the narrowest implementation path.
3. Edit only that path and its required dependents.
4. Inspect the final diff one hunk at a time.
5. Remove any change you introduced that is not required for the goal.

Use this test for every hunk: if reverting the hunk would not prevent the goal, break the build, or invalidate required verification, the hunk does not belong.

## Forbidden scope expansion

Unless the goal cannot be achieved without it, do not:

- Refactor, rename, reorganize, or extract code.
- Reformat untouched code or normalize nearby style.
- Pre-optimize for future requirements.
- Add abstractions, helpers, configuration, validation, or error handling for hypothetical use cases.
- Upgrade dependencies or rewrite adjacent code.
- Fix unrelated defects, warnings, comments, or tests.
- Expand the task because a broader design seems cleaner.

Preserve existing imperfections outside the required change. A cleaner diff is not a reason to make a larger diff.

## Necessary enabling work

When the goal truly requires a refactor or supporting change, make only the smallest enabling change. Keep it in the same diff and explain why the goal was otherwise impossible.

Do not alter or remove user-owned changes while trimming the diff. Remove only unrelated changes introduced during the current task.
