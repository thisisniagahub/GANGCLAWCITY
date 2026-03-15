# Repository Guidelines

## Project Structure & Module Organization

This repository is a multi-project workspace, not a single app. The root contains the public landing page in `index.html`, `style.css`, and `script.js`. Main application folders are `agent-town/` (Next.js pixel workspace), `ai-town/` (Vite + Convex), `openclaw-office/` (React/Vite dashboard), `mock-gateway/` (Express test gateway), `pixel-agents/` (VS Code extension), and `Star-Office-UI/` (Python-backed UI tooling). Shared documentation and operations live in `docs/`, `assets/`, `scripts/`, `infrastructure/`, `security/`, and `skills/`.

## Build, Test, and Development Commands

Run commands from the package you are changing. The root `npm run build` and `npm start` are placeholder scripts only.

- `pnpm --dir openclaw-office dev` starts the main OpenClaw dashboard locally.
- `pnpm --dir openclaw-office test` runs the Vitest suite for dashboard work.
- `pnpm --dir agent-town dev` starts the Next.js pixel office app.
- `npm --prefix ai-town test` runs the Jest tests for Convex and frontend logic.
- `npm --prefix mock-gateway run dev` starts the local gateway stub with Nodemon.

Use the package manager that matches the lockfile: `pnpm` where `pnpm-lock.yaml` exists, otherwise `npm`.

## Coding Style & Naming Conventions

TypeScript projects in this repo use 2-space indentation, single quotes, trailing commas, and roughly 100-character line width. Follow the local formatter and linter for the package you touch: ESLint/Prettier in `agent-town/`, `ai-town/`, and `pixel-agents/`; Oxlint/Oxfmt in `openclaw-office/`. Use PascalCase for React components, `useCamelCase` for hooks, and keep test files named `*.test.ts` or `*.test.tsx`.

## Testing Guidelines

Add or update tests in the package you modify. `openclaw-office/tests/setup.ts` configures Vitest; `ai-town` keeps Jest tests close to source files such as `convex/util/*.test.ts`. Run the nearest available test command before opening a PR. For UI-heavy changes, include screenshots or a short recording.

## Commit & Pull Request Guidelines

Git history uses Conventional Commit style, for example `feat: add Vercel config`, `fix: move landing page to root`, and `feat(security): token rotation`. Keep commits scoped and readable. PRs should cover one concern, explain what changed and how to verify it, link the issue when applicable, and include visual proof for frontend changes.

## Security & Configuration Tips

Start from `.env.example` files, never commit real secrets, and review related material in `security/` before changing credentials, tokens, or deployment configuration.
