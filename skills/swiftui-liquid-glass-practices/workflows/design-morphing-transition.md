# Workflow: Design a Purposeful Liquid Glass Morph

## Use When

A custom glass control expands, collapses, inserts, removes, merges, separates, or presents related
content, and motion can clarify continuity.

## First Question

What relationship does the morph communicate?

- **Same control, changed state:** compact actions expand into a control cluster.
- **Source to destination:** a toolbar action opens a related sheet or detail.
- **Grouped material:** separate compatible controls become one functional surface.
- **No meaningful relationship:** do not morph; use a simpler transition.

## Select the Correct Primitive

| Desired behavior | Primitive |
|---|---|
| Nearby effects sample and blend coherently | `GlassEffectContainer` |
| Several effects remain one shape at rest | `glassEffectUnion(id:namespace:)` |
| Effect appears/disappears through hierarchy change | `glassEffectID(_:in:)` |
| Nearby insertion/removal derives geometry from container peers | `.matchedGeometry` glass transition |
| Distant or intentionally independent appearance | `.materialize` glass transition |
| System sheet/detail originates from a control | Matched transition source plus navigation zoom transition |

## Procedure

1. Draw the before and after states without animation.
2. Verify both states are understandable independently.
3. Define the smallest shared `GlassEffectContainer`.
4. Set stack spacing based on layout; set container spacing based on when effects should interact.
5. Give each independently transitioning effect a stable identity in one namespace.
6. Use a shared **union** ID only for effects that should form one material shape.
7. Insert/remove the relevant view as state changes.
8. Animate the state mutation.
9. Choose `.matchedGeometry` or `.materialize` based on proximity and intended relationship.
10. Test interruption, rapid toggling, state restoration, Reduce Motion, and layout changes.

## Identity Rules

- IDs must be stable across the intended transition.
- Distinct effects normally have distinct `glassEffectID` values.
- A shared `glassEffectUnion` ID means “render these compatible effects as one shape.”
- Do not reuse IDs across unrelated controls merely to force a visual effect.
- Namespace scope should match the component or transition domain, not the entire app by default.

## Motion Rules

- Motion duration and spring behavior should follow the interaction, not showcase the material.
- Avoid chaining a glass morph, scale effect, symbol effect, and layout transition unless each adds
  distinct information.
- The final state must not depend on motion for discoverability.
- Under Reduce Motion, preserve state change and relationship with a lower-motion alternative.

## Verification

- Does the material remain continuous rather than pop or crossfade unexpectedly?
- Do shapes begin merging at the intended distance?
- Does the layout remain stable when the optional view disappears?
- Does rapid input leave state and visuals synchronized?
- Are source and destination semantics announced correctly?
- Does Reduce Motion avoid unnecessary elastic movement?
- Does the transition stay smooth on representative hardware?

## Common Misdiagnoses

| Symptom | Check first |
|---|---|
| No morph occurs | Was a glass view actually inserted/removed inside the animated transaction? |
| Wrong shapes merge | Container scope, spacing, and union IDs |
| Effect fades only | Transition type and whether identity/container requirements are met |
| Shadow or material pops | Duplicate effects, modifier order, or OS-specific rendering defect |
| Content becomes unreadable mid-transition | Variant, tint, background, and simultaneous foreground animation |
