# SwiftUI Implementation Review Gate

## Environment

- [ ] Project/workspace, scheme, Xcode/SDK, and minimum OS are known
- [ ] Repository instructions and local conventions were followed
- [ ] Beta-only assumptions are explicit

## Architecture

- [ ] Code is organized by meaningful feature
- [ ] Each mutable state has one owner
- [ ] Services/side effects are outside `body`
- [ ] Dependencies are explicit and appropriately scoped
- [ ] Preview/test fakes avoid live services
- [ ] No speculative framework or abstraction was added

## State and Identity

- [ ] Local state is private
- [ ] Passed values are not incorrectly stored as `@State`
- [ ] Binding is used only for child mutation
- [ ] `@Observable` ownership/injection is correct for iOS 17+
- [ ] Legacy wrappers match older targets where needed
- [ ] Mutually exclusive states use a coherent model
- [ ] `ForEach` identity is stable
- [ ] Tasks cancel/restart according to lifecycle

## Views

- [ ] View bodies are readable and cheap
- [ ] Meaningful subviews have clear inputs
- [ ] Native controls replace tap gestures
- [ ] Layout is container-driven
- [ ] Text can wrap and scale
- [ ] Safe-area/keyboard behavior is correct

## Navigation

- [ ] Typed destinations model product routes
- [ ] Tabs preserve intended history
- [ ] Sheets own focused temporary flows
- [ ] Deep links use the same route model
- [ ] Toolbars/search use semantic APIs

## Availability

- [ ] New APIs are gated at a small boundary
- [ ] Older branch compiles and preserves behavior
- [ ] Deployment target was not silently raised

## Performance

- [ ] No heavy work or allocation in `body`
- [ ] Large collections are lazy/appropriate
- [ ] Images are sized and loaded responsibly
- [ ] Observed dependencies are not unnecessarily broad
- [ ] No redundant nested custom glass

## Evidence

- [ ] App builds
- [ ] Primary path runs
- [ ] Important previews render
- [ ] Focused tests pass
- [ ] Warnings introduced by the change are resolved or explained
