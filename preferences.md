# Environment preferences

These describe desired outcomes rather than the current tools. Repository work
rules remain authoritative in [AGENTS.md](AGENTS.md); current implementation status
is recorded in [workflow/status.md](workflow/status.md).

- Optimize for a busy solo developer: reliable autonomous work, low maintenance,
  easy recovery, and minimal supervision.
- Prefer simple, inspectable solutions and preserve working behavior unless a
  change has a clear benefit. Keeping the current setup is a valid outcome.
- Make the environment understandable without remembering prior conversations:
  document tool responsibilities, shortcuts, configuration sources, and recovery.
- Keep workflows portable across agent harnesses and avoid overlapping ownership
  of delegation, job state, and completion tracking.
- Favor the least expensive model that reliably handles the task. Subscription
  access, paid API usage, and local inference are distinct choices; no paid API
  switch or spending increase is implicitly authorized.
- Focus on local development. Remote development, Tailscale, and repurposing
  another laptop remain deferred.

No preferred target OS, machine profile, provider entitlement, spending budget,
or concurrency limit has been established for installation yet. The current
repository preparation task does not authorize changing system settings or
activating configuration.
