# Pattern: Lived-In Prototype

## Problem

Uniform placeholder data makes weak layouts appear successful.

## Pattern

Create a small cast of realistic synthetic scenarios:

| Fixture | Exposes |
|---|---|
| First use | onboarding and primary action |
| Normal use | everyday hierarchy |
| Power user | density and performance |
| Long content | wrapping and localization |
| Partial/offline | status and recovery |
| Error/permission denied | trust and alternatives |

Use varied names, dates, quantities, media aspect ratios, and relationships. Keep data synthetic.

## Procedure

1. Derive fixtures from the product entity model.
2. Give each fixture a narrative, not just a count.
3. Reuse it across previews and tests.
4. Render the same screen across fixtures.
5. Fix hierarchy before adjusting effects.

## Verification

- No lorem ipsum or `Item 1`.
- Empty and dense states feel like the same product.
- Long text does not clip.
- Content behind glass spans bright/dark/busy cases.
- Tests do not depend on current time or network.
