# Example: Adapt a Legacy Media Screen

## Scenario

An iPhone/iPad media app has:

- A custom blurred navigation bar.
- A custom floating tab bar made from capsules.
- Album cards with `.ultraThinMaterial` backgrounds.
- A custom bottom player capsule.
- A settings sheet with `presentationBackground(.thinMaterial)`.
- A blue search-shaped tab that actually creates a playlist.

The request is “make everything Liquid Glass.”

## Incorrect First Pass

- Replace every `.ultraThinMaterial` with `.glassEffect()`.
- Put all cards in one `GlassEffectContainer`.
- Add `.interactive()` to cards for liveliness.
- Keep the fake search tab because it matches the desired separated pill.

This increases material usage while preserving the wrong architecture. Content looks interactive,
the tab semantics are false, and system components cannot adapt.

## Step 1: Diagnose Layers

| Element | Layer | Decision |
|---|---|---|
| Album art/cards | Content | Keep non-glass; use layout and content styling |
| Navigation bar | System functional | Restore `NavigationStack` toolbar; remove custom blur |
| Tab bar | System functional | Restore semantic `TabView` |
| Create-playlist action | Functional action | Put in toolbar/safe-area action, not a search tab |
| Bottom player | Custom functional | Candidate for one restrained glass surface |
| Settings sheet | System presentation | Remove custom presentation material and test detents |

## Step 2: Restore System Structure

- Move top actions into `.toolbar` and group related actions.
- Use real `Tab` values for Library, Browse, and Search.
- Give Search an actual search role and scope `searchable` to the correct container.
- Place Create Playlist as a labeled toolbar or prominent action.
- Use a native sheet with medium/large detents.

At this point, rebuild and inspect automatic Liquid Glass before adding a custom effect.

## Step 3: Remove Conflicts

- Delete custom navigation/tab backgrounds.
- Remove `presentationBackground(.thinMaterial)`.
- Remove material from album cards; restore content hierarchy through spacing, typography, and
  artwork.
- Remove fixed toolbar padding and legacy corner radii.

## Step 4: Justify the Player

Rationale:

> The mini-player is a persistent transport control floating above changing media content. Liquid
> Glass distinguishes the functional controls while allowing the content context to remain visible.

Use a semantic group of buttons and labels. Start with one regular glass capsule around the player,
or peer glass buttons inside one small container if their independent interaction genuinely matters.
Do not apply glass to both the parent capsule and child buttons.

## Step 5: Consider Motion

If tapping the mini-player opens the full player, use a source-destination navigation/presentation
transition when it communicates continuity. Do not use `glassEffectUnion` merely because both views
contain album art.

## Step 6: Verify

- Light/dark over bright and dark artwork.
- Search/tab semantics with VoiceOver.
- Create Playlist remains a button, not a fake tab.
- Medium and large settings-sheet states.
- Dynamic Type impact on player geometry.
- Scroll behavior beneath toolbars/tab bar.
- Device performance during artwork animation and player expansion.

## Result

The adapted interface contains less custom glass than requested, yet feels more like the Apple
design because the structure, semantics, hierarchy, and system components now participate in the
platform.
