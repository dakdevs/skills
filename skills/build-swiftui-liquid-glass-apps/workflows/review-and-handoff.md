# Workflow: Review and Handoff

## Review Order

Review from consequence to polish:

1. Product task and data safety.
2. Navigation and state recovery.
3. Accessibility and privacy.
4. Layout and localization.
5. SwiftUI correctness and performance.
6. Liquid Glass placement and behavior.
7. Visual rhythm, motion, copy, and delight.

Do not lead with spacing while data can be lost or a flow cannot complete.

## Review Procedure

1. Read the brief and implementation plan.
2. Run the primary path and one failure path.
3. Inspect previews for the state matrix.
4. Run the relevant checks in `checks/`.
5. Inspect the diff for accidental scope, dead variants, debug fixtures, and beta-only APIs.
6. Verify build and test evidence independently when possible.

## Finding Format

```markdown
### [Priority] Outcome-focused title

- Surface: [screen, flow, file, lines]
- Evidence: [observable behavior or code]
- Affected state/person: [who and when]
- Rule: [local skill rule or Apple source]
- Correction: [smallest viable change]
- Verification: [how to prove it is resolved]
```

Priority:

- **P0** - data loss, privacy/security breach, crash in primary path;
- **P1** - primary task blocked, inaccessible core action, severe regression;
- **P2** - meaningful state, layout, performance, or platform problem;
- **P3** - polish or maintainability improvement.

## Handoff Package

Include:

- concise task and architecture summary;
- files/features changed;
- state coverage;
- minimum OS and SDK assumptions;
- build/test/runtime evidence;
- preview/screenshot locations if artifacts exist;
- accessibility and localization checks;
- remaining product decisions;
- known technical risks;
- exact next recommended slice.

Use `templates/verification-report.md`.

## Completion Gate

Do not call the work complete when:

- a required build or test is failing;
- the primary path was not run;
- only the populated state exists;
- custom glass has not been checked with accessibility settings;
- beta APIs were used without an explicit beta assumption;
- source changes are mixed with unrelated work;
- the designer cannot tell which assumptions shaped the result.

## Good Handoff

A new agent should be able to:

1. locate the app shell and feature;
2. understand state ownership;
3. render fixtures without live services;
4. reproduce the verified path;
5. know why custom glass exists;
6. continue with the next slice without re-architecting the app.
