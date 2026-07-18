# Implementation Workflow

## Use When

Creating a new feature, restructuring an existing flow, or implementing a design across one or more
of Web, macOS, and iPhone.

## Procedure

### 1. Write the outcome contract

Define:

- who is acting and what they want;
- the shortest credible path to success;
- data read, changed, transmitted, or deleted;
- entry points, exits, interruption points, and recovery;
- required versus optional permissions;
- supported surfaces, sizes, inputs, and locales.

### 2. Model shared states

Before choosing components, define observable states:

```text
idle -> initiating -> in progress -> success
                    -> recoverable failure
                    -> cancelled
                    -> interrupted -> restored
```

Add empty, partial, offline, permission-denied, expired-authentication, and conflict states when the
domain permits them. Preserve user-entered data through recoverable failures.

### 3. Build the semantic core

Specify entities, actions, roles, labels, and state changes once. Mark destructive actions and
actions that can be undone. Establish a terminology list so labels stay consistent.

### 4. Choose the platform shell

Read every targeted platform file. Create a platform-delta table:

| Concern | Web | macOS | iPhone |
|---|---|---|---|
| Entry point |  |  |  |
| Navigation |  |  |  |
| Primary command |  |  |  |
| Secondary commands |  |  |  |
| Selection |  |  |  |
| Presentation |  |  |  |
| Recovery |  |  |  |
| Keyboard/pointer/touch |  |  |  |

Do not fill cells by copying. Use `workflows/platform-adaptation-workflow.md`.

### 5. Choose components by behavior

Read the relevant component reference. Prefer the platform's familiar component when it provides
the needed semantics, state, accessibility, and interaction. Customize appearance after behavior is
correct.

### 6. Apply hierarchy and content

- Put the primary outcome first.
- Keep essential controls visible; disclose secondary capability predictably.
- Separate controls from content without obscuring either.
- Use concise, action-oriented labels.
- Make empty states useful and errors corrective.
- Keep prominent actions few; never style a destructive action as the preferred default.

### 7. Implement accessibility and privacy with the feature

Add semantic labels, focus order, text scaling/reflow, alternate input, contrast, reduced motion,
permission rationale, data minimization, and recovery before declaring the flow complete.

### 8. Verify behavior

Run the shared and platform checklists. Exercise real state transitions, not only the default state.
Use actual devices when display, touch, keyboard, pointer, appearance, or assistive behavior matters.

## Output Template

```markdown
## Outcome
[Primary task and supported surfaces]

## Shared model
[Entities, actions, states, safety and privacy]

## Platform deltas
[Completed table]

## Implemented behavior
[Files, components, and state changes]

## Verification
[Sizes, inputs, appearances, locales, states, and results]

## Remaining risk
[Only concrete unverified or external dependencies]
```

## Failure Conditions

Do not call the implementation complete when:

- the primary task is inaccessible by a supported input;
- user work disappears after a recoverable error;
- permission is requested before its purpose is clear;
- the responsive layout clips or loses essential commands;
- Mac commands lack menu or keyboard discoverability where expected;
- an iPhone interaction depends only on a hidden gesture;
- the Web surface imitates native visuals while losing Web semantics;
- loading, empty, error, and destructive states remain unspecified.
