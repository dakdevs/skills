# Performance and Instruments Reference

## Use When

Several glass effects appear together, effects animate, sampled content changes continuously, or
users report jank, heat, energy use, or delayed response.

## What Apple Establishes

- `GlassEffectContainer` renders contributed effects together and can improve performance.
- Too many effects outside containers and too many effect containers can degrade performance.
- Simultaneous on-screen effects should be limited.
- SwiftUI performance should be measured with Instruments rather than inferred from view syntax.

Apple does not publish a universal safe count. Do not invent one.

## Risk Factors

| Risk | Why it matters |
|---|---|
| Many independent effects | Repeated sampling/composition work |
| Many small containers | Multiple effect regions and poor batching |
| Video, camera, map, or animation beneath glass | Continuously changing sampled content |
| Morph plus layout plus symbol animation | Competing render/update work |
| Large translucent area | More pixels and background detail to process |
| Custom Metal capture | Texture transfer, blur, shader, and update scheduling cost |
| Rapid state churn | Repeated hierarchy and geometry transitions |

## Optimization Order

1. Remove effects without a functional purpose.
2. Restore system components where they can manage rendering.
3. Consolidate related effects in the smallest sensible container.
4. Split unrelated groups whose spacing causes unnecessary interaction.
5. Simplify simultaneous animations.
6. Reduce update frequency for custom renderers when the background is static or user-driven.
7. Optimize application state/view invalidation identified by Instruments.
8. Consider a custom renderer only for a measured case native view composition cannot handle.

## Measurement Workflow

### Define scenarios

- Cold appearance of the screen.
- Idle state with all intended effects visible.
- Primary interaction and morph.
- Scrolling beneath functional UI.
- Worst-case moving background.
- Accessibility setting that materially changes appearance.

### Capture

Use representative physical hardware when possible. Record:

- SwiftUI view-body/update activity.
- Animation hitches and frame pacing.
- Core Animation behavior.
- CPU/GPU/energy signals appropriate to the target.
- Memory growth during repeated transitions.
- Interaction latency and cancellation behavior.

### Compare

Measure the same scenario before and after. If evaluating container scope, compare equivalent
implementations rather than unrelated screen states.

## Performance Acceptance

Set project-specific thresholds based on target hardware and interaction criticality. At minimum:

- No repeatable visible hitch in the primary interaction.
- No runaway view invalidation or memory growth.
- Idle state does not continuously render without a functional reason.
- Custom renderer update mode matches background dynamics.
- Results are documented by device, OS, build, and scenario.

## Common Reasoning Errors

- “The API is native, so it is free.”
- “A container always makes it faster,” without considering container count and scope.
- “It feels smooth in Simulator.”
- “Nine effects worked in another app, so nine is safe here.”
- Optimizing shader code before removing unnecessary material surfaces.

## Related Apple Sources

- [Applying Liquid Glass to custom views](https://developer.apple.com/documentation/swiftui/applying-liquid-glass-to-custom-views)
- [Optimize SwiftUI performance with Instruments](https://developer.apple.com/videos/play/wwdc2025/306/)
- [SwiftUI performance analysis](https://developer.apple.com/documentation/swiftui/performance-analysis)
