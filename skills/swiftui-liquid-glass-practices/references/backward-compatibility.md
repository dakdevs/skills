# Backward Compatibility Reference

## Use When

The app supports systems before platform version 26 or shares components between native-glass and
legacy branches.

## Goal

Preserve the user task, semantic role, hierarchy, hit target, state, and contrast. Visual parity is
not the goal because standard `Material` does not reproduce native Liquid Glass optical behavior.

## Strategy Order

1. Let the standard control use its platform-native appearance on each OS.
2. If a custom functional surface is necessary, use native glass on 26+.
3. Use a standard material/shape fallback on older systems only to preserve hierarchy.
4. Centralize repeated branching behind a small project-owned abstraction when repetition becomes
   material.
5. Adopt a third-party backport only after dependency, accessibility, performance, maintenance, and
   licensing review.

## Branching Pattern

Prefer an `@ViewBuilder` boundary that returns complete semantic controls:

```swift
struct PrimaryActionLabel: View {
    var body: some View {
        Label("Continue", systemImage: "arrow.right")
            .frame(maxWidth: .infinity)
    }
}

@ViewBuilder
func primaryAction(action: @escaping () -> Void) -> some View {
    if #available(iOS 26.0, macOS 26.0, *) {
        Button(action: action) { PrimaryActionLabel() }
            .buttonStyle(.glassProminent)
    } else {
        Button(action: action) { PrimaryActionLabel() }
            .buttonStyle(.borderedProminent)
    }
}
```

This avoids hiding availability-sensitive types inside generic stored properties and keeps both
branches semantic.

## Fallback Design Rules

- Use the older platform's standard control style when it communicates the role.
- If a floating custom control needs separation, use a suitable standard `Material` plus an
  established shape.
- Honor Reduce Transparency and Reduce Motion in custom fallbacks.
- Do not reproduce refraction with layered gradients and shadows unless that visual fidelity is a
  documented product requirement and its cost is accepted.
- Keep state and accessibility behavior identical even when appearance differs.

## Abstraction Review

Create a wrapper only if it:

- Reduces repeated, error-prone availability code.
- Preserves type and semantic information.
- Makes native versus fallback behavior explicit in documentation/tests.
- Can evolve when new SDKs arrive.

Avoid wrappers that shadow Apple API names, pretend unsupported features exist, or make every
component glass by default.

## Testing Matrix

| Dimension | Minimum cases |
|---|---|
| OS | Oldest supported, latest pre-26, current 26+ |
| Appearance | Light, dark |
| Accessibility | Reduce Transparency, Increase Contrast, Reduce Motion |
| State | Enabled, disabled, selected/expanded where applicable |
| Input | Touch/pointer/keyboard/focus for target platform |

## Failure Modes

- A fallback replaces semantic controls with gestures.
- A custom material is marketed or documented as native Liquid Glass.
- Native-only types leak through a public API lacking availability annotations.
- Older-system UI receives different labels, actions, or state restoration.
- A package is adopted solely to avoid five lines of availability branching.
