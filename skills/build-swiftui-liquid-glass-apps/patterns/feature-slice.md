# Pattern: Feature Slice

## Problem

New apps often accumulate architecture before delivering a runnable user outcome.

## Pattern

Implement one vertical feature path:

```text
Destination
  -> View
  -> State/model
  -> Service boundary
  -> Fixture/fake
  -> Focused test
```

## Procedure

1. Name the outcome.
2. Add the route from the existing shell.
3. Model the minimum domain data.
4. Define explicit screen states.
5. Build with fixture data.
6. Add live persistence/service after the interaction works.
7. Add focused tests.
8. Verify and commit before the next slice.

## Example File Map

```text
Features/Capture/
  CaptureView.swift
  CaptureState.swift
  CaptureService.swift
  Components/CaptureForm.swift
Tests/CaptureStateTests.swift
```

## Boundaries

- Keep local UI state in the view.
- Keep domain operations in a model/service.
- Introduce a protocol when live/fake separation needs it.
- Share a service only after multiple features need the same lifecycle.
- Keep preview fixtures deterministic.

## Verification

- Slice builds without later slices.
- Primary outcome runs.
- Important states preview.
- Failure is recoverable.
- Test proves the core transition.
- No speculative abstraction remains unused.
