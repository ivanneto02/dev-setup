# Initial import baseline

Recorded on 2026-10-29 as a **historical import snapshot**. Scope: repository
preparation only. For current profile decisions and verification, see
[workflow/status.md](../workflow/status.md); later decisions do not rewrite the
import evidence below.

## Provenance and ownership

- Source: `/home/ivan/nvim-config`, clean working tree at revision
  `bdafd1a0b503646db573690021d0c3cc9f435a12`.
- An identical copy already existed at `dev-setup/nvim-config` when work began.
- All 11 imported files retain their original contents, including hidden files,
  `init.lua-mobile`, `kitty.conf.bak`, and `lazy-lock.json`.
- The copied nested Git metadata was moved to
  `.git/import-backups/nvim-config.git` so the parent repository can own the files.
  This local recovery copy is not versioned. The original source repository is
  untouched. After the reorganization below, restore the original layout before
  moving this metadata back to `nvim-config/.git`, if that recovery is needed.
- Future configuration edits belong in this repository. No synchronization with
  the old repository or live configuration has been configured.

## Machine and activation

At the time of import, the inspection host reported Arch Linux. No target
machine or installation profile had been selected; this import did not establish
Arch compatibility. The owner later selected this Arch host as the current
inspection target and added two OS profiles, without a default OS.

At the time of import, there were no installation destinations or override rules.
The imported files had no precedence over live configuration. Later work added
[profile ownership rules](profile-ownership.md) and a preview-first deployment
script; neither action applied imported files to the live host. Activation still
requires target-path inspection, backups and explicit approval.

## Observed configuration

The main `config/nvim/init.lua` bootstraps lazy.nvim and configures Telescope, LSP/Mason,
completion, formatting, Treesitter, and a transparent Tokyo Night theme. Its
leader is backslash. The mobile alternative uses `vim.pack` and differs
substantially; the lazy.nvim lockfile should not be treated as its lockfile.

The imported Bash file contains machine-specific CUDA paths and NVM loading.
The tmux file loads TPM from `~/.tmux/plugins/tpm/tpm`. Ghostty defines `ctrl+b`
key sequences, including pane navigation also represented in the tmux file.
Kitty includes `theme.conf` followed by `current-theme.conf`. These configurations
are preserved as found, not certified for a new machine. Shortcut interactions
and runtime behavior still need validation before deployment.

## Validation and next step

The import was compared against the original source, excluding Git metadata.
File contents and the plugin lockfile match. The lockfile parses as JSON, and the
imported Bash file passes `bash -n`.

No imported configuration was executed. Neovim startup, plugin installation,
terminal behavior, and target compatibility have not been tested. Starting the
imported Neovim configuration can bootstrap dependencies, so runtime validation
belongs in a later, explicitly scoped setup task.

At the time of import, the baseline on `main` was uncommitted. It was later
committed in `9683e05`; subsequent setup and profile decisions are recorded in
[workflow/status.md](../workflow/status.md). No upstream compatibility review
or upgrades were part of the import itself.

## Repository reorganization

On 2026-10-29, the imported files were moved into tool directories without editing
their contents. The old `nvim-config/` directory was removed after it became empty.

| Original path under `nvim-config/` | Current path |
| --- | --- |
| `nvim/` | `config/nvim/` |
| `ghostty/` | `config/ghostty/` |
| `kitty/` | `config/kitty/` |
| `.bashrc` | `config/bash/.bashrc` |
| `.tmux.conf` | `config/tmux/.tmux.conf` |
| `.tmux/` (empty plugin directories) | `config/tmux/.tmux/` |
| `README.md` | `docs/nvim-config-original-readme.md` |

SHA-256 comparisons against the original source verified all 11 files unchanged.
The imported empty `.tmux/plugins/` directories were also moved under the tmux
directory; they contain no plugin code and are not tracked by Git. Kitty's relative theme
paths remain together. The main and mobile Neovim configurations remain separate;
no profile or alternate startup selection has been introduced.

To reverse the layout change, recreate `nvim-config/` and move the entries in the
table back to their original paths, checking for conflicts first. No system
rollback is needed because no live configuration was changed.
