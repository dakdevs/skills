# Release Readiness Gate

## Build and Tests

- [ ] Required schemes build on intended configuration
- [ ] Focused tests pass
- [ ] Relevant suite passes
- [ ] Required extensions/widgets build
- [ ] New warnings are resolved or documented

## Runtime

- [ ] Cold launch and primary path run
- [ ] Error/recovery path runs
- [ ] Background/foreground behavior is correct where relevant
- [ ] Persistence/restoration is correct
- [ ] Keyboard, sheet, and navigation behavior is correct

## Design and Accessibility

- [ ] `checks/design-review.md` passes
- [ ] `checks/liquid-glass-review.md` passes
- [ ] `checks/accessibility-review.md` passes
- [ ] Appearance/state preview matrix exists

## Compatibility

- [ ] Minimum supported OS branch was exercised
- [ ] Latest supported OS branch was exercised
- [ ] Stable/beta SDK assumptions are documented
- [ ] No accidental deployment-target increase exists

## Privacy and Data

- [ ] Permission strings and flows are correct
- [ ] Privacy manifests/requirements were considered
- [ ] Logs and fixtures contain no sensitive data
- [ ] Destructive data behavior is tested

## Handoff

- [ ] Verification report names tools, destinations, and results
- [ ] Screenshots/previews are linked when relevant
- [ ] Remaining risks are explicit
- [ ] Next slice is concrete
- [ ] No temporary variants, tuning UI, debug data, or dead code remains

Fail the gate if a required check was skipped without a reason and risk statement.
