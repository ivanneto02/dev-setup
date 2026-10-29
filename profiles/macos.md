# macOS candidate profile

This is a **candidate**, not the selected default machine or OS. No macOS target, version, device restrictions or desired tool set is confirmed; no macOS machine was inspected or tested. Do not infer macOS compatibility from the Arch import host. Select and inspect the target before approving any live change. See [ownership and precedence](../docs/profile-ownership.md).

| Tool | Repository source | Proposed user destination | Status / boundary |
| --- | --- | --- | --- |
| Neovim (main baseline) | `config/nvim/init.lua`, `config/nvim/lazy-lock.json` | `$HOME/.config/nvim/` | Candidate only; startup can fetch/build plugins. Check installed Neovim and dependencies on the target. |
| Ghostty | `config/ghostty/config` | Explicit active config path under `$HOME` | Candidate; inspect both XDG `config` and `config.ghostty` paths and `~/Library/Application Support/com.mitchellh.ghostty/config{,.ghostty}`. macOS-specific config can override XDG config. Choose `--ghostty-dest` only after inspection. |
| tmux | `config/tmux/.tmux.conf` | `$HOME/.tmux.conf` | Candidate; check TPM/plugins on the target. |
| Kitty | `config/kitty/` | None | Blocked by Linux-only Wayland settings; deploy script rejects macOS selection. |
| Bash | `config/bash/.bashrc` | None | Deferred: imported Linux-specific settings are not portable. |

The main Neovim file uses lazy.nvim with `lazy-lock.json`. `config/nvim/init.lua-mobile` is a **deferred alternative** using `vim.pack`, not a deployed baseline; its plugin manager must not be combined with the main lockfile. No package manager, package list, install command, or tool version is assumed for macOS. Pi, Limen, Herdr, plugins and runtime state are not installed by the profile or deployment script.

Once a macOS target is selected, inspect existing user files, active config paths, installed versions and managed-device restrictions without replacing anything. Run `scripts/deploy-config.sh` in preview mode for each chosen tool, using an explicitly inspected Ghostty destination. Get approval for the exact links, backups, plugin effects and rollback before `--apply`. Follow [deployment and rollback](../docs/deploy-config.md). Link presence does not establish app load; runtime and recovery must be checked on the actual Mac.
