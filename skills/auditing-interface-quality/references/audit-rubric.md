# Design Quality and UI Architecture Rubric

Use this rubric to understand the interface as a designed product and as a component system. Do not force findings where evidence is healthy or inconclusive.

## Contents

1. [Product intent and visual direction](#1-product-intent-and-visual-direction)
2. [Hierarchy, composition, and content clarity](#2-hierarchy-composition-and-content-clarity)
3. [Typography, color, spacing, density, and surfaces](#3-typography-color-spacing-density-and-surfaces)
4. [Design-system coherence and token architecture](#4-design-system-coherence-and-token-architecture)
5. [Component boundaries and layer ownership](#5-component-boundaries-and-layer-ownership)
6. [Component APIs, variants, slots, and composition](#6-component-apis-variants-slots-and-composition)
7. [State, behavior, and data ownership](#7-state-behavior-and-data-ownership)
8. [Responsive layout, interaction, motion, and stability](#8-responsive-layout-interaction-motion-and-stability)
9. [Semantics, accessibility, and inclusive states](#9-semantics-accessibility-and-inclusive-states)
10. [Documentation, stories, tests, and governance](#10-documentation-stories-tests-and-governance)

## Evidence vocabulary

- **Fact:** Directly demonstrated by source, documentation, configuration, stories, or tests.
- **Source-inferred risk:** A likely visual or runtime outcome whose final effect depends on rendering, content, environment, or user input.
- **Design consequence:** The effect on hierarchy, comprehension, coherence, character, density, affordance, or feedback.
- **Architecture cause:** The boundary, ownership, API, reuse, state, or governance decision that creates or permits the consequence.
- **Intentional exception:** A documented deviation with bounded scope and a reason.
- **Trend:** Two independent occurrences. A shared implementation with several consumers is a shared-component risk.

## 1. Product intent and visual direction

### Inventory

- Audience, core tasks, information priority, product tone, brand expression, and platform posture.
- Design principles, reference surfaces, explicit exceptions, and the distinction between application, editorial, marketing, and utility UI.
- Which pages or workflows best express the intended quality bar.

### Reliable signals

- Documentation names a visual or interaction direction that representative pages do not carry.
- Primary tasks and secondary information receive indistinguishable emphasis.
- Brand expression appears only in isolated decoration while the core product uses generic defaults.
- Different product areas imply incompatible density, tone, or interaction models without a documented boundary.

### False positives

- Marketing, onboarding, dense operational tools, and long-form content intentionally use different modes.
- Platform-specific adaptations preserve product intent through different native patterns.
- Minimal visual treatment may be intentional when content and task priority remain clear.
- A design can be quiet without being generic.

### Evidence and ownership

Cite intent documentation plus representative page/composition source. When documentation is absent, infer cautiously from recurring page-level decisions and label that inference. Ownership usually belongs to product design direction, a composition system, or a feature—not automatically to tokens.

### Runtime confirmation

Required for final visual character, imagery, perceived density, optical balance, and whether the rendered product feels distinctive or generic.

## 2. Hierarchy, composition, and content clarity

### Inventory

- Page landmarks, headings, sections, primary/secondary actions, navigation, summaries, details, empty/loading/error states, and progressive disclosure.
- Grouping, alignment, reading order, whitespace, emphasis, and repeated page compositions.
- Labels, instructions, status copy, error recovery, and information scent.

### Reliable signals

- Heading levels, type roles, surface emphasis, or action prominence do not match task priority.
- Every section uses the same card/container treatment, flattening relationships and creating “card soup.”
- Layout components encode arbitrary visual gaps rather than semantic relationships.
- Content is duplicated, over-labeled, hidden behind vague affordances, or ordered by implementation rather than user task.
- Repeated page sections solve the same composition differently.

### False positives

- Similar visual weight is intentional for peer choices.
- Dense expert workflows prioritize scan efficiency over generous spacing.
- A flat surface hierarchy can reduce unnecessary chrome when grouping remains clear.
- Domain content may require repetition for safety or comparison.

### Evidence and ownership

Cite representative page structure, heading/type roles, layout classes, action variants, and repeated compositions. Name the user task that loses clarity. Ownership usually belongs to compositions or pages; promote a pattern only when several pages share meaning and change cadence.

### Runtime confirmation

Required for visual scanning order, fold composition, optical grouping, text wrapping, localized content, and perceived action prominence.

## 3. Typography, color, spacing, density, and surfaces

### Inventory

- Type families, roles, scale, weight, line height, measure, numeric treatment, and code/data typography.
- Semantic color roles, contrast intent, surfaces, borders, elevation, overlays, and dark/high-contrast themes.
- Spacing rhythm, control sizing, density modes, radius, icon sizing, alignment, and interactive states.

### Reliable signals

- Near-identical type roles or spacing values create no meaningful hierarchy.
- Important content uses microcopy roles, while incidental metadata competes with primary information.
- Color, border, shadow, and radius are layered simultaneously without a clear surface model.
- Equivalent controls have different heights, internal rhythm, icon placement, or state treatment.
- Raw values repeatedly bypass a coherent semantic foundation.
- Density varies accidentally between adjacent product surfaces.

### False positives

- Data visualization, mathematical geometry, media ratios, and platform-normalization values may be literal.
- Optical corrections and icon-specific offsets need not become shared tokens.
- Compact chrome can surround readable content without making the entire product too dense.
- Different semantic roles may resolve to the same current value while preserving future theming intent.

### Evidence and ownership

Cite the foundation definition, representative usage, and the visible relationship affected. A raw value is not a finding by itself. Foundation owns recurring semantic concepts; components own bounded anatomy; compositions own content rhythm.

### Runtime confirmation

Required for computed contrast, font fallback, optical alignment, perceived density, theme balance, and target size.

## 4. Design-system coherence and token architecture

### Inventory

- Primitive versus semantic tokens, aliases, themes, component recipes, variants, state tokens, and documented exceptions.
- How CSS, JavaScript, SVG, charts, and motion consume shared decisions.
- Where consumers override component styling or reconstruct recipes.

### Reliable signals

- Tokens mirror raw scales but do not encode product meaning.
- Components expose tokens or variants that overlap, conflict, or have unclear intended use.
- Consumers reach through component boundaries with selectors, arbitrary values, or internal part knowledge.
- One concept has separate uncoordinated representations across CSS and component code.
- Token additions are driven by individual screenshots rather than recurring semantic needs.
- Documentation and shipped recipes describe different systems.

### False positives

- Not every value deserves a token; premature semantic naming creates noise.
- A one-off feature value may correctly remain local.
- Exposing constrained style hooks can be intentional for a platform component.
- A small product may need a compact foundation rather than a large formal system.

### Evidence and ownership

Trace a decision from foundation to primitive/component to page. Cite overrides and consumers. Judge whether the system encodes intent, not merely whether variables exist. Ownership belongs to foundations only for concepts that recur across layers.

### Runtime confirmation

Required for resolved theme values and final style precedence. Architecture conclusions about duplication, naming, and override paths can be source facts.

## 5. Component boundaries and layer ownership

### Inventory

- Foundations, primitives, reusable components, compositions, feature/page components, and governance assets.
- Import direction, domain dependencies, styling ownership, behavior ownership, and repeated compositions.
- Components that mix fetching, domain policy, layout, visual anatomy, and low-level interaction.

### Reliable signals

- A primitive imports feature/domain concepts or contains product copy.
- Pages rebuild the same semantic component anatomy and behavior independently.
- A generic component owns unrelated layout, data, routing, and business behavior.
- Consumers depend on internal DOM structure or style implementation.
- Shared components accept page-specific escape hatches because their boundary is too broad.
- Design decisions live at a layer that cannot enforce them across relevant consumers.

### False positives

- Colocation is not poor architecture when responsibility remains bounded.
- Large components can be coherent when they own one complex interaction.
- Duplication is preferable when two surfaces share appearance but not semantics or change cadence.
- Feature-specific components do not belong in a universal design system merely because they repeat twice.

### Evidence and ownership

Map import/consumer relationships and describe the responsibility in one sentence. Identify the decision that crosses a boundary and the change that would require editing unrelated consumers. Choose the narrowest layer capable of enforcing the invariant.

### Runtime confirmation

Usually unnecessary for ownership and dependency findings. Runtime checks are needed when the architectural issue is inferred from rendered composition or behavior.

## 6. Component APIs, variants, slots, and composition

### Inventory

- Props, variants, slots, children, compound components, render hooks, polymorphism, defaults, and controlled/uncontrolled contracts.
- Boolean combinations, mutually exclusive states, public style overrides, internal part exposure, and variant usage across consumers.
- Whether APIs describe product semantics or implementation details.

### Reliable signals

- Boolean props create invalid or ambiguous combinations.
- Variants encode page names or one consumer's layout rather than reusable meaning.
- Callers must coordinate several props to express one semantic mode.
- Component defaults are weak, so every consumer repeats configuration or overrides anatomy.
- Slots are either too closed for legitimate composition or so open that the component enforces no design.
- A “universal” component contains conditional branches for unrelated product concepts.

### False positives

- A small number of independent booleans may accurately model orthogonal behavior.
- Explicit props can be clearer than a clever compound API.
- Polymorphism is unnecessary when semantics should remain fixed.
- Local duplication may be safer than a premature abstract variant.

### Evidence and ownership

Cite the public API and at least representative consumers. Build a combination or change-impact matrix when prop interactions are material. Ownership belongs to the component API; domain modes may require distinct compositions rather than more variants.

### Runtime confirmation

Usually unnecessary for API-shape findings. Confirm behavior when prop combinations affect focus, layout, or lifecycle.

## 7. State, behavior, and data ownership

### Inventory

- Controlled/uncontrolled state, domain state, transient UI state, server/client boundaries, async feedback, measurement, keys, and context/providers.
- Which layer owns selection, disclosure, validation, navigation, loading, and optimistic state.
- State synchronization between primitives, components, compositions, and routes.

### Reliable signals

- A presentational primitive owns domain workflow or data fetching.
- Pages manually coordinate state that a semantic shared component should own.
- Props are mirrored into local state without a clear authority model.
- Context provides unrelated high-frequency state to broad subtrees.
- Keys or conditional branches destroy identity for presentation-only changes.
- Async results, timers, or optimistic state can race or publish stale feedback.

### False positives

- Feature state correctly remains near domain rules even if several controls consume it.
- A keyed remount may intentionally reset a completed or security-sensitive workflow.
- Local transient state is often preferable to central storage.
- Server ownership can intentionally reset client UI on navigation.

### Evidence and ownership

Describe the state machine and source of truth. Cite the owner, transition paths, and consumers. Separate domain policy from reusable interaction mechanics. Ownership belongs at the lowest common ancestor that understands the decision without acquiring unrelated responsibilities.

### Runtime confirmation

Required for races, interruption, hydration, focus/scroll loss, and controlled/uncontrolled synchronization.

## 8. Responsive layout, interaction, motion, and stability

### Inventory

- Layout primitives, intrinsic sizing, breakpoints, container behavior, overflow, zoom, localization, and safe areas.
- Control feedback, navigation, overlays, replacement content, loading/error states, motion hierarchy, interruption, reduced motion, and first paint.
- Geometry changes across rest, focus, selected, loading, and validation states.

### Reliable signals

- Page layouts depend on fixed dimensions without content or viewport escape paths.
- Components own page layout assumptions or consumers patch component internals at breakpoints.
- Repeated controls change box metrics or broad transitions animate future geometry.
- Entering/exiting replacement content occupies multiple flow slots.
- Feedback appears far from its action, displaces unrelated content, or races.
- CSS and imperative motion bypass the shared hierarchy or reduced-motion policy.
- Geometry is published before valid measurement or first paint visibly corrects essential layout.

### False positives

- Intentional content growth, dense desktop panes, media frames, and bounded data tables can require fixed or scrolling regions.
- Transform animation does not itself alter layout geometry.
- A documented one-time expressive entrance may differ from repeated feedback.
- Components may expose responsive slots while compositions own final rearrangement.

### Evidence and ownership

Trace the page layout and component anatomy together. Cite state branches, measurements, and breakpoint ownership. Phrase final movement, clipping, and pacing as source-inferred unless deterministic. Layout decisions usually belong to compositions; reusable internal containment belongs to components/primitives.

### Runtime confirmation

Required for bounding boxes, actual overflow, zoom/localization, focus continuity, frame rate, perceived pacing, layout shift, and reduced-motion output.

## 9. Semantics, accessibility, and inclusive states

### Inventory

- Native elements, names, roles, states, relationships, landmarks, focus, keyboard/touch, contrast intent, reduced motion, large text, errors, status, disabled/pending states, and content alternatives.
- Whether semantic/accessibility behavior is guaranteed by primitives or reconstructed by consumers.

### Reliable signals

- Generic elements reproduce native controls or ARIA roles omit required behavior.
- Component APIs make accessible naming or relationships optional when meaning is known.
- Visual hierarchy relies solely on color, position, hover, or motion.
- Focus and error/status behavior are patched per consumer instead of owned centrally.
- Compact visual controls have no larger interaction target or density mode.
- Loading, empty, error, and disabled states lose essential actions or context.

### False positives

- An imported semantic primitive may supply behavior invisible at the consumer.
- Browser-native focus may be intentionally preserved.
- `aria-label` is not required when a valid visible or associated name exists.
- Different input modes may have different enhancements while retaining equivalent access.

### Evidence and ownership

Trace semantics across abstractions and cite the owning primitive plus consumers. Treat accessibility as part of component architecture, not a page-level cleanup. Do not claim standards conformance from source alone.

### Runtime confirmation

Required for accessibility-tree output, focus order/visibility, announcements, computed contrast, zoom, touch, and assistive-technology behavior.

## 10. Documentation, stories, tests, and governance

### Inventory

- Component documentation, usage guidance, stories/examples, design references, visual fixtures, unit/component/E2E/visual/accessibility tests, lint rules, and CI gates.
- Coverage of variants, content extremes, themes, responsive states, interaction states, and intentional exceptions.
- Whether examples model recommended architecture or merely demonstrate prop permutations.

### Reliable signals

- A component has a complex API but no canonical examples or discouraged combinations.
- Stories showcase isolated atoms but not representative page compositions.
- Visual tests snapshot pixels without protecting hierarchy, state, or responsive relationships.
- Behavioral tests ignore design invariants; design reviews lack executable regression protection.
- Documentation, code defaults, and actual consumers disagree.
- No workflow catches consumer overrides, unsupported variants, or token drift.

### False positives

- Low-risk internal components may not need dedicated stories.
- Not every visual decision needs a screenshot test.
- Tests may live in a separate workspace or external CI; search before declaring absence.
- Manual design review remains valuable for qualities automation cannot measure.

### Evidence and ownership

Cite the component/API risk and nearest docs/test/manifest evidence. Tie each proposed guard to a specific design or architecture invariant. Governance owns enforcement; component teams own representative fixtures.

### Runtime confirmation

Not needed to establish presence or absence. Executing tests is outside this read-only audit unless separately authorized; name the expected checks and commands only when source evidence supports them.
