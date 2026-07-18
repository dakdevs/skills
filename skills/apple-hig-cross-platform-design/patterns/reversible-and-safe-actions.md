# Pattern: Reversible and Safe Actions

## Problem

People need freedom to act without accidental loss, privacy harm, or repeated confirmation fatigue.

## Pattern

Match protection to consequence: prevent invalid action, offer undo for routine reversible action,
and confirm only serious or hard-to-recover action.

## Decision Table

| Consequence | Response |
|---|---|
| Invalid before execution | Disable only with explanation, or validate and guide correction |
| Routine and reversible | Perform, show result, offer undo |
| Recoverable but broad | Summarize scope and offer undo or brief confirmation based on surprise |
| Hard to recover or external | Specific confirmation naming object, destination, and consequence |
| Permission/data access | In-context rationale, system prompt, usable denial path |

## Procedure

1. Identify object, scope, reversibility, external side effects, and affected people/devices.
2. Prevent ambiguous or invalid targeting.
3. Use clear action labels and destructive roles.
4. Keep destructive actions away from the default primary action.
5. Preserve input and selection if execution fails.
6. Make undo visible for an appropriate period and define synced/multi-device behavior.
7. Verify keyboard, menu, touch, and assistive paths invoke the same protection.

## Confirmation Copy

Use:

- title: specific consequence;
- body: affected object and scope;
- primary nondestructive alternative when appropriate;
- destructive button: exact verb and object;
- cancel: clear exit that preserves state.

Avoid generic "Are you sure?" without consequence.

## Verification

- Destructive action never receives preferred/default styling.
- Undo restores content, selection, and ordering as expected.
- Multi-device or shared scope is explicit.
- A failed operation leaves work intact and provides a next step.
- Repeated confirmations are not used where undo is safer and faster.
