---
name: explain-config
description: Explain editor, terminal, and shell behavior from actual configuration. Use when documenting shortcuts, tracing where behavior is configured, or identifying conflicting mappings.
---

# Explain configuration

Produce a practical explanation grounded in the user's configuration. Follow
the target repository's AGENTS.md and read its README before inspecting relevant
files. Resolve configuration paths from that repository, not this skill folder.

## Inspect

- Establish whether the request concerns repository configuration or the live
  environment. Do not assume the inspection host is the target machine.
- Follow includes, imports, mapping helpers, and relevant plugin configuration.
  Keep alternative profiles separate; a file's presence does not prove it is active.
- Identify leader/prefix keys, modes, conditional mappings, and overrides.
  For behavior supplied by defaults or plugins, check the relevant version's
  authoritative documentation or installed source and label that evidence.
- Compare overlapping terminal, multiplexer, and editor keys. Distinguish a
  potential interception from a conflict demonstrated at runtime.

## Explain

For shortcut inventories, use a table with application, mode/context, key or
sequence, action, source path and line, and verification status. Explain notation
such as leader keys and multi-key sequences before the table.

Distinguish configured mappings, documented defaults, and runtime-verified
behavior. Record unresolved dynamic/plugin mappings and the checks needed to
resolve them; do not imply the inventory is complete when it is not.

Cite configuration locations for behavioral claims. Prefer a concise answer for
a focused question; create or update documentation when requested. Preserve
useful existing explanations and clearly identify assumptions.

## Starting task for dev-setup

When asked to generate this repository's shortcut guide, inspect:

- `config/nvim/init.lua` and relevant plugin declarations/lockfile.
- `config/ghostty/config`.
- `config/tmux/.tmux.conf`.

Write `docs/shortcuts.md`. Treat `config/nvim/init.lua-mobile` as a separate
alternative only if requested. Include potential conflicts and validation gaps.

This workflow documents behavior. Change configuration only when the user asks.
Do not launch applications merely to extract mappings if startup could install
plugins or otherwise alter the environment; report static inspection limits.
