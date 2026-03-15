# Deployment Status

Date checked: March 15, 2026

## Current Truth

- There is no single verified end-to-end production deployment that can be trusted purely from the current source tree.
- Root Vercel and VPS claims from earlier reports were inconsistent and have been archived.
- Root `npm` scripts are placeholders and must not be treated as release commands.

## What Can Be Run Locally

- Root landing page via static file hosting
- `openclaw-office/` via `pnpm`
- `agent-town/` via `pnpm`
- `ai-town/` via `npm`
- `Star-Office-UI/` via Python
- `mock-gateway/` for local gateway simulation

## Known Deployment Gaps

- Compose and Skaffold paths do not align with the current folder layout.
- Health probes and service ports are not consistent across all apps.
- Some frontend flows still assume browser-visible gateway configuration.
- Historical docs claimed verified Vercel and VPS states that were not reproducible from the checked repository state.

## Release Gate Before Any Production Claim

1. Fix deployment paths and probes.
2. Remove browser exposure of production gateway credentials.
3. Re-verify the actual public URL and exact commit deployed.
4. Record the result in this file, not in one-off root reports.

## Rule

Until the four steps above are complete, treat this repository as pre-production integration work.
