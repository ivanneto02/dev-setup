# Herdr: local installation and agent visibility

## What it adds

Herdr owns persistent terminal panes and displays agent activity. Pi remains the
interactive coordinator; **Limen remains the owner of delegated jobs, job state,
and worktrees**. Do not introduce a second delegation/worktree workflow through
Herdr merely because it offers those commands.

Limen documents detached workers launched in Herdr as **log-tail tabs**, not
interactive agent terminals. Its `--tab` mode is for interactive hosted workers.
Herdr does not automatically discover and display every arbitrary background
process launched elsewhere. The intended path is to start the coordinator in a
Herdr pane and let Limen create the job views. This path has not yet been tested
in this setup; Limen project initialization is still pending.

Closing a client/detaching leaves the Herdr server's terminal processes running.
A machine/server restart does not preserve the original processes. Supported
agent sessions can be restored/resumed through integrations; recovery must be
validated before relying on it for unattended work.

## Installed on this host

- Official upstream: https://github.com/herdrdev/herdr
- Release: **v0.9.5**, Linux x86_64.
- Binary: `~/.local/bin/herdr` (already on PATH).
- Asset: `https://github.com/herdrdev/herdr/releases/download/v0.9.5/herdr-linux-x86_64`.
- SHA-256, checked against GitHub's release-asset digest:
  `14d9e8bc8b4a9e0118d77c32266f76d461f09b40342eb23752960bd89f59929d`.
- Pi integration: installed with `herdr integration install pi`; reports
  **current (v9)** in `herdr integration status`.
- Managed extension: `~/.pi/agent/extensions/herdr-agent-state.ts`.
  Its SHA-256 at installation is
  `2c5272d732b475bbf91a027203b1f98d25fe43d2c1402530a442b288aeaca1e4`.

No pre-existing binary or integration file was replaced. The binary was fetched
to a temporary staging directory, checksum-verified, then installed with mode
755. No sudo, package-manager changes, shell edits, remote access, login service,
or worker/model calls were involved. No Herdr configuration file was authored.
Herdr reports its default config path as `~/.config/herdr/config.toml`; runtime
logs/session data belong outside this repository.

The extension is owned by the installed Herdr release, not copied into this repo.
Reinstalling/updating the integration replaces it; put any future custom
extensions alongside it, not inside it. Pi discovers user extensions at startup
or `/reload`. The bundled extension reports through the local Herdr socket only
when running in a Herdr environment; it does not change model/provider settings.
Like any Pi extension it executes with the user's permissions, not in a sandbox.

## Start using it

From a fresh terminal tab (preferably outside tmux for the initial trial):

```sh
cd ~/dev-setup
herdr
```

Complete any first-run onboarding. Start Pi **inside a Herdr pane**:

```sh
pi
```

Use the mouse first: select tabs/panes, use right-click menus to split, and inspect
the sidebar. This starts a separate Pi session; it does not move the current
external Pi process into Herdr. Use Pi's session chooser deliberately if resuming
an existing conversation, and avoid running the same session in two processes.

Useful commands from a terminal, after Herdr is running:

```sh
herdr status server
herdr agent list
herdr integration status
```

Detach with `Ctrl+b`, release, then `q`; run `herdr` again to reattach. These are
upstream defaults, not runtime-verified shortcuts here. To **stop the server and
its panes**, use `herdr server stop` only after intentionally stopping or handing
off active work. Detaching and stopping are not interchangeable.

## Shortcut conflict: decide before relying on keyboard navigation

Herdr 0.9.5's `--default-config` documents a `Ctrl+b` prefix. The repository's
[`config/ghostty/config`](../config/ghostty/config) defines the same prefix and
many matching suffixes, including `c`, `n`, `p`, `h/j/k/l`, `v`, `x`, and `z`.
Ghostty may handle these before Herdr sees them. tmux's documented default prefix
is also Ctrl+b. No live collision was demonstrated and no shortcuts were changed.

