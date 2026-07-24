# Pattern: Functional Glass Layer

## Problem

Custom controls need to float above content without confusing content hierarchy or competing with
system Liquid Glass.

## Pattern

1. Draw the content independently.
2. Use system bars and controls first.
3. Reserve a safe-area inset if a custom control plane covers scroll content.
4. Place one custom glass cluster in the functional plane.
5. Group its effects with `GlassEffectContainer`.
6. Keep one meaningful tinted primary action.
7. Provide an earlier-OS semantic fallback.

## Conceptual Layout

```text
ZStack
  Content (scrolling, no glass)
  Functional control cluster (glass, sparse, interactive)
```

## Example Structure

```swift
ScrollView {
    content
}
.safeAreaInset(edge: .bottom) {
    PrimaryControlPlane()
        .padding()
}
```

`PrimaryControlPlane` chooses an available glass implementation or standard fallback internally.

## Invariants

- Every glass shape is a control or navigation element.
- Independent functional planes do not overlap.
- The last content item remains reachable.
- Tint expresses hierarchy.
- Interactive semantics use `Button`/native controls.
- Reduced transparency and contrast settings remain legible.

## Verification

- Scroll bright/dark/busy content behind the cluster.
- Use large text.
- Rotate/resize.
- Exercise pressed, disabled, selected, and expanded states.
- Turn on Reduce Transparency, Increase Contrast, and Reduce Motion.
- Run the older-OS branch.

## Avoid

- Glass list rows.
- A second glass background behind the cluster.
- Clear glass over arbitrary backgrounds.
- Icon images with tap gestures.
- Overlaying content without a bottom inset.
