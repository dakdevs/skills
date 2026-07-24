# Source and Adaptation Notes

## Origin

- Primary title: SwiftUI documentation, Human Interface Guidelines, and Liquid Glass guidance
- Primary author or organization: Apple Inc.
- Primary URL: https://developer.apple.com/documentation/swiftui
- Community source type: Agent skills indexed by skills.sh and their public GitHub repositories
- Implementation source type: Public SwiftUI application repositories
- Date accessed: 2026-07-23
- Snapshot caveat: stars, installs, SDK availability, and prerelease behavior change over time

## Adaptation Scope

This skill tree is an authored synthesis. It converts the sources into an operational path a
designer can use with an agent: define the product, generate and compare interface directions,
implement a small SwiftUI architecture, apply Liquid Glass intentionally, and verify the result in
Xcode. It is not a verbatim copy of Apple documentation, community skills, or repository code.

Apple documentation is authoritative for APIs, availability, and platform behavior. Community
skills contribute routing, failure cases, and practical review ideas. Open-source apps provide
evidence of how teams isolate availability, group glass, structure features, and use the APIs in
real interfaces.

## Research Method

1. Searched skills.sh for SwiftUI, iOS design, Liquid Glass, layout, performance, accessibility, and
   iOS 26 platform skills.
2. Ranked relevant results by direct task fit, install count, repository activity, reference depth,
   security-audit status, and originality.
3. Cloned the leading public skill repositories at a specific commit and inspected their routers
   and relevant reference documents.
4. Read current Apple SwiftUI, Liquid Glass, HIG, WWDC25, and WWDC26 material.
5. Searched public Swift code for `glassEffect`, `GlassEffectContainer`, glass button styles, and
   `glassEffectID`, then inspected repository metadata and representative paths.
6. Resolved disagreements in favor of current Apple documentation and locally installed SDK
   behavior.

## Leading skills.sh Sources

Install and star counts are snapshots observed on 2026-07-23.

