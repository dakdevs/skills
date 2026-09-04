# Native SwiftUI API Reference

## Use When

Implementing or reviewing explicit custom Liquid Glass. Confirm signatures in the active SDK before
shipping because this reference records the 2026 research snapshot.

## `View.glassEffect(_:in:)`

Purpose: render a Liquid Glass shape behind a view and apply foreground glass effects.

```swift
nonisolated func glassEffect(
    _ glass: Glass = .regular,
    in shape: some Shape = DefaultGlassEffectShape()
) -> some View
```

Key semantics:

- Default glass is `.regular`.
- Default shape is effectively the system's capsule-like default glass shape.
- The effect is anchored to the modified view's bounds, including earlier padding.
- Apply it after modifiers that determine content appearance and bounds.
- One independent effect does not require a container merely to exist.

## `GlassEffectContainer`

Purpose: render multiple contributed glass shapes together, improve combined rendering, and enable
their shapes to interact or morph.

Key semantics:

- Container spacing controls when shapes begin influencing and blending with each other.
- Larger container spacing makes interaction begin at greater separation.
- If container spacing exceeds inner layout separation, shapes may blend at rest.
- Scope the container to a meaningful functional group.
- More containers are not automatically better; each creates another effect region.

## `View.glassEffectUnion(id:namespace:)`

Purpose: cause compatible glass effects with a shared union identifier to contribute to one
material shape, including at rest.

```swift
func glassEffectUnion(
    id: (some Hashable & Sendable)?,
    namespace: Namespace.ID
) -> some View
```

Union requirements and implications:

- Participants use the same union ID and namespace.
- Compatible shape and glass variant are required for a single result.
- Use for a deliberate shared surface, not merely because views are adjacent.
- A union ID is not the same concept as a transition identity.

## `View.glassEffectID(_:in:)`

Purpose: assign transition identity to glass effects defined within a view.

```swift
func glassEffectID(
    _ id: (some Hashable & Sendable)?,
    in namespace: Namespace.ID
) -> some View
```

Use with:

- A `GlassEffectContainer`.
- Glass effects that enter or leave the hierarchy.
- Stable, meaningful identifiers.
- An animated state mutation.

Apple's canonical examples assign distinct IDs to distinct effects. Container geometry and spacing
coordinate the morph. Do not teach “same ID on both views” as a universal Liquid Glass rule.

## `View.glassEffectTransition(_:)`

Purpose: configure the change applied when a glass effect is added to or removed from the view
hierarchy.

### `.matchedGeometry`

Use when the added/removed effect is spatially related to nearby glass in the container. The system
derives more than an opacity transition.

### `.materialize`

Use for a simpler appearance/disappearance, custom transition choreography, or effects farther
apart than the container's intended interaction spacing.

## Glass Button Styles

Use built-in button styles for ordinary actions:

```swift
Button("Add", systemImage: "plus", action: add)
    .buttonStyle(.glass)

Button("Continue", action: continueFlow)
    .buttonStyle(.glassProminent)
```

This preserves native button behavior, state handling, artwork, and platform adaptation better than
placing a raw effect behind label content.

## Related Structural APIs

These are not all Liquid Glass effects, but they are often the correct adoption tools:

- `ToolbarSpacer` for meaningful toolbar groups.
- `sharedBackgroundVisibility` for exceptional toolbar content that should not share a background.
- `scrollEdgeEffectStyle` and `safeAreaBar` for legibility around scrolling content.
- `backgroundExtensionEffect` for visually extending adjacent content behind sidebars/inspectors.
- `tabBarMinimizeBehavior` and `tabViewBottomAccessory` for adaptable tab experiences.
- Semantic `Tab(role: .search)` and `searchable` for search.
- `matchedTransitionSource` plus a navigation transition for source-destination presentations.

Check each API's exact platform availability separately.

## Modifier Ordering Pattern

```swift
Label("Record", systemImage: "mic.fill")
    .font(.headline)
    .foregroundStyle(.primary)
    .padding(.horizontal, 18)
    .padding(.vertical, 12)
    .glassEffect(.regular.interactive(), in: .capsule)
    .accessibilityHint("Starts a new recording")
```

The label, typography, foreground, and padding establish what the effect captures. Accessibility
modifiers can follow because they do not alter the glass geometry.

## API Review Questions

- Is the API native for every compiled target?
- Is the chosen primitive the smallest one that expresses the behavior?
- Are geometry and appearance modifiers before the effect?
- Are union IDs and transition identities used for their documented purposes?
- Is a system button style available instead of a custom effect?
- Is the state mutation actually animated?

## Failure Modes

- Applying glass before padding and then compensating with extra backgrounds.
- Wrapping one independent effect in its own container by habit.
- Sharing a transition identity because a union example used a shared ID.
- Using raw `.glassEffect()` on ordinary buttons instead of a native button style.
- Assuming every related structural API has identical platform availability.

## Verification

Type-check representative native, morphing, union, and fallback examples against the current SDK.
Then validate visual behavior on the target OS because successful compilation cannot establish
sampling, morphing, accessibility adaptation, or device rendering correctness.
