---
name: toolbox
description: >
  Save useful online tools and find tools from the user's personal catalog when
  choosing an implementation approach, selecting software, or looking for an
  existing utility. Use for "save this tool", "remember this tool", "add to my
  toolbox", or "do I have a tool for this?".
---

# Toolbox

Keep useful tools discoverable by the problems they solve. Start with the short
[catalog](references/catalog.md), then read only the relevant tool cards.

## Save a tool

1. Inspect the supplied URL and any official documentation needed to understand
   its purpose and access method. Preserve the user's reason for saving it when
   provided. If the source is unavailable, save the link and known information,
   marking the missing details as unverified.
2. Check the catalog for the same tool or canonical URL. Update an existing card
   instead of creating a duplicate. Keep unrelated entries intact.
3. Write a card in `references/tools/<tool-name>.md`. Include the canonical link,
   concrete tasks it helps with, how to access it, and a brief usage workflow.
   Add prerequisites or limitations only when they affect use. Record whether
   the tool is saved, tested, or preferred; call it preferred only when the user
   says so. Date verification and describe exactly what was checked.
4. Add or update its catalog row with a relative link, task language and useful
   synonyms, and its access method. Keep operational details in the card.
5. Report what was saved and where. Saving a tool documents it; installation and
   execution belong to a task that needs it.

Keep the catalog and cards together in this skill directory. If the installed
skill is a symlink, edit its source so future uses read the same catalog.

## Find and use a tool

1. Match the current task against the catalog by capability and desired outcome,
   even when the user has not named a tool. For a large catalog, search it and
   `references/tools/` with task terms and synonyms.
2. Read matching cards and judge their fit against the task's requirements and
   the project's existing tools. A saved tool is a candidate. If none fits,
   continue with the task using another approach.
3. Check current instructions and availability before relying on a tool. Use
   the documented access method, such as a browser, CLI, API, or connector.
   A website link alone does not establish an API or an installed integration.
4. Use the chosen tool within the user's task and existing authorization. Check
   the resulting artifact before describing the workflow as tested.
5. When actual use reveals useful details, update the card's workflow and
   verification notes. Distinguish inspecting a page from testing an export or
   completing a workflow.

## Discovery

The agent initially sees this skill's name and description. Reference-file
keywords help lookup after selection. To prompt discovery during planning, add
this instruction to the user's persistent agent guidance:

> When planning an implementation or choosing an external tool, consult the
> toolbox catalog for relevant saved tools. Match by the problem being solved,
> including when I haven't named a tool.

Promote a tool card into a separate skill when it develops a substantial reusable
workflow or needs its own task-specific trigger. Link to that skill from the card
instead of duplicating its instructions.
