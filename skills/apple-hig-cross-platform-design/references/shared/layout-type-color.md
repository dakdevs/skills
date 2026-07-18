# Layout, Type, Color, and Appearance

## Origin

Adapted from [Layout](https://developer.apple.com/design/human-interface-guidelines/layout),
[Typography](https://developer.apple.com/design/human-interface-guidelines/typography),
[Color](https://developer.apple.com/design/human-interface-guidelines/color), and
[Dark Mode](https://developer.apple.com/design/human-interface-guidelines/dark-mode).

## Use When

Establishing hierarchy, responsive behavior, typography, semantic color, or appearance adaptation.

## Layout Model

Build from relationships rather than coordinates:

1. Group related items.
2. Give essential information space and priority.
3. Separate controls from content.
4. Align elements to make hierarchy scannable.
5. Disclose secondary content predictably.
6. Extend backgrounds/content appropriately while respecting safe and obscured regions.
7. Reflow around context changes while preserving recognition and selection.

## Adaptability Inputs

Every supported surface must account for applicable changes:

- viewport, display, resolution, and color space;
- portrait/landscape or window resizing;
- camera housing, Dynamic Island, browser chrome, toolbars, and sidebars;
- external displays and multiple windows;
- text size and browser zoom;
- light, dark, and increased contrast;
- locale, text length, numerals, and RTL direction;
- pointer, keyboard, touch, and assistive input.

Test the smallest and largest credible layouts first. Reflow before hiding. Preserve the relative
location of important content and controls.

## Typography Rules

- Prefer platform system type and built-in text styles when building native interfaces.
- Use few typefaces and a stable hierarchy of size, weight, and color.
- Avoid thin weights for small or important text.
- Use body styles intended for multi-line reading.
- Support enlargement without losing primary content, actions, or hierarchy.
- At large sizes, stack inline content and reduce columns rather than truncate.
- For Web, choose a readable stack and responsive scale; do not represent Apple's point sizes as
  universal CSS pixel requirements.
- Test real copy, longest localization, error text, and data-heavy states.

## Color Rules

- Use semantic meaning rather than hard-coded native system color values.
- Keep one color meaning consistent. Do not reuse an interaction color for decorative text.
- Supply light, dark, and increased-contrast variants where the platform requires them.
- Pair color with labels, shape, iconography, or position.
- Apply accent color sparingly, primarily to true emphasis or the primary action.
- Test against rich content and translucency, not only a flat mockup background.
- Test different displays and lighting when color fidelity matters.

## Appearance Decision Table

| Situation | Preferred response | Avoid |
|---|---|---|
| System changes to dark appearance | Adapt while app is running | Requiring restart or ignoring preference |
| Increased contrast | Strengthen differentiation and legibility | Subtle-only borders or color differences |
| Large text narrows layout | Stack, wrap, or reduce columns | Clipping, overlap, important truncation |
| Width decreases | Preserve primary content; disclose secondary areas | Sudden unrelated structure changes |
| Rich imagery behind controls | Increase separation/contrast using platform means | Similar control and content colors |
| RTL locale | Mirror structural flow where semantic | Flipping logos, digits, or physical direction |

## Platform Notes

- iPhone: respect safe areas and system features; support both orientations unless the experience
  genuinely depends on one. Avoid default full-width buttons that ignore system margins.
- macOS: do not put critical controls only at the bottom because windows can extend below the
  screen. Support broad window resizing and multiple displays.
- Web: define behavior by content breakpoints and capabilities, not device labels. Preserve URLs,
  focus, and reading order when layout reflows.

## Verification

- [ ] Primary content remains first at all target sizes.
- [ ] Control and content layers are distinguishable.
- [ ] No essential control is obscured by system/browser/window chrome.
- [ ] Largest text and longest labels reflow without loss.
- [ ] Light, dark, and increased-contrast states remain legible.
- [ ] State and interactivity do not depend on color alone.
- [ ] RTL and locale-sensitive formatting preserve meaning.
- [ ] Selection and task state survive size/orientation changes.

## Failure Modes

- Selecting one fashionable breakpoint and calling the layout responsive.
- Replacing hierarchy with many card borders or decorative surfaces.
- Hard-coding native system colors or metrics that can change.
- Treating Dark Mode as color inversion.
- Shrinking text to preserve a composition.
- Hiding the only action when space becomes narrow.