| Skill | Snapshot | What informed this tree | Boundary |
|---|---:|---|---|
| [swiftui-expert-skill](https://skills.sh/avdlee/swiftui-agent-skill/swiftui-expert-skill) by AvdLee | 27.1K installs, 3.3K stars | Correctness rules, API currency, state ownership, view structure, previews, accessibility, performance, availability | Broader review skill; this tree adds designer-to-app workflow and current Xcode 27 context |
| [mobile-ios-design](https://skills.sh/wshobson/agents/mobile-ios-design) by wshobson | 19.0K installs, 38.2K stars | HIG-first navigation, layouts, semantic system styling, state restoration, iPad and accessibility awareness | Useful overview but not a full implementation and verification loop |
| [swiftui-performance-audit](https://skills.sh/dimillian/skills/swiftui-performance-audit) by Dimillian | 7.9K installs, 3.8K stars | Code-first diagnosis followed by Instruments when runtime evidence is needed | Performance is one route here, not the product workflow |
| [swiftui-liquid-glass](https://skills.sh/dimillian/skills/swiftui-liquid-glass) by Dimillian | 3.6K installs, 3.8K stars | Native glass API selection, modifier order, grouping, interactivity, morphing, fallbacks | Some design guidance was tightened against current HIG |
| [swiftui-ui-patterns](https://skills.sh/dimillian/skills/swiftui-ui-patterns) by Dimillian | 3.0K installs, 3.8K stars | Feature wiring, enum-driven navigation and sheets, async state, small views, previews | This tree adds a design-facing front end and comprehensive checks |
| [swiftui-view-refactor](https://skills.sh/dimillian/skills/swiftui-view-refactor) by Dimillian | 1.9K installs, 3.8K stars | Small stable view types, explicit dependencies, MV-first defaults, thin body actions | Refactoring guidance only |
| [ios-26-platform](https://skills.sh/johnrogers/claude-swift-engineering/ios-26-platform) by John Rogers | 35 weekly installs at snapshot | Automatic Liquid Glass adoption, navigation-layer discipline, migration awareness | Several numeric heuristics were not treated as normative |
| [axiom-liquid-glass](https://skills.sh/charleswiltgen/axiom/axiom-liquid-glass) by Charles Wiltgen | 244 installs, 1.1K stars | Material layer model, variant discipline, visual failure modes, review pressure | Apple docs remain authoritative |
| [axiom-liquid-glass-ref](https://skills.sh/charleswiltgen/axiom/axiom-liquid-glass-ref) by Charles Wiltgen | 204 installs, 1.1K stars | App-wide adoption, system-first migration, platform and accessibility audit ideas | Large reference distilled into focused local routes |
| [axiom-swiftui-layout](https://skills.sh/charleswiltgen/axiom/axiom-swiftui-layout) by Charles Wiltgen | 231 installs, 1.1K stars | Container-driven layout and warnings about idiom/size-class assumptions in resizable apps | Device specifics must be rechecked against the active SDK |
| [axiom-swiftui-performance](https://skills.sh/charleswiltgen/axiom/axiom-swiftui-performance) by Charles Wiltgen | 226 installs, 1.1K stars | SwiftUI Instrument, cause/effect reasoning, update and body-cost checks | Diagnostic depth is routed on demand |
| [axiom-ios-accessibility](https://skills.sh/charleswiltgen/axiom/axiom-ios-accessibility) by Charles Wiltgen | 211 installs, 1.1K stars | VoiceOver, Dynamic Type, contrast, touch target, and review routing | Accessibility requirements are integrated into every workflow here |

Additional high-quality repository source:

- [SwiftUI Pro](https://github.com/twostraws/swiftui-agent-skill) by Paul Hudson informed concise
  modern-Swift defaults, feature-oriented files, HIG review, and practical accessibility checks.
  Its skills.sh page was not reliably retrievable during research, so no install count is claimed.

## Primary Apple Sources

The core primary sources are:

- [SwiftUI](https://developer.apple.com/documentation/swiftui)
- [Adopting Liquid Glass](https://developer.apple.com/documentation/TechnologyOverviews/adopting-liquid-glass)
- [Applying Liquid Glass to custom views](https://developer.apple.com/documentation/swiftui/applying-liquid-glass-to-custom-views)
- [Landmarks: Building an app with Liquid Glass](https://developer.apple.com/documentation/swiftui/landmarks-building-an-app-with-liquid-glass)
- [Human Interface Guidelines: Materials](https://developer.apple.com/design/human-interface-guidelines/materials)
- [Meet Liquid Glass, WWDC25](https://developer.apple.com/videos/play/wwdc2025/219/)
- [Build a SwiftUI app with the new design, WWDC25](https://developer.apple.com/videos/play/wwdc2025/323/)
- [Optimize SwiftUI performance with Instruments, WWDC25](https://developer.apple.com/videos/play/wwdc2025/306/)
- [Create UI prototypes using agents in Xcode, WWDC26](https://developer.apple.com/videos/play/wwdc2026/227/)
- [Xcode, agents, and you, WWDC26](https://developer.apple.com/videos/play/wwdc2026/259/)
- [What's new in SwiftUI, WWDC26](https://developer.apple.com/videos/play/wwdc2026/269/)
- [WWDC26 SwiftUI guide](https://developer.apple.com/wwdc26/guides/swiftui/)

See `source-map.md` and `references/apple-documentation-index.md` for the complete categorized
inventory.

## Open-Source Implementation Sources

Representative repositories were selected for actual native API use, activity, educational value,
and variety rather than stars alone:

- [XITRIX/iTorrent](https://github.com/XITRIX/iTorrent)
- [Shpigford/clearly](https://github.com/Shpigford/clearly)
- [mudkipme/MoeMemos](https://github.com/mudkipme/MoeMemos)
- [Dimillian/PokeSwift](https://github.com/Dimillian/PokeSwift)
- [olvid-io/olvid-ios](https://github.com/olvid-io/olvid-ios)
- [xmtplabs/convos-ios](https://github.com/xmtplabs/convos-ios)
- [artemnovichkov/iOS-26-by-Examples](https://github.com/artemnovichkov/iOS-26-by-Examples)
- [classicsc/MaruReader](https://github.com/classicsc/MaruReader)
- [castdrian/AudioYoink](https://github.com/castdrian/AudioYoink)
- [Eslzzyl/Pixiv-SwiftUI](https://github.com/Eslzzyl/Pixiv-SwiftUI)

Specific paths, commit links, observed patterns, and licenses are recorded in
`references/open-source-implementation-index.md`.

## Source-Derived Operating Model

| Source contribution | Local adaptation |
|---|---|
| Apple HIG material hierarchy | `references/liquid-glass-design.md`, `patterns/functional-glass-layer.md` |
| Apple SwiftUI API docs and Landmarks | `references/liquid-glass-api.md`, `examples/media-controls-glass.md` |
| Apple Xcode agent and prototyping sessions | `workflows/prototype-and-iterate.md`, `workflows/build-run-verify.md` |
| Popular SwiftUI skill correctness checks | `references/state-and-data-flow.md`, `checks/implementation-review.md` |
| UI-pattern skills | `references/navigation-and-presentation.md`, `patterns/adaptive-app-shell.md` |
| Performance skills and WWDC session | `references/performance.md` |
| Open-source apps | `references/open-source-implementation-index.md`, migration and cluster patterns |

## Gaps and Assumptions

- Apple documentation and beta SDKs can change after the access date.
- Xcode 27 and 2027 OS features may be beta on the user's machine. The skill therefore requires
  toolchain inspection and does not blindly adopt them.
- GitHub code search is not proof that a whole app follows HIG or uses Liquid Glass well. Cited
  repositories are examples to inspect, not blanket endorsements.
- Community skill popularity is not correctness. Install counts informed discovery, not authority.
- The skill does not redistribute Apple sample projects, third-party source code, or imagery.

## Source Credit

Apple is credited as the authoritative source for SwiftUI, Liquid Glass, Human Interface
Guidelines, Xcode, and platform behavior. The community authors and skills.sh entries named above
are credited for practical agent-routing and review ideas. The GitHub projects named above are
credited only for the implementation patterns observed at the linked commits. Full URLs,
snapshots, license notes, and local adaptations are preserved in this file, `source-map.md`, and
`references/open-source-implementation-index.md`.

## Copyright and License Handling

- No long source passages or copied tables are included.
- Code patterns are independently written from public API signatures and common SwiftUI usage.
- Repository links include license notes where known; future agents must inspect the current license
  before adapting third-party code.
- Source credits and direct links are preserved so claims can be rechecked.
