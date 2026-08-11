# Worked Example: From Symptoms to Root Causes

This fictional example demonstrates synthesis depth. Its paths and findings are not reusable evidence.

## Evidence boundary

Source-only review of a fictional dashboard's shared tabs and menu. No rendering occurred. The project documents `--duration-control: 140ms` and `--duration-panel: 220ms` in `src/styles/motion.css:4-5`, and says selected controls preserve their outer geometry in `docs/interface-rules.md:18-20`.

## Raw evidence ledger

| Observation                                                                        | Evidence                                                                                | Type                                                     |
| ---------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| Selected tabs change from weight 400 to 700                                        | `src/ui/tabs.css:21-25`                                                                 | Fact; resulting width movement is a source-inferred risk |
| Entering and exiting panels are sibling normal-flow blocks during presence overlap | `src/ui/tabs.tsx:67-84`                                                                 | Fact; downstream displacement is a source-inferred risk  |
| Tabs use 420ms while menu controls use 310ms                                       | `src/ui/tabs.tsx:75`, `src/ui/menu.css:32`                                              | Fact                                                     |
| Both values bypass documented 140ms/220ms tokens                                   | `src/styles/motion.css:4-5`                                                             | Fact                                                     |
| Shared tabs appear in Settings and Billing                                         | `src/features/settings/settings-tabs.tsx:9`, `src/features/billing/billing-tabs.tsx:12` | Fact; shared-component reach                             |

Publishing these as three unrelated findings would produce local patches. The evidence supports two causes.

## Pattern map

| Root cause                                                                                 | Symptoms                                                                                 | Blast radius                                      | Primary ownership |
| ------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------- | ------------------------------------------------- | ----------------- |
| The shared tabs primitive has no explicit geometry contract for selection or replacement   | Selected labels may move neighbors; overlapping panels may create a temporary second row | Shared-component risk across Settings and Billing | Primitive         |
| Motion tiers are documented but not consumable/enforced across CSS and component animation | Equivalent repeated feedback uses 310ms and 420ms literals                               | Trend: two independent declarations               | Foundation/token  |

The label and panel symptoms remain one finding because they share the same owner and invariant: the tabs primitive must preserve geometry while state changes. Timing drift is separate because its correction starts at the foundation and affects more than tabs.

## Prioritized findings

| ID    | Severity | Confidence | Evidence type                              | Root cause                                                   | User/system impact                                                                         | Evidence                                                                                                                                               | Ownership        | Runtime confirmation                                              |
| ----- | -------- | ---------- | ------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------- | ----------------------------------------------------------------- |
| IQ-01 | P1       | Medium     | Facts plus source-inferred rendered impact | Tabs lacks a state-geometry contract                         | Repeated tab changes can move adjacent controls and downstream content across two features | `src/ui/tabs.css:21-25`; `src/ui/tabs.tsx:67-84`; consumers at `src/features/settings/settings-tabs.tsx:9`, `src/features/billing/billing-tabs.tsx:12` | Primitive        | Compare bounding boxes and panel-slot flow during rapid switching |
| IQ-02 | P2       | High       | Fact                                       | Motion tiers are documentation-only and literals bypass them | Equivalent interactions feel inconsistent and will continue to drift                       | `src/styles/motion.css:4-5`; `src/ui/tabs.tsx:75`; `src/ui/menu.css:32`                                                                                | Foundation/token | Perceived pacing needs runtime review; token mismatch does not    |

## Remediation cards

### IQ-01 — Preserve one stable geometry slot through tab selection

**Target outcome:** Selecting a tab changes state without moving tab triggers or creating a second normal-flow panel row.

**Root cause:** The shared tabs primitive does not own invariants for trigger metrics and replacement-panel layout.

**Evidence and reach:** The selected rule changes font weight at `src/ui/tabs.css:21-25`. Presence renders replacement siblings at `src/ui/tabs.tsx:67-84`. Settings and Billing consume the primitive at `src/features/settings/settings-tabs.tsx:9` and `src/features/billing/billing-tabs.tsx:12`. The declarations and reach are facts; visible displacement remains a source-inferred risk until rendered.

