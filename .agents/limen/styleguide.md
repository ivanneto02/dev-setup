# Styleguide

`AGENTS.md` is authoritative for work rules and validation. This file only describes the shape of changes in this repository.

## Shape

- Put managed tool configuration in `config/<tool>/`; machine/OS differences in `profiles/` when needed; executable setup and checks in `scripts/`; agent workflows in `agents/` and `workflow/`; usage and recovery in `docs/`.
- Keep human-owned requirements in `preferences.md`, not scattered across configuration files.

## Prefer

- Make focused changes with matching documentation and practical validation evidence.
- Preserve Neovim plugin lockfile and imported behavior unless replacing them is a separate, deliberate change.
- Explicitly document installation destinations, precedence, assumptions, and rollback for setup work.

## Avoid

- Treating a file's presence as proof that a tool is active, or a worktree as a security boundary.
- Copying AGENTS.md into an overlay or creating parallel owners of job state.
- Embedding machine-specific paths, credentials, or sessions in portable files.
