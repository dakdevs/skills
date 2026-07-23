# Example: Existing App Migration

## Starting App

A reading app supports iOS 17+. It has:

- a `TabView`;
- a `NavigationStack` in each tab;
- a custom blurred bottom reading toolbar;
- a custom search field inside a toolbar;
- `presentationBackground(.ultraThinMaterial)` on settings sheets;
- content cards using `Material`.

## Baseline

Record screenshots and runtime behavior on the existing stable SDK. Build, run search, open a book,
use reading controls, and present settings.

## Automatic Adoption Audit

After building with the iOS 26-aligned SDK:

| Area | Observation | Action |
|---|---|---|
| Tab bar | System adopts new functional material | Keep system |
| Navigation/toolbar | System adopts glass and edge behavior | Remove custom background |
| Search | Custom field conflicts with platform placement | Replace with `.searchable` |
| Settings sheet | Custom presentation material fights system | Remove and retest |
| Reading toolbar | Product-specific floating controls remain | Candidate for custom glass |
| Content cards | Still content | Keep semantic content treatment, no glass |

## Migration Slice 1

Remove interference only. Build and compare. Do not add custom glass yet.

Verification:

- tab/navigation/search/sheet behavior;
- scrolling under chrome;
- light/dark;
- iOS 17 appearance unchanged.

## Migration Slice 2

Refactor reading controls into:

```text
ReadingControlPlane
  -> iOS 26 GlassReadingControls
  -> iOS 17 StandardReadingControls
```

Both branches share actions and state. The modern branch uses one container. Only the most important
control is tinted.

## Migration Slice 3

Add an optional morph from compact controls to expanded playback settings only if it preserves the
identity of the same control plane. Provide immediate/reduced-motion behavior.

## Verification Matrix

- iOS 17 fallback;
- iOS 26 current stable appearance;
- newest beta only when explicitly in scope;
- narrow/wide and iPad split;
- bright/dark pages;
- large text;
- Reduce Transparency, Increase Contrast, Reduce Motion;
- interrupted expand/collapse;
- rapid page scroll;
- VoiceOver labels/order.

## Adoption Report

| Area | Automatic | Custom | Fallback | Evidence |
|---|---|---|---|---|
| App shell | tab/navigation | none | system | screenshots + runtime |
| Search | system `.searchable` | none | system | keyboard/focus run |
| Settings | system sheet | none | system | sheet run |
| Reader controls | no | one grouped plane | material group | matrix |
| Content cards | no | intentionally no glass | semantic fill | design review |

## Lesson

Most of the migration is deletion and system adoption. Custom glass is reserved for the one
product-specific floating control plane.
