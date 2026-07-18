# Actions, Input, and Feedback

## Origin

Adapted from HIG guidance on buttons, text fields, toggles, pickers, gestures, keyboards, pointing
devices, feedback, loading, and progress indicators.

## Use When

Choosing controls, assigning primary/destructive roles, building forms, supporting input, or
communicating progress and result.

## Action Decision Rules

- Use a button for an instantaneous action and a link for navigation on Web.
- Use a toggle for an immediate binary setting; use a checkbox or other platform convention where
  Web semantics require it.
- Use a picker/selection control when choosing among known values.
- Use a text field only when free-form or formatted text is necessary.
- Use one or at most a few visually prominent actions. Too many prominent controls destroy priority.
- Distinguish a preferred choice by role/style, not arbitrary size difference.
- Never assign the primary role to a destructive action.
- Custom buttons need pressed, hover where applicable, focus, disabled, and progress states.

## Input Parity

| Outcome | Keyboard | Pointer | Touch/gesture | Assistive path |
|---|---|---|---|---|
| Activate | Enter/Space as semantic | Click | Tap | Named control with correct role |
| Navigate | Tab/arrows/shortcuts | Click/scroll | Tap/swipe | Ordered focus and landmarks |
| Select | Standard modifiers/arrows | Click/drag | Tap/edit mode | State and count announced |
| Reorder/move | Keyboard command where needed | Drag/drop | Drag or explicit move UI | Explicit move controls |
| Dismiss/back | Escape/command where expected | Close/back control | Back button/swipe | Visible named control |

Convenience inputs may differ, but core outcomes need at least one discoverable, accessible path.

## Form Procedure

1. Remove fields the system or existing context can supply with permission.
2. Give every field a persistent, programmatic label.
3. Provide formatting hints or examples without replacing the label.
4. Choose the appropriate keyboard/input mode.
5. Validate at a useful time; do not interrupt every keystroke unnecessarily.
6. Put the error near the field and explain the correction.
7. Preserve valid input and focus the first actionable problem on submission.
8. Protect the draft through retry, reauthentication, resize, backgrounding, and navigation mistakes.

## Progress Procedure

- If duration is measurable, show determinate progress.
- If duration is unknown, show activity and explain what is happening when delay is meaningful.
- Keep the interface responsive; provide cancellation when cancellation is real and safe.
- Avoid showing progress for actions that complete immediately.
- On failure, preserve work and offer retry or another path.
- On success, update the actual content/state; do not rely only on a transient toast.

## Verification

- [ ] Interactive regions are comfortable for the platform and input.
- [ ] Labels describe actions out of surrounding visual context.
- [ ] Primary and destructive roles are not conflated.
- [ ] All required button/control states exist.
- [ ] Forms preserve work and show corrective inline errors.
- [ ] Keyboard, pointer, touch, and assistive paths are tested as applicable.
- [ ] Gesture, hover, drag, sound, color, or haptic is never the only signal.
- [ ] Progress corresponds to real work and failure has recovery.

## Failure Modes

- Placeholder-only fields.
- An icon-only command with no accessible name or ambiguous symbol.
- A 44-point visible button whose actual hit region is smaller.
- Disabled submit with no explanation of what remains incomplete.
- Spinner with no context during a long or failure-prone operation.
- Duplicate activation because optimistic and confirmed responses both fire feedback.
- Keyboard shortcut that conflicts with a standard platform command.
