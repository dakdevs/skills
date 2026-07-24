# Source Inventory

## Purpose

This map records the external sources used to build the skill. Detailed Apple links are expanded in
`references/apple-documentation-index.md`; implementation repositories are expanded in
`references/open-source-implementation-index.md`.

## Apple Documentation and Design

| Source | Contribution | Target documents |
|---|---|---|
| [SwiftUI](https://developer.apple.com/documentation/swiftui) | Framework root, pathways, samples, current API map | All implementation references |
| [Adopting Liquid Glass](https://developer.apple.com/documentation/TechnologyOverviews/adopting-liquid-glass) | System-first adoption and migration framing | Liquid Glass workflow and checks |
| [Applying Liquid Glass to custom views](https://developer.apple.com/documentation/swiftui/applying-liquid-glass-to-custom-views) | Custom glass, grouping, tint, interaction, morphing | API reference and patterns |
| [Landmarks: Building an app with Liquid Glass](https://developer.apple.com/documentation/swiftui/landmarks-building-an-app-with-liquid-glass) | Complete sample architecture and custom glass examples | Examples and implementation index |
| [Glass](https://developer.apple.com/documentation/swiftui/glass) | Material variants and configuration | API reference |
| [GlassEffectContainer](https://developer.apple.com/documentation/swiftui/glasseffectcontainer) | Shared sampling, blending, morphing, performance | Glass cluster pattern |
| [glassEffect](<https://developer.apple.com/documentation/swiftui/view/glasseffect(_:in:)>) | Custom-view effect signature and behavior | API reference |
| [HIG: Materials](https://developer.apple.com/design/human-interface-guidelines/materials) | Functional/content layer separation and variant guidance | Design reference |
| [HIG: Design principles](https://developer.apple.com/design/human-interface-guidelines/design-principles) | Hierarchy, familiarity, flexibility, delight | Design review |
| [HIG: Designing for iOS](https://developer.apple.com/design/human-interface-guidelines/designing-for-ios) | iPhone characteristics and interaction | Product and layout references |
| [HIG: Designing for iPadOS](https://developer.apple.com/design/human-interface-guidelines/designing-for-ipados) | Multitasking, pointer, large canvas | Layout and navigation |
| [HIG: Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility) | Inclusive foundation | Accessibility reference |
| [HIG: Layout](https://developer.apple.com/design/human-interface-guidelines/layout) | Adaptation and hierarchy | Layout reference |
| [HIG: Navigation and search](https://developer.apple.com/design/human-interface-guidelines/navigation-and-search) | Navigation models and search | Navigation reference |
| [HIG: Motion](https://developer.apple.com/design/human-interface-guidelines/motion) | Purposeful motion and reduced motion | Motion reference |
| [HIG: Privacy](https://developer.apple.com/design/human-interface-guidelines/privacy) | Permission timing and data explanation | Privacy checks |

## Apple Sessions and Guides

| Source | Contribution | Target documents |
|---|---|---|
| [Meet Liquid Glass - WWDC25](https://developer.apple.com/videos/play/wwdc2025/219/) | Dynamics, adaptivity, visual principles | Liquid Glass design |
| [Get to know the new design system - WWDC25](https://developer.apple.com/videos/play/wwdc2025/356/) | Platform design adoption | Design and migration |
| [Build a SwiftUI app with the new design - WWDC25](https://developer.apple.com/videos/play/wwdc2025/323/) | App structure, toolbar, search, controls, custom glass | API and workflow |
| [What's new in SwiftUI - WWDC25](https://developer.apple.com/videos/play/wwdc2025/256/) | Automatic appearance, toolbar and performance updates | Availability and performance |
| [Optimize SwiftUI performance with Instruments - WWDC25](https://developer.apple.com/videos/play/wwdc2025/306/) | Update groups, body cost, cause/effect graph | Performance |
| [Create UI prototypes using agents in Xcode - WWDC26](https://developer.apple.com/videos/play/wwdc2026/227/) | Variations, realistic content, edge cases, tuning | Prototype workflow |
| [Xcode, agents, and you - WWDC26](https://developer.apple.com/videos/play/wwdc2026/259/) | Plan, build, preview, test, annotate, orchestrate | Build/verify workflow |
| [What's new in SwiftUI - WWDC26](https://developer.apple.com/videos/play/wwdc2026/269/) | Refreshed Liquid Glass, resizability, 2027 APIs | Availability and layout |
| [WWDC26 SwiftUI guide](https://developer.apple.com/wwdc26/guides/swiftui/) | Xcode 27 skills and current feature guide | Source freshness |
| [WWDC26 Design guide](https://developer.apple.com/wwdc26/guides/design/) | Current design sessions and resources | Product and review |

## skills.sh Inventory

| Source | Repository snapshot | Adapted capability |
|---|---|---|
| [AvdLee: swiftui-expert-skill](https://skills.sh/avdlee/swiftui-agent-skill/swiftui-expert-skill) | `f06d1437a3fbec7df6cdce93f77004e5409b31ee` | Correctness, state, APIs, preview, performance |
| [wshobson: mobile-ios-design](https://skills.sh/wshobson/agents/mobile-ios-design) | `c4b82b0ad771190355eb8e204b1329732a18449a` | HIG-first iOS interface patterns |
| [Dimillian: swiftui-liquid-glass](https://skills.sh/dimillian/skills/swiftui-liquid-glass) | `05ba982bfeb0d77d3c97d4542b0ee15034d05f84` | Focused custom-glass workflow |
| [Dimillian: swiftui-ui-patterns](https://skills.sh/dimillian/skills/swiftui-ui-patterns) | same repository snapshot | App wiring and component routes |
| [Dimillian: swiftui-view-refactor](https://skills.sh/dimillian/skills/swiftui-view-refactor) | same repository snapshot | Stable, small SwiftUI view structure |
| [Dimillian: swiftui-performance-audit](https://skills.sh/dimillian/skills/swiftui-performance-audit) | same repository snapshot | Code-first and Instruments diagnosis |
| [Axiom: axiom-liquid-glass](https://skills.sh/charleswiltgen/axiom/axiom-liquid-glass) | `df8b00f006d50fd9300f65229c8e27ae0dad7688` | Deep material discipline and review |
| [Axiom: axiom-liquid-glass-ref](https://skills.sh/charleswiltgen/axiom/axiom-liquid-glass-ref) | same repository snapshot | App-wide adoption |
| [Axiom: axiom-swiftui-layout](https://skills.sh/charleswiltgen/axiom/axiom-swiftui-layout) | same repository snapshot | Adaptive layout and current resizability |
| [Axiom: axiom-swiftui-performance](https://skills.sh/charleswiltgen/axiom/axiom-swiftui-performance) | same repository snapshot | Detailed performance diagnosis |
| [Axiom: axiom-ios-accessibility](https://skills.sh/charleswiltgen/axiom/axiom-ios-accessibility) | same repository snapshot | Accessibility routing |
| [John Rogers: ios-26-platform](https://skills.sh/johnrogers/claude-swift-engineering/ios-26-platform) | `1dc2cf4d020bd524168f20bec95104da6cb2888c` | Automatic adoption and backward compatibility |
| [Paul Hudson: SwiftUI Pro](https://github.com/twostraws/swiftui-agent-skill) | `be297ff80dddec529af1f9b1f1f114aab6c9d11c` | Concise modern SwiftUI review model |

## Real-World Repository Inventory

| Repository | Snapshot observation | Why included |
|---|---|---|
| [XITRIX/iTorrent](https://github.com/XITRIX/iTorrent) | 3.1K stars, active 2026-07-23, MIT | Large iOS app with current custom-glass transition usage |
| [Shpigford/clearly](https://github.com/Shpigford/clearly) | 1.1K stars, iOS/iPadOS/macOS | Multi-platform editor and current material usage |
| [mudkipme/MoeMemos](https://github.com/mudkipme/MoeMemos) | 841 stars, active 2026-07-19, MPL-2.0 | Mature SwiftUI app with modern platform adoption |
| [Dimillian/PokeSwift](https://github.com/Dimillian/PokeSwift) | 364 stars, multi-platform SwiftUI | Expressive custom UI and multiple glass use sites |
| [artemnovichkov/iOS-26-by-Examples](https://github.com/artemnovichkov/iOS-26-by-Examples) | 100 stars, MIT | Minimal examples for glass effects and containers |
| [olvid-io/olvid-ios](https://github.com/olvid-io/olvid-ios) | 77 stars, AGPL-3.0 | Production-scale iOS client with reusable glass utilities |
| [Eslzzyl/Pixiv-SwiftUI](https://github.com/Eslzzyl/Pixiv-SwiftUI) | 76 stars, AGPL-3.0 | iOS/iPadOS/macOS media app |
| [xmtplabs/convos-ios](https://github.com/xmtplabs/convos-ios) | Active 2026-07-23 | Many custom control and overlay glass use sites |
| [castdrian/AudioYoink](https://github.com/castdrian/AudioYoink) | iOS Swift app | Search toolbar and status/control examples |
| [classicsc/MaruReader](https://github.com/classicsc/MaruReader) | Active 2026-07-21, GPL-3.0 | Content-first reader with glass control chrome |

## Extraction Notes

- Core procedure: define product and states, use adaptive system shell, implement vertical slices,
  layer content beneath restrained functional glass, then preview/run/test/critique.
- Primary decision: system component or custom element. Prefer system.
- Primary glass decision: functional layer or content layer. Glass belongs in the functional layer.
- Primary availability decision: installed stable SDK or explicit beta.
- Primary architecture decision: state owner and information structure before view type.
- Primary verification decision: preview for composition, runtime for behavior, tests for logic and
  flows, Instruments for unresolved performance.

## Freshness Risks

- skills.sh counts are a dated snapshot.
- Xcode 27 and iOS 27 documentation can change during the beta cycle.
- GitHub repository stars, licenses, paths, and implementations can change.
- Apple may update default Liquid Glass appearance without source changes in an app.
