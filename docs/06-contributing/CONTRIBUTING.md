# Contributing to GANGCLAWCITY

This repository is in active absorption and cleanup mode. Contribute with discipline.

## First Principles

- Improve the product line, not the noise.
- Keep docs and deployment claims truthful.
- Preserve upstream license obligations when rebranding donor code.
- Do not introduce browser-visible production secrets.

## Workstreams

- `openclaw-office/` and `agent-town/` are the primary workstreams.
- `ai-town/`, `Star-Office-UI/`, and `pixel-agents/` are donor modules and should be treated as adaptation work, not finished core apps.
- Root landing assets live at repo root, not under `landing-page/`.

## Local Setup

Use the commands in `docs/00-start-here/QUICKSTART.md`. Do not assume `pnpm install` at repo root will prepare the entire workspace.

## Coding Expectations

- Match the style of the package you touch.
- Keep changes scoped to one concern.
- Prefer additive changes over broad rewrites.
- Update or archive conflicting docs in the same change.

## Commits

Use Conventional Commits:

- `feat(dashboard): add queue health panel`
- `fix(agent-town): correct gateway proxy path`
- `docs(root): replace stale deployment claims`

## Pull Requests

Every PR should include:

- what changed
- why it changed
- how to verify it
- screenshots for visible UI changes
- risks or follow-up work if the change is incomplete

## Documentation Policy

- Active guidance belongs in `docs/`.
- Historical material belongs in `docs/99-legacy/`.
- Do not leave one-off reports in the repository root.

## Security Rules

- Never commit real tokens, passwords, or private gateway details.
- If a change touches auth, gateway routing, or remote access, include a security note in the PR.
