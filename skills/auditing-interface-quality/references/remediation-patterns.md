# Design and Component Architecture Remediation Patterns

Choose the smallest pattern that restores design intent at the correct layer. A good remediation improves the visible result and makes that quality harder to lose.

## Contents

1. [Establish a design hierarchy contract](#1-establish-a-design-hierarchy-contract)
2. [Create semantic visual foundations](#2-create-semantic-visual-foundations)
3. [Encode spacing and density rhythm](#3-encode-spacing-and-density-rhythm)
4. [Define the UI layer model](#4-define-the-ui-layer-model)
5. [Extract a semantic component](#5-extract-a-semantic-component)
6. [Split an overloaded component](#6-split-an-overloaded-component)
7. [Replace prop permutations with composition](#7-replace-prop-permutations-with-composition)
8. [Design a constrained component API](#8-design-a-constrained-component-api)
9. [Move state to the correct owner](#9-move-state-to-the-correct-owner)
10. [Make responsive structure compositional](#10-make-responsive-structure-compositional)
11. [Preserve feedback, motion, and geometry](#11-preserve-feedback-motion-and-geometry)
12. [Turn design intent into governance](#12-turn-design-intent-into-governance)

## Ownership rule

Assign one primary owner:

- **Foundation:** recurring visual or behavioral vocabulary.
- **Primitive:** low-level semantics, interaction, or internal containment.
- **Component:** reusable product-aware anatomy and bounded behavior.
- **Composition:** repeated section or workflow arrangement.
- **Feature/page:** domain content, state, and task-specific hierarchy.
- **Governance:** documentation, stories, tests, lint, and review gates.

Do not move a decision upward merely to maximize reuse. Move it to the narrowest layer that can express its meaning and enforce it across actual consumers.

## 1. Establish a design hierarchy contract

### Apply when

Pages have weak or inconsistent priority, every section looks equivalent, actions compete, or the code contains many unrelated choices for headings, containers, and emphasis.

### Sequence

1. Name the page's primary task, secondary tasks, supporting context, and exceptional states.
2. Define semantic content roles: page title, section heading, body, metadata, primary action, secondary action, and status.
3. Map each role to typography, spacing, surface, and action emphasis already present where possible.
4. Apply the contract to one representative page composition before generalizing.
5. Promote only relationships that recur across pages with the same meaning.

### Risks

- A rigid universal hierarchy can erase legitimate workflow differences.
- Changing type or action emphasis without content review can reveal unclear copy.
- A token-only solution may leave poor page grouping untouched.

### Verify

Review primary, empty, loading, error, and completed states at representative content lengths. **Done when:** the intended reading and action order is explicit in source, repeated page structures use the same semantic roles, and exceptions are locally owned and documented.

## 2. Create semantic visual foundations

### Apply when

Color, type, surface, elevation, radius, or motion decisions recur under raw or scale-only names and consumers cannot express product meaning consistently.

### Sequence

1. Inventory recurring roles from representative pages, not only existing literals.
2. Keep primitive scales private where possible and expose semantic roles such as surface, text hierarchy, control feedback, or overlay layer.
3. Map themes and renderers to one semantic vocabulary.
4. Move component anatomy to recipes or variants only when the combination recurs.
5. Define bounded exception and opt-out paths.

### Risks

- Tokenizing every value creates an unusable vocabulary.
- Semantic names that mirror one page age poorly.
- Global aliases can change unrelated surfaces unexpectedly.

### Verify

Trace each new role through at least two meaningful consumers and every supported theme. **Done when:** product concepts have one comprehensible name, consumers no longer duplicate the evidenced decision, and local optical values remain local.

## 3. Encode spacing and density rhythm

### Apply when

Adjacent surfaces use inconsistent control heights, section gaps, padding, or information density, or when spacing values exist without describing relationships.

### Sequence

1. Separate macro composition spacing, component anatomy, inline gaps, and optical correction.
2. Define density modes only when the product has real compact/comfortable contexts.
3. Let components own internal anatomy and compositions own relationships between components.
4. Use semantic layout primitives or recipes for recurring stacks, clusters, grids, and sections.
5. Test realistic long labels, metadata, and empty states before standardizing.

### Risks

- A global spacing scale does not guarantee good rhythm.
- Density variants can multiply component combinations.
- Uniform gaps can flatten semantic grouping.

### Verify

Compare related pages and component states at standard and compact contexts. **Done when:** hierarchy is reinforced by repeatable relationships, component boxes align where they should, and density changes are deliberate modes rather than consumer overrides.

## 4. Define the UI layer model

### Apply when

Foundations, primitives, components, compositions, and pages import or own each other's concerns; teams cannot tell where a design decision belongs.

### Sequence

1. Write one-sentence responsibilities for every observed layer.
2. Map import direction and public extension points.
3. Identify decisions currently owned above or below the layer that understands them.
4. Move enforcement to the narrowest correct owner while keeping domain policy in features.
5. Add dependency or review guards only for boundaries that materially prevent drift.

### Risks

- A theoretical layer model can create folders without better responsibilities.
- Moving code for purity can increase indirection.
- Strict import rules can block legitimate composition.

### Verify

Walk a representative change from foundation to page. **Done when:** each layer has a bounded role, dependencies point toward lower-level capability rather than feature policy, and a design change has an obvious primary owner.

## 5. Extract a semantic component

### Apply when

Several pages repeat the same meaning, anatomy, behavior, and change cadence—not merely similar markup or styling.

### Sequence

1. Compare consumers and identify the shared user-facing concept.
2. Separate invariant anatomy/behavior from domain content and layout context.
3. Give the component a semantic name and strong default.
4. Expose only variation already demonstrated by consumers.
5. Migrate representative consumers and delete parallel recipes.

### Risks

- Visual similarity can hide different semantics.
- Extracting before consumers stabilize creates speculative props.
- A component can absorb page layout and become hard to place.

### Verify

Implement change scenarios mentally or in tests across all known consumers. **Done when:** the component expresses one shared concept, consumers supply content rather than reconstruct anatomy, and future shared changes have one owner.

## 6. Split an overloaded component

### Apply when

One component owns unrelated product modes, domain behavior, page layout, data fetching, or large conditional anatomies.

### Sequence

1. List responsibilities and the consumers that require each one.
2. Separate reusable mechanics from product compositions and domain state.
3. Keep a stable primitive/component core only where behavior and anatomy genuinely recur.
4. Create named compositions for coherent product modes instead of one universal branch tree.
5. Preserve migration compatibility only where it has a defined removal path.

### Risks

- Splitting by line count creates fragments with no independent meaning.
- Excessive wrappers obscure control flow.
- A compatibility facade can become permanent duplicate architecture.

### Verify

Test common change requests against the target boundaries. **Done when:** each unit has one coherent reason to change, feature policy stays out of lower layers, and consumers no longer depend on unrelated modes.

## 7. Replace prop permutations with composition

### Apply when

Boolean or enumerated props create invalid combinations, page-specific modes, or conditional trees that callers must understand as an implicit state machine.

### Sequence

1. Build a matrix of current prop combinations and actual consumers.
2. Separate orthogonal behavior from mutually exclusive semantic modes.
3. Replace semantic modes with named components, variants, or compound composition as appropriate.
4. Use slots for content placement where anatomy is stable and content varies.
5. Remove unsupported combinations and provide migration examples.

### Risks

- Compound APIs can be heavier than explicit props.
- Splitting variants can duplicate legitimate shared behavior.
- Polymorphism can weaken semantics and typing.

### Verify

Express every real consumer with the new API and attempt previously invalid combinations. **Done when:** supported modes are obvious, invalid combinations are unrepresentable or rejected, and callers no longer coordinate internal implementation flags.

## 8. Design a constrained component API

### Apply when

Every consumer repeats configuration, overrides internals, passes style escape hatches, or cannot express legitimate content and layout variations cleanly.

### Sequence

1. Define the component's semantic responsibility and non-negotiable design invariants.
2. Choose strong defaults from representative consumers.
3. Expose semantic variants for meaningful recurring roles.
4. Expose named slots or composition points for legitimate structure variation.
5. Keep internal state/DOM/style details private unless consumers must coordinate them.
6. Document unsupported use cases and intentional escape hatches.

### Risks

- Over-constraining forces forks and wrappers.
- Unrestricted class/style props make all invariants optional.
- Semantic names can become vague dumping grounds.

### Verify

Review API usage across known consumers and future change scenarios. **Done when:** common use is concise, meaningful variations are explicit, invariants survive consumer use, and escape hatches are rare and bounded.

## 9. Move state to the correct owner

### Apply when

State is duplicated, mirrored, synchronized manually, owned by a presentational layer, or coordinated across consumers that should share one behavioral component.

### Sequence

1. Define authoritative domain state, reusable interaction state, and local presentation state.
2. Place each at the lowest common owner that understands its meaning.
3. Define controlled/uncontrolled contracts deliberately.
4. Route transitions through one path and keep visual animation subordinate to state.
5. Preserve identity, focus, and async ordering across changes.

### Risks

- Centralizing transient state creates broad updates and coupling.
- Local optimism can diverge from authoritative controlled state.
- Moving state can alter reset behavior or navigation persistence.

### Verify

Exercise internal, external, rejected, interrupted, and reset transitions. **Done when:** one source of truth governs each decision, components do not mirror props ambiguously, and UI state cannot visibly contradict domain state.

## 10. Make responsive structure compositional

### Apply when

Components contain page-specific breakpoints, pages patch component internals at narrow widths, or responsive adaptations lose task hierarchy.

### Sequence

1. Separate component-internal containment from page-level rearrangement.
2. Let components own intrinsic behavior, wrapping, and minimum constraints.
3. Let compositions own column changes, navigation modes, and content priority.
4. Preserve semantic order while changing presentation.
5. Define overflow and disclosure policies for long, dense, and localized content.

### Risks

- CSS reordering can diverge from reading/focus order.
- Too many responsive props expose layout internals.
- Moving all breakpoints upward can make components fragile in containers.

### Verify

Test representative pages at narrow width, zoom, localization extremes, and short viewports. **Done when:** components contain themselves, compositions preserve task priority, and consumers do not reach into internal anatomy for responsive repair.

## 11. Preserve feedback, motion, and geometry

### Apply when

State changes move controls, replacement content stacks, feedback displaces unrelated content, motion hierarchy drifts, or rendered identity is lost.

### Sequence

1. Define the stable user-facing object and the geometry that should persist.
2. Reserve changing label/icon/control slots where appropriate.
3. Give replacement content one parent-owned slot and explicit height/interruption behavior.
4. Localize pending/success/error feedback near its action without hiding recovery.
5. Use semantic motion tiers and one reduced-motion policy across renderers.
6. Keep state authoritative over animation and clean timers/observers.

### Risks

- Fixed reservation can fail localization.
- Overlapping content can remain interactive or announced.
- Blanket zero-duration rules can break lifecycle cleanup.

### Verify

Exercise long content, unequal panels, rapid reversal, errors, keyboard focus, and reduced motion. **Done when:** state remains clear, stable objects retain geometry/identity, only current content is operable, and motion supports rather than substitutes for hierarchy.

## 12. Turn design intent into governance

### Apply when

Quality depends on reviewer memory, documentation and code disagree, component APIs lack canonical examples, or regressions recur across pages.

### Sequence

1. Write short component and composition contracts around user-observable intent.
2. Add representative stories/examples with realistic content, themes, states, and responsive contexts.
3. Protect semantics and state with component tests.
4. Protect hierarchy, containment, and geometry with focused rendered or visual checks.
5. Add source checks only for rules that are deterministic and low-noise.
6. Make exceptions explicit and reviewable.

### Risks

- Broad snapshots create noise without protecting intent.
- Stories can become prop galleries rather than design references.
- Lint rules can ban legitimate exceptions and encourage workarounds.

### Verify

Demonstrate that each guard fails against the evidenced regression and passes the intended exception. **Done when:** canonical examples show the quality bar, automated checks protect material invariants, and documentation, defaults, consumers, and exceptions agree.
