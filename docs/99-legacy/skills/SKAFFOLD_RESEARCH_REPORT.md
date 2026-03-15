# GANGCLAWCITY 5 Repos - Deep Research & Skaffold Development Plan

**Date:** March 13, 2026  
**Purpose:** Understand all 5 repos deeply + create Skaffold configuration for rapid development  
**Target:** Deploy all 5 repos to Kubernetes with hot-reload using Skaffold

---

## 📊 EXECUTIVE SUMMARY

### The 5 Repositories

| # | Repository | Type | Stack | Status | Package |
|---|------------|------|-------|--------|---------|
| **1** | `agent-town` | Next.js App | Next.js 16, React 19, Phaser 3 | ✅ Published | `@geezerrrr/agent-town` v0.4.1 |
| **2** | `openclaw-office` | Vite App | Vite 6, React 19, R3F, Zustand | ✅ Published | `@ww-ai-lab/openclaw-office` v2026.3.8-1 |
| **3** | `ai-town` | Convex App | Convex, PixiJS, React 18, Vite 4 | 📦 Private | `ai-town` v0.0.0 |
| **4** | `Star-Office-UI` | Python/Flask | Flask 3.0, Python 3.10+ | 🐍 Python | `star-office-ui` v0.1.0 |
| **5** | `pixel-agents` | VS Code Extension | TypeScript, VS Code API, React 19 | ✅ Published | `pixel-agents` v1.0.2 |
| **6** | `landing-page` | Static HTML | Vanilla HTML/CSS/JS | 📄 Static | N/A |

---

## 🎯 DEVELOPMENT CHALLENGE

### Current State
- **5 separate repositories** with different tech stacks
- **No unified development workflow**
- **Manual setup** for each project
- **No Kubernetes deployment** configuration
- **No hot-reload** across repos

### Goal
Create **Skaffold configuration** that enables:
1. ✅ **Multi-repo development** in single Kubernetes cluster
2. ✅ **Hot-reload** for all 5 projects simultaneously
3. ✅ **One-command deployment** (`skaffold dev`)
4. ✅ **Fast iteration** (file sync, no rebuild needed)
5. ✅ **Production-ready** Docker images

---

## 🔍 REPOSITORY ANALYSIS

### 1. AGENT-TOWN (`agent-town/`)

#### Overview
- **Purpose:** Pixel RPG AI office collaboration platform
- **Integration:** OpenClaw gateway via WebSocket proxy
- **NPM Package:** `@geezerrrr/agent-town` v0.4.1

#### Tech Stack
```json
{
  "runtime": "Node.js 22+",
  "framework": "Next.js 16.1.6",
  "react": "19.2.3",
  "game_engine": "Phaser 3.90.0",
  "styling": "Tailwind CSS v4",
  "websocket": "ws 8.19.0"
}
```

#### Build & Dev Commands
```bash
# Development
pnpm dev          # Runs server.ts (tsx)
pnpm dev:next     # Next.js dev server

# Production
pnpm build        # next build
pnpm start        # NODE_ENV=production tsx server.ts

# Package
prepublishOnly: next build && node scripts/prepare-package.mjs
```

#### Server Architecture
```typescript
// server.ts
- HTTP server serving Next.js standalone build
- WebSocket proxy at /api/gateway
- Forwards WSS traffic to OpenClaw Gateway (ws://localhost:18789)
- Default port: 3000
```

#### Docker Requirements
```dockerfile
FROM node:22-alpine
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm build
EXPOSE 3000
CMD ["node", ".next/standalone/server.js"]
```

#### Skaffold Strategy
- **Build:** Docker build with pnpm
- **Sync:** File sync for `.ts`, `.tsx`, `.css` files
- **Port-forward:** 3000:3000
- **Dev mode:** Hot reload with Next.js fast refresh

---

### 2. OPENCLAW-OFFICE (`openclaw-office/`)

#### Overview
- **Purpose:** Visual monitoring & management for OpenClaw multi-agent system
- **Integration:** Native OpenClaw Gateway WebSocket + RPC
- **NPM Package:** `@ww-ai-lab/openclaw-office` v2026.3.8-1

