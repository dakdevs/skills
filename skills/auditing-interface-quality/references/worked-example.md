# Worked Example: Design Quality Through Component Architecture

This fictional source-only example demonstrates how to connect visible design symptoms to architectural causes. Its paths are not reusable evidence.

## Evidence boundary

The fictional project is a billing dashboard. The audit reviews its overview and reports pages, type/spacing tokens, `Card`, and repeated metric markup. No rendered output is observed.

## Intended direction

The product documentation says operators should scan account health quickly, identify exceptions, then drill into detail (`docs/product-principles.md:12-18`). The design foundation defines distinct page-title, section-title, metric-value, body, and metadata roles (`src/styles/type.css:4-28`) plus section and cluster spacing (`src/styles/space.css:2-14`).

## Raw evidence

| Observation                                                                               | Evidence                                                      | Type                                         |
| ----------------------------------------------------------------------------------------- | ------------------------------------------------------------- | -------------------------------------------- |
| Overview uses body-medium for page title, section labels, and metric labels               | `src/pages/overview.tsx:18-64`                                | Fact; flattened hierarchy is source-inferred |
| Reports uses three raw font sizes and five one-off vertical gaps                          | `src/pages/reports.tsx:14-71`                                 | Fact                                         |
| Both pages independently build label/value/change metric blocks                           | `src/pages/overview.tsx:38-57`; `src/pages/reports.tsx:31-52` | Fact; two occurrences                        |
| Generic `Card` accepts `compact`, `interactive`, `selected`, `elevated`, and `borderless` | `src/ui/card.tsx:6-42`                                        | Fact                                         |
| Consumers combine flags differently and override internal padding                         | `src/pages/overview.tsx:35-60`; `src/pages/reports.tsx:28-55` | Fact                                         |

## Design-quality assessment

| Dimension                 | Assessment | Evidence                                                  | Consequence                                                                             |
| ------------------------- | ---------- | --------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| Hierarchy and composition | Weak       | `overview.tsx:18-64`; `reports.tsx:14-71`                 | Titles, sections, and supporting metadata are likely hard to distinguish while scanning |
| Typography and content    | Mixed      | Type roles exist at `type.css:4-28` but pages bypass them | The intended operational hierarchy is not carried into primary surfaces                 |
| Spacing and density       | Mixed      | `space.css:2-14`; page-level literals above               | Related metric groups have no shared rhythm                                             |
| Component expression      | Weak       | Duplicate metric anatomy and overloaded `Card` API        | Pages reconstruct design decisions and can drift independently                          |

## Architecture map

| Layer        | Observed responsibility                            | Assessment                     |
| ------------ | -------------------------------------------------- | ------------------------------ |
| Foundation   | Appropriate semantic type and spacing roles        | Strong but under-consumed      |
| Primitive    | `Card` owns surface mechanics plus unrelated modes | Boundary too broad             |
| Component    | No semantic metric component                       | Missing shared product anatomy |
| Composition  | Pages build metric grids independently             | Duplicate design ownership     |
| Feature/page | Owns domain data and all visual hierarchy          | Overloaded                     |
| Governance   | No representative metric story or hierarchy test   | Missing enforcement            |

## Prioritized causal findings

| ID    | Severity | Confidence | Design problem                                                 | Architecture cause                                                                          | Blast radius                         | Evidence                                                  | Owner       | Runtime confirmation                                                          |
| ----- | -------- | ---------- | -------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------ | --------------------------------------------------------- | ----------- | ----------------------------------------------------------------------------- |
| IQ-01 | P1       | Medium     | Primary pages do not express the documented scan hierarchy     | Pages bypass semantic type/spacing roles and no composition contract carries them           | Trend across Overview and Reports    | `type.css:4-28`; `space.css:2-14`; both page ranges above | Composition | Render both pages with realistic long/exception data and verify reading order |
| IQ-02 | P1       | High       | Metric presentation lacks a coherent, reusable visual identity | Generic `Card` exposes unrelated flags while semantic metric anatomy is duplicated in pages | Trend plus shared-component API risk | `card.tsx:6-42`; both page metric ranges                  | Component   | Runtime only for final visual quality; architecture cause is source-proven    |

