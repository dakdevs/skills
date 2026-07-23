# Example: Habit Tracker from Brief to Verified Slice

## Brief

```text
Product: A calm habit tracker for people who want a small daily ritual.
Primary job: Mark today's habits and understand whether the day is complete.
Success: All chosen habits show today's completion and the person can stop thinking about the app.
Visual direction: Quiet, warm, content-led, one expressive completion moment.
Minimum OS: iOS 17; Liquid Glass on iOS 26+.
```

## Product Model

- Person: Someone checking in during a transition in their day.
- Entities: Habit, DailyCompletion.
- Destinations: Today, History, Settings.
- Primary loop: Open Today -> mark habit -> see day progress -> close.
- First slice: fixture-backed Today list with toggle and completion summary.
- Non-goals: social, streak competition, cloud sync.

## State Matrix

| State | Experience |
|---|---|
| First use | Explain the ritual and offer "Create a habit" |
| Loading | Compact progress while local data loads |
| Empty | One clear create action |
| Partial | Habit list plus progress |
| Complete | Calm success state, no confetti requirement |
| Error | Preserve visible data and offer retry |

## Architecture

```text
App/
  RitualApp.swift
Features/
  Today/
    TodayView.swift
    TodayModel.swift
    HabitRow.swift
    TodayPrimaryAction.swift
  History/
  Settings/
Models/
  Habit.swift
Services/
  HabitRepository.swift
```

The app shell uses `TabView`; each tab owns a `NavigationStack`. A typed environment repository is
injected at the root. The Today feature owns transient filter/presentation state.

## Model

```swift
struct Habit: Identifiable, Equatable, Sendable {
    let id: UUID
    var title: String
    var symbolName: String
    var isCompleteToday: Bool
}

enum TodayPhase: Equatable {
    case loading
    case empty
    case content([Habit])
    case failed(String)
}
```

## View State

```swift
@Observable
@MainActor
final class TodayModel {
    private(set) var phase: TodayPhase = .loading

    func load() async {
        // Ask the injected repository and map result into phase.
    }

    func toggle(_ habit: Habit) async {
        // Optimistically update, persist, and roll back on failure.
    }
}
```

The model expresses the state transition. The view renders it and sends intent.

## Today Screen

```swift
struct TodayView: View {
    @State private var model: TodayModel

    init(model: TodayModel) {
        _model = State(initialValue: model)
    }

    var body: some View {
        List {
            content
        }
        .navigationTitle("Today")
        .safeAreaInset(edge: .bottom) {
            TodayPrimaryAction()
                .padding()
        }
        .task {
            await model.load()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch model.phase {
        case .loading:
            ProgressView("Loading today")
                .frame(maxWidth: .infinity)
        case .empty:
            ContentUnavailableView(
                "No habits yet",
                systemImage: "checkmark.circle",
                description: Text("Create one small ritual to begin.")
            )
        case .content(let habits):
            TodaySummary(habits: habits)
            ForEach(habits) { habit in
                HabitRow(habit: habit) {
                    Task { await model.toggle(habit) }
                }
            }
        case .failed(let message):
            ErrorState(message: message)
        }
    }
}
```

In production, choose an older-OS fallback for `ContentUnavailableView` if the deployment target
requires it.

## Functional Glass Layer

The list and summary remain content. The custom bottom create control is the only custom functional
surface.

```swift
struct TodayPrimaryAction: View {
    var body: some View {
        if #available(iOS 26, *) {
            GlassCreateButton()
        } else {
            StandardCreateButton()
        }
    }
}

@available(iOS 26.0, *)
private struct GlassCreateButton: View {
    var body: some View {
        Button("Create habit", systemImage: "plus", action: create)
            .buttonStyle(.glassProminent)
    }

    private func create() {}
}

private struct StandardCreateButton: View {
    var body: some View {
        Button("Create habit", systemImage: "plus", action: create)
            .buttonStyle(.borderedProminent)
    }

    private func create() {}
}
```

If the system tab/toolbar provides the action clearly, remove this custom surface instead of keeping
glass for its own sake.

## Preview Matrix

Create fixtures:

- empty;
- three habits, one complete;
- all complete;
- twelve habits with long localized names;
- repository error;
- accessibility extra-extra-extra-large text;
- dark appearance;
- right-to-left.

## Verification Plan

| Check | Evidence |
|---|---|
| Build | App scheme on current iPhone Simulator |
| Preview | Empty, partial, complete, long-content |
| Runtime | Toggle habit; background/foreground; relaunch |
| Unit | toggle success, persistence failure rollback |
| Accessibility | VoiceOver reads title/state/action; large text |
| Glass | iOS 26+ and iOS 17 fallback; bright/dark scrolling |

## Design Critique

- Completion feedback should reduce demand, not create a new task.
- A streak metric should not outrank today's actions.
- Warm brand color may tint the one create/commit action; it should not tint every check control.
- History remains a secondary destination and should not invade the Today hierarchy.

## Result

This slice is valuable without cloud sync, analytics, social features, or a large architecture. It
proves the loop, state model, navigation shell, preview strategy, and Liquid Glass boundary.
