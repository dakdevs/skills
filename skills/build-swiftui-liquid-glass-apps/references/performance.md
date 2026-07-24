# SwiftUI Performance

## Contents

- [Start with a Symptom](#start-with-a-symptom)
- [Code-First Review](#code-first-review)
- [Data Flow](#data-flow)
- [View Structure](#view-structure)
- [Lists and Images](#lists-and-images)
- [Liquid Glass](#liquid-glass)
- [Instruments Escalation](#instruments-escalation)
- [Report Format](#report-format)
- [Verification](#verification)

## Start with a Symptom

Classify:

- slow first render;
- delayed interaction;
- janky scroll;
- dropped animation frames;
- hang;
- high CPU;
- memory growth;
- excessive view updates;
- slow image loading;
- custom glass hitch.

Do not "optimize SwiftUI" without a reproducible symptom or a clear structural bug.

## Code-First Review

Check:

1. Heavy work, allocation, formatting, decoding, sorting, or filtering in `body`.
2. Models/services/images created during rendering.
3. Broad environment or observable dependencies.
4. State assigned repeatedly to an equal value.
5. Unstable `ForEach` identity.
6. Non-lazy containers for large scrolling content.
7. Oversized images decoded at full resolution.
8. Tasks restarting unintentionally.
9. Synchronous disk/network work on the main actor.
10. Many independent or nested glass effects.

Fix only issues connected to a real risk or symptom.

## Data Flow

Performance follows invalidation:

- keep fast-changing state near the smallest subtree;
- pass only values a child reads;
- avoid one app-wide observable object for unrelated features;
- remove unused environment reads;
- keep derived expensive data outside view rendering;
- prefer stable value types and identity.

## View Structure

Small view types can create better invalidation boundaries and clearer profiling names. Extraction
alone is not a guarantee. Preserve stable identity and avoid rebuilding unrelated roots.

## Lists and Images

- Use lazy containers or `List` for large data.
- Avoid inline filtering/sorting for every render.
- Use stable IDs.
- Downsample images near display size.
- Cache according to product semantics.
- Cancel image/network work when the item leaves or request changes.
- Avoid invisible duplicate views doing the same work.

## Liquid Glass

- Use system components first.
- Group nearby custom effects in `GlassEffectContainer`.
- Avoid nested/overlapping independent glass.
- Do not animate glass without a state purpose.
- Test scrolling and morphing over representative content.
- If a hitch exists, profile on real hardware before simplifying blindly.

## Instruments Escalation

Use Apple's SwiftUI Instruments workflow:

1. Reproduce the exact path.
2. Record with the SwiftUI template on a supported destination.
3. Check whether SwiftUI update groups overlap the symptom.
4. Inspect long view body/platform view updates.
5. Use cause/effect data to find the state source driving updates.
6. Correlate with Time Profiler, Hangs, and Hitches.
7. Change one cause.
8. record again under the same scenario.

If SwiftUI lanes are empty while CPU spikes, investigate outside SwiftUI.

## Report Format

| Symptom | Evidence | Likely cause | Change | Before/after verification |
|---|---|---|---|---|

Separate measured findings from code-review hypotheses.

## Failure Modes

- Adding `.equatable()` everywhere.
- Moving all work off main without isolation reasoning.
- Replacing system controls with lighter custom views.
- Removing animations without measuring.
- Cleaning/rebuilding instead of profiling runtime behavior.
- Treating high body-call count alone as a bug; cheap bodies may be fine.
- Claiming a performance improvement without a comparable second trace or observable test.

## Verification

- The original symptom is reproducible.
- The change is scoped to a causal path.
- Build and behavior remain correct.
- The same scenario is rerun.
- Results are measured or explicitly labeled observational.
