# Pattern: Temporary Tuning Panel

## Problem

Motion and spacing are difficult to judge from source constants, but arbitrary live tweaking can
leak debug UI or produce inconsistent values.

## Pattern

Expose only the parameters that affect one key moment:

- spring response/damping;
- transition distance/scale;
- spacing between glass elements;
- tint strength;
- corner geometry where custom shape is justified.

Use a temporary preview-only control panel or local debug view.

## Procedure

1. State what the moment communicates.
2. Establish a restrained baseline.
3. Vary one parameter at a time.
4. Compare normal and Reduce Motion behavior.
5. Check interruption and repeated input.
6. Name and centralize chosen constants.
7. Remove the tuning controls from production code.

## Output

```text
Moment:
Parameter range:
Chosen value:
Reason:
Reduce Motion behavior:
```

## Verification

- Tuning code does not ship.
- Constants have names tied to purpose.
- Result works at 60/120 Hz-capable devices without relying on frame rate.
- Motion remains understandable when disabled.
- Glass does not hitch over realistic content.
