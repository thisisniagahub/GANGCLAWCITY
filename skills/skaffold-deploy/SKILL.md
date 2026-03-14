---
name: skaffold-deploy
description: Deploy all 5 GANGCLAWCITY repos to Kubernetes with Skaffold hot-reload
version: 1.0.0
author: GANGCLAWCITY Team
metadata: {"openclaw":{"emoji":"🛠️","requires":{"bins":["skaffold","kubectl","docker"],"os":["linux","darwin","win32"],"env":["KUBECONFIG"]}}}
user-invocable: true
---

# Skaffold Deployment - GANGCLAWCITY Multi-Repo

## What it does

Deploy all 5 GANGCLAWCITY repositories to Kubernetes with **Skaffold hot-reload** for rapid development:
- ✅ agent-town (Next.js + Phaser 3)
- ✅ openclaw-office (Vite + R3F + Zustand)
- ✅ ai-town (Convex + PixiJS)
- ✅ Star-Office-UI (Flask + Python)
- ✅ landing-page (Static HTML/CSS/JS)

## Inputs needed

- **KUBECONFIG**: Path to Kubernetes config (default: ~/.kube/config)
- **NAMESPACE**: Kubernetes namespace (default: gangclawcity)
- **REGISTRY**: Docker registry for images (default: gangclawcity)

## Workflow

### Step 1: Prerequisites Check

Verify required tools are installed:

```bash
# Check kubectl
kubectl version --client

# Check Skaffold
skaffold version

# Check Docker
docker --version

# Check Node.js (for local dev)
node --version  # Should be 22+

# Check pnpm
pnpm --version
```

If any missing, install:

```bash
# Install kubectl
# macOS
brew install kubectl
# Windows
choco install kubernetes-cli
# Linux
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Install Skaffold
# macOS
brew install skaffold
# Windows
choco install skaffold
# Linux
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
chmod +x skaffold
sudo mv skaffold /usr/local/bin

# Install Docker Desktop
# Download from https://www.docker.com/products/docker-desktop
```

### Step 2: Setup Kubernetes Cluster

**Option A: Docker Desktop (Recommended for local dev)**

```bash
# Enable Kubernetes in Docker Desktop
# Docker Desktop → Settings → Kubernetes → Enable Kubernetes
```

**Option B: Kind (Kubernetes IN Docker)**

```bash
# Install kind
# macOS
brew install kind
# Linux
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Create cluster
kind create cluster --name gangclawcity
```

**Option C: Minikube**

```bash
# Install minikube
# macOS
brew install minikube
# Linux
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start cluster
minikube start --memory=4096 --cpus=2
```

### Step 3: Create Skaffold Configuration

Create root `skaffold.yaml` in GANGCLAWCITY directory:

```yaml
apiVersion: skaffold/v4beta12
kind: Config
metadata:
  name: gangclawcity

# Include all sub-projects
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

# Port forwarding for all services
portForward:
  - resourceType: Deployment
    resourceName: agent-town
    port: 3000
    localPort: 3000
  - resourceType: Deployment
    resourceName: openclaw-office
    port: 5180
    localPort: 5180
  - resourceType: Deployment
    resourceName: ai-town
    port: 5173
    localPort: 5173
  - resourceType: Deployment
    resourceName: star-office-ui
    port: 19000
    localPort: 19000
  - resourceType: Deployment
    resourceName: landing-page
    port: 80
    localPort: 8080

profiles:
  - name: dev
    activation:
      - command: dev
    deploy:
      kubectl: {}
  - name: prod
    activation:
      - command: run
    deploy:
      kubectl: {}
```

### Step 4: Create Dockerfiles

#### agent-town/Dockerfile

```dockerfile
FROM node:22-alpine AS builder

WORKDIR /app

# Install pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY . .
RUN pnpm build

FROM node:22-alpine AS runner

WORKDIR /app

COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

ENV NODE_ENV=production
EXPOSE 3000

CMD ["node", "server.js"]
```

#### openclaw-office/Dockerfile

```dockerfile
FROM node:22-alpine AS builder

WORKDIR /app

RUN corepack enable && corepack prepare pnpm@latest --activate

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY . .
RUN pnpm build

FROM node:22-alpine

WORKDIR /app

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/bin ./bin
COPY --from=builder /app/package.json ./

ENV NODE_ENV=production
EXPOSE 5180

CMD ["node", "./bin/openclaw-office.js"]
```

