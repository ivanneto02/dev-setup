# Deploy repository configuration

`/skill:deploy-config` is a Pi project skill (in `.agents/skills/deploy-config/SKILL.md`). A trusted Pi session can load it at startup or after `/reload`. Asking an agent to deploy is **not** approval to change live files: it must identify the target and present an exact preview and rollback before applying changes. The script below is also usable without Pi or paid model calls. It is **not** a package installer or a one-command deployment of the full environment.

## Supported files and destinations

`scripts/deploy-config.sh` supports Arch Linux and macOS; `--tool` is required, can be repeated, and preview is the default. It links individual files, leaving neighboring local files in place. Symlinks use absolute paths back to this checkout; moving or deleting the checkout breaks them. The checked-out revision, including uncommitted files, is the source. Re-run preview after moving the checkout.

| Selection | Repository source | User destination / conditions |
| --- | --- | --- |
| `--tool nvim` | `config/nvim/init.lua`, `lazy-lock.json` | `~/.config/nvim/` on both systems. The mobile alternative is not selected. Starting Neovim can download/build plugins; validate prerequisites and authorize those effects separately. |
| `--tool ghostty --ghostty-dest PATH` | `config/ghostty/config` | One explicitly chosen, active config path under home. On Arch, inspect `~/.config/ghostty/config` **and** `config.ghostty`. On macOS, inspect XDG paths and `~/Library/Application Support/com.mitchellh.ghostty/config{,.ghostty}`; macOS-specific files load after XDG and can override them. Do not add a link at an inactive path and claim activation. |
| `--tool kitty` | `config/kitty/kitty.conf`, `theme.conf`, `current-theme.conf` | `~/.config/kitty/` on Arch only. Relative includes remain beside the config. `kitty.conf.bak` is an archive, not deployed. The imported Kitty config has Linux-only Wayland settings and is blocked on macOS. |
| `--tool tmux` | `config/tmux/.tmux.conf` | `~/.tmux.conf` on both systems. Requires an appropriate tmux/TPM setup; check plugins and prefix conflicts before activation. |

**Not supported:** The imported `config/bash/.bashrc` forces `TERM`, repeats CUDA paths and assumes Linux helpers; it must be repaired and tested before deployment, especially on macOS. Pi/Limen/Herdr binaries, their user settings, service state, credentials, skills from `agents/skills/`, and Neovim plugin downloads are not installed by this script. This limitation is tracked by issues #3, #5, #6 and #10. Mac installation and live runtime remain untested. Arch tools may be similar to this host, but inspect the actual machine.

## Preview, approval, apply

From this repository, for example, after inspecting installed apps and active config paths:

```sh
scripts/deploy-config.sh --tool nvim --tool ghostty --ghostty-dest "$HOME/.config/ghostty/config"
# Only after the exact effects and billing/access implications have been explained and approved:
scripts/deploy-config.sh --tool nvim --tool ghostty --ghostty-dest "$HOME/.config/ghostty/config" --apply
```

The Ghostty path above is an **example**, not the active path on every machine. On this Arch host the existing config was `~/.config/ghostty/config.ghostty`; creating `config` beside it without understanding Ghostty load precedence is not a safe default. On macOS, inspect both config locations and their overrides using the installed Ghostty version. Ghostty's [configuration guide](https://ghostty.org/docs/config) (checked 2026-10-29) describes XDG and macOS-specific paths and load order. Confirm effective behavior after activation, not just file presence.

For an isolated test, pass `--home /path/to/disposable/home` and choose a Ghostty destination under that same path. This does not change `$HOME` for applications; it only redirects where the script puts links. The script does not create its target home or install missing tools.

Preview reports `link`, `backup`, or `keep` without writing files. Apply preflights all selections before writing, creates missing parent directories, moves each existing file or symlink to a sibling with `.pre-dev-setup-<timestamp>-<pid>`, then links the source. A second apply keeps already-correct links. It rejects directory targets and symlinked parent directories. A failed apply can leave earlier links in place; inspect actual files and backups before continuing. No sudo or automatic plugin startup is used. Live config may have other files and overrides; this script manages only the named paths.

## Verify and recover

Check `ls -l` or `readlink` on each destination, run the tool's safe parser/check if available, and test its behavior only with any required download/build effects approved. Re-run the same command **without** `--apply`: every selected file should say `keep`. A link to the repo does not prove the application loaded it. Changes to source files take effect according to each application's reload behavior; existing sessions may need reload/restart.

For each destination created by apply, remove **only its link if it still points to this repo**. If the apply output named a saved `DEST.pre-dev-setup-*` file, move that exact backup back to `DEST` after checking for later edits. For a new destination without a backup, only remove the link. This is per-file rollback; never glob-delete backups. Review any partial run before restoring. Keeping the repo checkout available preserves linked configuration until rollback. Do not remove live credentials, sessions, caches or unrelated files.

Validation on 2026-10-29: `bash -n`, preview without changes, conflicting-file backup, fresh links, repeat preview/apply, restore, and fail-closed cases in temporary homes on Arch. **No real home or macOS machine was modified or verified.**