#### Tech Stack
```json
{
  "runtime": "Node.js 22+",
  "bundler": "Vite 6.3.0",
  "react": "19.1.0",
  "3d": "React Three Fiber 9.5.0",
  "state": "Zustand 5.0.0",
  "i18n": "react-i18next 16.5.4",
  "styling": "Tailwind CSS v4.1.0"
}
```

#### Build & Dev Commands
```bash
# Development
pnpm dev        # Vite dev server (port 5180)

# Production
pnpm build      # tsc -b && vite build
pnpm start      # node ./bin/openclaw-office.js

# Testing
pnpm test       # vitest run
pnpm test:watch # vitest --passWithNoTests
```

#### Vite Configuration Highlights
```typescript
// vite.config.ts
- Custom WebSocket proxy for OpenClaw Gateway
- Proxy path: /gateway-ws → ws://localhost:18789
- Connection config endpoint: /__openclaw/connection
- Default port: 5180
- React plugin + Tailwind CSS v4
```

#### Docker Requirements
```dockerfile
FROM node:22-alpine
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm build
EXPOSE 5180
CMD ["node", "./bin/openclaw-office.js"]
```

#### Skaffold Strategy
- **Build:** Docker build with pnpm
- **Sync:** File sync for `.ts`, `.tsx`, `.css` (Vite HMR)
- **Port-forward:** 5180:5180
- **Dev mode:** Vite fast refresh (instant updates)

---

### 3. AI-TOWN (`ai-town/`)

#### Overview
- **Purpose:** Virtual town where AI characters socialize (Convex-based)
- **Integration:** Convex backend + PixiJS frontend
- **Status:** Private repo, fork of a16z-infra/ai-town

#### Tech Stack
```json
{
  "runtime": "Node.js 18",
  "bundler": "Vite 4.4.9",
  "react": "18.2.0",
  "backend": "Convex 1.19.2",
  "rendering": "PixiJS 7.2.4",
  "styling": "Tailwind CSS v3.3.3"
}
```

#### Build & Dev Commands
```bash
# Development (parallel)
npm run dev         # npm-run-all --parallel dev:backend dev:frontend
npm run dev:backend # convex dev --tail-logs
npm run dev:frontend # vite

# Production
npm run build       # tsc && vite build

# Testing
npm test            # Jest with experimental VM modules
```

#### Convex Backend
```typescript
// convex/
- Real-time database with vector search
- Transactional mutations
- Scheduled functions (crons)
- Agent memory with embeddings (HNSWlib)
```

#### Docker Requirements
```dockerfile
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y curl python3 python3-pip
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
RUN nvm install 18
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 5173
CMD ["npx", "vite", "--host"]
```

#### Skaffold Strategy
- **Build:** Docker build (Ubuntu + Node 18)
- **Sync:** File sync for `.ts`, `.tsx` (Vite HMR)
- **Port-forward:** 5173:5173
- **Dev mode:** Vite + Convex dev mode
- **Special:** Requires Convex cloud or self-hosted Convex

---

### 4. STAR-OFFICE-UI (`Star-Office-UI/`)

#### Overview
- **Purpose:** Pixel-style AI office status dashboard
- **Integration:** Flask backend + OpenClaw HTTP API
- **Language:** Python 3.10+

#### Tech Stack
```json
{
  "runtime": "Python 3.10+",
  "framework": "Flask 3.0.0",
  "frontend": "Vanilla JS + HTML",
  "package_manager": "uv/pip"
}
```

#### Build & Dev Commands
```bash
# Install dependencies
python3 -m pip install -r backend/requirements.txt

# Development
cd backend && python3 app.py  # Flask server (port 19000)

# State management
python3 set_state.py writing "Working"  # Set agent state
```

#### Flask Backend
```python
# backend/app.py (2104 lines)
- HTTP REST API for state management
- File I/O for state.json, agents-state.json
- Memory files (memory/*.md)
- Default port: 19000
```

