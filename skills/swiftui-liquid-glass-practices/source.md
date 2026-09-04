# Source and Adaptation Notes

## Origin

- **Primary source family:** Apple Liquid Glass technology overview, adoption guide, Human
  Interface Guidelines, SwiftUI API documentation, WWDC25 sessions, and Landmarks sample.
- **Primary author/organization:** Apple Inc.
- **Root URL:** https://developer.apple.com/documentation/TechnologyOverviews/liquid-glass
- **Source types:** Documentation site, design guidance, video transcripts, sample code, and PDF.
- **Supporting sources:** Inspectable open-source repositories, production retrospectives,
  specialist implementation articles, an independent usability critique, and two design studies.
- **Research date:** 2026-09-03.

## Adaptation Scope

This skill tree is an authored synthesis. It transforms source material into task routing,
decision rules, workflows, implementation patterns, anti-patterns, verification gates, examples,
and evals. It is not a verbatim copy of Apple documentation or any third-party source.

Apple sources determine intended design behavior and current API semantics. Third-party sources
are used to expose production constraints, compatibility techniques, failure modes, and risky
alternatives. No repository code is copied into this package.

## Primary Apple Sources

- [Liquid Glass technology overview](https://developer.apple.com/documentation/TechnologyOverviews/liquid-glass)
- [Adopting Liquid Glass](https://developer.apple.com/documentation/TechnologyOverviews/adopting-liquid-glass)
- [Human Interface Guidelines: Materials](https://developer.apple.com/design/human-interface-guidelines/materials)
- [Applying Liquid Glass to custom views](https://developer.apple.com/documentation/swiftui/applying-liquid-glass-to-custom-views)
- [View.glassEffect(_:in:)](https://developer.apple.com/documentation/swiftui/view/glasseffect(_:in:))
- [GlassEffectContainer](https://developer.apple.com/documentation/swiftui/glasseffectcontainer)
- [View.glassEffectID(_:in:)](https://developer.apple.com/documentation/swiftui/view/glasseffectid(_:in:))
- [View.glassEffectUnion(id:namespace:)](https://developer.apple.com/documentation/swiftui/view/glasseffectunion(id:namespace:))
- [View.glassEffectTransition(_:)](https://developer.apple.com/documentation/swiftui/view/glasseffecttransition(_:))
- [Build a SwiftUI app with the new design](https://developer.apple.com/videos/play/wwdc2025/323/)
- [Meet Liquid Glass](https://developer.apple.com/videos/play/wwdc2025/219/)
- [Get to know the new design system](https://developer.apple.com/videos/play/wwdc2025/356/)
- [Optimize SwiftUI performance with Instruments](https://developer.apple.com/videos/play/wwdc2025/306/)
- [Landmarks: Building an app with Liquid Glass](https://developer.apple.com/documentation/swiftui/landmarks-building-an-app-with-liquid-glass)
- [New features available with iOS 26 (PDF)](https://www.apple.com/os/pdf/All_New_Features_iOS_26_Sept_2025.pdf)

## Supporting Implementation Sources

- [Jellyfin/Swiftfin](https://github.com/jellyfin/Swiftfin) — large production SwiftUI app with
  availability-gated Liquid Glass use and legacy styling.
- [sozercan/kaset](https://github.com/sozercan/kaset) — production macOS SwiftUI app documenting
  functional-layer use, fallbacks, transition selection, and glass-on-glass avoidance.
- [GetStream/awesome-liquid-glass](https://github.com/GetStream/awesome-liquid-glass) — native
  animation example gallery; useful for discovery, not an authority or production framework.
- [BarredEwe/LiquidGlass](https://github.com/BarredEwe/LiquidGlass) — custom Metal renderer showing
  update-mode, GPU, and optical-emulation tradeoffs.
- [rryam/LiquidGlasKit](https://github.com/rryam/LiquidGlasKit) — hybrid Swift package with native
  platform-26 behavior and older-system fallbacks.
- [DnV1eX/LiquidGlassKit](https://github.com/DnV1eX/LiquidGlassKit) — Metal backport and customized
  components; valuable chiefly as a private-API and App Store risk case study.
- [superwall/iOS-Backports](https://github.com/superwall/iOS-Backports) — centralized availability
  wrapper pattern.
- [ryanashcraft/FabBar](https://github.com/ryanashcraft/FabBar) — explicit case study in semantic
  compromises and internal UIKit hierarchy brittleness.
- [noppefoxwolf/MergeableView](https://github.com/noppefoxwolf/MergeableView) — focused drag-to-merge
  package built around native glass effects.
- [mertozseven/LiquidGlassSwiftUI](https://github.com/mertozseven/LiquidGlassSwiftUI) — compact
  native morphing example.

Repository stars were sampled on 2026-09-03 and are deliberately not embedded as durable facts in
the operational guidance. Popularity helped locate examples; it did not determine correctness.

## Supporting Articles and Studies

- Natalia Panferova, [Presenting Liquid Glass sheets in SwiftUI on iOS 26](https://nilcoalescing.com/blog/PresentingLiquidGlassSheetsInSwiftUI/), 2025-07-18.
- Natalia Panferova, [SwiftUI Liquid Glass sheets with NavigationStack and Form](https://nilcoalescing.com/blog/LiquidGlassSheetsWithNavigationStackAndForm/), 2025-09-09.
- Blake Crosley, [Liquid Glass in SwiftUI: Three Patterns From Shipping Return on iOS 26](https://blakecrosley.com/blog/liquid-glass-swiftui-patterns), 2026-04-29.
- Raluca Budiu, Nielsen Norman Group, [Liquid Glass Is Cracked, and Usability Suffers in iOS 26](https://www.nngroup.com/articles/liquid-glass/), 2025-10-10.
- Simon Lou, [Designing with an Opinion (PDF)](https://thesis.simonlou.com/media/site/c34a8e6511-1769339262/simonlou-thesis.pdf), 2026. This is observational design research, not an HCI usability study.
- I Wayan Brahmani Novus and I Gede Santi Astawa, [Liquid Glass redesign study](https://ejournal2.unud.ac.id/index.php/jnatia/en/article/view/86), 2026. Its sample of 15 users limits generalization.

## Source Quality and Conflict Policy

- Apple API documentation wins for signatures, availability, and framework behavior.
- Apple HIG wins for intended design use.
- Production reports may refine testing and architecture but cannot override API semantics.
- Independent criticism is used to strengthen accessibility and usability checks, not to negate
  the platform design wholesale.
- Beta-era bugs and workarounds are not treated as current without re-verification.
- Claims that visionOS exposes the same SwiftUI glass API are excluded because the inspected 2026
  API availability metadata does not list visionOS.
- Community tutorials sometimes say morphing views must share an ID. Apple examples instead give
  effects distinct identities; shared IDs belong to union groups. This tree follows Apple.

## Gaps and Freshness Risks

- Liquid Glass behavior can change between platform point releases and SDKs.
- Apple does not publish a universal effect-count or frame-time threshold.
- Some rendering defects are device-only and cannot be established from simulator results.
- Repository APIs, licenses, and star counts can change after the research date.
- Platform-specific visual output cannot be fully represented by static code examples.

Before implementing production code, confirm the current Xcode SDK declarations and rerun the
visual, accessibility, and performance matrices on target hardware.

## Copyright Handling

- Source recommendations are paraphrased.
- No long passages, source tables, or repository implementations are reproduced.
- Code examples are original compositions using public API names.
- Repository code with missing or unclear licensing is treated as inspection-only evidence.
