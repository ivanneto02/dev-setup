---
name: end-to-end
description: Complete authorized implementation tasks through validation and handoff without asking for approval at every small step. Use when a user asks to build, fix, or finish a task end-to-end; pause for explicit approval before changing the live development environment.
---

# End-to-end implementation

When the user asks for a task, aim for the finished outcome, not a list of small next steps for them to perform. Read the project's instructions and relevant files, inspect Git state, make reasonable reversible decisions within scope, implement, validate, and report. Use available tools yourself; do not stop at a plan or ask for permission for routine edits, commands, or checks that are already authorized. If a test fails, diagnose and fix it when practical. Preserve unrelated work.

## Boundary: environment changes require approval

Authorization to implement a task is **not** authorization to change the user's live development environment. Before installing, upgrading, uninstalling, enabling, linking, or applying tools/configuration; changing system or user settings, shell startup files, services, provider/billing routes, or active integrations; or running a setup command with such effects:

1. Inspect the current state and identify the target machine and likely effects. A repository file or plan is not proof it is active.
2. Tell the user exactly what you propose to change, where, why, what existing state may be affected, how you will verify it, and how to undo it. State uncertainties and any expected cost or access implications.
3. Request explicit approval for that defined change **before** applying it. Approval for one change does not cover additional environment changes discovered later.

Writing or updating source-controlled implementation, tests, and documentation is not by itself applying it to the live environment. Read-only inspection and safe validation can continue while waiting. Do not use a skill invocation as implied approval for installation or activation. If the request itself explicitly approves a clearly scoped environment change, proceed within that scope and ask before expanding it.

## Work to completion

- Define observable completion criteria and validate proportionately. Check version-sensitive facts against authoritative sources when relevant.
- Ask only when missing information materially affects correctness, cost, access, scope, or an irreversible action. Otherwise choose a sensible option and continue.
- For external effects such as publishing, merging, deploying, purchasing, or changing accounts, follow the project's authorization rules; never infer permission from "end-to-end."
- If blocked, finish what can safely be done, then give the precise blocker and the smallest decision or approval needed. Do not claim incomplete work is done.
- Report what changed, what checks actually ran, remaining limitations, and recovery steps where relevant. Summarize *all* environment changes accurately if any were approved and made.

This skill does not override project instructions or higher-priority safety and authorization boundaries. It encourages initiative within them, not unsupervised environment changes.