#### Docker Requirements
```dockerfile
FROM python:3.10-slim
WORKDIR /app
COPY backend/requirements.txt ./
RUN pip install -r requirements.txt
COPY . .
EXPOSE 19000
CMD ["python3", "backend/app.py"]
```

#### Skaffold Strategy
- **Build:** Docker build with Python 3.10
- **Sync:** File sync for `.py` files (Flask debug mode)
- **Port-forward:** 19000:19000
- **Dev mode:** Flask --reload flag

---

### 5. PIXEL-AGENTS (`pixel-agents/`)

#### Overview
- **Purpose:** VS Code extension for Claude Code agent visualization
- **Integration:** Observational (JSONL transcript parsing)
- **Type:** VS Code Extension (not web app)

#### Tech Stack
```json
{
  "runtime": "VS Code 1.107.0+",
  "extension": "TypeScript",
  "webview": "React 19, Vite 7.2.4",
  "bundler": "esbuild 0.27.2"
}
```

#### Build & Dev Commands
```bash
# Development
npm run watch         # npm-run-all -p watch:*
npm run watch:esbuild # node esbuild.js --watch
npm run watch:tsc     # tsc --noEmit --watch

# Production
npm run package       # esbuild.js --production
npm run build:webview # cd webview-ui && npm run build

# Testing
npm run lint
npm run format
```

#### Extension Architecture
```
pixel-agents/
├── src/                    # Extension logic
│   ├── extension.ts        # Entry point
│   ├── agentManager.ts
│   ├── fileWatcher.ts
│   └── transcriptParser.ts
└── webview-ui/             # React webview
    ├── src/
    └── public/
```

#### Skaffold Strategy
- **NOT APPLICABLE** - VS Code extension, not Kubernetes-deployable
- **Alternative:** Develop locally with `npm run watch`
- **Testing:** VS Code Extension Development Host (F5)

---

### 6. LANDING-PAGE (`landing-page/`)

#### Overview
- **Purpose:** GANGCLAWCITY marketing site
- **Type:** Static HTML/CSS/JS

#### Tech Stack
```json
{
  "type": "Static files",
  "styling": "Custom CSS",
  "animations": "Vanilla JS + Canvas"
}
```

#### Deployment
```bash
# Simple HTTP server
python3 -m http.server 8000

# Or use Nginx
nginx -g "daemon off;"
```

#### Docker Requirements
```dockerfile
FROM nginx:alpine
COPY . /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

#### Skaffold Strategy
- **Build:** Docker build with Nginx
- **Sync:** File sync for `.html`, `.css`, `.js`
- **Port-forward:** 80:80
- **Dev mode:** Nginx auto-reload

---

## 🛠️ SKAFFOLD CONFIGURATION PLAN

### What is Skaffold?

**Skaffold** is a command-line tool that facilitates continuous development for Kubernetes applications. You can iterate on your application source code locally then deploy to remote Kubernetes clusters.

**Key Features:**
- ✅ **Hot-reload** with file sync
- ✅ **Auto-build** on file changes
- ✅ **Auto-deploy** to Kubernetes
- ✅ **Port-forward** automatically
- ✅ **Multi-artifact** support (perfect for 5 repos!)

### Skaffold Configuration Structure

```
GANGCLAWCITY/
├── skaffold.yaml              # Main Skaffold config
├── agent-town/
│   ├── skaffold.yaml          # Agent-town specific config
│   └── Dockerfile
├── openclaw-office/
│   ├── skaffold.yaml          # Openclaw-office specific config
│   └── Dockerfile
├── ai-town/
│   ├── skaffold.yaml          # Ai-town specific config
│   └── Dockerfile
├── Star-Office-UI/
│   ├── skaffold.yaml          # Star-Office-UI specific config
│   └── Dockerfile
└── landing-page/
    ├── skaffold.yaml          # Landing-page specific config
    └── Dockerfile
```

### Main skaffold.yaml (Root)

```yaml
apiVersion: skaffold/v4beta12
kind: Config
metadata:
  name: gangclawcity

# Include all sub-project configs
requires:
  - path: agent-town
    configs: [agent-town]
  - path: openclaw-office
    configs: [openclaw-office]
  - path: ai-town
    configs: [ai-town]
  - path: Star-Office-UI
    configs: [star-office-ui]
  - path: landing-page
    configs: [landing-page]

