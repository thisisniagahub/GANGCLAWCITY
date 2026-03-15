# GANGCLAWCITY Quickstart

Use package-level commands. There is no working one-command root build for the whole workspace yet.

## Prerequisites

- Node.js 22+ for `openclaw-office/` and `agent-town/`
- `pnpm` for `openclaw-office/` and `agent-town/`
- `npm` for `ai-town/` and `pixel-agents/`
- Python 3.10+ for `Star-Office-UI/`

## Landing Page

The current landing page is the static site at repo root.

```bash
cd G:\PROJECT-4\GANGCLAWCITY
python -m http.server 8080
```

Open `http://127.0.0.1:8080`.

## Dashboard

```bash
pnpm --dir openclaw-office install
pnpm --dir openclaw-office dev
```

Useful checks:

```bash
pnpm --dir openclaw-office build
pnpm --dir openclaw-office test
pnpm --dir openclaw-office lint
```

## City Demo

```bash
pnpm --dir agent-town install
pnpm --dir agent-town dev
```

Useful checks:

```bash
pnpm --dir agent-town build
pnpm --dir agent-town lint
```

## Simulation Lab

```bash
npm --prefix ai-town install
npm --prefix ai-town run dev
```

## Workspace Tooling

```bash
npm --prefix pixel-agents install
npm --prefix pixel-agents run build
```

## Office Status Board

```bash
python -m pip install -r Star-Office-UI/backend/requirements.txt
cd Star-Office-UI/backend
python app.py
```

Open `http://127.0.0.1:19000`.

## Important Notes

- Root `npm run build` and `npm start` are placeholders.
- Committed Docker and Kubernetes paths need repair before they should be treated as trustworthy deployment paths.
- Do not place production gateway tokens in browser-visible env files during local testing.
