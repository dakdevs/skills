# Variants, Shapes, Tint, and Interactivity

## Use When

Choosing the visual configuration of a justified custom functional element.

## Variant Decision

### Regular

Use by default. Regular glass adapts background luminosity and blur to support foreground
legibility. It is the safer choice for controls with text, mixed backgrounds, popovers, sidebars,
and unfamiliar content.

### Clear

Use only when all of these are true:

- The surface floats above visually rich media such as a photo or video.
- Preserving background detail materially improves the experience.
- Foreground labels are bold/simple enough to remain legible.
- Bright and detailed background cases are tested.
- A dimming treatment is acceptable when needed.

Apple's HIG suggests considering a dark dimming layer around 35% opacity behind clear glass on
bright content. Treat that as a starting point tied to the documented context, not a universal
overlay recipe.

Do not mix regular and clear variants within one functional group merely for variety.

## Shape Decision

| Element | Starting shape | Rationale |
|---|---|---|
| Compact text/icon control | Capsule | Accommodates dynamic label width and finger-friendly form |
| Isolated icon action | Circle | Clear single target when label is available semantically |
| Larger tool panel | Continuous rounded rectangle | Supports multiple controls without excessive pill geometry |
| Control near rounded sheet/window edge | Concentric/system-derived rectangle | Aligns inner and outer corner centers |

The glass shape should match the visual and interactive region. Do not create an oversized glass
halo around a smaller hit target or vice versa.

## Tint Decision

Tint must answer “why this color?”

Good reasons:

- Primary or next action.
- Success, warning, or destructive meaning with adequate redundant cues.
- A selected state that needs stronger emphasis.
- App accent applied consistently and legibly.

Weak reasons:

- Matching background colors.
- Making every toolbar group colorful.
- Demonstrating that tint exists.
- Encoding state by color alone.

Prefer system colors or custom colors with light, dark, and increased-contrast variants.

## Interactivity Decision

Add `.interactive()` when the glass surface itself is a touch, pointer, or focus target. It enables
native responsive behavior such as scale, bounce, and shimmer.

Do not add it to:

- Static labels.
- Decorative badges with no action.
- A parent panel when only child controls are interactive.
- Content cards that use separate semantic controls.

An interactive appearance without an action creates a false affordance.

## Background Stress Test

Test each custom surface over:

1. Near-white flat content.
2. Near-black content.
3. High-saturation imagery.
4. Fine text or detailed patterns.
5. Moving video or animated content.
6. The actual worst-case app content.

Check normal, pressed/hovered/focused, disabled, and selected states. If the effect requires a
handpicked background to work, the configuration is not robust.

## Verification Checklist

- [ ] Regular was considered first.
- [ ] Clear satisfies the media and legibility criteria.
- [ ] Shape matches role, size, and hit region.
- [ ] Nearby shapes feel related and harmonious.
- [ ] Tint has semantic meaning and adequate contrast.
- [ ] State is not communicated by color alone.
- [ ] Interactive treatment matches actual interaction.
- [ ] Background stress test passes.
