# Workflow: Prototype and Iterate with an Agent

## Origin

Operational adaptation of Apple's WWDC26 sessions "Create UI prototypes using agents in Xcode"
and "Xcode, agents, and you."

## Principle

Use the agent to multiply experiments, populate realistic conditions, and operate the tools. Keep
design judgment with the designer. One generated answer is a starting point, not a decision.

## Phase 1: Explore Structured Variations

Ask for three to five variations that hold product behavior constant while changing one dimension:

| Dimension | Example range |
|---|---|
| Information density | focused, balanced, data-rich |
| Navigation | tabs, list-detail, task-first |
| Hierarchy | content-led, action-led, status-led |
| Layout | editorial, utility, immersive media |
| Motion | restrained, responsive, expressive |

Keep each variant in a separate preview or clearly named temporary view. Do not create multiple
architectures. Use shared fixture data and state types so comparison remains meaningful.

For every variant, state:

- the design hypothesis;
- what it optimizes;
- what it sacrifices;
- the primary failure risk.

## Phase 2: Compare, Then Remix

Do not choose by visual novelty alone. Compare:

- time to understand the screen;
- visibility of primary action;
- hierarchy at small and large text;
- number of competing controls;
- content usefulness;
- adaptation to narrow and wide containers;
- placement of the functional glass layer.

Select individual ideas, not necessarily a whole variant. Combine them into one direction and
delete discarded temporary paths after the decision is captured.

## Phase 3: Make the Prototype Lived In

Read `patterns/lived-in-prototype.md`.

Create fixtures for:

- first launch and empty state;
- one normal account;
- a heavy-use account with many records;
- very long names and content;
- partial or stale data;
- offline/error state;
- permission denied;
- destructive/recovery states.

Use plausible names, dates, quantities, images, and relationships. Avoid `Item 1`, lorem ipsum, and
perfectly uniform content; they hide layout problems.

## Phase 4: Tune Key Moments

Choose no more than three moments:

- entering the primary destination;
- committing the primary action;
- expanding a control cluster;
- showing success or recovery;
- transitioning between related glass controls.

For each moment:

1. Write its communication goal.
2. Implement the simplest system transition.
3. Add a temporary tuning surface using `patterns/tuning-panel.md`.
4. Compare a restrained range of duration, spring response, spacing, and scale.
5. Test Reduce Motion.
6. Commit constants to named tokens and remove the tuning UI from production.

Motion should explain change, preserve continuity, or acknowledge input. If it only makes the screen
busier, remove it.

## Phase 5: Annotate Precisely

When giving feedback to the agent, attach the screenshot or preview and describe:

- the exact view or control;
- the current observable problem;
- the intended relationship or outcome;
- what must not change.

Good:

```text
In the populated Home preview, the weekly total competes with the Add button. Preserve the data and
tab structure; reduce the total's visual dominance and make the add action the single tinted
functional control.
```

Weak:

```text
Make it cleaner and more premium.
```

## Phase 6: Verify the Chosen Direction

Render a matrix:

- compact and regular width;
- portrait and landscape or resizable equivalents;
- light and dark;
- default and accessibility text;
- empty, populated, error, and long-content;
- left-to-right and right-to-left when localization matters.

Then run the interaction in Simulator. Check keyboard, focus, scrolling under glass, sheets,
navigation back behavior, and animation interruption.

## Output

Record:

- variants considered and their hypotheses;
- selected and remixed decisions;
- fixture states used;
- tuned constants and their purpose;
- preview/runtime evidence;
- unresolved product decisions.

## Failure Modes

- Generating variations that also change product scope.
- Keeping all variants and shipping accidental dead code.
- Approving a layout with toy data.
- Tuning animation before hierarchy works.
- Adding glass to make variants look more different.
- Treating the agent as the source of taste instead of a fast experimental collaborator.
