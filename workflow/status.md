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
| Pi | Installed on this host; owner reports fullscreen UI and gpt-6-astra medium working; no repo-managed adapter |
| Limen | User-level CLI installed; startup and hook discovery paths checked, no project initialization or workers tested; see [installation notes](../docs/limen-setup.md) |
| Herdr | 0.9.5 installed at user level with bundled Pi integration v9; checksum/CLI/extension-loader checks passed; server not started and live Limen integration untested; see [setup notes](../docs/herdr-setup.md) |

`workflow update` is a proposed interface and is **not implemented**. Setup,
profile selection, model routing, delegation, and resource-limit enforcement are
also not implemented. Limen and Herdr upstream installation guidance was reviewed;
end-to-end Pi/Limen/Herdr compatibility remains untested. Limen owns delegated jobs
and worktrees; Herdr supplies terminal persistence and visibility, not a second
job manager. Ghostty/Herdr Ctrl+b conflicts need a deliberate configuration decision.

Before implementing setup, select the target machine and OS, inspect its existing
configuration, and establish installation destinations and override precedence.
Then resolve machine-specific settings and validate the imported configurations
in isolation. The original setup guide is archived as historical documentation,
not an installation procedure.

The portable starter skill at `agents/skills/explain-config/SKILL.md` is available
for manual editing and explicit file-based use. Harness discovery and Pi runtime
validation are not configured. The [shortcut guide](../docs/shortcuts.md) now
covers the main Neovim, Ghostty, and tmux configuration using static inspection
and selected locked plugin sources; mappings are not runtime-verified.

Keep `profiles/` and `scripts/` empty until those decisions produce
concrete content. Shared repository instructions stay in AGENTS.md rather than
being copied into an agent adapter. Candidate tools should be evaluated before
adding integrations or another owner of job state.
