# Anti-Patterns: Fake Parity and Brittle Customization

## Use When

A package or implementation promises native Liquid Glass on unsupported systems, uses private
interfaces, alters system-control internals, or assigns false semantic roles to obtain artwork.

## Fake Optical Parity

### Smell

A stack of `Material`, gradients, strokes, shadows, and scale animations is called a “Liquid Glass
backport” without explaining differences.

### Risk

- Misleads maintainers and users about system behavior.
- Omits dynamic sampling, focus, interaction, and accessibility adaptation.
- Accumulates visual tuning for every background and OS.

### Repair

Call it a material fallback or custom glass-inspired effect. Preserve semantic hierarchy and allow
appearance to differ across OS generations.

## False Semantic Roles

### Smell

A non-search primary action is implemented as `Tab(role: .search)` to obtain a separated pill.

### Risk

VoiceOver, focus, state restoration, and system behavior all treat it as search. Visual similarity
does not compensate for incorrect semantics.

### Repair

Use a real button in an appropriate toolbar/accessory/safe-area location, or revise the layout.

## Internal Hierarchy Manipulation

### Smell

Code traverses system subviews by index/class name, hides internal labels, injects overlays, or
assumes the structure of a system control.

### Risk

Point releases can change the hierarchy. Accessibility, focus, pointer, and layout behavior may
silently break.

### Repair

Use public customization points. If no public API meets the product requirement, document the gap
and seek explicit risk acceptance before an experimental branch.

## Private API and Capture

### Smell

Runtime lookup of underscore-prefixed classes, private backdrop layers, selector injection, or
undocumented material variants.

### Risk

App Review rejection, runtime failure, undefined behavior, and high maintenance cost.

### Required Response

Stop ordinary implementation. Present public alternatives, exact unmet requirement, risks, kill
switch, fallback, owner, and removal condition.

## Dependency-by-Default

Do not add a framework merely because it has stars or wraps one modifier. Evaluate:

- License and source availability.
- Maintenance and current SDK support.
- Semantic/accessibility behavior.
- API naming collisions.
- Fallback honesty.
- Performance evidence.
- Exit cost.

## Verification

- Search source for private class strings, runtime mutation, and control-subview assumptions.
- Run accessibility and input tests independent of appearance.
- Test multiple OS point releases.
- Confirm documentation clearly distinguishes native and custom rendering.
