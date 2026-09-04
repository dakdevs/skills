# Pattern: Morphing Presentations

## Problem Shape

A control opens a sheet, detail, menu, popover, or action surface, and a source-destination
transition can make the relationship clearer.

## Core Idea

Prefer the system presentation and its built-in behavior. Add an explicit source-destination
transition only when the source is stable, the destination is directly related, and the transition
survives accessibility and cancellation.

## Decision Rules

| Presentation | Preferred behavior |
|---|---|
| Menu/popover from a standard control | Let the system provide its origin behavior |
| Confirmation dialog/action sheet | Anchor to the action source and preserve nonmodal expectations |
| Partial-height sheet from toolbar action | Consider matched source plus zoom destination |
| Unrelated modal launched from background event | Do not invent a source morph |
| Custom control cluster expands in place | Use glass container/identity workflow, not navigation transition API |

## Procedure

1. Implement the sheet/detail using standard SwiftUI presentation.
2. Remove custom material backgrounds and verify native appearance.
3. Put the presenting toolbar in `NavigationStack` or `NavigationSplitView` where required.
4. Create a namespace scoped to the presenting feature.
5. Mark the source with a stable ID.
6. Apply the matching navigation transition to the destination.
7. Test dismissal, cancellation, repeated presentation, restoration, and device rotation/window resize.
8. Verify Reduced Motion behavior.

## Distinguish the APIs

- `matchedTransitionSource`/navigation transition connects navigation or presentation endpoints.
- `glassEffectID`/`GlassEffectContainer` coordinates custom glass effects inside a container.
- `glassEffectUnion` creates one material surface from compatible participants.

Do not mix these merely because each uses an ID and namespace.

## Verification

- The source remains visible/stable when presentation begins.
- The destination logically belongs to the source action.
- The sheet is still usable at all supported detents.
- Form/navigation backgrounds do not accidentally mask or overexpose the sheet.
- VoiceOver focus moves to the destination and returns sensibly.
- Reduced Motion does not make the presentation confusing.
