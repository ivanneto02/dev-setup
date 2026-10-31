# dev-setup

Source of truth for my development environment: editor and terminal configuration,
development tools, agent workflows, setup automation, and documentation.

Repository policy lives in [AGENTS.md](AGENTS.md).

## Current state

The imported configuration now lives under `config/`, organized by tool. File
contents and the Neovim plugin lockfile are preserved. These are ordinary files
owned by this repository, not submodules or links to live configuration.

None of the imported configurations has been linked or applied by this repository to the machine.
Pi, Limen's CLI, and Herdr are installed at user level on this host; see
[the Limen trial results](docs/limen-setup.md) and
[Herdr installation and usage](docs/herdr-setup.md). Herdr's bundled Pi integration
is installed; a running Herdr server and a disposable Limen worker/continuation
were observed on this host. Herdr's live user config now uses `F12` as its prefix
instead of conflicting with Ghostty's unchanged `Ctrl+b` shortcuts; the owner
verified the F12 keypress. Limen is now initialized in this repository, with
project hook stubs, planning files and ignored runtime state. A fresh Pi launch
(or `/reload`) is needed to load the project hook in a session; delegated jobs
have since run in `dev-setup`, but recovery remains untested. A selective, preview-first
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
| `config/kitty/` | Archived Kitty configuration, themes, and original backup; unsupported |
| `config/bash/.bashrc` | Imported Bash configuration |
| `config/tmux/.tmux.conf` | Archived tmux configuration; unsupported |
| `preferences.md` | Durable environment preferences |
| `workflow/status.md` | Implementation status and open decisions |
| `workflow/model-policy.md` | OAuth-only role routes and bounded worker rules |
| `profiles/arch-linux.md`, `profiles/macos.md` | OS profiles without a default target |
| `docs/profile-ownership.md`, `docs/terminal-policy.md` | Configuration ownership and terminal decisions |
| `spec/` | Limen project vision, board, and feature lanes (planning committed to Git) |
| `.agents/limen/styleguide.md` | Limen project writing conventions; `AGENTS.md` remains authoritative |
| `.pi/extensions/limen.ts`, `.omp/extensions/limen.ts` | Limen package hook loaders for Pi and OMP (OMP unused) |
| `.gitignore` | Ignores Limen's `.limen/` runtime state |
| `agents/skills/` | Authoritative sources for `explain-config`, `end-to-end`, and `make-skill` |
| `.agents/skills/` | Project skill discovery: links to those sources, plus `deploy-config` |
| `scripts/deploy-config.sh` | Selective, preview-first user-file deployment for Arch and macOS |
| `scripts/limen-oauth.sh` | Bounded OAuth-only worker/reviewer launch; not a billing guarantee |
| `scripts/test-*.sh` | Disposable-home deployment and mocked-auth launch checks |
| `docs/deploy-config.md` | Destinations, approval, validation, limits, and rollback |
| `docs/import-baseline.md` | Import provenance, validation, limitations, and next steps |
| `docs/shortcuts.md` | Source-cited Neovim, Ghostty, and tmux shortcuts, potential conflicts, and validation gaps |
| `docs/herdr-setup.md` | Herdr installation, Pi integration, usage, validation limits, and recovery |

`profiles/` contains Arch and macOS OS profiles. This Arch host is the selected
current inspection target, but no default machine is set and no deployment was
authorized by that selection. `scripts/` contains only selective user-file activation, not tool installation
or a complete setup. Empty directories are not tracked by Git. Repository
instructions remain in AGENTS.md.

The [explain-config skill](agents/skills/explain-config/SKILL.md) documents
configuration and shortcuts; the [end-to-end skill](agents/skills/end-to-end/SKILL.md)
guides autonomous implementation while requiring explicit approval before live
environment changes; [make-skill](agents/skills/make-skill/SKILL.md) guides skill
creation and improvement. The [leave-pr-comment skill](agents/skills/leave-pr-comment/SKILL.md)
guides concise, evidence-based PR comments with an AI-assistance footer. The
[diagnose-problem skill](agents/skills/diagnose-problem/SKILL.md) guides
cross-source investigation of bugs, errors, and broken workflows. These two
are repository sources only; they have not been linked into project skill
discovery. Relative links under `.agents/skills/` expose the other three
sources to Codex project skill discovery without duplicating their contents.
They have not been verified in a fresh Codex or Pi session. The `deploy-config`
skill is also in that discovery path and appeared in a trusted Pi startup on
this Arch host; existing Pi sessions need `/reload`. Invocation has not been
tested on macOS. The initial shortcut guide is based on static
configuration and pinned plugin-source inspection, not runtime verification.

The imported [README](docs/nvim-config-original-readme.md) is historical: its vim-plug and
`PlugInstall` instructions do not describe the main configuration's lazy.nvim
setup. Its apt/PPA commands are not a verified installation procedure for this
repository. Read the [baseline notes](docs/import-baseline.md) before planning
installation.
