# Open-Source SwiftUI and Liquid Glass Implementations

## Contents

- [Use](#use)
- [High-Signal App Repositories](#high-signal-app-repositories)
- [Official Sample](#official-sample)
- [Repository Review Procedure](#repository-review-procedure)
- [Anti-Pattern](#anti-pattern)

## Use

Use these repositories to inspect real project organization, availability boundaries, custom
control placement, and failure tradeoffs. They are not normative design authorities. Check the
current license before copying code; prefer learning the pattern and writing a project-specific
implementation.

Repository statistics are snapshots from 2026-07-23.

## High-Signal App Repositories

### XITRIX/iTorrent

- Repository: [XITRIX/iTorrent](https://github.com/XITRIX/iTorrent)
- Snapshot: 3.1K stars, MIT, active 2026-07-23
- Platforms: iOS and tvOS
- Evidence:
  [CompatibilityGlass.swift](https://github.com/XITRIX/iTorrent/blob/e95af51ff84b45f4a5de075aa024a75ed2a19bdb/iTorrent/Utils/Extensions/SwiftUI/CompatibilityGlass.swift)
- Inspect for:
  - one availability wrapper for container, effect, transition, and ID behavior;
  - platform branching for visionOS;
  - semantic material fallback.
- Pressure-test:
  - a global convenience wrapper can make glass too easy to apply;
  - prefer explicit component boundaries when design intent matters.

### Shpigford/clearly

- Repository: [Shpigford/clearly](https://github.com/Shpigford/clearly)
- Snapshot: 1.1K stars, source-available license marker, active 2026-05-27
- Platforms: macOS, iOS, iPadOS
- Evidence:
  [BottomToolbar.swift](https://github.com/Shpigford/clearly/blob/06e3e01670d9cb89ca99061271a72a4c1797a1b2/Clearly/BottomToolbar.swift)
- Inspect for:
  - a floating functional toolbar above document content;
  - explicit availability split;
  - content inset reserved so the overlay does not hide text;
  - selection tint, accessible labels, and Reduce Motion handling.
- Pressure-test:
  - platform-specific sizing should not be copied into iOS without adaptation.

### mudkipme/MoeMemos

- Repository: [mudkipme/MoeMemos](https://github.com/mudkipme/MoeMemos)
- Snapshot: 841 stars, MPL-2.0, active 2026-07-14
- Platforms: iPhone/iPad
- Evidence:
  - [MemoEditorToolbar.swift](https://github.com/mudkipme/MoeMemos/blob/3131dcfa2b69a5ffb8ccde6c6b673492d6593821/Packages/MemoKit/Sources/MemoKit/Editor/Components/MemoEditorToolbar.swift)
  - [AsyncThumbnailImage.swift](https://github.com/mudkipme/MoeMemos/blob/3131dcfa2b69a5ffb8ccde6c6b673492d6593821/Packages/MemoKit/Sources/MemoKit/Components/AsyncThumbnailImage.swift)
- Inspect for:
  - functional editing control plane with earlier material fallback;
  - clear glass play control over rich video imagery.
- Pressure-test:
  - custom background inside glass should be evaluated against current HIG;
  - the play image should retain Button semantics when it is actionable.

### Dimillian/PokeSwift

- Repository: [Dimillian/PokeSwift](https://github.com/Dimillian/PokeSwift)
- Snapshot: 364 stars, active 2026-03-19
- Platforms: SwiftUI game UI across Apple platforms
- Evidence:
  - [BattleStatusCard.swift](https://github.com/Dimillian/PokeSwift/blob/8fc87c2903462b1b0275b5fff345219e53d2f4fd/Sources/PokeUI/Scenes/Battle/BattleStatusCard.swift)
  - [GameplaySidebarPrimitives.swift](https://github.com/Dimillian/PokeSwift/blob/8fc87c2903462b1b0275b5fff345219e53d2f4fd/Sources/PokeUI/Scenes/Field/GameplaySidebarPrimitives.swift)
  - [GameBoyChrome.swift](https://github.com/Dimillian/PokeSwift/blob/8fc87c2903462b1b0275b5fff345219e53d2f4fd/Sources/PokeUI/Shared/GameBoyChrome.swift)
- Inspect for:
  - expressive content-specific visual language;
  - custom functional chrome separated from gameplay;
  - shared primitives and platform adaptation.
- Pressure-test:
  - game UI tolerates custom behavior that a utility app may not.

### olvid-io/olvid-ios

- Repository: [olvid-io/olvid-ios](https://github.com/olvid-io/olvid-ios)
- Snapshot: 77 stars, AGPL-3.0, active 2026-06-15
- Platform: production-scale iOS messaging client
- Evidence:
  - [GlassStyleUtils.swift](https://github.com/olvid-io/olvid-ios/blob/400dbc4150fc4e68ab74c42269a2e5ef069c13ba/Sources/App/ObvComposition/Sources/Utils/GlassStyleUtils.swift)
  - [ObvPlusButton.swift](https://github.com/olvid-io/olvid-ios/blob/400dbc4150fc4e68ab74c42269a2e5ef069c13ba/Sources/App/ObvDesignSystem/Sources/SwiftUI/ObvPlusButton/ObvPlusButton.swift)
  - [ComposeView.swift](https://github.com/olvid-io/olvid-ios/blob/400dbc4150fc4e68ab74c42269a2e5ef069c13ba/Sources/App/ObvComposition/Sources/Views/ComposeView.swift)
- Inspect for:
  - a shared style boundary in a large modular codebase;
  - repeated composer/control use cases;
  - availability and design-system integration.
- License note: AGPL requires careful review before copying.

### xmtplabs/convos-ios

- Repository: [xmtplabs/convos-ios](https://github.com/xmtplabs/convos-ios)
- Snapshot: active 2026-07-23
- Platform: iOS private messaging/agent app
- Evidence:
  - [MessagesBottomBar.swift](https://github.com/xmtplabs/convos-ios/blob/16fa8aacbaaba43219623907a862141e7fb0feda/ConvosCore/Sources/ConvosComposer/MessagesBottomBar.swift)
  - [ContactsSearchBar.swift](https://github.com/xmtplabs/convos-ios/blob/16fa8aacbaaba43219623907a862141e7fb0feda/Convos/Contacts/ContactsSearchBar.swift)
  - [InviteCodeOverlay.swift](https://github.com/xmtplabs/convos-ios/blob/16fa8aacbaaba43219623907a862141e7fb0feda/Convos/Conversation%20Detail/InviteCodeOverlay.swift)
  - [AgentContactCardChip.swift](https://github.com/xmtplabs/convos-ios/blob/16fa8aacbaaba43219623907a862141e7fb0feda/Convos/Agent%20Builder/AgentContactCardChip.swift)
- Inspect for:
  - composer bars, overlays, chips, and control clusters;
  - many feature-local custom surfaces in an active app.
- Pressure-test:
  - frequency of glass API use is not evidence that every placement is HIG-optimal.

### artemnovichkov/iOS-26-by-Examples

- Repository: [artemnovichkov/iOS-26-by-Examples](https://github.com/artemnovichkov/iOS-26-by-Examples)
- Snapshot: 100 stars, MIT
- Evidence:
  - [GlassEffectView.swift](https://github.com/artemnovichkov/iOS-26-by-Examples/blob/3925d51bd4a22893848448f8a3ea096f1b363dde/iOS-26-by-Examples/Views/GlassEffectView.swift)
  - [GlassEffectContainerView.swift](https://github.com/artemnovichkov/iOS-26-by-Examples/blob/3925d51bd4a22893848448f8a3ea096f1b363dde/iOS-26-by-Examples/Views/GlassEffectContainerView.swift)
- Inspect for:
  - minimal API demonstrations;
  - isolated learning examples.
- Pressure-test:
  - a demonstration intentionally omits product architecture and full state/accessibility context.

### classicsc/MaruReader

- Repository: [classicsc/MaruReader](https://github.com/classicsc/MaruReader)
- Snapshot: GPL-3.0, active 2026-07-21
- Platform: iOS reading/study app
- Evidence:
  - [WebViewerBottomToolbarView.swift](https://github.com/classicsc/MaruReader/blob/5b39be44fe044449bf783439a83459aa28c8b9c7/MaruWeb/Views/WebViewerBottomToolbarView.swift)
  - [WebViewerNavigationClusterView.swift](https://github.com/classicsc/MaruReader/blob/5b39be44fe044449bf783439a83459aa28c8b9c7/MaruWeb/Views/WebViewerNavigationClusterView.swift)
  - [WebReadingModeOverlay.swift](https://github.com/classicsc/MaruReader/blob/5b39be44fe044449bf783439a83459aa28c8b9c7/MaruWeb/Views/WebReadingModeOverlay.swift)
- Inspect for:
  - content-first reader surfaces with floating toolbars and overlays;
  - multiple controls sharing a functional plane.
- License note: GPL requires careful review before copying.

### castdrian/AudioYoink

- Repository: [castdrian/AudioYoink](https://github.com/castdrian/AudioYoink)
- Snapshot: iOS Swift app
- Evidence:
  - [SearchToolbar.swift](https://github.com/castdrian/AudioYoink/blob/1474d8691a01ba7abc153001cc62172daff78308/AudioYoink/Views/Components/SearchToolbar.swift)
  - [SiteStatusView.swift](https://github.com/castdrian/AudioYoink/blob/1474d8691a01ba7abc153001cc62172daff78308/AudioYoink/Views/SiteStatusView.swift)
  - [AutocompleteView.swift](https://github.com/castdrian/AudioYoink/blob/1474d8691a01ba7abc153001cc62172daff78308/AudioYoink/Views/AutocompleteView.swift)
- Inspect for:
  - search/control surfaces and compact status elements.

### Eslzzyl/Pixiv-SwiftUI

- Repository: [Eslzzyl/Pixiv-SwiftUI](https://github.com/Eslzzyl/Pixiv-SwiftUI)
- Snapshot: 76 stars, AGPL-3.0, active 2026-06-19
- Platforms: iOS, iPadOS, macOS
- Inspect for:
  - media-rich adaptive layout;
  - current SwiftUI project organization;
  - platform-specific content/navigation relationships.
- License note: AGPL requires careful review before copying.

## Official Sample

- [Landmarks: Building an app with Liquid Glass](https://developer.apple.com/documentation/swiftui/landmarks-building-an-app-with-liquid-glass)
  is the normative implementation reference. Prefer it over third-party code for API intent.

## Repository Review Procedure

When using a repository:

1. Open the specific file and its nearby view hierarchy.
2. Read deployment/platform guards.
3. Identify whether the surface is content or functional chrome.
4. Check Button/accessibility semantics.
5. Check how content avoids the overlay.
6. Check fallback behavior.
7. Read the license.
8. Recreate only the general pattern needed by the current product.

## Anti-Pattern

Do not rank examples by stars alone. A small active app may demonstrate the exact API boundary more
clearly than a popular repository, and a popular app may carry product-specific tradeoffs that do
not transfer.
