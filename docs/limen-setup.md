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

At installation, launcher shell syntax, `limen --help`, and the project hook
loader's package discovery paths passed; no workers had been run. A later
narrow trial with Pi 1.4.0 and Herdr 0.9.5 is recorded below. Upstream's
last-known-good Pi remains 1.2.0; broader compatibility is unverified.

## Bounded workflow (disposable trial and project jobs)

- Pi is the interactive coordinator; Limen owns jobs, worktrees and job state.
- Herdr supplies visibility; see [Herdr setup](herdr-setup.md). A detached job's
  log-tail tab was observed in a disposable trial. Limen retains job ownership.
- Follow the [ChatGPT OAuth model policy](../workflow/model-policy.md) before
  launching the coordinator, workers, or reviewers. Only Pi `openai` with a
  ChatGPT-plan OAuth credential is permitted; no OpenAI API key, paid extra usage,
  proxy, or alternate provider is allowed. The owner approved this route for
  authorized work; no per-job account-level proof is available. Stop on auth
  failures or observed billing/entitlement warnings. The local auth check
  verifies credential readiness and type, **not** plan entitlement or paid-extra
  controls.
- Default to one detached worker or reviewer at a time; allow up to three when
  independent tasks justify the resource use. Short trials use 10 minutes and
  `LIMEN_MAX_TOOL_CALLS=50 LIMEN_PREFLIGHT=auth`; bounded issue jobs may use
  20 minutes and 80 calls. These are per-job execution controls, not a spending
  cap or a seat-wide concurrency guard. Hosted jobs lack detached limits.
- Use `scripts/limen-oauth.sh worker 'label' 'task'` or
  `scripts/limen-oauth.sh reviewer BRANCH 'label' 'review task'` for a
  short bounded spawn on the approved route; it rejects API-key auth and
  provider overrides before starting Limen. For other jobs pass
  engine/provider/model/thinking explicitly after the policy preflight. The
  [role policy](../workflow/model-policy.md) describes limits and gaps. Limen's fallback is
  `openai-codex/gpt-6-astra:high`, not Pi's saved default. Never silently switch
  route on a spawn or continuation. Keep credentials in Pi's private user store
  outside Git. Review auth metadata without `--credentials` or token output.
- The first trial was a documentation task in a disposable Git repository with a
  committed baseline. Several bounded issue workers later ran in `dev-setup`;
  this verifies launch and completion here, not coordinator recovery. An
  independent review job later ran through `scripts/limen-oauth.sh reviewer`;
  it reported an open target-selection check rather than approving the candidate.
  Trial results and remaining gaps are below.
- Review artifacts and checks, not merely a `done` status. Merging remains
  subject to explicit owner approval.

Workers auto-approve tools and have the user's filesystem and credential access.
Worktrees are not sandboxes. On Linux upstream also documents limits to escaped
process cleanup. See the installed `SECURITY.md` and `docs/jobs.md`.

## Disposable trial results (2026-10-29)

- The temporary repository `/tmp/limen-e2e-fXnequ` had two local baseline
  commits and `limen init`-generated vision, board, feature lanes, styleguide,
  Pi/OMP hook stubs, and ignored `.limen/` runtime state. These files were
  inspected and the vision/styleguide scoped to documentation only. No Limen
  initialization or hook was added to `dev-setup`; no merge or push occurred.
- The coordinator was the existing Pi 1.4.0 session in Herdr 0.9.5. Pi reported
  `openai/gpt-6-sol` ready before launch. One detached worker at a time ran via
  `LIMEN_MAX_TOOL_CALLS=50 LIMEN_PREFLIGHT=auth limen spawn --engine pi
  --provider openai --model gpt-6-sol --thinking medium --timeout 10m`.
  This trial predates the role policy. Its ready OAuth check did not establish
  plan entitlement or paid-extra settings for future launches.
  The first job finished in 56 seconds using 12 tool calls. It added only a
  `Usage` section to the disposable README; worktree `git diff --check` passed.
