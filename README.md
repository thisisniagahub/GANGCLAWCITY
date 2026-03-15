# GANGCLAWCITY

GANGCLAWCITY is a workspace for turning proven AI-agent products into a unified GANGCLAWCITY platform. The goal is not to start from zero. The goal is to absorb strong concepts, remove fragmented branding from user-facing surfaces, harden the architecture, and ship a cleaner product line for Malaysian operators and SMEs.

## What This Repository Is

- A multi-project workspace, not a finished monorepo.
- A migration layer between upstream donor apps and GANGCLAWCITY-owned products.
- A place to standardize docs, branding, security posture, and deployment discipline before public launch.

## Product Map

| Folder | GANGCLAWCITY role | Current status |
| --- | --- | --- |
| `openclaw-office/` | Dashboard and control surface | Primary integration target |
| `agent-town/` | Spatial demo and operator UX | Primary integration target |
| `ai-town/` | Simulation and experimentation lab | Donor module |
| `Star-Office-UI/` | Lightweight office status board | Donor module |
| `pixel-agents/` | Developer tooling and workspace visualization | Donor module |
| Root `index.html` + `style.css` + `script.js` | Current landing page | Static marketing shell |

## Current Truth

- Root `npm` scripts are placeholders only.
- Deployment docs from early March 2026 were inconsistent and are being archived.
- Some subfolders still retain upstream package metadata, nested `.git` directories, and historical docs.
- Legal attribution must stay intact even when product branding changes.

## Start Here

1. Read `docs/00-start-here/START_HERE.md`.
2. Use `docs/00-start-here/QUICKSTART.md` for local commands.
3. Treat `docs/01-architecture/ARCHITECTURE.md` and `docs/02-deployment/DEPLOYMENT_STATUS.md` as the active source of truth.

## Documentation Policy

- Active operational docs live under `docs/`.
- Historical reports and superseded plans belong in `docs/99-legacy/`.
- Do not claim a deployment is live unless it is re-verified from the current source tree.

## Attribution

This repository contains donor code derived from external open-source projects. Rebranding product surfaces is allowed, but original licenses and attribution obligations must remain preserved.
