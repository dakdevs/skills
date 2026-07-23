# Liquid Glass Design

## Contents

- [Authority](#authority)
- [What Liquid Glass Does](#what-liquid-glass-does)
- [Layer Model](#layer-model)
- [Placement Decision](#placement-decision)
- [Regular and Clear](#regular-and-clear)
- [Hierarchy](#hierarchy)
- [Motion](#motion)
- [Content Behind Glass](#content-behind-glass)
- [Accessibility](#accessibility)
- [Failure Modes](#failure-modes)
- [Verification](#verification)

## Authority

Apple's Human Interface Guidelines and current framework documentation are normative. Recheck them
when using beta SDKs or unfamiliar variants.

## What Liquid Glass Does

Liquid Glass is an adaptive functional material. It creates a distinct layer for controls and
navigation while allowing content to remain visible underneath. Its optical response and motion
help communicate presence, interactivity, grouping, and transitions.

It is not a generic blur, frosted card style, or background decoration.

## Layer Model

```text
Functional layer: navigation + high-value controls -> Liquid Glass
Content layer: text + media + lists + forms + data -> no Liquid Glass
```

System navigation components already occupy the functional layer. Custom glass should extend that
layer only when necessary.

## Placement Decision

| Surface | Use Liquid Glass? | Reason |
|---|---|---|
| System tab bar/sidebar/toolbar | Automatic | Platform owns appearance and behavior |
| Floating primary control over content | Sometimes | Clear functional separation |
| Cluster of custom media controls | Sometimes | One interactive plane over rich content |
| List row or content card | No | Belongs to content layer |
| App background | No | Use semantic color or standard material |
| Decorative badge | Usually no | Decoration is not a functional layer |
| Slider/toggle | Use system control | System provides interaction material |
| Sheet/popover | Automatic where supported | Avoid conflicting custom background |

## Regular and Clear

Use regular glass by default. It adapts across varied content and accessibility settings.

Consider clear glass only when:

- the surface appears over visually rich media;
- the content/control remains bold and legible;
- the full background range has been tested;
- the clearer treatment supports the content relationship rather than novelty.

Do not mix variants arbitrarily in one control plane. Current HIG and SDK behavior win over any
community heuristic.

## Hierarchy

- Keep one primary tinted action when tint communicates importance.
- Keep secondary controls neutral.
- Prefer monochrome SF Symbols for toolbar actions.
- Preserve breathing room between independent glass shapes.
- Use consistent geometry that relates to the surrounding container.
- Avoid solid fills layered inside glass unless the system component owns them.

## Motion

Liquid Glass can flex, materialize, and morph. Use motion to:

- connect a compact control to its expanded state;
- show grouping or separation;
- acknowledge touch;
- preserve continuity through navigation/presentation.

Do not morph unrelated objects. Respect Reduce Motion and ensure the state change remains
understandable without the animation.

## Content Behind Glass

Test glass over:

- bright imagery;
- dark imagery;
- high-frequency texture;
- flat semantic backgrounds;
- moving or rapidly scrolling content;
- empty/loading states;
- light/dark appearances.

The system adapts, but the designer still owns placement, hierarchy, and custom-control semantics.

## Accessibility

System material responds to settings such as Reduce Transparency and Increase Contrast. Custom
controls still require:

- correct semantic role;
- accessible name and value;
- sufficiently large interaction area;
- predictable focus order;
- non-color state communication;
- readable content at large type;
- a reduced-motion behavior.

Automatic material adaptation does not make a custom control automatically accessible.

## Failure Modes

| Failure | Why it fails |
|---|---|
| Glass on content cards | Competes with functional chrome and obscures hierarchy |
| Glass on glass | Creates ambiguous depth and inconsistent sampling |
| Every action tinted | Removes priority |
| Clear glass over arbitrary content | Legibility becomes content-dependent |
| Static content marked interactive | Visual behavior promises unavailable action |
| Custom bar gradients behind glass | Fights system edge behavior |
| Pixel-matching an older material fallback | Preserves appearance but not semantic role |
| Judging one still screenshot | Misses adaptation, scrolling, interaction, and accessibility |

## Verification

- Can every glass surface be named as navigation or a control?
- Would removing it make functional/content separation worse?
- Are system components used first?
- Is custom glass sparse?
- Do grouped surfaces share a container?
- Are regular/clear and tint choices semantic?
- Does the experience remain clear with transparency and motion reduced?
- Has it been observed in motion over varied content?