#### ai-town/Dockerfile

```dockerfile
FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y \
    curl python3 python3-pip \
    build-essential iproute2 \
    && rm -rf /var/lib/apt/lists/*

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    nvm install 18

ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 18.0.0
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 5173

CMD ["npx", "vite", "--host"]
```

#### Star-Office-UI/Dockerfile

```dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY backend/requirements.txt ./
RUN pip install -r requirements.txt

COPY . .

EXPOSE 19000

ENV FLASK_ENV=development
ENV FLASK_DEBUG=1

CMD ["python3", "backend/app.py"]
```

#### landing-page/Dockerfile

```dockerfile
FROM nginx:alpine

COPY . /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

### Step 5: Create Kubernetes Manifests

Create `k8s/` directory in each project:

#### agent-town/k8s/deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: agent-town
  labels:
    app: agent-town
spec:
  replicas: 1
  selector:
    matchLabels:
      app: agent-town
  template:
    metadata:
      labels:
        app: agent-town
    spec:
      containers:
      - name: agent-town
        image: gangclawcity/agent-town
        ports:
        - containerPort: 3000
        env:
        - name: NODE_ENV
          value: production
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
```

#### agent-town/k8s/service.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: agent-town
spec:
  selector:
    app: agent-town
  ports:
  - port: 3000
    targetPort: 3000
  type: ClusterIP
```

(Repeat similar structure for other 4 projects with their respective ports)

### Step 6: Create Skaffold Configs for Each Project

#### agent-town/skaffold.yaml

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
```

#### openclaw-office/skaffold.yaml

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
```

(Similar for ai-town, Star-Office-UI, landing-page)

### Step 7: Run Skaffold Dev

```bash
# Start all 5 projects with hot-reload
skaffold dev

# Expected output:
# Starting deploy...
# Deployment agent-town deployed
# Deployment openclaw-office deployed
# Deployment ai-town deployed
# Deployment star-office-ui deployed
# Deployment landing-page deployed
#
# Port forwarding:
# agent-town:3000 -> localhost:3000
# openclaw-office:5180 -> localhost:5180
# ai-town:5173 -> localhost:5173
# star-office-ui:19000 -> localhost:19000
# landing-page:80 -> localhost:8080
#
# Watching for changes...
```

### Step 8: Access Applications

Open browser:
- **Landing Page:** http://localhost:8080
- **Agent Town:** http://localhost:3000
- **OpenClaw Office:** http://localhost:5180
- **AI Town:** http://localhost:5173
- **Star Office UI:** http://localhost:19000

## Guardrails

- ✅ Verify Kubernetes cluster is running before deploying
- ✅ Ensure Docker has enough memory (4GB+ recommended)
- ✅ Check disk space (5GB+ for images)
- ✅ Stop local dev servers before running skaffold dev
- ❌ Never deploy to production cluster without testing locally first
- ❌ Don't commit skaffold logs or temporary files

## Failure handling

### Issue: Skaffold won't start

```bash
# Check cluster status
kubectl cluster-info

# Check Docker is running
docker ps

# Reset Skaffold
skaffold config delete-all
```

### Issue: Hot-reload not working

```bash
# Check file sync configuration
skaffold dev --verbosity debug

# Verify sync patterns match file paths
# Edit skaffold.yaml sync.manual[] patterns
```

### Issue: Port already in use

```bash
# Find process using port
# macOS/Linux
lsof -i :3000
# Windows
netstat -ano | findstr :3000

# Kill process or change localPort in skaffold.yaml
```

### Issue: Build fails

```bash
# Clean build
skaffold build --cleanup

# Check Dockerfile syntax
docker build -t test .

# Verify package manager (pnpm vs npm)
```

## Examples

### Quick local development

```bash
# Start all 5 projects
skaffold dev

# Stop with Ctrl+C
```

### Deploy to specific namespace

```bash
skaffold dev --namespace gangclawcity-dev
```

### Deploy single project only

```bash
cd agent-town
skaffold dev
```

### Production deployment

```bash
# Build and deploy to production cluster
skaffold run --kube-context production-cluster -p prod
```

### View logs

```bash
# All logs
skaffold dev --tail

# Specific deployment
kubectl logs -f deployment/agent-town
```

### Cleanup

```bash
# Delete all deployments
skaffold delete

# Or manually
kubectl delete -f k8s/
```
