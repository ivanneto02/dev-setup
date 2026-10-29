# AGENTS.md

## Purpose

This repository is the source of truth for my development environment.

It contains my editor and terminal configuration, development tools, agent
workflows, setup automation, and documentation. It should let an agent configure
a machine consistently and help me understand, maintain, and improve that setup.

Optimize for a busy solo developer: reliable autonomous work, low maintenance,
easy recovery, and minimal time spent supervising tools.

## Core principles

- Preserve working behavior unless a change has a clear benefit.
- Prefer simple, inspectable solutions over elaborate infrastructure.
- Keep preferences separate from their current implementation.
- Automate repeatable operations with scripts; use agents for judgment.
- Make changes reproducible, reversible, and documented.
- Treat keeping the current setup as a valid outcome.
- Never claim that a proposed or documented feature is implemented.
- Avoid introducing tools with overlapping responsibilities without explaining
  why both are needed.

## Before making changes

1. Read the README and relevant configuration, scripts, and documentation.
2. Inspect the current Git state. Preserve unrelated and uncommitted work.
3. Identify the target machine, operating system, and applicable profile.
4. Establish the current behavior before attempting to improve it.
5. Check upstream documentation when relying on version-sensitive behavior.
6. Make reasonable implementation decisions within the requested scope.
   Ask only when missing information materially affects correctness, cost,
   access, or an irreversible action.

Do not assume that the machine running the agent is the machine being configured.

## Repository organization

Follow the existing layout. Until a layout is established, use:

- `config/`: editor, terminal, shell, and tool configurations.
- `profiles/`: machine and operating-system differences.
- `scripts/`: installation, verification, migration, and recovery.
- `agents/`: shared instructions, skills, roles, and harness adapters.
- `workflow/`: tool selections, model policies, version records, and evaluations.
- `docs/`: usage guides, shortcuts, decisions, and maintenance reports.
- `preferences.md`: durable requirements, constraints, and preferences.

Create directories when they contain useful material. Avoid empty scaffolding.

Keep repository-wide instructions concise. Place specialized instructions near
the files they govern and link to detailed documentation where appropriate.

## Configuration ownership

- Maintain one authoritative source for each managed configuration.
- Explicitly document installation destinations and override precedence.
- Separate shared defaults from machine-specific settings.
- Keep credentials, session transcripts, caches, and runtime state outside Git.
- Keep project-specific requirements in the project that owns them.
- Avoid copying shared instructions into multiple places where they can drift.

When importing `nvim-config`, preserve its behavior and plugin lockfile first.
Perform restructuring or plugin replacement as separate, reviewable changes.

## Environment setup

Setup must be repeatable and safe to rerun.

- Inspect existing files before replacing or linking them.
- Back up conflicting configuration and explain how to restore it.
- Prefer scoped edits over replacing entire files.
- Detect missing prerequisites and report actionable failures.
- Do not silently elevate privileges or assume administrator access.
- Respect managed-device restrictions; do not bypass them.
- Separate user-level configuration from system-level installation.
- Provide a preview or dry-run mode for operations with broad effects.
- Record the tested versions or revisions needed to reproduce the setup.
- Verify the resulting environment after applying changes.

Do not introduce a configuration manager solely for architectural neatness.
Use one when its benefits justify the additional dependency.

## Agent stack

The initial candidate stack is:

- Neovim for direct editing and inspection.
- Ghostty for the terminal.
- Pi for interactive agent work and model access.
- Herdr for persistent workspaces and agent visibility.
- Limen for delegated jobs, worktrees, and review workflows.

This is a starting hypothesis, not a permanent requirement.

Check current upstream capabilities and compatibility before installation.
Do not assume that examples, package names, flags, or integration instructions
remain valid across versions.

Give each component a clear responsibility. Prefer one owner for delegation,
job state, and completion tracking.

Keep core preferences and workflows portable across harnesses. Put
harness-specific configuration behind clearly identified adapters.

## Autonomous work

Work independently on authorized, reversible tasks.

Use available CLI tools proactively within the authorized task. Prefer `git`
for local repository operations, `gh` for GitHub operations, and `rg` for file
and text searches. These are examples, not an exhaustive list; no skill is
required for ordinary CLI usage. Check tool availability and relevant
authentication in the execution environment when needed. Run commands yourself
when access permits rather than asking the user to run them. Tool availability
does not expand authorization or bypass execution permissions.

Before a substantial task, establish:

- The desired outcome.
- Relevant constraints and files.
- Observable completion criteria.
- Appropriate validation.
- Conditions that require stopping or asking for input.

Use subagents when independent work materially improves the result. Avoid
delegating trivial tasks or creating agents without a clear purpose.

For parallel implementation:

- Give each worker a bounded task and clear ownership.
- Use separate branches or worktrees where appropriate.
- Avoid concurrent edits to the same files.
- Keep a coordinator responsible for integration and final verification.
- Set concurrency, time, and spending limits appropriate to available resources.
- Begin conservatively and increase concurrency only when useful.

A completed agent process does not prove that the task is complete.
Check its artifacts and validation evidence.

Worktrees separate changes; they do not restrict filesystem, network, or
credential access. Use an actual restricted execution environment when required.

Do not merge, publish, deploy, purchase, or alter external accounts unless the
user's instructions authorize that action.

Disclose significant Pi-assisted changes, including work by Pi-run subagents:

- Add `AI-assisted: Pi` as a footer to commit messages Pi authors, and as a final
  line in issues, issue comments, pull requests, release notes, and other
  published text Pi creates or substantially edits. Do not rely on a label.
- A Git push has no message field. Report a Pi-run push with its destination and
  commit hashes in the completion report; the pushed Pi-authored commits carry
  the footer. Do not rewrite human-authored commits just to add disclosure.