**Why it matters:** Tabs are repeated navigation controls. Movement at the trigger and content boundaries can make selection feel imprecise and can shift the reading position in two known flows.

**Primary ownership layer:** Primitive.

**Affected files and consumers:** Start in `src/ui/tabs.css` and `src/ui/tabs.tsx`; verify Settings and Billing. Search for other imports before migration and report them as discovered consumers.

**Apply in this order:**

1. Keep trigger font metrics constant; express selection with color and a fixed-space indicator. If bold is a documented requirement, reserve the bold label width without exposing duplicate text to assistive technology.
2. Give the panel parent one persistent slot and overlap entering/exiting panels in the same grid area.
3. Define the slot's height policy for unequal content; do not let both replacement states contribute separate rows.
4. Make only the active panel operable and exposed at the appropriate lifecycle point.
5. Add geometry and keyboard regression coverage at the primitive, then exercise both known consumers.

**Implementation risks:** Positioned panels can collapse parent height; hidden duplicate labels can be announced; premature accessibility hiding can suppress exit content before focus is handed off.

**Verification:** In a rendered component test, record trigger and downstream-anchor bounding boxes, select every tab, switch rapidly, and repeat with unequal-height panels and long labels. Verify keyboard focus and reduced motion separately.

**Done when:** Trigger outer widths remain unchanged across selection; entering and exiting panels never occupy two normal-flow rows; downstream movement matches the documented unequal-height policy; only the active panel is interactive.

### IQ-02 — Make motion tiers executable across CSS and components

**Target outcome:** Repeated controls and panel replacement consume the project's documented tiers without erasing the distinction between them.

**Root cause:** The foundation documents durations but provides no shared consumption path or regression guard, so components duplicate literals.

**Evidence and reach:** The intended tiers are defined at `src/styles/motion.css:4-5`; tabs and menu bypass them at `src/ui/tabs.tsx:75` and `src/ui/menu.css:32`. Two independent declarations qualify as a trend.

**Why it matters:** One local duration edit would leave the policy unenforced and allow equivalent interactions to drift again.

**Primary ownership layer:** Foundation/token.

**Affected files and consumers:** Define framework-compatible CSS and component representations in the motion foundation; migrate tabs and menu first; search the frontend for remaining duration literals before claiming full adoption.

**Apply in this order:**

1. Choose one canonical semantic vocabulary for control feedback and panel replacement.
2. Expose equivalent values to CSS and component animation without duplicating numeric sources where the build permits.
3. Replace the evidenced 310ms and 420ms literals with the appropriate semantic tiers.
4. Preserve any documented one-time expressive tier; do not force marketing entrances into the repeated-control tier.
5. Add a source or unit check that detects unsupported repeated-interaction duration literals.

**Implementation risks:** A mechanical replacement can map interactions to the wrong tier; globally shortening durations can break transition-end-dependent cleanup; tooling enforcement may flag legitimate data or test values.

**Verification:** Inspect all frontend duration declarations, run interaction tests for normal and interrupted entry/exit, and review control versus panel pacing in normal and reduced-motion modes.

**Done when:** The evidenced tabs and menu declarations use named semantic tiers; unsupported interaction-duration literals are absent from the searched frontend scope or documented as exceptions; exits and interruptions still complete their state cleanup.

## Foundation-first roadmap

1. Establish the executable motion vocabulary (IQ-02) so the tabs fix consumes the final tier rather than introducing another temporary literal.
2. Restore the tabs geometry contract (IQ-01) and protect it at the primitive.
3. Verify Settings and Billing without adding consumer-specific geometry patches.
4. Run the motion-literal search and interaction suite as regression gates.

The order is foundation-first, but the two implementation branches can proceed in parallel after tier names and ownership are agreed.
