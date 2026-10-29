# Limen local installation and initial workflow

## Installed baseline

Installed on this Linux x86_64 host from https://github.com/overment/limen at
revision `3419a4ca62eb3de413e30fc3c417952ff3c20847` (package version 0.1.0).
This is a host installation, not portable setup automation.

- Checkout: `~/.local/share/limen`.
- Command: `~/.local/bin/limen`, a symlink to the local
  `~/.local/share/limen/bin/limen-local` launcher.
- Launcher executes `/usr/bin/node ~/.local/share/limen/bin/limen "$@"`.
  System Node is 26.12.1; Limen requires >=24. Default Node remains Pi's
  bundled 22.23.4. No shell defaults or Pi settings were changed.
- The launcher lives in the package's `bin/` directory because Limen's project
  hook loader resolves the command symlink to discover the package root.
  `bin/limen-local` is a local untracked addition, not an upstream change.
- No npm install/link was needed: the inspected package has no runtime
  dependencies and runs TypeScript using Node's built-in type stripping.
  Development dependencies were not installed.

Validation: launcher shell syntax, `limen --help`, and the project hook loader's
package discovery paths passed. No hooks were loaded into Pi, no model requests
were sent, and no worker, review, continuation, or stop behavior was tested.
Upstream's last known-good Pi is 1.2.0; this host uses Pi 1.4.0, so integration
compatibility remains to be tested.

## Proposed first workflow (not activated)

- Pi is the interactive coordinator; Limen owns jobs, worktrees and job state.
- Do not add Herdr until detached jobs demonstrate a need for its UI.
- Start with one detached worker at a time, a 10-minute timeout and
  `LIMEN_MAX_TOOL_CALLS=50`. These are execution controls, not a spending cap;
  one-at-a-time is an operating policy, not configured concurrency enforcement.
- Pass engine/provider/model/thinking explicitly. Use the owner's selected
  `gpt-6-astra` with `medium` thinking; confirm the approved provider route before
  launching. Limen's fallback is `openai-codex/gpt-6-astra:high`, not Pi's saved
  default. Do not silently switch provider or billing route.
- First trial: a small documentation task in a disposable Git repository with a
  committed baseline. Inspect the job log, result and diff. Then test stop and
  continuation before trusting long-running work.
- Review artifacts and checks, not merely a `done` status. Merging remains
  subject to explicit owner approval.

Workers auto-approve tools and have the user's filesystem and credential access.
Worktrees are not sandboxes. On Linux upstream also documents limits to escaped
process cleanup. See the installed `SECURITY.md` and `docs/jobs.md`.

## Before initializing dev-setup

The repository currently has no commits and its baseline files are untracked.
Do not start workers against it yet. Review and commit the intended baseline
with owner approval first, then deliberately integrate `limen init` output:

- `spec/vision.md`, `spec/build.md`, feature lanes;
- `.agents/limen/styleguide.md`;
- `.pi/extensions/limen.ts` and `.omp/extensions/limen.ts`.

Keep AGENTS.md authoritative rather than duplicating its rules. Choose whether
planning belongs in Git or uses `limen planning private`; keep `.limen/` runtime
state out of Git. Inspect init's actual changes before accepting them.
No init command has been run in this repository.

## Maintenance and removal

Do not blindly pull upstream: all initialized projects share the same checkout.
Review changes against the recorded revision and test them before adoption;
reload coordinator hooks only after an adopted update. Preserve the local
`bin/limen-local` launcher and check its filename does not collide with upstream.
Direct invocation of upstream `bin/limen` still uses PATH's Node 22 and can fail;
use the installed `limen` command. Team-group workflows that supply the direct
upstream path have not been enabled or validated.

To remove this installation, first ensure no jobs are running, then remove the
`~/.local/bin/limen` symlink. Archive or remove `~/.local/share/limen` after
checking for local changes. No project hooks or services need removal from this
installation because none were activated. Pi's installation is unaffected.
