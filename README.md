# dev-setup

Source of truth for my development environment: editor and terminal configuration,
development tools, agent workflows, setup automation, and documentation.

Repository policy lives in [AGENTS.md](AGENTS.md).

## Current state

The imported configuration now lives under `config/`, organized by tool. File
contents and the Neovim plugin lockfile are preserved. These are ordinary files
owned by this repository, not submodules or links to live configuration.

None of the imported configurations has been linked or applied to the machine.
Pi, Limen's CLI, and Herdr are installed at user level on this host; see
[the Limen trial results](docs/limen-setup.md) and
[Herdr installation and usage](docs/herdr-setup.md). Herdr's bundled Pi integration
is installed; a running Herdr server and a disposable Limen worker/continuation
were observed on this host. Herdr's live user config now uses `F12` as its prefix
instead of conflicting with Ghostty's unchanged `Ctrl+b` shortcuts; the owner
verified the F12 keypress. Limen is now initialized in this repository, with
project hook stubs, planning files and ignored runtime state. A fresh Pi launch
(or `/reload`) is needed to load the project hook in a session; no worker has
run in `dev-setup` and recovery remains untested. A selective, preview-first
[configuration deployment script](docs/deploy-config.md) now supports Arch and
macOS file linking, but does not install tools or validate the full stack.
`workflow update` remains unavailable. The candidate stack has a narrow
successful trial, not full validation.

| Path | Contents |
| --- | --- |
| `config/nvim/init.lua` | Main Neovim configuration using lazy.nvim |
| `config/nvim/lazy-lock.json` | Preserved plugin revisions for that configuration |
| `config/nvim/init.lua-mobile` | Separate alternative using `vim.pack`; not selected automatically |
| `config/ghostty/` | Ghostty configuration |
| `config/kitty/` | Kitty configuration, themes, and original backup |
| `config/bash/.bashrc` | Imported Bash configuration |
| `config/tmux/.tmux.conf` | Imported tmux configuration |
| `preferences.md` | Durable environment preferences |
| `workflow/status.md` | Implementation status and open decisions |
| `spec/` | Limen project vision, board, and feature lanes (planning committed to Git) |
| `.agents/limen/styleguide.md` | Limen project writing conventions; `AGENTS.md` remains authoritative |
| `.pi/extensions/limen.ts`, `.omp/extensions/limen.ts` | Limen package hook loaders for Pi and OMP (OMP unused) |
| `.gitignore` | Ignores Limen's `.limen/` runtime state |
| `agents/skills/` | Portable skill sources: `explain-config` and `end-to-end` |
| `.agents/skills/deploy-config/SKILL.md` | Project-discoverable deployment skill (separate from portable skill sources) |
| `scripts/deploy-config.sh` | Selective, preview-first user-file deployment for Arch and macOS |
| `docs/deploy-config.md` | Destinations, approval, validation, limits, and rollback |
| `docs/import-baseline.md` | Import provenance, validation, limitations, and next steps |
| `docs/shortcuts.md` | Source-cited Neovim, Ghostty, and tmux shortcuts, potential conflicts, and validation gaps |
| `docs/herdr-setup.md` | Herdr installation, Pi integration, usage, validation limits, and recovery |

`profiles/` is intentionally empty: no target-machine profile is established.
`scripts/` contains only selective user-file activation, not tool installation
or a complete setup. Empty directories are not tracked by Git. Repository
instructions remain in AGENTS.md.

The [explain-config skill](agents/skills/explain-config/SKILL.md) documents
configuration and shortcuts; the [end-to-end skill](agents/skills/end-to-end/SKILL.md)
guides autonomous implementation while requiring explicit approval before live
environment changes. These are repository sources, not installed into a harness
discovery path or verified in Pi. To use either without installation, ask Pi to
read its `SKILL.md` and follow it. The `deploy-config` skill is in Pi's project
skill discovery path and appeared in a trusted Pi startup on this Arch host;
existing sessions need `/reload`. Invocation has not been tested on macOS. The initial shortcut guide is based on static
configuration and pinned plugin-source inspection, not runtime verification.

The imported [README](docs/nvim-config-original-readme.md) is historical: its vim-plug and
`PlugInstall` instructions do not describe the main configuration's lazy.nvim
setup. Its apt/PPA commands are not a verified installation procedure for this
repository. Read the [baseline notes](docs/import-baseline.md) before planning
installation.