- A detached continuation, explicitly routed to the same provider/model and
  tool-call cap, finished and added a single sentence to that section. While it
  ran, `herdr workspace list` and `herdr tab list` showed its separate log-tail
  workspace and running tab; Limen logged tab closure afterward. A second
  continuation was started and stopped; the log records `stop requested` and
  `stopped: process group interrupted`. Its worktree still has only the README
  edit, with `git diff --check` passing. No running jobs remained after checks.
- The worker's uncommitted edit was inspected in its worktree at
  `/tmp/.limen-e2e-fXnequ-limen-worktrees/2026-10-29-trial-readme-documentation-ff134a20`.
  `limen diff` compared commits and showed no patch because the worker did not
  commit; use `git -C <worktree> diff` as well as Limen's result in future trials.
  After confirming no jobs remained, the worktree was removed with `git worktree
  remove --force`; the disposable repo and its runtime state were then deleted.
  No trial work remains to recover from those temporary directories.

This trial did not verify automatic completion delivery into the coordinator's
chat, restart recovery, a review job, or unattended long-running operation.
The owner later confirmed that the F12 prefix keypress works in Herdr.
The trial does not establish a spending cap; continuation commands do not
accept the spawn `--timeout` flag, so keep continuations small
and inspect their limits before relying on them. A worker's full access to user
files/credentials remains a trust boundary, not a sandbox guarantee.

## dev-setup project initialization (2026-10-29)

The repository baseline was committed as `9683e05` before project initialization;
Limen needs at least one commit before a worker starts. The owner explicitly
authorized `limen init` after the disposable trial. Its output was inspected
before project guidance was filled in. The command created `spec/vision.md`, `spec/build.md`,
`spec/features/` templates and lanes, `.agents/limen/styleguide.md`,
`.pi/extensions/limen.ts`, `.omp/extensions/limen.ts`, and `.gitignore` for
`/.limen/`. There were no existing files at those paths. It also created
ignored `.limen/jobs/` runtime state. `AGENTS.md` was reported as an overlay
of the Limen package default; it was **not** replaced, and no package-default
instructions were copied into it.

The vision and styleguide were filled with short, project-specific content;
`AGENTS.md` and `preferences.md` remain the authoritative work rules and durable
preferences. The board notes the current local direction but invents no tickets
or model routing. Planning stays committed to this repository (the default
`limen planning committed`); `.limen/` jobs, logs and sessions stay outside Git.
No model request or worker was launched in `dev-setup` during initialization.
The OMP hook stub is generated by Limen but dormant unless OMP is installed and
run in this project; Pi is the selected engine.

The stubs import hooks from the installed Limen package discovered via PATH (or
`LIMEN_PACKAGE`); they do not vendor a fixed release into Git. A repeat
`limen init` kept every generated file unchanged (hashes matched),
`limen planning` reported `committed`, and `git check-ignore` confirmed
`/.limen/`. A fresh Pi 1.4.0 offline, no-session, one-run-trusted startup
listed `.pi/extensions/limen.ts` among loaded extensions without startup
warnings; the interactive smoke was terminated after 8 seconds. This verifies
startup discovery, **not** a worker or completion delivery in this repository.
On this Linux host the installed launcher resolves that package. On macOS, installation,
PATH, Node >=24, and hook compatibility must be validated separately rather
than assuming these stubs work there. Pi discovers project extensions at startup
or `/reload`; an already-running session is not automatically reloaded. Do not
start a job without the [policy](../workflow/model-policy.md) preflight, an
explicit approved provider/model/thinking route and execution limits. No hard
spending cap or concurrency enforcement was added.

To undo only this project initialization, first stop/inspect any jobs, then
remove the generated `spec/`, `.agents/limen/`, `.pi/extensions/limen.ts`,
`.omp/extensions/limen.ts` and the added `.gitignore` if they still contain only
this setup, and reload/restart Pi. Preserve any later project edits or runtime
state worth keeping before deleting `.limen/`. This does not uninstall the
user-level Limen binary or affect the Herdr server.

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
checking for local changes. Project hooks now exist in `dev-setup`; remove them as described above if
reversing project initialization. Pi's installation is otherwise unaffected.
