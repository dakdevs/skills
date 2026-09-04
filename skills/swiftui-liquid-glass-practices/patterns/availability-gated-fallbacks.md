# Pattern: Availability-Gated Semantic Fallbacks

## Problem Shape

One component must use native Liquid Glass on platform version 26+ while remaining functional and
native-feeling on older systems.

## Pattern

Keep shared content and state independent from appearance. Branch at a small `@ViewBuilder`
boundary, returning complete semantic controls on both sides.

```swift
struct ConfirmAction: View {
    let action: () -> Void

    var body: some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            control
                .buttonStyle(.glassProminent)
        } else {
            control
                .buttonStyle(.borderedProminent)
        }
    }

    private var control: some View {
        Button(action: action) {
            Label("Confirm", systemImage: "checkmark")
        }
    }
}
```

## For Custom Floating Surfaces

When an older-system control needs visual separation from content:

- Native branch: public Liquid Glass API.
- Fallback branch: appropriate system `Material` and shape.
- Both branches: identical semantic control, state, label, hit target, and accessibility behavior.

## Decision Rules

- Prefer the platform's standard button appearance to a hand-built optical imitation.
- Centralize branching only after repetition is real.
- Avoid passing `Glass` or other new types through unannotated stored properties or protocols.
- Keep fallback naming honest: `legacySurface`, `materialFallback`, or role-based naming—not
  `liquidGlassBackport` unless it truly is one and is documented as such.
- Test compile-time and runtime paths separately.

## Verification

- Compile against all supported platform targets.
- Run a native and a fallback OS.
- Compare actions, disabled state, selection, focus, keyboard, and accessibility.
- Confirm visual differences are intentional and documented.
- Check that appearance-specific code does not fork business state.

## Failure Modes

- Duplicated action logic in each availability branch.
- A fallback view has a tap gesture but no button semantics.
- An abstraction shadows Apple's modifier and obscures which branch runs.
- A material fallback is described as optical parity.