# Profiles for different environments
profiles:
  - name: dev
    activation:
      - command: dev
    patches:
      - op: add
        path: /deploy/kubeContext
        value: docker-desktop  # or minikube, kind, etc.

  - name: prod
    activation:
      - command: run
    patches:
      - op: add
        path: /deploy/kubeContext
        value: production-cluster
```

### Agent-Town skaffold.yaml

```yaml
apiVersion: skaffold/v4beta12
kind: Config
metadata:
  name: agent-town

build:
  artifacts:
    - image: gangclawcity/agent-town
      context: .
      docker:
        dockerfile: Dockerfile
      sync:
        manual:
          - src: 'app/**/*.tsx'
            dest: /app/.next/standalone/app/
          - src: 'components/**/*.tsx'
            dest: /app/.next/standalone/components/
          - src: 'lib/**/*.ts'
            dest: /app/.next/standalone/lib/
          - src: '*.ts'
            dest: /app/.next/standalone/
          - src: '*.css'
            dest: /app/.next/standalone/

deploy:
  kubectl:
    manifests:
      - k8s/deployment.yaml
      - k8s/service.yaml

portForward:
  - resourceType: Deployment
    resourceName: agent-town
    port: 3000
    localPort: 3000
```

### OpenClaw-Office skaffold.yaml

```yaml
apiVersion: skaffold/v4beta12
kind: Config
metadata:
  name: openclaw-office

build:
  artifacts:
    - image: gangclawcity/openclaw-office
      context: .
      docker:
        dockerfile: Dockerfile
      sync:
        manual:
          - src: 'src/**/*.tsx'
            dest: /app/src/
          - src: 'src/**/*.ts'
            dest: /app/src/
          - src: '*.css'
            dest: /app/

deploy:
  kubectl:
    manifests:
      - k8s/deployment.yaml
      - k8s/service.yaml

portForward:
  - resourceType: Deployment
    resourceName: openclaw-office
    port: 5180
    localPort: 5180
```

### Ai-Town skaffold.yaml

```yaml
apiVersion: skaffold/v4beta12
kind: Config
metadata:
  name: ai-town

build:
  artifacts:
    - image: gangclawcity/ai-town
      context: .
      docker:
        dockerfile: Dockerfile
      sync:
        manual:
          - src: 'src/**/*.tsx'
            dest: /usr/src/app/src/
          - src: 'src/**/*.ts'
            dest: /usr/src/app/src/
          - src: 'convex/**/*.ts'
            dest: /usr/src/app/convex/

deploy:
  kubectl:
    manifests:
      - k8s/deployment.yaml
      - k8s/service.yaml

portForward:
  - resourceType: Deployment
    resourceName: ai-town
    port: 5173
    localPort: 5173
```

### Star-Office-UI skaffold.yaml

```yaml
apiVersion: skaffold/v4beta12
kind: Config
metadata:
  name: star-office-ui

build:
  artifacts:
    - image: gangclawcity/star-office-ui
      context: .
      docker:
        dockerfile: Dockerfile
      sync:
        manual:
          - src: 'backend/**/*.py'
            dest: /app/backend/
          - src: 'frontend/**/*.js'
            dest: /app/frontend/
          - src: '*.py'
            dest: /app/

deploy:
  kubectl:
    manifests:
      - k8s/deployment.yaml
      - k8s/service.yaml

portForward:
  - resourceType: Deployment
    resourceName: star-office-ui
    port: 19000
    localPort: 19000
```

### Landing-Page skaffold.yaml

```yaml
apiVersion: skaffold/v4beta12
kind: Config
metadata:
  name: landing-page

build:
  artifacts:
    - image: gangclawcity/landing-page
      context: .
      docker:
        dockerfile: Dockerfile
      sync:
        manual:
          - src: '*.html'
            dest: /usr/share/nginx/html/
          - src: '*.css'
            dest: /usr/share/nginx/html/
          - src: '*.js'
            dest: /usr/share/nginx/html/

