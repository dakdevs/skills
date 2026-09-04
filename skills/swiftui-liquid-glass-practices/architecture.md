# Architecture: Content-First Liquid Glass Adaptation

## Core Model

Liquid Glass is not the app's visual theme. It is the adaptive material of a functional layer that
floats above content. A successful adaptation preserves the app's identity in its content,
typography, imagery, data visualization, and interaction model while allowing system navigation
and controls to feel native.

The operating model has five layers:

1. **Purpose and information architecture** — what people are doing and how they move through it.
2. **Content layer** — the information, media, documents, and task-specific surfaces.
3. **System functional layer** — navigation, toolbars, search, tabs, sidebars, sheets, menus, and
   standard controls that adopt Liquid Glass automatically.
4. **Custom functional layer** — only the important custom controls or transient overlays that
   require explicit glass.
5. **Adaptation and evidence layer** — platform, accessibility, input, visual, and performance
   verification.

Changes flow downward through these layers. Never begin at layer four.

## Apple Design Principles as Decisions

### Hierarchy

Question: Can a person immediately distinguish content from the controls that operate on it?

- Put the task and content beneath the functional layer.
- Avoid glass inside repeated content cells, documents, or background decoration.
- Remove opaque legacy chrome that makes system controls compete with content.

### Harmony

Question: Do shapes, placement, spacing, and motion relate to the surrounding hardware and
containers?

- Prefer system shapes and spacing.
- Use concentric rounded geometry where custom shapes nest near container edges.
- Let platform containers adapt instead of hard-coding an iPhone layout everywhere.

### Consistency

Question: Does the interface behave like the platform while retaining the app's identity?

- Use semantic SwiftUI structures and roles.
- Keep familiar action placement and input behavior.
- Use custom visuals without replacing system semantics.

### Restraint

Question: Does glass clarify function, or merely advertise the effect?

- Add it only to important functional UI.
- Prefer regular glass; justify clear glass against real background content.
- Use semantic tint sparingly.
- Decline ornamental morphing without a relationship to communicate.

## Adaptation Flow

```text
User task
   |
   v
Information and navigation architecture
   |
   v
Standard SwiftUI structures and controls
   |
   +--> Remove conflicting custom backgrounds and metrics
   |
   v
Is a custom functional element still necessary?
   |                         |
  no                        yes
   |                         |
   v                         v
Use system result       Choose variant, shape, interaction,
                       composition, and transition semantics
                             |
                             v
                   Accessibility + platform + performance QA
```

## Dependency Order

- Platform and deployment constraints precede API choice.
- Information architecture precedes visual styling.
- Standard components precede custom glass.
- Layout and content modifiers precede `.glassEffect()`.
- Container scope precedes union or transition configuration.
- Identity and hierarchy change precede animation choice.
- Accessibility behavior precedes visual sign-off.
- Measurement precedes performance claims.

## Invariants

After adaptation:

- The app remains understandable with transparency and motion reduced.
- Content is not mistaken for a control.
- System-provided navigation and presentation behavior remains available.
- A custom surface has one functional reason to be glass.
- Nearby glass elements share the correct sampling/composition scope.
- Morphing expresses continuity and does not conceal state.
- Older systems preserve tasks and semantics through honest fallbacks.
- Platform-specific changes are intentional and documented.

## Failure Modes

| Failure | Likely cause | Architectural repair |
|---|---|---|
| Everything looks glassy | Material treated as theme | Reclassify layers; remove content-layer effects |
| Interface still looks pre-platform-26 | Custom backgrounds mask system design | Remove overrides before adding effects |
| Controls merge unexpectedly | Container spacing exceeds visual separation | Reduce spacing or split functional groups |
| Morph seems arbitrary | No state/source relationship | Use materialize/fade or no morph |
| VoiceOver semantics are wrong | Visual replica replaced semantic control | Restore standard control/role |
| Older OS “fallback” behaves differently | Visual emulation replaced behavior | Preserve semantics first; simplify appearance |
| Device performance regresses | Too many live sampling regions/effects | Consolidate, reduce, and profile |

## Output Goal

A correct application produces a native-feeling interface adaptation with an auditable rationale:
what stayed content, what system styling now supplies, what custom glass remains, why any morph is
meaningful, how platforms differ, and what evidence demonstrates accessibility and performance.