- For significant live configuration or other non-Git changes, include the same
  disclosure in the completion report and any durable change record. Do not add
  markers to executable configuration where they could change behavior.

Do not claim human review unless it happened. Do not alter earlier human-authored
content merely to add attribution; disclose assistance in a new update instead.

## Context and handoffs

Durable project state must not depend on a single conversation.

For substantial or interrupted work, leave a concise handoff containing:

- Intended outcome and current status.
- Relevant branch, worktree, and changed files.
- Checks run and their results.
- Decisions, blockers, and unresolved questions.
- The next concrete action.
- How to resume the relevant session or job, when supported.

Prefer references to authoritative files over duplicating their contents.
Keep handoffs factual and distinguish verified results from assumptions.

## Workflow maintenance

The intended maintenance entry point is `workflow update`.

Treat this and other workflow commands as proposed interfaces until they are
implemented and verified. Documentation must clearly identify unavailable
commands.

A workflow update should:

1. Inventory the installed and configured environment.
2. Read preferences, resource constraints, and previous decisions.
3. Review official releases, advisories, deprecations, and migration guidance.
4. Investigate alternatives only when they address a concrete need.
5. Evaluate promising changes in an isolated branch or disposable environment.
6. Recommend keeping, upgrading, trialing, or replacing components.
7. Record evidence, compatibility concerns, migration steps, and rollback.
8. Update configuration and documentation together when changes are adopted.

Do not equate newer with better.

Evaluate changes against:

- Task correctness and quality.
- Human intervention required.
- Reliability during long-running work.
- Resume and recovery behavior.
- Model and provider compatibility.
- Cost, rate limits, and local resource usage.
- Maintenance burden and portability.

Use representative tasks from actual development work. Prefer a small,
repeatable evaluation suite over a large synthetic benchmark.

Record when sources were checked and which versions were evaluated. Avoid
recommending the same rejected alternative repeatedly unless relevant facts
have changed.

A recommendation to keep the current setup is a successful maintenance result.

## Models and resource use

- Configure model choices by role rather than scattering model IDs in scripts.
- Distinguish subscription access, separately billed API usage, and local inference.
  A model request over a provider API authenticated with a ChatGPT subscription
  OAuth credential is not, for this policy, a switch to separately billed API-key
  usage. Check the actual credential type and route; OAuth alone does not prove
  every plan's entitlement or rule out paid extra usage.
- Verify authentication and entitlement support before relying on a provider.
  When a subscription route is verified for the task, authorized subagents may
  use it without separate approval for each worker. Do not assume a past
  task-specific model choice is a permanent default for unrelated work.
- Never silently switch to separately billed API usage, enable paid extra usage,
  or increase an agreed spending limit. Ask first when the route or billing is
  uncertain. Conserve subscription-plan tokens and rate limits: delegate only
  when useful, bound worker time and concurrency, and avoid redundant calls.
- Prefer the least expensive model that reliably meets the task's requirements.
- Escalate to stronger models when complexity or observed failures justify it.
- Configure explicit concurrency and execution limits.
- Report cost estimates as estimates; do not imply unverified hard enforcement.

## Discoverability and learning

The environment must be understandable without remembering prior conversations.

Maintain documentation that answers:

- What tools are installed, and why?
- How do I start, stop, inspect, and resume work?
- Which shortcuts are active?
- Where is each behavior configured?
- How is the repository organized?
- What changed recently?
- How do I recover from a broken update?

Generate inventories from authoritative configuration where practical.
Document limitations when runtime behavior cannot be fully extracted.

For shortcuts:

- Identify the application and relevant mode or context.
- Include the action and configuration source.
- Account for terminal, multiplexer, and editor conflicts.
- Distinguish configured mappings from mappings verified at runtime.

For explanatory agent responses, inspect the actual configuration and cite
relevant file paths. Do not answer solely from tool defaults or memory.

## Validation

Match validation to the risk and scope of the change.

Relevant checks may include:

- Configuration parsing and syntax checks.
- Shell linting.
- Installation previews.
- Repeated setup runs to verify idempotence.
- Application startup and smoke tests.
- Agent launch, delegation, interruption, and resume.
- Backup restoration and rollback.

Do not write tests that merely restate implementation details.

Do not report checks as passing unless they were run successfully.
If the target system is unavailable, explain what was verified locally and what
still needs validation there.

## Commit organization

When committing, separate logically independent changes into focused commits
when that improves review or rollback. Keep each commit coherent: include the
implementation, its tests, and directly related documentation together. Do not
split tightly coupled changes merely to make smaller commits.

Stage only the files or hunks intended for each commit. Preserve unrelated work,
use descriptive commit messages, and validate each commit as appropriate. This
rule does not itself authorize committing, pushing, or rewriting history.

## Documentation and change reporting

Whenever changes are made, review and update the relevant documentation in
the same change. This applies to configuration, scripts, tools, workflows, and
repository organization—not only code implementation.

Check affected guides, README links, shortcut references, implementation status,
and recovery instructions. Keep claims aligned with what is implemented and
verified. Update only documentation affected by the change; if none needs an
update, say so briefly in the completion report.

For significant decisions, record the problem, selected approach, meaningful
alternatives, and reasons to reconsider later.

When finishing work, report:

- What changed and why.
- What was verified.
- Any remaining limitation or required user action.
- Recovery instructions when relevant.

Keep reports concise. Include commands and file paths when they help me act.

## Current scope

Focus on local environment setup, agent workflows, maintenance, and
discoverability.

Remote development, Tailscale, and repurposing another laptop are deferred.
Preserve portability where inexpensive, but do not implement remote
infrastructure until requested.