deploy:
  kubectl:
    manifests:
      - k8s/deployment.yaml
      - k8s/service.yaml

portForward:
  - resourceType: Deployment
    resourceName: landing-page
    port: 80
    localPort: 8080
```

---

## 🚀 DEVELOPMENT WORKFLOW

### Local Development (No Kubernetes)

```bash
# Terminal 1: Agent Town
cd agent-town
pnpm dev

# Terminal 2: OpenClaw Office
cd openclaw-office
pnpm dev

# Terminal 3: AI Town
cd ai-town
npm run dev

# Terminal 4: Star Office UI
cd Star-Office-UI
python3 backend/app.py

# Terminal 5: Landing Page
cd landing-page
python3 -m http.server 8000
```

### Kubernetes Development (With Skaffold)

```bash
# Start all 5 projects with hot-reload
skaffold dev

# Output:
# Starting deploy...
# Deployment agent-town deployed
# Deployment openclaw-office deployed
# Deployment ai-town deployed
# Deployment star-office-ui deployed
# Deployment landing-page deployed
# Port forwarding agent-town:3000 -> localhost:3000
# Port forwarding openclaw-office:5180 -> localhost:5180
# Port forwarding ai-town:5173 -> localhost:5173
# Port forwarding star-office-ui:19000 -> localhost:19000
# Port forwarding landing-page:80 -> localhost:8080
# Watching for changes...
# File changed app/page.tsx - rebuilding agent-town
# File changed src/App.tsx - syncing openclaw-office
```

### Production Deployment

```bash
# Build and deploy to production cluster
skaffold run --kube-context production-cluster

# Or with profiles
skaffold run -p prod
```

---

## 📦 DOCKERFILE TEMPLATES

### Agent-Town Dockerfile

```dockerfile
FROM node:22-alpine AS builder

WORKDIR /app

# Install pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Copy dependency files
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy source
COPY . .

# Build Next.js
RUN pnpm build

# Production stage
FROM node:22-alpine AS runner

WORKDIR /app

# Copy built application
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

ENV NODE_ENV=production
EXPOSE 3000

CMD ["node", "server.js"]
```

### OpenClaw-Office Dockerfile

```dockerfile
FROM node:22-alpine AS builder

WORKDIR /app

# Install pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Copy dependency files
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy source
COPY . .

# Build
RUN pnpm build

# Production stage
FROM node:22-alpine

WORKDIR /app

# Copy built application
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/bin ./bin
COPY --from=builder /app/package.json ./

ENV NODE_ENV=production
EXPOSE 5180

CMD ["node", "./bin/openclaw-office.js"]
```

### AI-Town Dockerfile

```dockerfile
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    python3 \
    python3-pip \
    unzip \
    socat \
    build-essential \
    libssl-dev \
    iproute2 \
    && rm -rf /var/lib/apt/lists/*

# Install NVM and Node.js 18
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    nvm install 18 && \
    nvm use 18

ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 18.0.0
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

WORKDIR /usr/src/app

# Copy dependencies
COPY package*.json ./

# Install
RUN npm install

# Copy source
COPY . .

EXPOSE 5173

CMD ["npx", "vite", "--host"]
```

### Star-Office-UI Dockerfile

```dockerfile
FROM python:3.10-slim

WORKDIR /app

# Copy dependencies
COPY backend/requirements.txt ./

# Install
RUN pip install -r requirements.txt

# Copy source
COPY . .

EXPOSE 19000

ENV FLASK_ENV=development
ENV FLASK_DEBUG=1

CMD ["python3", "backend/app.py"]
```

### Landing-Page Dockerfile

```dockerfile
FROM nginx:alpine

# Copy static files
COPY . /usr/share/nginx/html

# Copy nginx config (optional, for custom routing)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

---

## 🎯 OPENCLAW SKILL.MD FOR SKAFFOLD DEPLOYMENT

Now I'll create a SKILL.md that teaches how to setup Skaffold for all 5 repos.

---

**Status:** Research Complete ✅  
**Next Step:** Create SKILL.md for Skaffold deployment
