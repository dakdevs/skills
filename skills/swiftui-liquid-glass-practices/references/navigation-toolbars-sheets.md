# Navigation, Toolbars, Search, Tabs, and Sheets

## Use When

Adapting app structure or any system functional layer. Apply this reference before adding explicit
custom glass.

## Structural Principle

Navigation and controls should form a distinct functional layer above content. Standard SwiftUI
containers already know how to adapt their material, placement, focus, safe areas, and platform
behavior. Custom replicas inherit none of that automatically.

## Navigation and Sidebars

- Prefer `NavigationStack` for hierarchical flows and `NavigationSplitView` for multi-column
  structures.
- Let sidebars and inspectors float above or relate to content using system behavior.
- Audit safe areas so underlying content peeks through intentionally rather than being clipped.
- Use `backgroundExtensionEffect` for eligible hero/background imagery when extending the visual
  field behind a sidebar or inspector; do not move important content underneath it.
- Support arbitrary window sizes and fluid column resizing on iPad and Mac.

## Toolbars

- Group actions that affect the same object or perform related operations.
- Separate unrelated groups with `ToolbarSpacer` instead of arbitrary padding.
- Prefer familiar SF Symbols for common actions; do not mix icon-only and text-only styles inside a
  shared group without a reason.
- Give every icon-only action an accessibility label.
- Use tint only for semantic emphasis.
- Remove custom backgrounds and darkening layers that interfere with the system scroll-edge effect.
- Hide the entire toolbar item, not just its label, to avoid empty material regions.
- Use `sharedBackgroundVisibility` narrowly for content that genuinely should not share the group
  background, such as a distinct avatar.

## Tabs

- Use `TabView` and semantic `Tab` values rather than a visual tab replica.
- Use a search role only for actual search.
- Consider `sidebarAdaptable` when top-level navigation should become a sidebar on larger contexts.
- Opt into tab minimization based on content and task frequency; ensure primary navigation remains
  discoverable.
- Put a bottom accessory above the tab bar only for persistent secondary functionality such as now
  playing, and adapt its content to placement.

## Search

- Apply `searchable` to the container that represents the scope of search.
- Let the system choose platform-appropriate placement unless the information architecture needs a
  specific alternative.
- Use a dedicated search tab when search is a top-level destination, not as a loophole for another
  action.
- Test focus, keyboard appearance, compact layouts, and restoration.

## Sheets and Popovers

- Partial-height sheets can adopt Liquid Glass automatically on current systems.
- Remove legacy `presentationBackground` overrides before attempting to add glass.
- Inspect content around the increased corner curvature and outside inset sheet edges.
- Full-height presentation may become more opaque; design content for both states.
- Forms and pushed navigation destinations can introduce opaque backgrounds. Hide those backgrounds
  only when preserving the partial-sheet treatment is intentional and the full-height result is
  still legible.
- Anchor action sheets/popovers to the initiating control so origin and relationship are clear.

## Source-Destination Presentation Morph

Use when a toolbar action opens a directly related sheet or detail:

1. Put the presenting toolbar inside a navigation container.
2. Create a local namespace.
3. Mark the source control with a stable source ID.
4. Apply the matching navigation transition to the destination.
5. Test dismissal, interactive cancellation, and Reduce Motion.

This is a navigation transition, not the same API as `glassEffectID` inside a
`GlassEffectContainer`.

## Adaptation Review Table

| Legacy customization | First repair |
|---|---|
| Custom toolbar blur/background | Remove and inspect system result |
| Homegrown floating tab bar | Restore semantic `TabView`; document unmet requirement |
| Custom search button at screen edge | Use `searchable` or a real search tab |
| Material sheet background | Remove override and test partial/full detents |
| Fixed toolbar padding | Use toolbar grouping and system metrics |
| Opaque sidebar next to hero image | Evaluate background extension and safe areas |

## Verification

- Test compact and regular width, portrait/landscape, and resizable windows.
- Test scroll-edge behavior over light, dark, and detailed content.
- Check toolbar grouping and labels with VoiceOver and Voice Control.
- Verify keyboard and pointer behavior.
- Confirm presentation origin and dismissal remain understandable with motion reduced.
