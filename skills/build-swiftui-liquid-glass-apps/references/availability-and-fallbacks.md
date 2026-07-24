# Availability and Fallbacks

## Contents

- [Three Versions to Distinguish](#three-versions-to-distinguish)
- [Stable vs Beta Policy](#stable-vs-beta-policy)
- [Availability Pattern](#availability-pattern)
- [Behavioral Equivalence](#behavioral-equivalence)
- [Liquid Glass Fallback Table](#liquid-glass-fallback-table)
- [Xcode 27 / iOS 27](#xcode-27--ios-27)
- [App-Wide Compatibility Modes](#app-wide-compatibility-modes)
- [Verification](#verification)

## Three Versions to Distinguish

1. **Installed SDK/toolchain** - what symbols the compiler knows.
2. **Deployment target** - the oldest OS the app promises to run on.
3. **Runtime OS** - the OS executing a particular branch.

An `if #available` check solves runtime/deployment selection only. It cannot make an old Xcode
compile a symbol it does not know.

## Stable vs Beta Policy

| Situation | Policy |
|---|---|
| Existing project uses stable SDK | Stay stable unless asked to migrate |
| Existing project already uses beta SDK | Preserve and document beta assumptions |
| New production app during beta season | Prefer newest installed stable SDK |
| User explicitly requests iOS 27/Xcode 27 | Use beta APIs with availability and explicit caveat |
| Prototype only | Beta is acceptable when stated and locally available |

Do not infer beta authorization from "modern" or "latest-looking."

## Availability Pattern

Use a small boundary:

```swift
@ViewBuilder
private var primaryControl: some View {
    if #available(iOS 26, *) {
        GlassPrimaryControl()
    } else {
        StandardPrimaryControl()
    }
}
```

Prefer two small components when the new branch uses unavailable types. Keep shared content/data
outside the branch.

## Behavioral Equivalence

A fallback must preserve:

- action;
- label and role;
- focus/tap target;
- state;
- error handling;
- navigation outcome.

It need not imitate the new optical material.

## Liquid Glass Fallback Table

| Modern surface | Earlier fallback |
|---|---|
| `.buttonStyle(.glassProminent)` | `.buttonStyle(.borderedProminent)` |
| `.buttonStyle(.glass)` | `.buttonStyle(.bordered)` |
| Custom `.glassEffect` panel | `.background(.regularMaterial, in: shape)` when depth is necessary |
| Glass morph | direct state transition or a restrained standard transition |
| System glass sheet | system sheet for that OS |
| Floating glass media controls | material-backed control group with equivalent actions |

## Xcode 27 / iOS 27

The 2027 releases refresh Liquid Glass and add new APIs for toolbars, presentations, reordering,
documents, and resizability. Treat these separately from the iOS 26 Liquid Glass baseline:

- automatic visual refresh may require no source changes;
- new API use requires its own availability gate;
- source compatibility changes can occur at compile time even with an older deployment target;
- preview and simulator validation should include both stable-minimum and newest-runtime behavior
  when infrastructure supports it.

## App-Wide Compatibility Modes

Apple may provide compatibility keys for staged design adoption. Use only after reading current
official documentation. If used:

- record why it is enabled;
- treat it as temporary;
- create an audit/removal plan;
- do not mix a compatibility appearance with assumptions from the new design;
- test both configurations during migration.

## Failure Modes

- Referencing a new type in a stored property outside the available declaration.
- Scattering availability checks across every modifier.
- Duplicating the whole screen for one visual difference.
- Silently raising the deployment target.
- Shipping a beta-only API in a stable production plan.
- Treating fallback as a screenshot recreation.
- Failing to test the older branch because the developer device is new.

## Verification

- Installed Xcode and SDK are recorded.
- Minimum deployment target is read from the project.
- New symbols compile with the installed SDK.
- Older supported runtime takes a real fallback branch.
- Both branches preserve semantics and accessibility.
- Beta assumptions are explicit in plan and handoff.
- Deployment target changes are intentional and visible in the diff.
