# Workflow: Build, Run, and Verify

## Goal

Turn source edits into observable evidence. Use the Apple development tools available in the agent
environment; prefer dedicated Xcode build, simulator, test, and UI-automation tools over improvised
shell workflows.

## 1. Discover Before Building

Inspect:

- project or workspace path;
- schemes;
- active configuration;
- simulator/device destination;
- deployment target and SDK;
- existing test plans;
- repository-specific commands.

When XcodeBuildMCP or an equivalent Apple build tool is available, inspect its session defaults
before the first build. If project, scheme, and simulator defaults are already correct, build and
run directly. Discover projects only when defaults are missing or wrong.

Do not create a second project because the intended one was not discovered.

## 2. Build the Smallest Relevant Target

Choose:

| Change | First build |
|---|---|
| View-only change | App scheme for Simulator |
| Package feature | Relevant Swift package target/tests |
| App plus extension | App scheme, then affected extension |
| Build setting or dependency | Clean relevant resolution only if normal build proves it necessary |

Read the first causal compiler error. Later errors are often cascades.

When fixing:

1. Identify file and symbol.
2. Confirm availability and type context.
3. Make the smallest correction.
4. Rebuild.
5. Avoid unrelated modernization during error repair.

## 3. Render Preview Evidence

Create or use `#Preview` entries for:

- happy path;
- empty/loading/error;
- long content;
- narrow and wide container;
- light/dark;
- large text;
- mocked dependencies.

Previews must not require network, production credentials, or mutable shared storage. A preview
crash is a product architecture signal: isolate the view and replace live dependencies.

Capture or inspect the rendered result. Validate hierarchy and clipping before runtime testing.

## 4. Run in Simulator

Launch the app and exercise the exact changed path.

Check:

- first launch and restored state;
- tap targets and feedback;
- navigation forward/back and sheet dismissal;
- keyboard appearance and focus;
- scrolling beneath toolbar/tab/search glass;
- rotation or interactive resize;
- app background/foreground if state matters;
- interruption during animations;
- error and recovery paths.

Use UI inspection and screenshots when available. Prefer accessibility identifiers for stable
automation, but do not add them indiscriminately to every view.

## 5. Test

Use the smallest test first:

1. model/service unit test;
2. feature/view-state test;
3. focused UI flow;
4. relevant suite;
5. broader suite when risk justifies it.

Test behavior, not private layout implementation. Useful assertions include:

- route selected for an action;
- state transition after async success/failure;
- persistence round trip;
- destructive action requires confirmation;
- fallback renders on an older supported OS;
- primary element is accessible by label/identifier.

## 6. Accessibility and Appearance Matrix

Inspect:

- VoiceOver order and labels;
- Dynamic Type through accessibility sizes;
- bold text and increased contrast;
- Reduce Motion and Reduce Transparency;
- light and dark;
- right-to-left layout and long localized strings;
- keyboard/pointer when iPad support matters.

Use `checks/accessibility-review.md`.

## 7. Escalate to Performance Tools

Use Instruments when:

- a real hitch, hang, or scroll delay is reproduced;
- view bodies appear expensive;
- state changes cause broad unexpected updates;
- custom glass clusters animate poorly;
- code review cannot establish the cause.

Start with the SwiftUI template on a supported real device or host app. Use Time Profiler, Hangs,
and Hitches where the SwiftUI lane is unavailable. Correlate symptoms with update groups and cause/
effect data. Do not guess based on view size alone.

## 8. Record Evidence

Use `templates/verification-report.md`.

Never say "tested" without naming:

- command or tool action;
- destination;
- result;
- relevant state or path;
- skipped checks and why.

## Failure Modes

- Running a generic build without the app's scheme.
- Repeatedly cleaning derived data before reading the error.
- Treating a preview as a test.
- Treating a successful build as runtime verification.
- Ignoring warnings caused by the change.
- Adding arbitrary delays to UI tests instead of waiting for observable state.
- Profiling before reproducing the symptom.
- Reporting success while a required target or state remains unchecked.
