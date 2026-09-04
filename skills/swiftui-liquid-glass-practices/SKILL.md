---
name: swiftui-liquid-glass-practices
description: "CRITICAL: Use when adapting, implementing, reviewing, migrating, or debugging SwiftUI interfaces for Apple Liquid Glass. Triggers on: Liquid Glass, glassEffect, GlassEffectContainer, glassEffectID, glassEffectUnion, glassEffectTransition, glass button, iOS 26 UI, macOS 26 UI, Tahoe UI, morphing glass, glass toolbar, glass sheet, tab bar modernization, or requests to make an Apple-platform interface feel native to the current design system."
globs: ["**/*.swift", "**/*.xcodeproj/**", "**/Package.swift"]
metadata:
  origin_title: "Apple Liquid Glass documentation, Human Interface Guidelines, and WWDC sessions"
  origin_author: "Apple Inc., supplemented by attributed production and independent sources"
  origin_url: "https://developer.apple.com/documentation/TechnologyOverviews/liquid-glass"
  origin_note: "Authored operational synthesis based on credited sources; not a verbatim copy."
---

# SwiftUI Liquid Glass Practices

> **Version:** 1.0.0 | **Last Updated:** 2026-09-03
>
> **Origin credit:** Derived primarily from Apple's current Liquid Glass documentation, Human
> Interface Guidelines, WWDC sessions, and sample code. Production repositories, specialist
> articles, and research are supporting evidence. See `source.md`.

## Intent

Equip an agent to adapt a real SwiftUI interface to Liquid Glass as Apple intends: content remains
the focus; controls and navigation form a restrained functional layer; system components do most
of the work; custom effects communicate interaction or state; and the result remains legible,
accessible, performant, and native across supported platforms.

This is not a glassmorphism recipe. Do not begin by adding `.glassEffect()` to cards. Begin by
understanding the app's hierarchy, rebuilding with the current SDK, and removing custom styling
that prevents SwiftUI from adopting the system design.

## Governing Rule

**Structure first, system adoption second, custom glass last.**

When guidance conflicts, use this priority:

1. Current Apple API documentation for availability and API behavior.
2. Current Apple HIG and design sessions for intended use.
3. The project's established architecture for organization and naming.
4. Measured production evidence for performance and edge cases.
5. Community examples only as hypotheses to verify.

## Required First Actions

1. Identify target platforms, deployment targets, Xcode/SDK version, and affected screens.
2. Inspect navigation, toolbars, sheets, menus, controls, backgrounds, safe areas, and accessibility.
3. Classify every candidate surface as content, system functional UI, or custom functional UI.
4. Read the route below that matches the request.
5. State what should stay non-glass before proposing any custom effect.

## Document Map

| File | Purpose |
|---|---|
| `source.md` | Provenance, adaptation scope, limitations, and copyright handling |
| `source-map.md` | Claim-to-source ledger and source quality notes |
| `architecture.md` | Apple-intended operating model and invariants |
| `workflows/adapt-existing-interface.md` | End-to-end migration and adaptation workflow |
| `workflows/implement-custom-glass.md` | Native custom-control implementation workflow |
| `workflows/design-morphing-transition.md` | Purposeful container, union, identity, and transition workflow |
| `workflows/review-implementation.md` | Evidence-based review procedure |
| `workflows/diagnose-rendering-problems.md` | Systematic diagnosis for visual and animation defects |
| `references/platform-availability.md` | SDK, deployment, platform, and compatibility constraints |
| `references/native-api-reference.md` | Verified SwiftUI API semantics and modifier ordering |
| `references/variants-shapes-tint.md` | Regular/clear selection, shapes, tint, and interactivity |
| `references/navigation-toolbars-sheets.md` | System adoption for structure and presentations |
| `references/accessibility-input.md` | Accessibility, focus, pointer, touch, and testing |
| `references/performance-instruments.md` | Rendering budget and measurement workflow |
| `references/backward-compatibility.md` | Availability branches and honest fallbacks |
| `references/custom-renderers-private-api.md` | Native alternatives and experimental-risk boundaries |
| `references/github-case-studies.md` | Lessons and limitations from inspected repositories |
| `patterns/container-union-and-identity.md` | Correct distinction between composition primitives |
| `patterns/semantic-glass-controls.md` | Reusable functional-layer design pattern |
| `patterns/morphing-presentations.md` | Source-destination and hierarchy-change transitions |
| `patterns/availability-gated-fallbacks.md` | Cross-version component pattern |
| `anti-patterns/content-layer-and-glass-on-glass.md` | Misuse detection and repair |
| `anti-patterns/fake-parity-and-brittle-customization.md` | Backport, private API, and imitation hazards |
| `checks/implementation-review.md` | Final correctness checklist |
| `checks/accessibility-visual-matrix.md` | Visual and assistive-technology test matrix |
| `checks/performance-profile.md` | Instruments-based performance gate |
| `examples/interface-adaptation-walkthrough.md` | Full before/after reasoning example |
| `examples/native-morphing-control.md` | Custom morphing control example |
| `examples/sheet-transition.md` | Native sheet adaptation example |
| `examples/cross-version-component.md` | Availability and fallback example |
| `evals/evals.json` | Prompts and assertions that test applied judgment |

