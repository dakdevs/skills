# Source Map and Claim Ledger

## Purpose

Use this ledger when refreshing the skill or challenging a material claim. Operational files cite
this map rather than duplicating research history.

| Claim family | Primary evidence | Supporting or adversarial evidence | Local destinations | Confidence |
|---|---|---|---|---|
| Liquid Glass is a functional layer above content | Apple HIG Materials; Meet Liquid Glass | NN/G usability critique; shipping retrospective | `architecture.md`, content-layer anti-pattern | High |
| Standard SwiftUI components should lead adoption | Adopting Liquid Glass; WWDC25 session 323 | Swiftfin and Kaset | adaptation workflow; navigation reference | High |
| Regular/clear variants have semantic contexts | Apple HIG Materials | Production visual reports | variants reference | High |
| Multiple glass effects should use a container | Applying Liquid Glass; `GlassEffectContainer` API | Kaset; native example repos | container pattern; performance reference | High |
| Modifier order affects captured content | Applying Liquid Glass | Repository syntax corrections | native API reference | High |
| Union and transition identity are different concepts | `glassEffectUnion`; `glassEffectID`; Apple sample | Community tutorials reveal recurring confusion | container pattern; evals | High |
| Morphing requires animated hierarchy/geometry change | Applying Liquid Glass; transition API | Nil Coalescing sheet article | morphing workflow and patterns | High |
| Accessibility settings can modify glass and motion | Adopting Liquid Glass; Meet Liquid Glass; HIG Accessibility | NN/G; small usability study | accessibility reference and matrix | High |
| Too many effects/containers can degrade performance | Applying Liquid Glass; Instruments session | Metal repositories and shipping retrospective | performance reference and gate | High qualitative; no universal threshold |
| Public native API is preferred over emulation | Apple adoption guidance | DnV1eX, FabBar, BarredEwe case studies | custom-renderer reference and anti-pattern | High |
| Fallbacks should preserve semantics, not claim parity | Availability metadata; system-first guidance | Swiftfin, Kaset, Superwall, LiquidGlasKit | compatibility reference and pattern | High |
| Current API platform availability | Symbol metadata inspected 2026-09-03 | Repository requirements sometimes conflict | platform reference | High for inspected SDK generation |

## Apple Page Inventory

| Page or session | What it contributes |
|---|---|
| Liquid Glass overview | Entry point, design principles, system-first adoption |
| Adopting Liquid Glass | Migration order, background removal, controls, navigation, modals, testing |
| HIG Materials | Functional/content layers, restraint, regular/clear selection, legibility |
| Applying Liquid Glass to custom views | Effect configuration, modifier order, containers, unions, transitions, performance |
| `glassEffect` API | Default variant/shape and bounds behavior |
| `GlassEffectContainer` API | Combined rendering and spacing behavior |
| `glassEffectID` API | Transition identity semantics |
| `glassEffectUnion` API | At-rest geometry grouping semantics |
| `glassEffectTransition` API | Add/remove transition semantics |
| WWDC25 session 323 | Practical SwiftUI adoption across structure, toolbars, search, controls, custom effects |
| WWDC25 session 219 | Optical behavior, adaptivity, hierarchy, harmony, consistency, accessibility |
| WWDC25 session 356 | Cross-platform design system and structural design |
| WWDC25 session 306 | SwiftUI performance investigation with Instruments |
| Landmarks sample | First-party end-to-end application structure |

## Repository Selection Method

Repositories were discovered through GitHub search and web indexing, then screened for:

- Actual Swift/SwiftUI implementation rather than screenshots or design assets.
- Inspectable source or technical documentation.
- Relevance to native adoption, morphing, compatibility, or rendering tradeoffs.
- Maintenance recency, licensing visibility, and explicit limitations.
- Production use or a focused, teachable implementation surface.

Repositories were not selected solely by stars. High-star projects with only incidental Liquid
Glass use do not define patterns. Small repositories are retained when they expose a specific
failure or design decision unavailable elsewhere.

## Contradictions Resolved

### “Use the same ID to morph”

This wording confuses two APIs. A union ID deliberately groups compatible effects into one shape.
A glass effect ID associates transition identity; Apple examples use distinct IDs for distinct
effects and let container spacing and geometry drive the morph. The skill forbids teaching these
as interchangeable.

### “Always wrap every effect in a container”

A single independent effect does not need a container. Multiple simultaneous or interacting
effects should normally share a purposeful container. Too many containers are themselves a
performance risk. The skill teaches composition based on scope rather than ritual wrapping.

### “A material fallback is Liquid Glass”

Standard `Material` can preserve hierarchy and translucency on older platforms but does not
reproduce native refraction or dynamic system behavior. The skill calls it a semantic fallback,
not a backport with optical parity.

### “If it looks right in the simulator, it is correct”

Community evidence includes device-only rendering defects. Simulator review is useful, but the
final gate requires representative device testing for interaction and performance where risk is
material.

## Refresh Procedure

1. Recheck Apple symbol availability and signatures in the current SDK.
2. Review HIG change logs and current design sessions.
3. Revalidate any point-release workaround before retaining it.
4. Refresh repository licensing and maintenance status before copying or recommending code.
5. Update the ledger when new evidence changes a decision rule.
