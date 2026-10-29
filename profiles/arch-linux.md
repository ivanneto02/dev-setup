# Arch Linux candidate profile

This is a **candidate**, not the selected default machine or OS. The inspected Linux host is an import and development host, not an approved deployment target. Its Arch version, device restrictions, and desired tool set have not been confirmed with the owner. Do not apply this profile without selecting a specific machine, inspecting its live files and obtaining approval for the exact preview. See [ownership and precedence](../docs/profile-ownership.md).

| Tool | Repository source | Proposed user destination | Status / boundary |
| --- | --- | --- | --- |
| Neovim (main baseline) | `config/nvim/init.lua`, `config/nvim/lazy-lock.json` | `$HOME/.config/nvim/` | Candidate; no repo activation verified. Startup can fetch/build plugins. |
| Ghostty | `config/ghostty/config` | Explicit active path under `$HOME` | Candidate; inspect both `$HOME/.config/ghostty/config` and `config.ghostty` before choosing `--ghostty-dest`. |
| Kitty | `config/kitty/kitty.conf`, `theme.conf`, `current-theme.conf` | `$HOME/.config/kitty/` | Candidate on Arch only; keep relative includes together. `kitty.conf.bak` is archival. |
| tmux | `config/tmux/.tmux.conf` | `$HOME/.tmux.conf` | Candidate; TPM/plugins are not installed by this repo. |
| Bash | `config/bash/.bashrc` | None | Deferred: imported Linux-specific CUDA/NVM and TERM settings need review. |

The main Neovim file uses lazy.nvim and its preserved lockfile. `config/nvim/init.lua-mobile` is a **deferred alternative**, not a second supported baseline or a file deployed by the script. It uses `vim.pack`; do not combine its plugin manager with the main lockfile. Pi, Limen, Herdr, tools, plugins and their runtime state are outside this file-link profile. No package install is specified.

Read-only inspection on 2026-10-29: the current host reported Linux `7.0.14-zen1-1-zen` x86_64; `pacman -Q` found Neovim 0.12.6-1, Ghostty 1.4.0-1, Kitty 0.49.2-1 and tmux 3.8-1. `~/.config/nvim`, `~/.config/ghostty`, `~/.config/kitty`, `~/.bashrc` and `~/.tmux.conf` exist as local paths, not repository links. This shows installed packages and existing paths, **not** which app loaded which configuration or whether the imported files match. No live file was changed. The particular target host and its active configuration still need inspection.

For a selected Arch target, inspect the paths and active app settings first, then run `scripts/deploy-config.sh --tool nvim` (add only approved tools, and supply `--ghostty-dest` after inspecting Ghostty) without `--apply`. Approve the exact links, backups, possible plugin effects, and rollback before applying. Follow [deployment and rollback](../docs/deploy-config.md); file links do not prove runtime activation.