## Routing

| User or code signal | Read first | Then read |
|---|---|---|
| “Adapt this app/view to Liquid Glass” | `workflows/adapt-existing-interface.md` | `architecture.md`, then relevant structural reference |
| Existing UI looks over-styled or non-native | `anti-patterns/content-layer-and-glass-on-glass.md` | `workflows/adapt-existing-interface.md` |
| Add glass to a custom control | `workflows/implement-custom-glass.md` | `references/variants-shapes-tint.md` |
| Morph, merge, expand, or transform glass | `patterns/container-union-and-identity.md` | `workflows/design-morphing-transition.md` |
| Sheet, toolbar, search, tab, or sidebar | `references/navigation-toolbars-sheets.md` | `patterns/morphing-presentations.md` |
| Support older OS releases | `references/platform-availability.md` | `patterns/availability-gated-fallbacks.md` |
| Visual corruption, popping, clipping, wrong sampling | `workflows/diagnose-rendering-problems.md` | `patterns/container-union-and-identity.md` |
| Jank, heat, energy, or frame drops | `references/performance-instruments.md` | `checks/performance-profile.md` |
| Accessibility or legibility concern | `references/accessibility-input.md` | `checks/accessibility-visual-matrix.md` |
| Custom Metal renderer, backport, or private API | `references/custom-renderers-private-api.md` | `anti-patterns/fake-parity-and-brittle-customization.md` |
| Review an implementation or pull request | `workflows/review-implementation.md` | All three files in `checks/` |

## Full Adaptation Route

For a broad UI adaptation, read and apply in this order:

1. `architecture.md`
2. `workflows/adapt-existing-interface.md`
3. `references/platform-availability.md`
4. `references/navigation-toolbars-sheets.md`
5. `references/variants-shapes-tint.md`
6. `patterns/semantic-glass-controls.md`
7. `patterns/container-union-and-identity.md` if custom glass is still justified
8. `references/accessibility-input.md`
9. `references/performance-instruments.md`
10. `checks/implementation-review.md`
11. `checks/accessibility-visual-matrix.md`
12. `checks/performance-profile.md`

## Decision Sequence

For each proposed change, answer in order:

1. **Purpose:** What user task or relationship does this change clarify?
2. **Layer:** Is this content or functional UI?
3. **System primitive:** Can a standard SwiftUI component express it?
4. **Removal:** Which legacy background, overlay, or fixed metric should be removed?
5. **Custom need:** If system adoption is insufficient, why is custom glass necessary?
6. **Composition:** Is this one effect, a container, a union, or a hierarchy transition?
7. **Adaptation:** How does it behave on every target platform and accessibility setting?
8. **Evidence:** How will the change be visually, semantically, and performance verified?

If questions 1–3 do not justify custom glass, do not add it.

## Non-Negotiable Invariants

- Content remains visually primary.
- Liquid Glass marks functional UI, not arbitrary decoration.
- Standard controls and containers are preferred over replicas.
- There is no glass-on-glass layering.
- Tint carries meaning or prominence; it is not ambient decoration.
- Interactive glass is attached only to interactive or focusable elements.
- Morphing communicates continuity between states or source and destination.
- `glassEffectUnion` IDs and `glassEffectID` identities are not conflated.
- Fallbacks preserve role, hierarchy, hit targets, and semantics—not claimed optical parity.
- Accessibility settings produce a usable interface, not merely a different rendering.
- Performance claims come from measurement on representative hardware.
- Private APIs and internal hierarchy manipulation are never silently introduced.

## Output Contract

For adaptation or implementation requests, produce:

1. **UI diagnosis:** current hierarchy, conflicts, and platform constraints.
2. **Keep/remove/change map:** explicitly include elements that should remain non-glass.
3. **Adaptation plan:** system-first changes before custom effects.
4. **Implementation:** scoped code changes with availability behavior.
5. **Verification:** visual, accessibility, interaction, and performance evidence.
6. **Residual risks:** SDK bugs, platform differences, or unmeasured behavior.

For reviews, report only actionable findings, ordered by user impact. Cite the violated invariant,
identify the affected code, and recommend the smallest native repair.

## Refusal and Escalation

Pause and explain the tradeoff when a request requires private API, falsifying semantic roles (for
example, presenting an action as a search tab), removing accessibility adaptation, or claiming a
custom blur is native Liquid Glass. Offer the nearest public, semantic alternative.

## Completion Gate

Do not call an adaptation complete until:

- The system-first structural pass is finished.
- Custom glass has a documented functional purpose.
- Supported platforms and fallbacks are explicit.
- Light/dark and accessibility configurations have been checked.
- Morphing and sampling behavior are correct.
- Representative performance has been measured or the lack of measurement is disclosed.
