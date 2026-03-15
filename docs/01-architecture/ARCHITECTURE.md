# GANGCLAWCITY Architecture

This document describes the repository as it exists now and the platform shape it is moving toward.

## Current State

GANGCLAWCITY is a workspace of proven donor applications, not yet a fully unified product.

### Core Integration Targets

- `openclaw-office/` -> GANGCLAWCITY Dashboard
- `agent-town/` -> GANGCLAWCITY CityView

### Donor Modules

- `ai-town/` -> GANGCLAWCITY Lab
- `Star-Office-UI/` -> GANGCLAWCITY Office
- `pixel-agents/` -> GANGCLAWCITY Workspace tooling

### Shared Layers

- Root static landing page
- `docs/`, `security/`, `skills/`, `config/`, and `scripts/`

## Main Problem To Solve

The repository still carries:

- upstream package metadata
- nested repositories
- duplicated status reports
- deployment configs that do not match the live tree
- browser-exposed gateway configuration patterns that are too weak for production

## Target Platform Shape

```text
GANGCLAWCITY
├── Landing
├── Dashboard
├── CityView
├── Lab
├── Office
└── Workspace Tooling
```

Each product surface should look like one brand, share one documentation standard, and converge on one secure gateway model.

## Target Runtime Model

```text
Browser UI
  -> GANGCLAWCITY app backend or proxy
  -> secured gateway broker
  -> OpenClaw gateway
  -> agents, tools, models, and workflows
```

## Non-Negotiable Rules

- Production tokens must not be exposed to browser clients.
- Public deployment claims must be backed by fresh verification.
- Rebranding can change UI and product copy, but it must not remove required license attribution.
- `openclaw-office/` and `agent-town/` get priority before the other donor modules.

## Recommended Migration Order

1. Stabilize `openclaw-office/`
2. Stabilize `agent-town/`
3. Fold in `Star-Office-UI/`
4. Fold in `ai-town/`
5. Reposition `pixel-agents/` as internal tooling
