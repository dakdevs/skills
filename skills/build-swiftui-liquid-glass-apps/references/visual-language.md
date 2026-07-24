# Visual Language

## Contents

- [Goal](#goal)
- [Tokens by Meaning](#tokens-by-meaning)
- [Typography](#typography)
- [Color](#color)
- [SF Symbols and Icons](#sf-symbols-and-icons)
- [Imagery](#imagery)
- [Shape and Corner Geometry](#shape-and-corner-geometry)
- [Spacing and Density](#spacing-and-density)
- [Copy](#copy)
- [Visual Review Questions](#visual-review-questions)

## Goal

Create a recognizable product without replacing native behavior. Brand should live in content,
language, imagery, rhythm, and a small number of semantic accents.

## Tokens by Meaning

Define only repeated decisions:

```swift
enum AppSpacing {
    static let compact: CGFloat = 8
    static let standard: CGFloat = 16
    static let section: CGFloat = 24
}

enum AppMotion {
    static let response = 0.32
    static let damping = 0.86
}
```

Do not wrap every SwiftUI modifier in a design-system API. Native semantic styles are already
tokens that adapt.

## Typography

- Use semantic text styles.
- Establish hierarchy through role, weight, spacing, and content, not many custom sizes.
- Use `@ScaledMetric` for custom measurements tied to text.
- Avoid fixed text heights.
- Test accessibility sizes and Bold Text.
- Use monospaced digits for rapidly changing aligned numbers when useful.
- Keep custom fonts optional unless brand requires them; ensure they scale.

## Color

- Use semantic foreground/background styles.
- Define brand colors in asset catalogs with light/dark variants when needed.
- Use tint for interactive hierarchy.
- Do not rely on color alone.
- Test Increase Contrast and different content behind glass.
- Avoid arbitrary translucent color overlays that fight Liquid Glass adaptation.

## SF Symbols and Icons

- Prefer familiar symbols for standard actions.
- Pair ambiguous symbols with text.
- Give icon-only buttons accessible labels.
- Use rendering modes deliberately.
- Keep toolbar symbols mostly monochrome.
- Avoid mixing unrelated visual weights.
- Confirm the symbol exists for the deployment target.

## Imagery

- Use imagery that advances the product, not generic decoration.
- Provide meaningful accessibility descriptions or mark decorative images hidden.
- Crop responsively.
- Downsample large assets for display.
- Provide placeholders and failure states.
- When using clear glass over media, test the full image range.

## Shape and Corner Geometry

- Let system controls own their shape.
- Use a small family of container radii for content surfaces.
- Relate nested radii and padding visually; do not assign random values.
- Do not force card geometry onto every section.
- Custom glass shape must express the control boundary.

## Spacing and Density

- Use rhythm, not a rigid universal grid.
- Start with system defaults and a small scale.
- Group by proximity before adding dividers or backgrounds.
- Increase density on larger screens by adding useful context, not merely shrinking controls.
- Ensure controls retain comfortable targets at all text sizes.

## Copy

- Use direct verbs for actions.
- Put the useful distinction first.
- Avoid technical errors and placeholder prose.
- Keep capitalization consistent with platform conventions.
- Localize user-visible strings and add translator context for ambiguous terms.
- Test strings that expand substantially.

## Liquid Glass Relationship

Brand belongs primarily in content. Use glass tint for one meaningful hierarchy signal, not as the
main carrier of brand color. Let the material adapt to the content beneath it.

## Visual Review Questions

- Is the primary task visible before decoration?
- Does the type hierarchy survive without color?
- Are system controls recognizable?
- Are repeated values actually consistent?
- Does the product feel specific because of meaningful content and language?
- Is custom imagery performant and accessible?
- Is glass sparse enough to make the content feel primary?
