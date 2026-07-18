# Source and Adaptation Notes

## Origin

- Title: Human Interface Guidelines
- Author or organization: Apple Inc.
- URL: https://developer.apple.com/design/human-interface-guidelines
- Source type: Live documentation site backed by Apple DocC JSON
- Date accessed: 2026-07-18
- Languages observed at the root: English, Japanese, Korean, and Simplified Chinese

## Adaptation Scope

This skill tree is an authored expansion of Apple HIG. It transforms the source into operational
routes, workflows, decision tables, patterns, checks, examples, and eval assertions. It is not a
verbatim copy and does not reproduce Apple's illustrations or detailed specification tables.

The requested platform terms map as follows:

- Phone -> iPhone and iOS.
- Native desktop -> Mac and macOS.
- Web -> a clearly labeled adaptation of shared HIG principles. Apple's HIG root covers Apple
  platforms and does not offer a "Designing for Web" platform page.

## Research Method

The traversal used Apple's live documentation data endpoints, beginning at:

`https://developer.apple.com/tutorials/data/design/human-interface-guidelines.json`

It recursively followed every local HIG topic identifier exposed by collection pages.

- 172 unique HIG pages inventoried.
- 0 fetch failures.
- Titles, abstracts, navigation relationships, and headings captured for all pages.
- Body-level extraction performed for 51 pages most relevant to shared design, Web adaptation,
  macOS, iPhone, components, inputs, patterns, and state handling.
- The complete inventory and depth marker appear in `source-map.md`.

## Primary Source Map

| Source area | Local documents | Adaptation |
|---|---|---|
| Design principles | `architecture.md`, `references/shared/principles-and-priorities.md` | Converted eight principles into priority and decision rules |
| Designing for iOS | `references/platforms/iphone.md`, `checks/iphone-review.md` | Converted device characteristics into structure, input, reach, and interruption checks |
| Designing for macOS | `references/platforms/macos.md`, `checks/macos-review.md` | Converted display, window, menu, keyboard, and pointer guidance into desktop behavior |
| Foundations | `references/shared/*.md` | Converted accessibility, layout, typography, color, material, motion, privacy, and writing into shared invariants |
| Patterns | `patterns/*.md`, `references/components/presentation-state-recovery.md` | Converted recurring tasks and failure states into procedures and recovery rules |
| Components | `references/components/*.md` | Converted component guidance into decision tables, not a component catalog |
| Inputs | `references/components/actions-input-feedback.md`, platform files | Converted gesture, keyboard, and pointing guidance into alternate-input requirements |
| Entire HIG navigation | `source-map.md` | Preserved the live page inventory and stable public URLs |

## Important Source-Derived Measurements

These are recorded for review context, not as universal Web CSS requirements:

| Item | iPhone/iOS | macOS | Source note |
|---|---:|---:|---|
| Default custom type reference | 17 pt | 13 pt | Accessibility and Typography |
| Minimum custom type reference | 11 pt | 10 pt | Accessibility and Typography |
| Default control size | 44x44 pt | 28x28 pt | Accessibility |
| Minimum control size | 28x28 pt | 20x20 pt | Accessibility |
| Text enlargement goal | 200% | 200% as a general accessibility goal | Accessibility; macOS has no Dynamic Type |

Use native semantic APIs and current platform resources rather than hard-coding system metrics.

## Gaps and Assumptions

- HIG is living documentation and can change after the access date.
- Web-specific browser behavior, HTML semantics, CSS, WCAG conformance procedures, and browser
  testing are outside the direct HIG source. The Web route flags this boundary.
- Native desktop is interpreted as macOS, not Windows or Linux, because the source is Apple HIG.
- iPadOS, tvOS, visionOS, watchOS, and games were inventoried but are not first-class routes in this
  package.
- Developer API implementation details are intentionally not duplicated; follow the current Apple
  developer links from the source when implementation depends on an API.

## Freshness Procedure

Before relying on time-sensitive specifications or newly introduced visual systems:

1. Open the referenced live HIG page.
2. Check its change log and supported platforms.
3. Prefer semantic system APIs over copied numeric or color values.
4. Record any material difference in the implementation or review report.

## Copyright Handling

- Long passages and full source tables were not copied.
- No Apple images or videos were reproduced.
- Source terminology is used only where necessary for accurate routing.
- The generated documents are original operational guidance based on the source.
