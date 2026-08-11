# Audit Rubric

Use this rubric to collect evidence, not to force findings. A category may be healthy or inconclusive.

## Contents

1. [Visual-system consistency](#1-visual-system-consistency)
2. [Layout and geometry stability](#2-layout-and-geometry-stability)
3. [State and content continuity](#3-state-and-content-continuity)
4. [Interaction and input behavior](#4-interaction-and-input-behavior)
5. [Motion behavior](#5-motion-behavior)
6. [Responsive layout and overflow](#6-responsive-layout-and-overflow)
7. [Accessibility and focus](#7-accessibility-and-focus)
8. [Rendering, measurement, and first paint](#8-rendering-measurement-and-first-paint)
9. [UI regression protection](#9-ui-regression-protection)

## Evidence vocabulary

- **Fact:** Directly demonstrated by declarations, control flow, markup, configuration, or tests.
- **Source-inferred risk:** A credible runtime outcome whose final effect depends on rendering, content, environment, or user input.
- **Intentional exception:** A documented deviation with bounded scope and a reason.
- **Trend:** Two independent occurrences or one shared implementation with multiple known consumers.
- **Ownership layer:** Foundation/token, primitive, shared component, feature consumer, or regression test.

## 1. Visual-system consistency

### Inventory

- Color, typography, spacing, size, radius, border, elevation, opacity, layer, and motion tokens.
- Shared variants, state recipes, icons, control densities, and content hierarchy.
- Where raw values coexist with tokens and where one-off variants enter the system.

### Reliable source signals

- Repeated near-match literals beside an established semantic token.
- A shared component exposing inconsistent defaults or consumers overriding its invariant styles.
- State styles that change typography, borders, or spacing differently across equivalent controls.
- Documentation, tokens, and shipped primitives describing different vocabularies.

### Common false positives

- Data visualization colors, mathematical geometry, media aspect ratios, and browser-normalization values.
- A documented brand or marketing surface intentionally using a different hierarchy.
- One literal inside the token definition itself.
- A value that has no semantic reuse and does not create a user-facing inconsistency.

### Evidence standard

Cite the intended token or convention, the divergent source line, and a second occurrence or shared-consumer path before calling drift systemic. Describe the user-visible state affected; “magic number” alone is not a UI finding.

### Likely ownership

Foundation/token when the concept is missing; primitive when a shared default is wrong; consumer when a supported variant is misused.

### Runtime confirmation

Required for computed color contrast, font fallback, platform default appearance, optical alignment, and theme-specific final rendering.

## 2. Layout and geometry stability

### Inventory

- Dimensions and alignment across rest, hover, focus, selected, loading, validation, and expanded states.
- Replacement panels, accordions, disclosures, list mutations, image/media loading, overlays, and feedback banners.
- Normal-flow participation of entering and exiting elements.

### Reliable source signals

- State changes alter font metrics, border thickness, padding, intrinsic labels, or icon slots without reserved space.
- Entering and exiting replacement content can coexist in normal flow.
- Feedback or validation content is inserted above/between stable content without a reserved or overlay strategy.
- Unknown media dimensions or late layout measurements determine published geometry.

### Common false positives

- Deliberate content-driven growth in a document flow where downstream movement is expected.
- A transform animation that changes pixels but not layout geometry.
- Explicitly reserved skeleton or aspect-ratio space.
- A container-height change intentionally communicating expanded content.

### Evidence standard

Trace the state transition and name the geometry property or flow relationship that can change. Cite both state branches when possible. Label the visible magnitude as source-inferred unless measured.

### Likely ownership

Primitive for reusable state geometry; shared component for replacement slots and feedback regions; consumer for content-specific reservation.

### Runtime confirmation

Required for bounding-box movement, cumulative layout shift, font-metric effects, scroll anchoring, and content-dependent height transitions.

## 3. State and content continuity

### Inventory

- Controlled and uncontrolled state, keys, mount/unmount boundaries, route transitions, filters, tabs, pagination, form progress, and async state.
- Focus, selection, scroll, input value, expanded state, and pending/success/error identity.

### Reliable source signals

- Keys derived from position or mutable display text.
- Conditional branches replace a control or subtree when only presentation changes.
- Local state initializes from a prop but cannot follow later controlled updates.
- A pending transition clears useful content, resets focus, or allows stale completion to overwrite current state.
- Loading, empty, and error branches change the surface's identity or control placement unnecessarily.

### Common false positives

- Intentional reset after account, tenant, or security boundary changes.
- A keyed remount explicitly used to reset a completed workflow.
- Server-rendered state that is intentionally authoritative on navigation.
- Removing hidden content to prevent stale or sensitive information exposure.

### Evidence standard

Describe the state machine: trigger, prior state, transition, next state, and identity that may be lost. Cite state ownership and conditional/keyed rendering lines.

### Likely ownership

Primitive for controlled/uncontrolled contracts; shared component for transition identity; feature consumer for domain reset rules.

### Runtime confirmation

Required for race ordering, focus/scroll loss, hydration timing, rapid interruption, and browser restoration behavior.

## 4. Interaction and input behavior

### Inventory

- Native element choice, pointer and keyboard activation, touch targets, drag thresholds, dismissal, disabled/pending behavior, repeated input, and feedback location.
- Menus, dialogs, tabs, comboboxes, disclosures, sliders, switches, and custom gestures.

### Reliable source signals

- Clickable non-native elements without an equivalent keyboard contract.
- ARIA roles applied without the required composite-widget behavior.
- Pointer-only hover or gesture as the sole discovery/activation path.
- Duplicate submissions, racing timers, stale async responses, or optimistic state without rollback.
- Feedback appears far from its originating control or changes unrelated layout.

### Common false positives

- A semantic primitive library supplies behavior not visible in the consumer file.
- Decorative elements intentionally ignore input.
- A compact visual glyph has a larger pseudo-element or wrapper hit target.
- Hover is supplementary and the action remains visible and keyboard accessible.

### Evidence standard

Follow abstractions before declaring behavior missing. Cite the interactive element, handler/state contract, and shared primitive implementation when relevant.

### Likely ownership

Primitive for semantic/input contracts; shared component for product feedback; feature consumer for domain actions and error recovery.

### Runtime confirmation

Required for event ordering, pointer capture, touch behavior, screen-reader interaction modes, and third-party primitive output.

## 5. Motion behavior

### Inventory

- Duration/easing/spring vocabulary, entrance/exit hierarchy, replacement transitions, shared-layout identity, interruption, reduced motion, and CSS versus JavaScript animation paths.

### Reliable source signals

- Repeated controls use divergent timings or unbounded `transition: all`.
- Exits are slower than entries without an intentional reason.
- Layout properties animate when transform/opacity or a stable slot can express the change.
- CSS and imperative animation bypass the project's reduced-motion policy.
- Animation replays on every mount despite documentation limiting it to a first visit or milestone.

### Common false positives

- A bounded, documented marketing entrance differs from repeated application feedback.
- Physics parameters differ because distance, mass, or interaction type differs.
- A layout animation is deliberate and tested for interruption.
- Zero-duration is not always the best reduced-motion response; useful opacity feedback may remain.

### Evidence standard

Cite the project motion policy, animation declaration, trigger frequency, and affected property. Separate consistency concerns from performance or vestibular risks.

### Likely ownership

Foundation for timing and reduced-motion policy; primitive for interruption and lifecycle behavior; consumer for one-time choreography.

### Runtime confirmation

Required for perceived pacing, frame rate, interruption quality, actual travel distance, and reduced-motion computed behavior.

## 6. Responsive layout and overflow

### Inventory

- Breakpoint strategy, intrinsic sizing, wrapping, truncation, min/max constraints, nested scroll regions, viewport units, safe areas, zoom, localization, and popup collision.

### Reliable source signals

- Fixed widths/heights without a smaller-screen or content-overflow path.
- Flex/grid children missing minimum-size escape hatches when content must shrink.
- Viewport-fixed shells create nested scrollers on mobile.
- Overlays lack maximum block size, internal scrolling, or edge handling.
- Long labels and dynamic values have no wrapping, truncation, or expansion policy.

### Common false positives

- A fixed dimension belongs to a bounded icon, avatar, or intentional media frame.
- An ancestor primitive supplies collision handling or a portal.
- Horizontal scrolling is the intended interaction for a code/table surface and is signposted.
- Desktop-only internal scrolling switches to document flow at smaller breakpoints.

### Evidence standard

Cite the constraint and the absence or presence of a responsive escape path. Phrase clipping and overflow as risks unless the source deterministically clips known content.

### Likely ownership

Foundation for breakpoints and layers; primitive for overlay containment; layout component for scroll architecture; consumer for content policies.

### Runtime confirmation

Required at narrow widths, large text/zoom, localization extremes, dynamic viewport changes, safe areas, and overlay edges.

## 7. Accessibility and focus

### Inventory

- Accessible names, roles, values/states, landmark labels, current-page state, focus order/visibility, focus trap/return, error/status announcements, contrast tokens, and reduced motion.

### Reliable source signals

- Native semantics replaced by roles without native behavior.
- Visible labels are not programmatically associated.
- State is conveyed only through color, position, or icon changes.
- Focus outline is removed without a visible replacement.
- Conditional unmount can remove the focused element without a handoff.
- Async feedback has no status/error communication.

### Common false positives

- A higher-level component injects names, descriptions, or focus management.
- Visually hidden text supplies a valid name.
- Browser-native focus is intentionally retained.
- Automated semantics from a well-defined primitive need verification before being called absent.

### Evidence standard

Trace label and state relationships across component boundaries. Cite both the missing/incorrect declaration and any existing primitive contract. Avoid claiming standard compliance from static source.

### Likely ownership

Primitive for semantics/focus mechanics; shared component for naming defaults and status regions; consumer for domain labels and error copy.

### Runtime confirmation

Required for accessibility-tree output, focus visibility, reading/interaction order, announcements, contrast, and assistive-technology behavior.

## 8. Rendering, measurement, and first paint

### Inventory

- Server/client state boundaries, hydration-sensitive values, layout effects, observers, fonts, images, portals, initial animation, theme initialization, and measurement fallbacks.

### Reliable source signals

- Client-only preference changes first-paint markup or geometry after hydration.
- Geometry is published before a valid measurement exists.
- Measurement updates only on window resize while content can change independently.
- Initial animations move default content on every load.
- Font/media space is unresolved until late load.

### Common false positives

- A server-safe inline initializer establishes theme before paint.
- CSS aspect ratio or explicit dimensions reserve media space.
- The observer or measurement exists in an imported helper.
- A client-only decorative effect does not influence layout or essential content.

### Evidence standard

Trace the first render, initialization, measurement, and update sequence. Cite the fallback geometry and every trigger that refreshes it. Mark flicker and hydration mismatch as risks unless deterministic.

### Likely ownership

Foundation/layout for theme and fonts; primitive for measurement lifecycle; consumer for media dimensions and data placeholders.

### Runtime confirmation

Required for hydration warnings, flash duration, web-font shifts, observer timing, portal placement, and real-device first paint.

## 9. UI regression protection

### Inventory

- Unit/component/E2E/visual/a11y tests, test scripts, CI commands, representative fixtures, reduced-motion coverage, and geometry assertions.

### Reliable source signals

- Complex shared state, measurement, focus, or animation code has no focused tests.
- Tests assert presence but not interaction continuity or accessible state.
- Visual snapshots exist without keyboard/state tests, or vice versa.
- No test covers rapid interruption, unequal content, long labels, narrow widths, or reduced motion where those are material risks.

### Common false positives

- Tests live in a separate workspace or CI repository; search before declaring absence.
- A low-risk presentational component may not warrant isolated tests.
- Type/lint coverage is useful but is not interaction coverage.
- Manual release checks may be documented outside package scripts.

### Evidence standard

Cite the risky implementation and the closest package/test configuration lines. State the search roots and patterns used for absence claims. Tie recommended tests to a specific invariant, not generic coverage.

### Likely ownership

Regression-test layer, with fixtures owned near the primitive or flow being protected.

### Runtime confirmation

Not needed to prove test presence. Running the existing suite is outside a read-only source audit unless the user separately authorizes it; report the commands and expected assertions instead.