There are semantic differences too: Ghostty's `Ctrl+b → v` requests a split down,
whereas Herdr's documented `Ctrl+b → v` splits right; Ghostty's `Ctrl+b → s`
splits right, whereas Herdr uses that sequence for settings. Prefer mouse menus
until the active terminal configuration is checked and prefix ownership chosen.

Recommended direction for a later authorized configuration change: let Herdr own
multiplexer navigation in agent workspaces, then either remove overlapping
Ghostty sequences or choose a distinct Herdr prefix. Avoid nesting tmux for the
first trial. See [the shortcut guide](shortcuts.md) for the existing mappings.

## Validation and remaining work

Verified:

- Official asset checksum and installed binary checksum match.
- `herdr --version` reports 0.9.5; CLI/help/default-config commands work.
- `herdr integration status` reports Pi integration v9 current.
- The extension imports through the installed Pi 1.4.0 `jiti` TypeScript loader;
  calling its factory outside Herdr is a no-op, as intended.
- Pi 1.4.0's installed extension API declares the used `tui` mode and
  `agent_settled` event.
- `herdr status server` reports **not running** after installation checks.

A direct `/usr/bin/node --check` attempt rejected TypeScript annotations; that is
not a valid check for this extension in that invocation. The successful Pi-loader
check above replaced it. This was not an end-to-end Pi/Herdr integration test.

Still unverified: interactive rendering, selection/copy behavior inside nested
TUIs, live lifecycle reporting, detach/reattach, session recovery, and Limen's
log-tail tabs. Limen's installed setup guide records Pi 1.2.0 and Herdr 0.9.1 as
last known-good, not the installed Pi 1.4.0 / Herdr 0.9.5 combination.

Next trial: initialize Limen deliberately in a disposable committed repository,
start its coordinator in Herdr, and run one bounded documentation job. Explicitly
pass the approved provider, `gpt-6-astra`, and `medium`; keep the one-job,
10-minute, 50-tool-call trial policy in [Limen setup](limen-setup.md). Inspect the
log tab, result, diff, stop/continue behavior, and cleanup before expanding use.
Do not enable services, remote machines, or additional agent integrations for
this trial.

## Update and recovery

Review release notes before updating. A controlled reinstall should download the
chosen version's binary to a temporary path, compare its SHA-256 with that
release's official asset digest, back up the existing binary, and replace it only
after verification. Re-run version and integration checks and update this record.
The built-in `herdr update` exists but was not run. Avoid updating a running server
until its work is safely stopped or its handoff behavior has been tested.

To undo this installation:

1. Preserve needed sessions/work and intentionally stop any running Herdr server.
2. Run `herdr integration uninstall pi`, then restart/reload affected Pi sessions.
3. Remove `~/.local/bin/herdr` after verifying it is still this installation.
4. Keep any `~/.config/herdr` runtime state unless you explicitly want to discard
   it. Do not remove the rest of `~/.pi` or change Pi's settings.

To roll back a future upgrade, restore the backed-up binary or re-download this
recorded version and verify its checksum. Reinstall its bundled Pi integration
and test compatibility with the saved runtime state rather than assuming it.

## Sources checked

- [Herdr v0.9.5 release](https://github.com/herdrdev/herdr/releases/tag/v0.9.5)
  and the release's bundled CLI/default configuration.
- [Integration documentation at v0.9.5](https://github.com/herdrdev/herdr/blob/v0.9.5/docs/next/website/src/content/docs/integrations.mdx).
- [Quick start at v0.9.5](https://github.com/herdrdev/herdr/blob/v0.9.5/docs/next/website/src/content/docs/quick-start.mdx).
- [Bundled Pi extension at v0.9.5](https://github.com/herdrdev/herdr/blob/v0.9.5/src/integration/assets/pi/herdr-agent-state.ts).
- [Herdr agent setup guide](https://herdr.dev/agent-guide.md), consulted during
  installation; commands were checked against the installed release.
- Installed Limen revision `3419a4ca62eb3de413e30fc3c417952ff3c20847`, `docs/setup.md`;
  installed Pi 1.4.0 configuration/extension docs and API declarations.
