# Herdr: local installation and agent visibility

## What it adds

Herdr owns persistent terminal panes and displays agent activity. Pi remains the
interactive coordinator; **Limen remains the owner of delegated jobs, job state,
and worktrees**. Do not introduce a second delegation/worktree workflow through
Herdr merely because it offers those commands.

Limen documents detached workers launched in Herdr as **log-tail tabs**, not
interactive agent terminals. Its `--tab` mode is for interactive hosted workers.
Herdr does not automatically discover and display every arbitrary background
process launched elsewhere. The tested path starts the coordinator in a Herdr pane and lets Limen create
log-tail job views. A disposable-repository trial confirmed that path; current
`dev-setup` job records also show detached workers in Herdr log-tail tabs.

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
or worker/model calls were involved. At installation no Herdr configuration file was authored. For the later trial,
`~/.config/herdr/config.toml` was updated with `[keys] prefix = "f12"` and backed
up as `~/.config/herdr/config.toml.pre-f12-20261029125402`. This is a live,
user-owned setting, not installed from this repository. Runtime logs/session
data belong outside this repository.

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

With the live user prefix override, detach with `F12`, release, then `q`; run
`herdr` again to reattach. The owner confirmed that F12 reaches Herdr; the
detach sequence itself has not been tested. The upstream default is `Ctrl+b → q`.
To **stop the server and its panes**, use `herdr server stop` only after
intentionally stopping or handing
off active work. Detaching and stopping are not interchangeable.

## Finding Limen workers in Herdr

A default `limen spawn` is detached, even when its coordinator runs in Herdr.
Limen runs the worker outside the pane and opens a **log-tail tab** in a job
workspace. That tab displays output; it is not an agent terminal. Do not expect
this worker in Herdr's agent list. The coordinator's own Pi pane can appear
there instead.

For job state, run these from the **main project root** (not a job worktree):

```sh
cd ~/dev-setup
limen jobs --running         # current running jobs
limen jobs <id>              # one job's state and recent log
limen jobs --all             # include older records
```

In the Herdr UI, use the workspace picker (`F12`, release, then `w` on this
host), or expand the sidebar (`F12`, release, then `b`) and select the
`dev-setup workers · /home/ivan/dev-setup` workspace. Select the tab labelled
`<job label> · running` to read its log. The upstream default prefix is
`Ctrl+b`, not this host's `F12`. The workspace picker and sidebar bindings
come from `herdr --default-config`; these particular navigation keystrokes
have **not** been exercised in the live UI. From any terminal, inspect the
same live layout without changing focus:

```sh
herdr workspace list
herdr tab list --workspace <workspace_id>
herdr agent list
```

`herdr agent list` lists detected agent panes, not Limen jobs. On this host it
listed the coordinator Pi pane while the running detached job appeared as a
tab in the worker workspace, with no worker agent row. Herdr can mark the
log-tail workspace's status `unknown`; that is not the job's Limen state.
A job tab is temporary. Limen closes it on completion and can close its
workspace when no tabs remain. Earlier `dev-setup` job logs record these
closures. The job record and log remain under the main project's
`.limen/jobs/<id>/`. If the tab has closed, `limen jobs <id>` still gives
state and recent log; `limen open <id>` can open a log view in Herdr, but
**does not resurrect a hosted worker**. A failed tab close can leave an old
tab behind, so an open tab alone does not prove a job is running.

No Herdr restart, config edit, server reload, or Pi `/reload` is needed to make
a detached worker appear in the agent list: it is not running in a Herdr agent
pane. The installed Pi integration reports `current (v9)` and the coordinator
is detected. Reloading Pi is relevant only after installing/changing a Pi
extension; it does not convert a detached log tail into an agent.

