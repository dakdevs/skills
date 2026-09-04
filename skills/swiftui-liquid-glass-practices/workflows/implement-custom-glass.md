# Workflow: Implement a Custom Liquid Glass Element

## Use When

A system control or container cannot express an important custom functional element, and the
element floats above content or temporarily becomes interactive.

## Preconditions

- The element's functional role is documented.
- A standard SwiftUI alternative was evaluated.
- Target platform availability is known.
- The content behind the surface is available for realistic preview/testing.

## Procedure

### 1. Define semantics first

Choose the semantic control (`Button`, `Toggle`, `Slider`, focusable custom control) before its
appearance. Provide label, value, traits, keyboard/focus behavior, and hit target.

### 2. Select the least custom surface

| Need | Preferred implementation |
|---|---|
| Standard action | `.buttonStyle(.glass)` |
| Prominent action | `.buttonStyle(.glassProminent)` |
| Custom control surface | `.glassEffect(_:in:)` |
| Several nearby effects | One purposeful `GlassEffectContainer` |
| Permanent composite surface | `glassEffectUnion` for compatible participants |
| Appearing/disappearing shape | `glassEffectID` plus a glass transition |

### 3. Establish layout before glass

Apply content, typography, frame, padding, foreground, and shape-affecting modifiers first. Apply
`.glassEffect()` after them so SwiftUI captures the intended bounds and appearance.

### 4. Choose variant and shape

- Start with `.regular`.
- Use `.clear` only over rich media after testing legibility and dimming.
- Use a capsule for compact controls, a circle for isolated icon controls, or a continuous rounded
  rectangle for larger functional panels.
- Prefer concentric/system-derived geometry near rounded containers.

### 5. Add meaning, not decoration

- Tint only for prominence, status, or action meaning.
- Add `.interactive()` only when the surface receives touch, pointer, or focus interaction.
- Keep related controls visually consistent, but do not force all controls into one union.

### 6. Compose multiple effects

Define the container around the smallest group that needs shared sampling or morphing. Tune spacing
against actual nearest-edge distances. Confirm that effects do not merge at rest unless intended.

### 7. Add availability behavior

Use a runtime availability branch. The fallback must preserve semantic control behavior, hit area,
hierarchy, and contrast. Describe it as a material fallback, never as native Liquid Glass.

### 8. Verify

- Test over bright, dark, detailed, moving, and flat backgrounds.
- Exercise pressed, hovered, focused, disabled, selected, and loading states.
- Run accessibility combinations and Dynamic Type.
- Profile if several effects animate or sample changing content.

## Original Baseline Pattern

```swift
@ViewBuilder
func actionSurface<Label: View>(
    action: @escaping () -> Void,
    @ViewBuilder label: () -> Label
) -> some View {
    if #available(iOS 26.0, macOS 26.0, *) {
        Button(action: action, label: label)
            .buttonStyle(.glass)
    } else {
        Button(action: action, label: label)
            .buttonStyle(.bordered)
    }
}
```

The fallback preserves a button rather than replacing it with a gesture on a styled view.

## Review Checklist

- [ ] Functional role is explicit.
- [ ] Standard system component considered first.
- [ ] Modifier order captures intended bounds.
- [ ] Variant and shape fit the context.
- [ ] Tint and interactivity are semantic.
- [ ] Container scope and spacing are deliberate.
- [ ] Fallback preserves behavior and semantics.
- [ ] Accessibility and background stress tests pass.
