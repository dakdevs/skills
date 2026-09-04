# Accessibility and Visual Verification Matrix

## Instructions

Use real app content. Record device/platform, OS, orientation/window size, build, and result. Test
the primary state plus every state where glass changes shape, tint, opacity, or hierarchy.

## Appearance Matrix

| Configuration | What to verify | Failure examples |
|---|---|---|
| Light appearance | Foreground contrast and edge visibility | White icons disappear over bright media |
| Dark appearance | Tint, shadows, and text luminosity | Tinted glass becomes muddy or overbright |
| Increase Contrast | Borders and foreground remain harmonious | Custom overlay duplicates system contrast treatment |
| Reduce Transparency | Hierarchy survives more opaque material | Content/control distinction depended on refraction |
| Reduce Motion | State change stays clear with calmer movement | Expanded actions appear without understandable continuity |
| Bold Text | Labels fit and grouping remains stable | Toolbar group clips or changes hit region |
| Largest supported Dynamic Type | Reflow and container spacing | Effects unintentionally merge or labels truncate |
| Differentiate Without Color | Selected/status meaning remains | Tint was the only selected-state indicator |

## Background Matrix

| Background | Regular glass | Clear glass | Transition state |
|---|---|---|---|
| Bright flat | Check edge/label contrast | Usually poor; justify/dim | Check foreground throughout |
| Dark flat | Check excessive glow | Check readability | Check shadow/material continuity |
| Detailed image | Verify blur supports labels | Validate dimming | Watch for noisy intermediate states |
| High-saturation image | Check adaptive foreground/tint | Validate color contamination | Check tint changes |
| Moving video/map | Check continuous legibility | High-risk; test motion | Check frame pacing and distraction |
| Actual worst-case content | Required | Required if used | Required |

## Assistive Technology Matrix

| Task | VoiceOver/Voice Control check | Keyboard/focus check |
|---|---|---|
| Activate custom glass control | Correct label, role, hint, result | Visible focus and activation |
| Expand/collapse cluster | Expanded state and logical item order | Focus does not jump or enter hidden items |
| Present/dismiss sheet | Focus enters destination and returns | Escape/cancel and default action work |
| Change selected tab/control | Selected trait/value announced | Arrow/tab navigation follows platform |
| Disabled/loading state | State announced; no false action | Disabled target cannot activate |

## Combined Stress Cases

Run at least:

1. Dark appearance + Reduce Transparency + Increase Contrast.
2. Light appearance + largest Dynamic Type + detailed background.
3. Reduce Motion + rapid repeated expand/collapse.
4. VoiceOver + source-destination sheet presentation.
5. Pointer or keyboard + interactive custom control on iPad/Mac.

## Evidence Template

```markdown
| Scenario | Device/OS | Settings | Result | Evidence/issue |
|---|---|---|---|---|
```

Do not mark the matrix passed from static previews alone.
