# Presentation, State, and Recovery

## Origin

Adapted from HIG guidance on alerts, sheets, popovers, modality, launching, loading, onboarding,
settings, managing accounts, and undo/redo.

## Use When

Choosing a temporary presentation or defining loading, empty, error, destructive, interrupted, and
restored states.

## Presentation Decision Table

| Need | Presentation | Key rule |
|---|---|---|
| Brief contextual options | Menu or popover | Keep close to the source and easy to dismiss |
| Focused task owned by current context | Sheet/dialog depending platform | Preserve parent context; define cancel/save |
| Critical information requiring a decision | Alert | Keep rare, specific, and concise |
| Durable destination or deep work | Page, window, or navigation destination | Give stable location and restoration |
| Teaching | In-context help or optional onboarding | Get to useful content quickly; allow skip |

Do not choose presentation by appearance alone. Choose by ownership, duration, interruption, and
whether the destination deserves a stable place.

## State Inventory

For every data-backed feature, decide whether these states apply:

- initial/launch;
- loading with known or unknown duration;
- content and partial content;
- empty before use and empty after filtering;
- offline/stale;
- permission denied/revoked;
- authentication expired;
- validation error;
- operation failure;
- destructive pending/complete;
- background/inactive;
- restored after interruption or relaunch.

## Recovery Rules

- Prefer prevention, then undo, then precise confirmation.
- Use undo for routine actions that are technically reversible.
- Confirm serious, surprising, or hard-to-recover operations and name the object/scope.
- Keep Cancel available in temporary editing or setup flows.
- Preserve user work through recoverable errors and authentication.
- Return focus and context after closing temporary presentation.
- Do not auto-dismiss information that people may need more time to perceive or act on.
- Make settings reversible and explain their enabled behavior clearly.

## Empty and Error States

| State | Include | Avoid |
|---|---|---|
| First-use empty | Purpose plus one clear first action | Crucial help that disappears after content exists |
| Filtered empty | Active filter/query plus clear/reset action | Pretending no data exists |
| Offline | What remains available plus retry/status | Destructive reset or sign-out as first response |
| Validation | Field-specific requirement and preserved input | Generic "invalid" message |
| Operation failure | What failed, impact, retry/alternative | False success or lost work |
| Permission denied | Feature impact and optional settings route | Repeated pressure or blocked unrelated features |

## Verification

- [ ] Presentation matches ownership, duration, and consequence.
- [ ] Alerts are reserved for attention-worthy decisions.
- [ ] Temporary flows define save, cancel, dismissal, and unsaved-work behavior.
- [ ] Every applicable state has visible content and actions.
- [ ] Undo and confirmation are used proportionally.
- [ ] Focus, scroll, selection, and draft state restore correctly.
- [ ] Auto-dismiss/timers do not create accessibility barriers.

## Failure Modes

- Modal stacking.
- Confirmation for every harmless action, causing alert fatigue.
- Toast-only error with no persistent recovery.
- Empty state that conflates a filter with no data.
- Onboarding before value, with no skip.
- Closing a sheet discards work without warning or draft recovery.
- Expired authentication resets the entire task.
