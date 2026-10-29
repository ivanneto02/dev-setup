# Workflow status

Updated 2026-10-29. This records repository state, not an inventory of installed
applications. See [preferences](../preferences.md) for desired outcomes and
[import notes](../docs/import-baseline.md) for provenance and validation.

| Component | Repository state |
| --- | --- |
| Neovim | Imported main and mobile configurations; main lazy.nvim lockfile preserved |
| Ghostty | Imported configuration; candidate terminal in AGENTS.md |
| Kitty | Imported configuration and themes retained from the source |
| Bash | Imported configuration with machine-specific CUDA paths and NVM loading |
| tmux | Imported configuration referencing TPM; no plugins installed by this repo |
| Pi | Installed on this host; fullscreen coordinator in Herdr and bounded `openai/gpt-6-sol` Limen worker tested; no repo-managed adapter |
| Limen | User-level CLI installed; initialized in `dev-setup` with project planning and Pi/OMP hook stubs; jobs were tested only in a disposable repo, not here; see [setup and trial](../docs/limen-setup.md) |
| Herdr | 0.9.5 installed with bundled Pi integration v9; server running during trial, Limen log-tail tab observed; live user config prefix changed to F12 (owner verified keypress); see [setup notes](../docs/herdr-setup.md) |

`workflow update` is a proposed interface and is **not implemented**. A
preview-first, selective user-file deployment script exists at
`scripts/deploy-config.sh` with a project skill in `.agents/skills/deploy-config/`.
It supports Arch Linux and macOS file destinations, not tool installation or
full-stack activation. Bash is excluded until its imported machine-specific
settings are repaired; Kitty is blocked on macOS. Full setup, profile selection,
model routing, and resource-limit enforcement are not implemented. Limen's project hook stubs make delegation
available after Pi loads them, but do not automatically start jobs. Limen and Herdr upstream installation
guidance was reviewed; a disposable Pi/Limen/Herdr job and its log-tail tab worked,
but broader compatibility and recovery remain untested. Limen owns delegated jobs
and worktrees; Herdr supplies terminal persistence and visibility, not a second
job manager. Ghostty retains Ctrl+b; Herdr's live user config now sets F12,
whose physical keypress the owner confirmed.

Before implementing setup, select the target machine and OS, inspect its existing
configuration, and establish installation destinations and override precedence.
Then resolve machine-specific settings and validate the imported configurations
in isolation. The original setup guide is archived as historical documentation,
not an installation procedure.

The portable skills at `agents/skills/explain-config/SKILL.md` and
`agents/skills/end-to-end/SKILL.md` are available for explicit file-based use.
The project skill at `.agents/skills/deploy-config/SKILL.md` was listed by a
trusted Pi startup on this Arch host; existing sessions need `/reload`.
The latter favors completing implementation without step-by-step approval, but
requires explicit approval before changing the live environment. The two portable skills are not configured for harness discovery or Pi runtime
validation. The deployment skill has not been tested on macOS. The [shortcut guide](../docs/shortcuts.md)
covers the main Neovim, Ghostty, and tmux configuration using static inspection
and selected locked plugin sources; mappings are not runtime-verified.

Keep `profiles/` empty until target-machine decisions produce concrete content.
See [deployment scope and rollback](../docs/deploy-config.md) before applying any
configuration. Shared repository instructions stay in AGENTS.md rather than
being copied into an agent adapter. Candidate tools should be evaluated before
adding integrations or another owner of job state.