For a **new** interactive job, `limen spawn --tab …` starts the selected engine
inside its Herdr tab (Herdr required). A person can type into that worker;
Herdr's agent detection can then report the supported agent pane. This is
not a display toggle for existing detached jobs. Hosted jobs refuse
`--timeout` and lack the detached harness's timeout, tool-call cap and process
containment. They must call `finish` to end the Limen job; an idle pane is not
completion. Use hosted mode only when direct interaction is needed. This job
did not start a hosted worker, so the exact agent-list row and sidebar badge
for a new hosted worker on this host remain unverified.

## Shortcut ownership

Ghostty retains its existing `Ctrl+b` tab/pane bindings, including the active
`~/.config/ghostty/config.ghostty`; neither Ghostty file was changed for the trial.
Herdr now has `F12` as its prefix in the live user config noted above, replacing
its default `Ctrl+b`. `herdr config check` passed and `herdr server reload-config`
reported `applied` without diagnostics. The owner confirmed the physical F12
keypress reaches Herdr. If another terminal intercepts F12, choose another
Herdr prefix rather than removing familiar Ghostty mappings. tmux still defaults
to `Ctrl+b` if run nested; the Ghostty/tmux overlap remains. See the
[shortcut guide](shortcuts.md).

## Validation and remaining work

Verified:

- Official asset checksum and installed binary checksum match.
- `herdr --version` reports 0.9.5; CLI/help/default-config commands work.
- `herdr integration status` reports Pi integration v9 current.
- The extension imports through the installed Pi 1.4.0 `jiti` TypeScript loader;
  calling its factory outside Herdr is a no-op, as intended.
- Pi 1.4.0's installed extension API declares the used `tui` mode and
  `agent_settled` event.
- At installation, `herdr status server` reported **not running**; during the
  later trial the server was running and reported compatible.

A direct `/usr/bin/node --check` attempt rejected TypeScript annotations; that is
not a valid check for this extension in that invocation. The successful Pi-loader
check above replaced it. This was not an end-to-end Pi/Herdr integration test.

On 2026-10-29, Pi 1.4.0 in Herdr 0.9.5 spawned a Limen documentation worker
in a disposable repo. Herdr showed its separate log-tail workspace/tab while a
continuation was running; Limen recorded the tab closing on completion. The
worker and a continuation finished; a second continuation was stopped, with
Limen recording a process-group interruption. See [Limen trial results](limen-setup.md).

Still unverified: selection/copy in nested TUIs, Pi lifecycle badge transitions
during a model turn, detach/reattach, and session recovery. Limen's upstream last-known-good versions remain Pi 1.2.0
and Herdr 0.9.1, so this trial demonstrates a narrow working path, not general
compatibility.

## Update and recovery

Review release notes before updating. A controlled reinstall should download the
chosen version's binary to a temporary path, compare its SHA-256 with that
release's official asset digest, back up the existing binary, and replace it only
after verification. Re-run version and integration checks and update this record.
The built-in `herdr update` exists but was not run. Avoid updating a running server
until its work is safely stopped or its handoff behavior has been tested.

To undo only the trial's prefix change (without uninstalling Herdr), first
compare the current file with the backup, then restore
`~/.config/herdr/config.toml.pre-f12-20261029125402` over
`~/.config/herdr/config.toml`, run `herdr config check`, and run
`herdr server reload-config`. This returns Herdr to its default `Ctrl+b`
prefix, which overlaps Ghostty. Preserve any later edits before restoring.

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
- For worker visibility: installed Herdr 0.9.5 `--default-config`, `workspace list`,
  `tab list`, `agent list` and `integration status`; installed Limen
  `src/integrations/herdr.ts` (`openWatchTab`, `createTab`, `settleJobTab`,
  `openJobPlace`), `templates/worker.md` and `templates/agents.md`.
  Read-only live `dev-setup` job records under `.limen/jobs/` and Herdr server
  log under `~/.config/herdr/` confirmed the running log tab and prior closes.
  UI navigation and hosted agent rendering were not tested in this investigation.
