# Liquid Glass Review Gate

## Placement

- [ ] Every glass surface is navigation or an interactive control
- [ ] Content rows/cards/backgrounds do not use Liquid Glass
- [ ] System containers are allowed to adopt automatically
- [ ] Custom bar/sheet/blur backgrounds do not fight the system
- [ ] Independent glass layers do not overlap

## API

- [ ] API is available in the installed SDK
- [ ] Deployment target has an availability branch
- [ ] New types are isolated inside available declarations
- [ ] Layout/visual modifiers precede `.glassEffect`
- [ ] Buttons use button semantics and styles where possible
- [ ] `.interactive()` appears only on interactive custom effects
- [ ] Nearby effects use one appropriate `GlassEffectContainer`
- [ ] Morph IDs and namespace are stable

## Design

- [ ] Regular glass is the default
- [ ] Any clear glass is justified by rich media and tested
- [ ] Tint communicates hierarchy/meaning
- [ ] One primary action remains dominant
- [ ] Shapes and spacing form one coherent control plane
- [ ] Fallback preserves behavior rather than imitating optics

## Accessibility

- [ ] VoiceOver label, role, value, and focus are correct
- [ ] Interaction area remains comfortable
- [ ] Reduce Transparency was tested
- [ ] Increase Contrast was tested
- [ ] Reduce Motion was tested
- [ ] State is not communicated only by tint or motion

## Runtime and Performance

- [ ] Bright/dark/busy/flat backgrounds were inspected
- [ ] Light/dark appearance was inspected
- [ ] Scrolling beneath glass remains legible
- [ ] Repeated/interrupting interactions preserve state
- [ ] Older runtime fallback was exercised
- [ ] Real device was used when visual/performance stakes require it
- [ ] Any reported hitch was profiled or clearly labeled observational

## Failure Report

For each failed item record surface, evidence, consequence, and smallest correction.
