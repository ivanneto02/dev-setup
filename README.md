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
[the Limen trial plan](docs/limen-setup.md) and
[Herdr installation and usage](docs/herdr-setup.md). Herdr's bundled Pi integration
is installed, but live agent visibility and recovery remain untested. No Herdr
server is running from this installation, and no Limen project hooks or workers
have been activated. There is no setup script or implemented
`workflow update` command yet. The complete candidate stack in AGENTS.md remains
an unvalidated proposal.

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
| `agents/skills/` | Portable skill sources; currently `explain-config` |
| `docs/import-baseline.md` | Import provenance, validation, limitations, and next steps |
| `docs/shortcuts.md` | Source-cited Neovim, Ghostty, and tmux shortcuts, potential conflicts, and validation gaps |
| `docs/herdr-setup.md` | Herdr installation, Pi integration, usage, validation limits, and recovery |

`profiles/` and `scripts/` are intentionally empty for now: no target
profile or setup automation has been implemented. Empty
directories are not tracked by Git. Repository instructions remain in AGENTS.md.

The starter [explain-config skill](agents/skills/explain-config/SKILL.md) documents
configuration and shortcuts. It is not installed into a harness discovery path
or verified in Pi yet. To try it without installation, ask Pi to read that file
and follow it to refresh [the shortcut guide](docs/shortcuts.md). The initial guide
is based on static configuration and pinned plugin-source inspection, not runtime
verification.

The imported [README](docs/nvim-config-original-readme.md) is historical: its vim-plug and
`PlugInstall` instructions do not describe the main configuration's lazy.nvim
setup. Its apt/PPA commands are not a verified installation procedure for this
repository. Read the [baseline notes](docs/import-baseline.md) before planning
installation.
