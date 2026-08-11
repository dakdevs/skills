# Remediation Patterns

Choose the smallest pattern that restores the missing invariant in the project's existing stack. These are implementation shapes, not mandatory libraries.

## Contents

1. [Reserve geometry across control states](#1-reserve-geometry-across-control-states)
2. [Overlap replacement content](#2-overlap-replacement-content)
3. [Remove feedback from content flow](#3-remove-feedback-from-content-flow)
4. [Measure before publishing geometry](#4-measure-before-publishing-geometry)
5. [Preserve mounted identity](#5-preserve-mounted-identity)
6. [Localize feedback](#6-localize-feedback)
7. [Preserve controlled and uncontrolled continuity](#7-preserve-controlled-and-uncontrolled-continuity)
8. [Stabilize first paint](#8-stabilize-first-paint)
9. [Contain responsive content](#9-contain-responsive-content)
10. [Restore semantic primitives](#10-restore-semantic-primitives)
11. [Establish motion hierarchy](#11-establish-motion-hierarchy)
12. [Honor reduced motion across renderers](#12-honor-reduced-motion-across-renderers)
13. [Protect invariants with regression tests](#13-protect-invariants-with-regression-tests)

## Ownership rule

Assign one primary layer per remediation:

- **Foundation/token:** a reusable value or policy is absent or contradictory.
- **Primitive:** semantics, state mechanics, geometry, or input behavior should hold for every instance.
- **Shared component:** product-specific composition or feedback is repeated.
- **Feature consumer:** the rule depends on domain content or workflow intent.
- **Regression test:** the behavior exists but is not protected.

List downstream consumers separately. Do not make every consumer co-own a primitive defect.

## 1. Reserve geometry across control states

### Apply when

Hover, focus, selected, loading, or validation state changes alter font metrics, border thickness, padding, label width, or icon occupancy and can move adjacent content.

### Sequence

1. Identify the largest or widest valid state for each changing slot.
2. Keep box-model properties and font metrics constant when possible.
3. Express state with color, opacity, background, outline, or a fixed-space indicator.
4. If content must change, reserve its slot with a fixed inline/block size or a hidden sizing copy that does not enter the accessibility tree.
5. Put progress and success icons into the same reserved slot.

### Risks

- A hard-coded width can fail for localization or user font scaling.
- Invisible sizing text can be announced if not hidden correctly.
- Reserving excessive space can weaken compact layouts.

### Verify

Compare the control and neighboring bounding boxes before and after every state at short, long, localized, and zoomed labels. **Done when:** state changes do not move the control's outer box or adjacent stable controls beyond the project's documented tolerance.

## 2. Overlap replacement content

### Apply when

Tabs, carousels, route sections, step content, or filtered results animate outgoing and incoming content that should occupy one conceptual slot.

### Sequence

1. Create one persistent slot owned by the parent.
2. Place outgoing and incoming children in the same grid area or positioned layer.
3. Decide the height policy: fixed/reserved, smoothly measured, or content-driven after replacement.
4. Keep inactive content out of pointer and accessibility interaction at the correct lifecycle point.
5. Define interruption behavior for rapid repeated selection.

### Risks

- Positioned children can remove all height unless the parent owns sizing.
- Both states may be announced or clickable during overlap.
- Serial exit/enter can leave an undesirable empty interval.

### Verify

Use unequal-height content, rapid switching, keyboard focus, and reduced motion. **Done when:** outgoing and incoming content never create two normal-flow rows, downstream content follows the declared height policy, and only the active state is operable.

## 3. Remove feedback from content flow

### Apply when

Validation, copy confirmation, save status, loading text, or transient banners push otherwise stable content for short-lived feedback.

### Sequence

1. Keep permanent instructions and actionable errors in flow when users need to read or revisit them.
2. For transient feedback, reserve a status slot or anchor an overlay to the originating control/region.
3. Give the feedback stable dimensions or a bounded wrap policy.
4. Announce status with the least disruptive live-region behavior appropriate to urgency.
5. Preserve a non-transient recovery path for errors.

### Risks

- Overlay feedback can cover content or clip inside overflow ancestors.
- Reserving space for rare messages can create unexplained gaps.
- Auto-dismissed errors may disappear before users can act.

### Verify

Trigger success, error, repeated action, long text, and narrow layout. **Done when:** feedback is perceivable and associated with its trigger without unintended movement or loss of recovery information.

## 4. Measure before publishing geometry

### Apply when

Drawers, expandable code, virtualized content, popups, or layout animation depend on a measured size and the first measurement may be missing or stale.

### Sequence

1. Define a safe pre-measure state that does not expose wrong geometry.
2. Measure the element at the lifecycle point required by the rendering model.
3. Observe the element or content source that can actually change; window resize alone is rarely sufficient.
4. Publish geometry only after a valid value exists.
5. Reconcile measurement updates without restarting unrelated interaction state.
6. Clean up observers and pending callbacks.

### Risks

- Hiding until measurement can create a blank flash.
- Layout-synchronous measurement can block rendering if repeated broadly.
- Observer loops can occur when measured styles change the measured size.

### Verify

Test first open, font/media load, dynamic content, resize, zoom, and rapid close. **Done when:** no invalid fallback is visibly animated, measurements update for every real size source, and cleanup prevents stale updates.

## 5. Preserve mounted identity

### Apply when

Presentation-only state changes remount controls or content, resetting focus, selection, scroll, input, media, or animation continuity.

### Sequence

1. Identify which element represents the stable user-facing object.
2. Keep that owner mounted and change attributes, descendants, or visual layers instead of replacing it.
3. Use stable domain IDs for keys; never rely on list position for reorderable state.
4. Move intentionally reset state to an explicit boundary and document the reset trigger.
5. Hand focus off before any necessary unmount.

### Risks

- Retained hidden state can become stale or expose sensitive content.
- Over-preserving components can keep expensive subscriptions alive.
- A stable key cannot fix state owned at the wrong level.

### Verify

Exercise the transition with focused inputs, selection, scroll, media, and repeated interruption. **Done when:** identity persists wherever product intent says it should, and intentional resets occur only at named boundaries.

## 6. Localize feedback

### Apply when

The outcome of an action is shown in a distant global region, replaces unrelated content, or is communicated only by a small icon/state change.

### Sequence

1. Keep immediate feedback adjacent to or inside the initiating control without changing its outer geometry.
2. Use a nearby status message for detail and recovery.
3. Change the accessible name/state when the control's meaning changes.
4. Prevent repeated actions and timers from racing the visible result.
5. Escalate to global notification only when the result is truly global or persists across navigation.

### Risks

- Multiple live regions can create noisy announcements.
- Replacing labels can alter width unless space is reserved.
- A disabled pending control can trap focus or hide cancellation.

### Verify

Test success, failure, repeated activation, keyboard focus, and assistive output. **Done when:** users can associate outcome with action, recover from failure, and observe no geometry or timer race.

## 7. Preserve controlled and uncontrolled continuity

### Apply when

A component supports both internal state and caller-owned state, or mirrors props into local state.

### Sequence

1. Define the source of truth for controlled and uncontrolled modes.
2. Treat `value` plus change callback as controlled; treat `defaultValue` as initialization only.
3. Route all state transitions through one update function.
4. Never switch modes silently after mount; warn or document if the framework supports diagnostics.
5. Keep pending animation/measurement state subordinate to the authoritative value.
6. Test external updates, rejected updates, and rapid changes.

### Risks

- Optimistic internal state can diverge from a controlled prop.
- A closure can publish stale state during rapid input.
- Mode detection based only on truthiness mishandles valid empty values.

### Verify

Run the same behavior matrix in controlled and uncontrolled modes. **Done when:** externally supplied state remains authoritative, defaults initialize once, and rapid transitions cannot expose stale selection or feedback.

## 8. Stabilize first paint

### Apply when

Theme, preference, client-only data, fonts, media, or initial animation changes essential appearance or geometry after the initial markup is visible.

### Sequence

1. Determine what can be known on the server or before first paint.
2. Establish theme and other visual preferences before content paint when feasible.
3. Make server and client initial structure agree.
4. Reserve media and font-dependent geometry with dimensions, aspect ratio, or metric-compatible fallbacks.
5. Disable decorative initial animation for already-present default content when repeat entrance adds no meaning.
6. Isolate truly client-only decoration so it cannot move essential layout.

### Risks

- Blanket hiding until hydration delays useful content.
- Suppressing mismatch warnings can conceal real structural divergence.
- Preference scripts can violate security policy if integrated carelessly.

### Verify

Inspect cold load, slow device/network, theme variants, cached/uncached fonts, and hydration logs. **Done when:** essential structure and theme do not visibly correct themselves after paint and server/client ownership is explicit.

## 9. Contain responsive content

### Apply when

Long content, narrow screens, zoom, dynamic viewport height, safe areas, overlays, or nested scrolling can clip or make actions unreachable.

### Sequence

1. Prefer intrinsic layout with sensible min/max constraints.
2. Allow flex/grid children to shrink or wrap where content policy permits.
3. Define explicit truncation plus discovery, wrapping, or scrolling behavior for long values.
4. Bound overlays to the dynamic viewport and give their body a deliberate scroll owner.
5. Add edge collision/portal behavior at the shared overlay layer.
6. Use document scrolling on compact layouts unless independent panes serve a tested need.

### Risks

- Multiple nested scroll owners harm keyboard, touch, and restoration behavior.
- Truncation without access to the full value loses information.
- Portals can complicate layering, theming, and reading order.

### Verify

Test 320 CSS px, large text/zoom, localization extremes, short landscape viewport, software keyboard, safe areas, and popup edges. **Done when:** essential content and dismissal/actions remain reachable with one understandable scroll path.

## 10. Restore semantic primitives

### Apply when

Custom roles, click handlers, or visual labels reproduce behavior already supplied by native elements or established project primitives.

### Sequence

1. Choose the native element matching the action: button, link, input, select, heading, list, or disclosure.
2. Use an existing semantic primitive when it supplies a complete composite-widget contract.
3. Add accessible name, state, relationships, and focus behavior at the owning layer.
4. Preserve native keyboard activation and form behavior; set button type deliberately.
5. Implement the entire ARIA interaction model only when native/disclosure semantics cannot express the product need.

### Risks

- Roles without keyboard behavior create a false semantic promise.
- Swapping markup can change CSS and event propagation.
- An application-style menu can be worse than a simple list of links/buttons when Tab navigation is expected.

### Verify

Test keyboard, focus order/return, names, states, form embedding, and assistive-tree output. **Done when:** semantics and behavior agree, native capability is retained, and no input mode depends on a pointer-only path.

## 11. Establish motion hierarchy

### Apply when

Equivalent interactions use inconsistent duration/easing, or decorative entrances compete with repeated application feedback.

### Sequence

1. Classify motion by purpose: micro feedback, reveal/replacement, overlay, spatial navigation, or one-time expression.
2. Reuse the project's existing tiers; add a token only for a recurring missing concept.
3. Keep repeated control feedback faster and quieter than structural or one-time motion.
4. Make exits no slower than entries unless content comprehension requires it.
5. Prefer transform/opacity for visual travel and allowlist CSS transition properties.
6. Define interruption and initial-mount behavior.

### Risks

- Uniform duration everywhere ignores distance and purpose.
- Replacing physics with fixed timing can make gestures feel disconnected.
- Broad `transition: all` silently animates future geometry changes.

### Verify

Compare equivalent controls, rapid interruption, entrance/exit, and first versus repeat visits. **Done when:** timing communicates hierarchy, repeated actions feel consistent, and documented expressive exceptions remain bounded.

## 12. Honor reduced motion across renderers

### Apply when

The project uses CSS transitions, keyframes, JavaScript animation, canvas, or imperative measurement-driven motion that is not governed by one preference path.

### Sequence

1. Inventory every renderer and shared motion entry point.
2. Establish one preference signal or equivalent policy for all paths.
3. Remove travel, scale, spin, parallax, and spring bounce when reduction is requested.
4. Preserve essential state communication with immediate change or restrained opacity/color where appropriate.
5. Make imperative snap/cancel branches honor the same rule as normal transitions.
6. Test preference changes if the platform can update them live.

### Risks

- Disabling all transition duration globally can break components that rely on transition-end events.
- Removing feedback entirely can make state changes harder to perceive.
- Root animation configuration may not affect CSS or imperative APIs.

### Verify

Exercise every motion renderer in normal and reduced modes. **Done when:** final states remain clear and no nonessential travel, scale, spin, or bounce survives through an unmanaged path.

## 13. Protect invariants with regression tests

### Apply when

The remediation depends on state coordination, focus, measurement, geometry, responsive containment, motion policy, or a shared primitive with broad blast radius.

### Sequence

1. Express the invariant as an observable predicate, not an implementation detail.
2. Put fast state/semantic assertions near the component.
3. Use end-to-end coverage for focus, browser layout, input modality, responsive flow, and user journeys.
4. Use geometry or visual assertions only for dimensions that matter to the invariant.
5. Include adversarial fixtures: long labels, unequal content, rapid input, errors, narrow screens, and reduced motion.
6. Add the command to the existing CI path rather than creating a parallel test island.

### Risks

- Pixel snapshots are brittle when the real contract is relative stability.
- Mocking measurement too deeply can miss browser lifecycle defects.
- Tests that only check final state miss transient double-layout and focus loss.

### Verify

Demonstrate that the test fails against the evidenced defect and passes after remediation. **Done when:** the test protects the user-observable invariant, runs in the project's normal suite, and covers the highest-risk transition path.
