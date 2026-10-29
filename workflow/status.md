# Workflow status

Updated 2026-10-29. This records repository state and checks on the current Arch
host, not a guarantee about another machine. See [preferences](../preferences.md),
[OS profiles](../docs/profile-ownership.md), [terminal policy](../docs/terminal-policy.md),
and [model policy](model-policy.md) for decisions and boundaries.

| Component | State |
| --- | --- |
| Neovim | Main lazy.nvim config and lockfile preserved; proposed baseline for both OS profiles. Mobile vim.pack alternative deferred. Main startup and plugin effects unverified. |
| Ghostty | Sole supported terminal; repo config keeps Ctrl+b. Arch 1.4.0 parsed candidate bindings match the unique live Ctrl+b set; nested GUI navigation and macOS runtime unverified. Existing Arch live file is not linked to this repo. |
| Kitty / tmux | Installed on this Arch host but unsupported archival imports. The deployment script rejects both. |
| Bash | Intended shell; imported `.bashrc` still has unsafe machine-specific CUDA, TERM, and NVM assumptions. Not deployable yet. |
| Pi | 1.4.0 installed on this host, running in Herdr. Project Limen hooks load at Pi startup or `/reload`. The portable explain-config and end-to-end skill sources are not configured for automatic discovery. |
| Limen | User-level CLI and project hooks installed; bounded issue workers and an independent review job ran in `dev-setup`. Job logs/state are ignored; workers use separate Git worktrees. Coordinator restart/recovery remains untested. |
| Herdr | 0.9.5 with Pi integration v9; live user config F12 prefix confirmed by owner. Detached Limen jobs open log-tail tabs in a worker workspace, not recognized agent panes; tabs close after completion. See [visibility guide](../docs/herdr-setup.md#finding-limen-workers-in-herdr). |
| Deploy script | `scripts/deploy-config.sh` previews/links only Neovim and Ghostty user files on Arch/macOS after explicit target selection and approval. Temporary-home Arch checks passed; Mac runtime and live deployment remain untested. |

`profiles/arch-linux.md` and `profiles/macos.md` describe two OS choices. The owner
intentionally left the default target machine/OS unspecified; select and inspect
the actual machine before activation. No full installation automation exists, and
none of the imported tool configurations was deployed by this repository.
`workflow update` is proposed and **not implemented**.

The owner selected ChatGPT-plan OAuth only; no OpenAI API keys, separately billed
API routes or paid extra usage. [Role policy](model-policy.md) defines coordinator,
worker and reviewer choices and execution limits. Pi auth metadata confirmed
`openai/gpt-6-sol` OAuth readiness on this Arch host; it cannot prove account
billing or hard-enforce a spending cap. `scripts/limen-oauth.sh` checks the route
and rejects API-key/proxy overrides for its own bounded job launches; direct
Pi/Limen invocations still require the policy preflight. Stop rather than falling back to an API key or another provider.

Ghostty owns tabs/splits, Herdr owns persistence/agent visibility, and Limen owns
job state/worktrees. tmux is not part of this workflow. The Herdr F12 prefix
was confirmed, but UI workspace-picker keys, hosted worker badges, detach/restart
recovery and nested Ghostty/Neovim key delivery remain unverified. Do not equate
a running Herdr log tab with a tracked agent or a completed job with validated
artifacts. See [Limen trial evidence](../docs/limen-setup.md) and
[shortcut gaps](../docs/shortcuts.md).

Before a macOS deployment, inspect installed versions, managed-device rules,
active config paths and application overrides. Test selected tools in isolation;
do not assume Linux paths, binaries, or bindings apply on the Mac. Setup changes
need an exact preview, approval, checks and rollback. No hard concurrency or
spending enforcement was added; the model policy's limits are per-job controls
and operating rules.
