# Worked Example: Task Manager

## Scenario

Design a task manager with projects, tasks, due dates, completion, search, and deletion across Web,
native macOS, and iPhone.

## Shared Semantic Core

- Entities: project, task, due date, completion state, tag.
- Primary outcome: capture and complete a task.
- Commands: New Task, Complete, Edit, Move, Delete, Undo, Search.
- States: loading, empty project, no search results, offline, save failure, deleted with undo.
- Safety: deletion is reversible for a defined period; sync conflicts preserve both versions until
  resolved.
- Privacy: notifications and calendar access are optional and requested when enabling reminders.

## Platform Delta

| Shared intent | Web | macOS | iPhone | Why |
|---|---|---|---|---|
| Navigate projects | URL-backed sidebar at wide widths; disclosed navigation when narrow | Persistent sidebar | Projects tab/list, then navigation stack | Browser location, desktop space, phone focus |
| View task detail | Side panel or route based on width | Detail pane or separate window | Pushed detail view | Available simultaneous context |
| Create task | Visible New Task button and shortcut if appropriate | File menu command, shortcut, toolbar button | Reachable add button | Platform command discovery and input |
| Complete task | Semantic checkbox/button | Control plus standard command where valuable | Touch control and optional swipe shortcut | Same outcome, local acceleration |
| Delete task | Menu/action with undo | Edit/menu/context command with undo | Menu or swipe shortcut plus visible alternative and undo | Safety plus input conventions |
| Search | Stable query route/field | Toolbar search with keyboard focus | Search integrated into task collection | Navigation and input expectations |
| Configure reminders | Settings route | App Settings window | In-app or system Settings route | Platform configuration conventions |

## Web Walkthrough

At wide width, the project list and task list can remain visible together. Selecting a task updates
the stable task location and preserves the list query/scroll. At narrow width, selection moves to a
detail route; Back returns to the same project and scroll position. Links navigate; Complete and
Delete are actions. Keyboard focus remains visible after optimistic completion, error rollback, and
responsive reflow.

## macOS Walkthrough

The primary window uses a sidebar, task list, and detail area. File > New Task and a standard custom
shortcut create tasks; Edit exposes Undo/Redo and task editing commands. The toolbar contains only
frequent contextual actions. Multiple task/project windows restore their selection and size.
Inactive selection remains distinguishable. Pointer, keyboard, context menu, and drag-to-project all
reach the same Move behavior.

## iPhone Walkthrough

The app opens to the most relevant task collection with a reachable add action. Projects and other
peer areas use a small stable tab model only if they are truly peers. Task detail is pushed; editing
uses a sheet with explicit Cancel/Done and draft preservation. Swipe-to-complete/delete is optional
acceleration; visible controls remain available. Dynamic Type stacks due-date metadata and actions
instead of truncating task names.

## State Example: Save Failure

1. Person edits a task and chooses Save.
2. The draft remains visible while saving.
3. On network failure, the task stays editable and the message says saving failed, not that the
   task is invalid.
4. Retry is available; leaving does not silently discard the draft.
5. Web reload, Mac window inactivity, and iPhone backgrounding preserve the draft.

## Verification

- Create, complete, delete, undo, search, fail-save, background/reload, and restore on all surfaces.
- Compare canonical command names and outcomes.
- Verify Web history/focus, macOS menu/shortcuts/windows, and iPhone touch/reach/interruption.
- Test large text, reduced motion, dark appearance, increased contrast, RTL, keyboard, pointer,
  touch, and assistive technology as applicable.

## Lesson

The product is consistent because tasks, commands, states, and safety remain stable. The interfaces
are intentionally different because browser history, Mac windows/menus, and iPhone touch/navigation
solve different interaction contexts.