## Remediation cards

### IQ-01 — Make operational hierarchy a page-composition contract

**Target design outcome:** Operators can identify page purpose, account-health summaries, exceptions, and supporting detail in that order without every block competing equally.

**Target architecture:** Overview and Reports consume a shared operational-page composition vocabulary for page header, summary section, detail section, and their semantic spacing/type roles.

**Root cause:** The foundation defines useful roles, but page compositions do not own or consume a hierarchy contract, so feature files choose typography and spacing independently.

**Evidence and reach:** The documented scan goal is a fact at `docs/product-principles.md:12-18`. Semantic roles exist at `src/styles/type.css:4-28` and `src/styles/space.css:2-14`; both pages bypass them at the cited ranges. Final visual flattening is source-inferred.

**Why it matters:** These are primary operational surfaces. Weak hierarchy slows scanning and makes design drift a page-by-page maintenance problem.

**Primary ownership layer:** Composition.

**Affected files and consumers:** Establish composition roles near shared page layout; migrate Overview and Reports. Do not turn domain copy or data loading into composition props.

**Apply in this order:**

1. Confirm the documented task and information order with representative content.
2. Define page-header, summary, and detail composition roles using existing semantic type/spacing foundations.
3. Keep domain data and copy in each feature while moving only recurring relationships into the composition layer.
4. Migrate both pages and delete their parallel hierarchy literals.
5. Add representative page fixtures with normal, long, empty, and exception-heavy data.

**Migration and design risks:** A universal dashboard template could erase meaningful differences between Reports and Overview. Existing semantic roles may need refinement if realistic content exposes weak contrast.

**Verification:** Review both pages with realistic content at common widths. Trace heading structure and source use of composition roles. Confirm that feature-specific sections can diverge without overriding shared anatomy.

**Done when:** Both pages express the documented reading order through shared semantic roles, duplicated hierarchy literals are gone, and feature-specific content remains locally owned.

### IQ-02 — Replace universal Card flags with a semantic metric component

**Target design outcome:** Account metrics have one recognizable anatomy and state hierarchy across pages while ordinary cards remain visually neutral containers.

**Target architecture:** Keep `Card` responsible for basic surface anatomy. Introduce a `MetricCard` component or composition that owns metric label, value, trend, status, and supported density/interaction modes.

**Root cause:** The generic Card API absorbs feature modes while pages still reconstruct metric anatomy, so neither layer owns the actual product concept.

**Evidence and reach:** `Card` exposes five interacting flags at `src/ui/card.tsx:6-42`. Overview and Reports combine them and duplicate label/value/change structure at their cited ranges. The API and duplication are facts across two independent consumers.

**Why it matters:** The current design can drift at two levels: flag combinations alter generic surfaces unpredictably, and metric hierarchy changes require parallel page edits.

**Primary ownership layer:** Component.

**Affected files and consumers:** Simplify `src/ui/card.tsx`; add the semantic metric component near product components; migrate both pages. Preserve any non-metric Card consumers after searching them.

**Apply in this order:**

1. Inventory real Card consumers and classify independent versus metric-specific modes.
2. Keep only neutral surface responsibilities in Card.
3. Define MetricCard anatomy and semantic states from the two real consumers, using slots only for demonstrated content variation.
4. Migrate Overview and Reports; remove internal padding overrides and invalid flag combinations.
5. Add a story/example covering long labels, positive/negative/neutral trends, missing data, selection, and density.

**Migration and design risks:** Extracting only shared markup could produce a rigid component; retaining compatibility flags could preserve the old architecture; metric color must not become the only state signal.

**Verification:** Express every real metric consumer with the target API and attempt unsupported combinations. Compare anatomy across pages and inspect whether ordinary cards remain unaffected.

**Done when:** Metric anatomy and supported states have one component owner, Card no longer contains metric/page modes, consumers provide domain content without internal overrides, and invalid combinations are unrepresentable.

## Target architecture

```text
semantic type + spacing foundations
              ↓
neutral Card primitive → MetricCard component
              ↓                 ↓
     operational compositions → Overview / Reports
              ↘ representative stories and page checks
```

This target improves the visible hierarchy by putting each design decision at the layer that understands and can preserve it.
