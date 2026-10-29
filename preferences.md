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
- Use only ChatGPT-plan OAuth for Pi and Limen model work. Never use an OpenAI
  API key, paid API route, or paid extra usage now or as a future fallback.
  Conserve subscription tokens and rate limits. The role choices and bounded
  execution policy live in [workflow/model-policy.md](workflow/model-policy.md);
  verify the route rather than inferring billing from its provider name.
- Support Arch Linux and macOS as distinct OS profiles without choosing a
  default target machine. The Arch host running this Pi session is the current
  target for inspection, not an authorization to deploy. Ghostty is the
  supported terminal and keeps Ctrl+b;
  Herdr handles persistence with F12. tmux and Kitty are unsupported historical
  imports. Bash is the intended shell, but its imported config needs repair
  before deployment.
- Focus on local development. Remote development, Tailscale, and repurposing
  another laptop remain deferred.

No default target machine, macOS version/restrictions, or separately billed
spending budget has been established. Do not interpret these preferences
as permission to change live system settings or apply configuration without an
exact preview and approval.
