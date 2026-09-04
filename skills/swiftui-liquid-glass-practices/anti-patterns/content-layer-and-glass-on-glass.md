# Anti-Patterns: Content-Layer Glass and Glass-on-Glass

## Use When

An interface looks busy, illegible, overly translucent, or “glassy everywhere,” or when several
materials overlap unpredictably.

## Content-Layer Glass

### Smell

Repeated cards, list rows, document sections, photos, or background decoration each receive
`.glassEffect()`.

### Why It Fails

- Blurs the distinction between content and controls.
- Competes with the content Liquid Glass is meant to reveal.
- Creates false affordances, especially if `.interactive()` is also applied.
- Increases rendering cost and contrast variability.

### Repair

1. Remove explicit glass from content.
2. Use spacing, typography, dividers, standard materials, or content-specific visual design.
3. Keep glass only on the functional controls operating above that content.

### Legitimate Exception Test

A content-layer element may temporarily take on functional glass behavior during direct
interaction, as system sliders/toggles can. The exception must be transient and communicate the
interaction—not decorate the resting content.

## Glass-on-Glass

### Smell

- A `.glass` button sits inside a parent that already has one broad `.glassEffect()`.
- Independent glass panels overlap.
- A custom material/blur is placed behind a system glass toolbar or sheet.

### Why It Fails

Glass cannot coherently sample another independent glass layer. The result can become cluttered,
flat, opaque, or visually inconsistent.

### Repair

- Decide whether the group is one surface with ordinary child controls or several peer effects in
  one `GlassEffectContainer`.
- Remove redundant materials and system-bar backgrounds.
- Use a union only when one resting surface is intended.

## Over-Grouping

One container around the entire screen is not a universal repair. It can cause unrelated effects to
interact and makes spacing semantics meaningless. Scope containers to one functional group.

## Review Questions

- What is the content?
- What operates on it?
- Which layer owns each material?
- Is any control receiving glass twice?
- Can system structure replace the custom surface?
- What remains understandable with transparency reduced?

## Verification

After repair, compare visual hierarchy over the busiest real content. A person should identify the
primary content and available actions without relying on motion or color.
