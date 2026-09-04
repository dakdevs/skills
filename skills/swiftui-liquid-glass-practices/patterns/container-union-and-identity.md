# Pattern: Container, Union, and Transition Identity

## Problem Shape

Several Liquid Glass elements need coherent sampling, permanent grouping, or a morph as views enter
and leave the hierarchy. These three needs use related but different primitives.

## Decision Table

| Question | Yes | No |
|---|---|---|
| Are several glass effects simultaneously nearby or interacting? | Put the meaningful group in one `GlassEffectContainer` | Keep a single independent effect simple |
| Should compatible participants be one surface at rest? | Give them one `glassEffectUnion` ID and namespace | Keep them separate |
| Does an effect enter or leave an animated hierarchy? | Give each effect a stable `glassEffectID` and choose a transition | Do not add transition identity ritualistically |
| Is the appearing effect spatially related to nearby glass? | Start with `.matchedGeometry` | Use `.materialize` or a non-glass transition |

## Canonical Composition

```swift
struct ExpandingToolCluster: View {
    @State private var isExpanded = false
    @Namespace private var glassNamespace

    var body: some View {
        GlassEffectContainer(spacing: 16) {
            HStack(spacing: 12) {
                Button {
                    withAnimation(.smooth) {
                        isExpanded.toggle()
                    }
                } label: {
                    Image(systemName: isExpanded ? "xmark" : "ellipsis")
                        .frame(width: 44, height: 44)
                }
                .buttonStyle(.glass)
                .glassEffectID("toggle", in: glassNamespace)

                if isExpanded {
                    Button(action: share) {
                        Image(systemName: "square.and.arrow.up")
                            .frame(width: 44, height: 44)
                    }
                    .buttonStyle(.glass)
                    .glassEffectID("share", in: glassNamespace)
                    .glassEffectTransition(.matchedGeometry)
                }
            }
        }
    }

    private func share() {}
}
```

The distinct IDs identify distinct effects. Their container geometry and animated insertion create
the morph relationship.

## Union Variant

Use a shared union only when separate view geometry should contribute to one material surface:

```swift
@Namespace private var glassNamespace

GlassEffectContainer(spacing: 8) {
    HStack(spacing: 8) {
        ForEach(actions) { action in
            action.label
                .padding(10)
                .glassEffect()
                .glassEffectUnion(id: "transport", namespace: glassNamespace)
        }
    }
}
```

All participants in the `transport` union must intentionally read as one control group. Do not
reuse this shared ID as a recipe for independent appearing controls.

## Spacing Procedure

1. Lay out both states without a container.
2. Measure or reason about nearest-edge distances during the transition.
3. Choose container spacing so interaction begins at the intended distance.
4. Confirm resting state does not merge unless desired.
5. Test Dynamic Type and localization because geometry can change.

## Verification

- Distinct effects have distinct transition identities.
- Union participants share one union ID only when one resting surface is intended.
- No unrelated glass is inside the container.
- Insert/remove occurs inside the animated transaction.
- Rapid toggles do not duplicate or orphan controls.
- Reduce Motion preserves comprehensible state change.
- The effect is smooth on device.

## Failure Modes

- One global namespace and repeated string ID across unrelated screens.
- A container wraps an entire screen “for performance.”
- Container spacing copied from a tutorial without matching actual layout.
- Union used to force a morph between semantically unrelated views.
- Animating opacity while expecting `glassEffectID` to create a hierarchy transition.
