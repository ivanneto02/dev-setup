# macOS candidate profile

This is one supported OS profile, not the selected default machine or OS. The macOS target's version, restrictions and live tool state have not been inspected or tested. Do not infer runtime compatibility from the Arch host. Inspect the target before approving any live change. See [ownership and precedence](../docs/profile-ownership.md).

| Tool | Repository source | Proposed user destination | Status / boundary |
| --- | --- | --- | --- |
| Neovim (main baseline) | `config/nvim/init.lua`, `config/nvim/lazy-lock.json` | `$HOME/.config/nvim/` | Candidate only; startup can fetch/build plugins. Check installed Neovim and dependencies on the target. |
| Ghostty | `config/ghostty/config` | Explicit active config path under `$HOME` | Candidate; inspect both XDG `config` and `config.ghostty` paths and `~/Library/Application Support/com.mitchellh.ghostty/config{,.ghostty}`. macOS-specific config can override XDG config. Choose `--ghostty-dest` only after inspection. |
| Bash (intended shell) | `config/bash/.bashrc` | None yet | Deferred: imported Linux-specific settings are not portable or safe to activate. |

Kitty and tmux are **unsupported archival imports**, not profile selections. The deployment script rejects them on both OS profiles; see [terminal policy](../docs/terminal-policy.md).

The main Neovim file uses lazy.nvim with `lazy-lock.json`. `config/nvim/init.lua-mobile` is a **deferred alternative** using `vim.pack`, not a deployed baseline; its plugin manager must not be combined with the main lockfile. No package manager, package list, install command, or tool version is assumed for macOS. Pi, Limen, Herdr, plugins and runtime state are not installed by the profile or deployment script.

Once a macOS target is selected, inspect existing user files, active config paths, installed versions and managed-device restrictions without replacing anything. Run `scripts/deploy-config.sh` in preview mode for each chosen tool, using an explicitly inspected Ghostty destination. Get approval for the exact links, backups, plugin effects and rollback before `--apply`. Follow [deployment and rollback](../docs/deploy-config.md). Link presence does not establish app load; runtime and recovery must be checked on the actual Mac.
