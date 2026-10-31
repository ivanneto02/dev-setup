---
name: end-to-end
description: Own an authorized build or fix from implementation through validation and handoff. Use for requests such as "handle this end to end" or "take it from start to finish." Not for a focused review, explanation, or plan-only request.
---

# End-to-end implementation

Own the requested outcome through a reviewable result. Establish observable completion criteria, read project instructions and relevant files, inspect Git state, and preserve unrelated work. Make reversible choices within the authorized scope, implement the change, and run checks proportionate to its risk. Diagnose failures and fix them when practical. Do not hand routine commands, edits, or checks back to the user.

## Boundary: environment changes require approval

Authorization to implement a task is **not** authorization to change the user's live development environment. Before installing, upgrading, uninstalling, enabling, linking, or applying user- or system-level tools/configuration; changing settings, shell startup files, services, provider/billing routes, or active integrations; or running a setup command with such effects:

1. Inspect the current state and identify the target machine and likely effects. A repository file or plan is not proof it is active.
2. Complete the source changes, preview, and safe checks needed to make the proposed action concrete and reviewable.
3. Tell the user exactly what would change and where, why, what existing state may be affected, how to verify it, and how to undo it. State material uncertainties and expected cost or access implications. Request explicit approval for that defined action **before** applying it. Approval for one action does not cover additional environment changes discovered later.

Repository edits, project-local dependencies, and isolated tests within the authorized task do not by themselves apply changes to the live environment. Read-only inspection and safe validation can continue while waiting. Do not use a skill invocation as implied approval for installation or activation. If the request or prior conversation explicitly approves a clearly scoped environment change, proceed within that scope and ask before expanding it. After approval, apply the change, verify the actual environment, and record recovery steps; approval is not the handoff.

## Work to completion

- Ask only when missing information materially affects correctness, cost, access, scope, or an irreversible action. Otherwise choose a sensible option and continue.
- For external effects such as publishing, merging, deploying, purchasing, or changing accounts, follow the project's authorization rules; never infer permission from "end-to-end."
- Check version-sensitive facts against authoritative sources when relevant. Do not claim a check passed unless it ran successfully.
- If blocked, finish independent work first, then state the precise blocker and the smallest decision or approval needed. Leave a concise handoff for substantial unfinished work; do not claim it is done.
- Report what changed, what checks actually ran, remaining limitations, and recovery steps where relevant. Summarize every approved environment change that was applied.

This skill does not override project instructions or higher-priority safety and authorization boundaries. It encourages initiative within them, not unsupervised environment changes.
