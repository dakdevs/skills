# Pattern: Progressive Disclosure

## Problem

The product has more capability than a focused interface can show without crowding the primary
task.

## Pattern

Keep the current goal and frequent actions visible. Reveal secondary detail through familiar,
predictable controls while preserving discoverability.

## Decision Rules

| Capability | Treatment |
|---|---|
| Required to understand or complete the primary task | Keep visible |
| Frequent contextual action | Visible near the content or in the primary toolbar |
| Infrequent but important action | Familiar menu/command location with clear label |
| Advanced configuration | Settings, inspector, disclosure group, or secondary view |
| Destructive action | Separated, explicit, and recoverable—not merely hidden |

## Procedure

1. Rank capabilities by task necessity, frequency, and consequence.
2. Keep the primary information and action visually dominant.
3. Group secondary controls by relationship.
4. Choose platform-native disclosure: Web menu/details/secondary region, macOS menu/inspector,
   iPhone menu/sheet/disclosure.
5. Make the disclosure control describe what it reveals.
6. Preserve state when the region opens, closes, or moves.
7. Confirm keyboard, pointer, touch, and assistive discoverability.

## Verification

- A first-time person can find the primary and one important secondary action.
- Experienced people can reach frequent commands without unnecessary steps.
- Hiding a region never hides the only recovery path.
- Disclosed content participates in correct focus and reading order.

## Anti-Patterns

- Hamburger or ellipsis as a warehouse for every action.
- Removing essential labels to make the interface look sparse.
- Hover-only disclosure.
- Requiring a modal flow to reveal simple contextual detail.
