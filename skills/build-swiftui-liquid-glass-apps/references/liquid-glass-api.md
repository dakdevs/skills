# Liquid Glass SwiftUI API

## Contents

- [Availability](#availability)
- [System First](#system-first)
- [Basic Effect](#basic-effect)
- [Modifier Order](#modifier-order)
- [Buttons](#buttons)
- [Grouping](#grouping)
- [Tint and Interactivity](#tint-and-interactivity)
- [Morphing](#morphing)
- [Availability Boundary](#availability-boundary)
- [Fallbacks](#fallbacks)
- [Review Checklist](#review-checklist)

## Availability

The custom Liquid Glass APIs in this document require the iOS 26-aligned SDK and are available on
supported iOS 26+ platforms. Check the exact API page for each platform. A deployment target below
iOS 26 requires an availability branch. An older Xcode that lacks these declarations cannot compile
the code at all.

## System First

Before applying any modifier:

1. Build with the new SDK.
2. Use `TabView`, navigation containers, toolbars, search, sheets, menus, and system controls.
3. Observe automatic appearance.
4. Remove conflicting custom backgrounds.
5. Add custom glass only to remaining high-value custom controls.

## Basic Effect

Apply layout before the effect:

```swift
if #available(iOS 26, *) {
    Label("Add entry", systemImage: "plus")
        .font(.headline)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .glassEffect(.regular.interactive(), in: .capsule)
}
```

The default effect uses regular glass and the framework's default glass shape, which is capsule-like.
Specify a shape when the component geometry requires it.

## Modifier Order

Preferred:

```swift
content
    .font(.headline)
    .foregroundStyle(.primary)
    .padding()
    .glassEffect(.regular, in: .rect(cornerRadius: 18))
```

The effect should see the final layout/shape. Apply semantic/accessibility modifiers according to
their behavior, but do not put padding after glass and then wonder why the surface is too small.

## Buttons

Prefer button styles for buttons:

```swift
Button("Add entry", systemImage: "plus", action: addEntry)
    .buttonStyle(.glass)

Button("Save", action: save)
    .buttonStyle(.glassProminent)
```

Use the raw effect when a custom control surface genuinely requires custom shape/tint behavior.
Never replace a `Button` with `onTapGesture` just to style it.

## Grouping

Use one container for nearby custom glass:

```swift
@available(iOS 26.0, *)
struct PlaybackControls: View {
    var body: some View {
        GlassEffectContainer(spacing: 12) {
            HStack(spacing: 12) {
                Button("Previous", systemImage: "backward.fill") {}
                    .buttonStyle(.glass)
                Button("Play", systemImage: "play.fill") {}
                    .buttonStyle(.glassProminent)
                Button("Next", systemImage: "forward.fill") {}
                    .buttonStyle(.glass)
            }
        }
    }
}
```

Container spacing controls when effects begin to blend; layout spacing controls view placement.
Start with related values, then inspect the actual result. Do not nest containers without a distinct
sampling/grouping reason.

## Tint and Interactivity

```swift
.glassEffect(.regular.tint(.accentColor).interactive(), in: .circle)
```

- Tint indicates hierarchy or meaning.
- `.interactive()` indicates the element responds to touch/pointer.
- Static labels do not get `.interactive()`.
- Prefer semantic tint and test it across content and accessibility settings.

## Morphing

Use stable IDs inside the same namespace and container:

```swift
@available(iOS 26.0, *)
struct ExpandingControl: View {
    @Namespace private var glassNamespace
    @State private var expanded = false

    var body: some View {
        GlassEffectContainer(spacing: 12) {
            Group {
                if expanded {
                    ExpandedActions(onCollapse: toggle)
                        .glassEffect(.regular, in: .capsule)
                        .glassEffectID("actions", in: glassNamespace)
                } else {
                    Button("More", systemImage: "ellipsis", action: toggle)
                        .labelStyle(.iconOnly)
                        .padding(12)
                        .glassEffect(.regular.interactive(), in: .circle)
                        .glassEffectID("actions", in: glassNamespace)
                }
            }
        }
        .animation(.smooth, value: expanded)
    }

    private func toggle() {
        expanded.toggle()
    }
}
```

The two states must represent the same conceptual control. Use `glassEffectUnion` when multiple
effect shapes should contribute to one union, and `glassEffectTransition` only when the default
transition does not communicate the intended relationship. Reopen Apple docs for exact signatures.

## Availability Boundary

Keep the unavailable type inside an available declaration:

```swift
struct PrimaryAction: View {
    var body: some View {
        if #available(iOS 26, *) {
            GlassPrimaryAction()
        } else {
            LegacyPrimaryAction()
        }
    }
}

@available(iOS 26.0, *)
private struct GlassPrimaryAction: View {
    var body: some View {
        Button("Create", action: create)
            .buttonStyle(.glassProminent)
    }

    private func create() {}
}

private struct LegacyPrimaryAction: View {
    var body: some View {
        Button("Create", action: create)
            .buttonStyle(.borderedProminent)
    }

    private func create() {}
}
```

This isolates new types and makes both branches previewable.

## Fallbacks

Fallback by semantic role:

| iOS 26+ | Earlier system behavior |
|---|---|
| Glass primary button | `.borderedProminent` |
| Glass secondary button | `.bordered` |
| Custom floating glass cluster | Standard material container with Buttons |
| Morphing glass control | Normal transition or matched geometry if justified |
| Automatic glass toolbar/sheet | Earlier system toolbar/sheet appearance |

Do not attempt to recreate Liquid Glass optics with a custom blur.

## Review Checklist

- New API types are isolated behind availability.
- System component could not solve the need more simply.
- Layout modifiers precede `.glassEffect`.
- Interactive surfaces use `Button` or another semantic control.
- `.interactive()` matches actual interaction.
- Nearby effects share an appropriate container.
- IDs and namespace are stable for morphs.
- Tint communicates hierarchy.
- No content card or background uses glass.
- Fallback preserves action and accessibility.
- Light/dark, varied backgrounds, accessibility settings, scrolling, and motion were inspected.
