# Responsive Web Adaptation

## Source Status

This is an authored adaptation. Apple HIG has no "Designing for Web" platform page. It derives from
shared HIG guidance on principles, accessibility, layout, typography, color, writing, privacy,
buttons, fields, search, pointer input, and web views.

Use current Web standards and browser guidance for normative HTML, CSS, accessibility, security,
and browser behavior. Do not claim HIG review alone establishes Web conformance.

## Problem Shape

Web interfaces run inside browser navigation, variable viewports, reloadable documents, shareable
locations, and mixed input environments. Preserve these strengths while applying HIG's clarity,
agency, familiarity, flexibility, responsibility, and craft.

## Decision Rules

### Structure and navigation

- Give meaningful destinations stable URLs when the product architecture permits it.
- Preserve Back, Forward, refresh, opening in a new tab, and deep-link behavior.
- Use links for navigation and buttons for actions.
- Reflow by content needs and available capability, not user-agent labels.
- Keep reading order and focus order coherent when visual columns rearrange.
- At wide sizes, add simultaneous context only when it reduces navigation and remains scannable.
- At narrow sizes, disclose secondary regions without hiding the only path to a core action.

### Input and focus

- Use semantic controls with visible focus.
- Support keyboard and pointer; support touch where the surface may be touch-enabled.
- Do not make hover, drag, right-click, or gesture the only path to a core function.
- Keep target regions comfortably usable for the expected input mix. Apple's native point metrics are
  informative, not one-to-one CSS pixel mandates.
- Preserve focus after updates, dialogs, errors, and responsive reflow.

### Forms and state

- Keep persistent labels; use placeholders for examples or formatting hints.
- Validate near the field and explain the correction.
- Preserve entered data through recoverable failures, reload risks, and reauthentication.
- Represent loading, empty, offline, partial, success, and error states intentionally.
- Use browser-native and semantic behavior before recreating controls with divs.

### Visual adaptation

- Build a clear content hierarchy with restrained surfaces and accents.
- Support browser zoom, text enlargement, light/dark preference, contrast settings where available,
  reduced motion, and RTL.
- Do not imitate Liquid Glass with a blur and claim native equivalence. Use translucency only when
  text and controls remain legible over real content.
- Avoid shrinking text or targets to keep a desktop composition on a phone-width viewport.

## Web-versus-Native Boundary

| Need | Web expression | Do not copy blindly |
|---|---|---|
| Navigation | URLs, links, browser history, responsive regions | iPhone-only tab/stack behavior without URL semantics |
| Global commands | Visible actions, menus, keyboard shortcuts where appropriate | macOS menu bar placement |
| Modal task | Semantic dialog only when focus must be constrained | Every native sheet as a blocking Web modal |
| Material | Robust surfaces, borders, elevation, or translucency | Native Liquid Glass appearance without behavior |
| Authentication | Web credential and security standards | Native APIs that don't exist in browsers |
| Accessibility | WCAG and platform testing plus HIG principles | HIG control metrics as proof of WCAG compliance |

## Procedure

1. Define the URL and history model for every major view.
2. Define semantic landmarks, heading order, reading order, and focus order.
3. Design narrow and wide layouts from the same content hierarchy.
4. Choose semantic links, buttons, fields, lists, tables, and dialogs.
5. Add keyboard, pointer, touch, and assistive paths.
6. Specify reload, offline, stale, partial, and authentication-expiry behavior.
7. Test zoom/reflow, longest text, RTL, reduced motion, appearances, and real content.

## Verification

Use `checks/web-review.md`. Also verify against the current Web accessibility and browser standards
required by the project; those standards are outside this source-derived package.

## Failure Modes

- A single-page app that breaks Back/Forward or loses scroll and focus context.
- A responsive layout that visually moves content but leaves DOM/focus order confusing.
- Buttons implemented as links or links implemented as buttons without correct behavior.
- Native-looking custom controls with incomplete keyboard and assistive states.
- Hidden hover-only actions.
- An overlay for every task, including work that needs a stable URL or long-lived context.
- Claiming Apple HIG defines a general Web design system.
