# GitHub Case Studies

## Use When

Looking for production architecture, compatibility, or failure evidence after reading Apple sources.
These repositories illustrate decisions; they do not override current Apple guidance.

## Production Applications

### Jellyfin/Swiftfin

[Repository](https://github.com/jellyfin/Swiftfin)

Observed lesson: a large SwiftUI codebase can introduce native glass behind runtime availability
while retaining a complete legacy button implementation. The relevant pattern preserves `Button`
semantics in both branches rather than styling an arbitrary gesture target.

Use the lesson for availability and semantic continuity. Do not generalize one component's tint or
shape to unrelated apps.

### sozercan/kaset

[Repository](https://github.com/sozercan/kaset)

Observed lessons:

- Documents a functional-layer/content-layer rule.
- Uses platform-native glass for a floating player and material fallbacks on older macOS.
- Uses `.materialize` for appearing panels.
- Calls out glass-on-glass avoidance and system sidebar behavior.
- Maintains centralized animation/accessibility patterns and UI identifiers.

The repository is useful because the design rationale is documented. Verify its actual code and
current target before transplanting any pattern.

## Native Example Collections

### GetStream/awesome-liquid-glass

[Repository](https://github.com/GetStream/awesome-liquid-glass)

Useful for discovering morph, menu, slider, tab, and toolbar possibilities. It is a gallery, not a
production framework, and no license was surfaced in the inspected repository metadata. Treat code
as inspection-only until licensing is confirmed.

### mertozseven/LiquidGlassSwiftUI

[Repository](https://github.com/mertozseven/LiquidGlassSwiftUI)

Small example of `GlassEffectContainer`, stable identities, an expanding control cluster, and
symbol replacement. Useful for composition study; insufficient as evidence of broad production
quality. Licensing was not clearly surfaced during inspection.

### noppefoxwolf/MergeableView

[Repository](https://github.com/noppefoxwolf/MergeableView)

An MIT package that turns drag proximity into a domain event while native glass communicates the
merge. The reusable lesson is to separate data mutation (“merge these tokens”) from the material
animation and preserve stable item identity.

## Compatibility and Abstraction

### superwall/iOS-Backports

[Repository](https://github.com/superwall/iOS-Backports)

Shows centralized `.backport` wrappers for platform-26 modifiers. The benefit is readable call
sites; the risk is creating an abstraction that appears to promise unavailable behavior. Document
fallback semantics and review dependency value before adoption.

### rryam/LiquidGlasKit

[Repository](https://github.com/rryam/LiquidGlasKit)

Shows a Swift package offering native effects on platform 26 and simpler older-system fallbacks,
with tests and active maintenance at research time. Useful for package organization and fallback
thinking; its wrappers are not automatically preferable to project-local code.

## Custom Rendering and Risk

### BarredEwe/LiquidGlass

[Repository](https://github.com/BarredEwe/LiquidGlass)

Custom Metal implementation with continuous, once, and manual update modes. Its most transferable
lesson is update-budget control: a custom optical effect should not continuously render when the
captured background is static. It is an approximation, not native system glass.

### DnV1eX/LiquidGlassKit

[Repository](https://github.com/DnV1eX/LiquidGlassKit)

Explores Metal refraction, background capture, custom switches/sliders, and native-like factories.
It also exposes the risks this skill must catch: private/internal classes, capture techniques that
change across point releases, incomplete TODOs, and installation details that need verification.
Use as a cautionary architecture study, not the default recommendation.

### ryanashcraft/FabBar

[Repository](https://github.com/ryanashcraft/FabBar)

Explicitly rejects lying about a search tab's semantics, which is a strong design decision. It then
uses internal `UISegmentedControl` hierarchy manipulation and clearly documents brittleness. The
lesson is twofold: preserve semantics, and disclose when a visual workaround introduces unsupported
maintenance risk.

## Evaluation Questions for Any Repository

- Does it use public native APIs or imitate them?
- Does it preserve semantic controls and accessibility?
- Are availability and fallback behavior explicit?
- Does it distinguish material grouping, union, and transition identity correctly?
- Are performance claims measured and scoped?
- Is the relevant code licensed for reuse?
- Is the repository maintained for the target SDK/OS point release?
- Are examples isolated demonstrations or production paths?

## Do Not Copy Popularity

Stars reflect interest, timing, and visibility. They do not establish Apple design correctness,
App Store safety, accessibility, or performance. Use stars to find material; use evidence to select
patterns.
