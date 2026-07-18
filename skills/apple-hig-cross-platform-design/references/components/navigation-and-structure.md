# Navigation and Structure

## Origin

Adapted from HIG guidance for layout, sidebars, split views, tab bars, toolbars, the menu bar,
windows, search fields, scroll views, and lists/tables.

## Use When

Choosing how people move among destinations, collections, detail, work contexts, and commands.

## Start With Relationships

Classify each destination:

- Peer: equally important top-level area.
- Hierarchical: parent, collection, or detail relationship.
- Contextual: belongs to the current selection.
- Independent: separate document or work context.
- Temporary: brief choice or focused subtask.

Choose structure after classification.

## Decision Table

| Relationship | Web | macOS | iPhone |
|---|---|---|---|
| Peer top-level areas | Persistent navigation that adapts at narrow width | Sidebar, toolbar segmentation, or app-specific structure | Stable tab bar with a small set |
| Hierarchy | URL-backed page/detail or master/detail | Sidebar/split/outline with persistent selection | Navigation stack |
| Independent work | Page/tab/workspace | New or existing window/document | Usually navigation flow; full-screen only if necessary |
| Contextual options | Menu, popover, inline controls | Toolbar, context menu, inspector, popover | Menu, row action, toolbar, sheet |
| Search | Search route/field with preserved query | Toolbar or content search with keyboard focus | Search integrated with current collection |
| Global commands | Visible app navigation and action system | Menu bar | Relevant visible controls and menus |

## Rules

- Keep location visible through titles, selection, URLs, and back paths appropriate to the platform.
- Use tabs for peers, not for sequential steps or actions.
- Keep tabs stable; do not repurpose a tab based on transient context.
- Use sidebars for persistent hierarchy or sources, not a miscellaneous command list.
- Toolbars contain common contextual actions, not the entire product command set.
- On macOS, menu bar coverage completes command discoverability.
- On Web, navigation must respect browser history and meaningful URLs.
- On iPhone, avoid deep modal stacks that bypass the normal back model.
- Preserve selection, scroll, and query when moving between overview and detail when useful.

## Procedure

1. Draw the destination graph and label each relationship.
2. Mark the current-location signal and recovery path.
3. Choose platform structures from the table.
4. Add command locations separately; do not overload navigation with actions.
5. Define resize/orientation behavior and state preservation.
6. Test keyboard, pointer, touch, Back, close, and restore behavior.

## Verification

- [ ] Every destination has one primary relationship and an understandable entry point.
- [ ] The back/close behavior matches the presentation that opened it.
- [ ] Current location and selection remain visible.
- [ ] Narrow layouts disclose navigation without erasing the primary task.
- [ ] Wide layouts add useful context rather than empty decoration.
- [ ] Search preserves query and scope through result/detail navigation.
- [ ] Navigation remains operable by all supported input methods.

## Failure Modes

- Using a bottom tab as an action button.
- Making a sidebar a dumping ground for settings and commands.
- Treating a modal as navigation to a durable destination.
- Breaking browser Back because internal state replaced location.
- Omitting macOS menu commands because toolbar buttons exist.
- Resetting scroll, selection, or query after viewing detail.
