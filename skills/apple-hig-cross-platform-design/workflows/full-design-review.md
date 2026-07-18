# Full Design Review Workflow

## Use When

Reviewing screenshots, prototypes, specifications, or running Web, macOS, or iPhone interfaces.

## Inputs

- Target surfaces and supported sizes.
- Primary tasks and critical data.
- Screens, states, or an interactive build.
- Known input methods, accessibility modes, and localization targets.
- Product constraints that explain intentional deviations.

## Procedure

### 1. Establish the task model

Write one sentence for the primary outcome. List entry, success, cancellation, error, and recovery.
Identify destructive, paid, permissioned, identity-related, or privacy-sensitive steps.

If the task model is unclear, record that as the first finding. Visual polish cannot rescue an
undefined or obstructed outcome.

### 2. Review shared invariants

Read the shared references. Check:

- purpose and hierarchy;
- agency, exits, and recovery;
- transparency and data minimization;
- perceivability without one sensory channel;
- text enlargement, appearance, locale, and input adaptability;
- concise labels, useful empty states, and actionable errors;
- feedback for action, progress, success, and failure.

### 3. Review each platform independently

Do not compare screenshots yet. For each surface, read its platform reference and checklist.
Evaluate the interface against the local context:

| Surface | Inspect first |
|---|---|
| Web | URL/history behavior, responsive reflow, focus order, semantics, pointer and touch variation |
| macOS | window lifecycle, menu bar coverage, keyboard shortcuts, pointer precision, inactive state |
| iPhone | primary-task focus, reachable controls, touch alternatives, rotation, interruption recovery |

### 4. Review components by behavior

Read the component reference that matches each interaction. Verify that the component's behavior,
role, state, and placement match the task. A visually similar substitute is not equivalent when it
loses keyboard behavior, semantics, history, selection, or recovery.

### 5. Compare cross-platform continuity

Compare concepts rather than pixels:

- Are nouns, action names, data, and status meanings stable?
- Does the same action lead to the same outcome?
- Are omissions intentional and explained by device context?
- Can a person resume the same task without relearning the information model?
- Does every surface provide an appropriate way to undo or recover?

### 6. Exercise non-happy paths

At minimum inspect loading, empty, partial, offline, denied-permission, invalid-input, destructive,
success, failure, background/inactive, and restored-session states where applicable.

### 7. Rank findings

Order by consequence:

1. Safety, privacy, inaccessible core task, or loss of work.
2. Blocked primary task or broken navigation/state.
3. Platform behavior that causes mistakes or major relearning.
4. Adaptability, readability, or feedback defects.
5. Craft inconsistencies with a concrete usability cost.

Avoid taste-only findings.

## Finding Template

```markdown
### [Severity] [Short outcome-focused title]

- Surface: Web | macOS | iPhone | shared
- Evidence: [observable screen, state, behavior, or code]
- Consequence: [realistic user impact]
- Rule: [source-derived principle or local skill document]
- Correction: [smallest coherent change]
- Verification: [specific state, input, size, or assistive mode]
```

## Verification

- Every finding cites observable evidence.
- Every proposed correction is platform-appropriate.
- Cross-platform differences are not treated as defects merely because they differ.
- The report covers states and input, not only static screenshots.
- The report names any source boundary or unverified assumption.
