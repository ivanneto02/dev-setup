# Vision

This repository is the source of truth for a portable, understandable local development setup for a busy solo developer. `AGENTS.md` governs repository work; `preferences.md` records durable preferences; `workflow/status.md` records what actually works today. Do not treat this vision as evidence that a proposed tool or workflow is installed.

## Product principles

- Make setup repeatable, reversible, and inspectable; keep live credentials, caches, and sessions outside Git.
- Reduce supervision without compromising the owner's control over environment changes, paid model routes, or publication.
- Keep responsibilities distinct: Pi coordinates, Limen owns delegated jobs and worktrees, and Herdr provides terminal persistence and visibility.
- Preserve working editor/terminal behavior and allow keeping the current setup when a proposed change is not worth its cost.

## Current direction

- Prepare a locally tested workflow and clear documentation before adapting installation to macOS in a separate task.
- Do not assume the Linux host's installed binaries, paths, or bindings apply on the future macOS target.
