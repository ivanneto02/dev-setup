# Arch Linux candidate profile

This is one supported OS profile, not the default machine or OS. On 2026-10-29 the owner selected the Arch machine running Pi as the **current target for inspection and local workflow decisions**. That choice does not approve deployment or make Arch the default for later work. Inspect restrictions and live files and obtain approval for the exact preview before applying configuration. See [ownership and precedence](../docs/profile-ownership.md).

| Tool | Repository source | Proposed user destination | Status / boundary |
| --- | --- | --- | --- |
| Neovim (main baseline) | `config/nvim/init.lua`, `config/nvim/lazy-lock.json` | `$HOME/.config/nvim/` | Candidate; no repo activation verified. Startup can fetch/build plugins. |
| Ghostty | `config/ghostty/config` | Explicit active path under `$HOME` | Candidate; inspect both `$HOME/.config/ghostty/config` and `config.ghostty` before choosing `--ghostty-dest`. |
| Bash (intended shell) | `config/bash/.bashrc` | None yet | Deferred: imported CUDA/NVM and TERM settings need repair before any activation. |

Kitty and tmux are **unsupported archival imports**, not selectable tools. The deployment script rejects them; see [terminal policy](../docs/terminal-policy.md).

The main Neovim file uses lazy.nvim and its preserved lockfile. `config/nvim/init.lua-mobile` is a **deferred alternative**, not a second supported baseline or a file deployed by the script. It uses `vim.pack`; do not combine its plugin manager with the main lockfile. Pi, Limen, Herdr, tools, plugins and their runtime state are outside this file-link profile. No package install is specified.

Read-only inspection on 2026-10-29: the current host reported Linux `7.0.14-zen1-1-zen` x86_64; `pacman -Q` found Neovim 0.12.6-1, Ghostty 1.4.0-1, Kitty 0.49.2-1 and tmux 3.8-1 (the last two are installed but unsupported by this setup). `~/.config/nvim`, `~/.config/ghostty`, `~/.config/kitty`, `~/.bashrc` and `~/.tmux.conf` exist as local paths, not repository links. This shows installed packages and existing paths, **not** which app loaded which configuration or whether the imported files match. No live file was changed. The owner later confirmed this is the current Arch target. Read-only inspection found Neovim's live `init.lua` and lockfile differ from the repository; the live Ghostty `config.ghostty` also differs by repeated bindings but Ghostty's parsed unique Ctrl+b set matches the candidate. The live Bash file differs too. The selected machine's user-config paths were inspected, not replaced; application startup and physical nested key delivery still need verification.

For a selected Arch target, inspect the paths and active app settings first, then run `scripts/deploy-config.sh --tool nvim` (add only approved tools, and supply `--ghostty-dest` after inspecting Ghostty) without `--apply`. Approve the exact links, backups, possible plugin effects, and rollback before applying. Follow [deployment and rollback](../docs/deploy-config.md); file links do not prove runtime activation.
