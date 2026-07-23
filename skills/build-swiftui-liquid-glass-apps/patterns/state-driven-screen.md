# Pattern: State-Driven Screen

## Problem

A screen built only for populated data becomes fragile when loading, errors, permissions, or empty
content occur.

## Pattern

Represent mutually exclusive visible states explicitly and keep the screen shell stable.

```swift
enum ScreenState: Equatable {
    case loading
    case empty
    case content([Item])
    case failed(String)
}
```

The view switches only the content region. Navigation title, toolbar ownership, and shared layout
remain stable.

## Procedure

1. Inventory states before implementation.
2. Give each state a direct preview.
3. Preserve user input across recoverable errors.
4. Keep retry and primary actions explicit.
5. Use realistic dense and long-content fixtures.
6. Test state transitions independently of layout.

## Verification

- No contradictory booleans can occur.
- Loading does not repeatedly restart.
- Empty explains the next step.
- Error does not expose technical detail.
- Offline/partial content is distinguishable.
- Large text and VoiceOver work in every state.
- Glass stays in shared functional chrome, not per-state content.
