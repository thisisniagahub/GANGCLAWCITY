# VPS Deployment Guide

> Deploy GANGCLAWCITY to production VPS

**Version:** 1.0.0  
**Last Updated:** March 13, 2026

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Prerequisites](#-prerequisites)
- [VPS Setup](#-vps-setup)
- [Docker Deployment](#-docker-deployment)
- [Manual Deployment](#-manual-deployment)
- [CI/CD Pipeline](#-cicd-pipeline)
- [Domain & SSL](#-domain--ssl)
- [Monitoring](#-monitoring)
- [Backup & Recovery](#-backup--recovery)
- [Troubleshooting](#-troubleshooting)

---

## 🎯 Overview

This guide covers deploying GANGCLAWCITY to a production VPS (Virtual Private Server).

### Deployment Options

| Option | Difficulty | Best For | Cost |
|--------|------------|----------|------|
| **Docker** | Easy | Most users | RM50-100/month |
| **Manual** | Medium | Advanced users | RM50-100/month |
| **Vercel + VPS** | Easy | Frontend-only | Free + RM50/month |

### Architecture

```
┌─────────────────────────────────────────┐
│           Internet                       │
└──────────────┬──────────────────────────┘
               │
               ▼
┌─────────────────────────────────────────┐
│         Cloudflare CDN                   │
│    (DDoS protection, caching)            │
└──────────────┬──────────────────────────┘
               │
               ▼
┌─────────────────────────────────────────┐
│              VPS                         │
│  ┌────────────────────────────────────┐ │
│  │     Nginx (Reverse Proxy)          │ │
│  └────────────┬───────────────────────┘ │
│               │                          │
│  ┌────────────▼───────────────────────┐ │
│  │     GANGCLAWCITY (Next.js)         │ │
│  │     Port: 3000                     │ │
│  └────────────┬───────────────────────┘ │
│               │                          │
│  ┌────────────▼───────────────────────┐ │
│  │     OpenClaw Gateway               │ │
│  │     Port: 18789                    │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │     PostgreSQL (Optional)          │ │
│  │     Port: 5432                     │ │
│  └────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

---

## 🔧 Prerequisites

### Required

- VPS with Ubuntu 22.04+ (2GB RAM, 1 CPU minimum)
- Domain name (e.g., gangclawcity.my)
- SSH access to VPS
- Basic Linux command line knowledge

### Recommended

- VPS with 4GB RAM, 2 CPU (for better performance)
- Cloudflare account (for CDN + DDoS protection)
- GitHub account (for CI/CD)
- Docker installed locally (for testing)

### VPS Providers

| Provider | Plan | RAM | CPU | Storage | Price/month |
|----------|------|-----|-----|---------|-------------|
| **DigitalOcean** | Basic | 2GB | 1 | 50GB SSD | $12 (RM56) |
| **Linode** | Nanode | 2GB | 1 | 50GB SSD | $12 (RM56) |
| **Vultr** | Cloud | 2GB | 1 | 55GB SSD | $12 (RM56) |
| **Hetzner** | CPX11 | 2GB | 2 | 40GB SSD | €5 (RM25) |

**Recommendation:** DigitalOcean or Hetzner for best value.

---

## 🖥️ VPS Setup

### Step 1: Create VPS

**DigitalOcean:**
1. Visit [digitalocean.com](https://digitalocean.com)
2. Click "Create Droplet"
3. Choose:
   - OS: Ubuntu 22.04 LTS
   - Plan: Basic ($12/month)
   - Region: Singapore (closest to Malaysia)
4. Add SSH key (recommended) or password
5. Create droplet

**Note IP address** (e.g., `123.45.67.89`)

### Step 2: SSH into VPS

```bash
# SSH into VPS
ssh root@123.45.67.89

# Or with SSH key
ssh -i ~/.ssh/id_rsa root@123.45.67.89
```

### Step 3: Update System

```bash
# Update packages
apt update && apt upgrade -y

# Install essential tools
apt install -y curl git wget ufw fail2ban

# Set timezone
timedatectl set-timezone Asia/Kuala_Lumpur
```

### Step 4: Create Deploy User

```bash
# Create deploy user
adduser deploy

# Add to sudo group
usermod -aG sudo deploy

# Switch to deploy user
su - deploy
```

### Step 5: Setup SSH Key for Deploy User

```bash
# On your local machine
ssh-copy-id deploy@123.45.67.89

# Test SSH
ssh deploy@123.45.67.89
```

### Step 6: Configure Firewall

```bash
# Enable UFW
ufw allow OpenSSH
ufw allow 80/tcp    # HTTP
ufw allow 443/tcp   # HTTPS
ufw enable

# Check status
ufw status
```

---

## 🐳 Docker Deployment

### Step 1: Install Docker

```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Add deploy user to docker group
usermod -aG docker deploy

# Verify installation
docker --version
```

### Step 2: Install Docker Compose

```bash
# Install Docker Compose
apt install docker-compose-plugin -y

# Verify
docker compose version
```

### Step 3: Clone Repository

```bash
# Clone GANGCLAWCITY
git clone https://github.com/your-org/gangclawcity.git
cd gangclawcity

# Create .env file
cp .env.example .env
nano .env
```

### Step 4: Configure Environment

```bash
# .env file
NODE_ENV=production
NEXT_PUBLIC_SITE_URL=https://gangclawcity.my
OPENCLAW_GATEWAY_URL=ws://localhost:18789
DATABASE_URL=postgresql://user:pass@localhost:5432/gangclawcity
NEXTAUTH_SECRET=your-secret-key-here
NEXTAUTH_URL=https://gangclawcity.my
```

**Generate secret:**
```bash
openssl rand -base64 32
```

### Step 5: Create Docker Compose File

```yaml
# docker-compose.yml
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - OPENCLAW_GATEWAY_URL=ws://gateway:18789
    depends_on:
      - gateway
    restart: unless-stopped

  gateway:
    image: openclaw/openclaw:latest
    ports:
      - "18789:18789"
    volumes:
      - ./openclaw-data:/root/.openclaw
    environment:
      - OPENCLAW_CONFIG_PATH=/root/.openclaw/openclaw.json
    restart: unless-stopped

  postgres:
    image: postgres:15-alpine
    volumes:
      - postgres-data:/var/lib/postgresql/data
    environment:
      - POSTGRES_DB=gangclawcity
      - POSTGRES_USER=gangclawcity
      - POSTGRES_PASSWORD=your-password-here
    restart: unless-stopped

volumes:
  postgres-data:
```

### Step 6: Build and Run

```bash
# Build Docker images
docker compose build

# Start services
docker compose up -d

# Check status
docker compose ps

# View logs
docker compose logs -f app
```

### Step 7: Setup Nginx Reverse Proxy

```bash
# Install Nginx
apt install nginx -y

# Create Nginx config
nano /etc/nginx/sites-available/gangclawcity
```

**Nginx Config:**
```nginx
server {
    listen 80;
    server_name gangclawcity.my www.gangclawcity.my;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

    # WebSocket support for OpenClaw
    location /gateway-ws {
        proxy_pass http://localhost:18789;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host $host;
    }
}
```

**Enable site:**
```bash
# Enable site
ln -s /etc/nginx/sites-available/gangclawcity /etc/nginx/sites-enabled/

# Test config
nginx -t

# Restart Nginx
systemctl restart nginx
```

---

## 📦 Manual Deployment

### Step 1: Install Node.js

```bash
# Install Node.js 22
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt install -y nodejs

# Verify
node --version  # v22.x
npm --version   # 10.x
```

### Step 2: Install pnpm

```bash
# Install pnpm
npm install -g pnpm

# Verify
pnpm --version
```

### Step 3: Clone and Build

```bash
# Clone repository
git clone https://github.com/your-org/gangclawcity.git
cd gangclawcity

# Install dependencies
pnpm install

# Build
pnpm build
```

### Step 4: Setup PM2

```bash
# Install PM2
npm install -g pm2

# Start application
pm2 start npm --name "gangclawcity" -- start

# Save PM2 config
pm2 save

# Setup PM2 startup
pm2 startup
```

### Step 5: Install OpenClaw

```bash
# Install OpenClaw
npm install -g openclaw@latest

# Start gateway
openclaw gateway --port 18789 &

# Or use PM2
pm2 start openclaw --name "openclaw-gateway" -- gateway --port 18789
```

---

## 🔄 CI/CD Pipeline

### GitHub Actions Setup

**Create `.github/workflows/deploy.yml`:**

```yaml
name: Deploy to VPS

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '22'

      - name: Install pnpm
        uses: pnpm/action-setup@v2
        with:
          version: 9

      - name: Install dependencies
        run: pnpm install

      - name: Build
        run: pnpm build

      - name: Deploy to VPS
        uses: easingthemes/ssh-deploy@v4
        with:
          SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
          REMOTE_HOST: ${{ secrets.VPS_HOST }}
          REMOTE_USER: deploy
          TARGET: /home/deploy/gangclawcity
          EXCLUDE: "/node_modules/,/.git/"
          SCRIPT_AFTER: |
            cd /home/deploy/gangclawcity
            pnpm install
            pnpm build
            pm2 restart gangclawcity
```

### Setup Secrets

```bash
# On GitHub repository settings
# Settings → Secrets and variables → Actions

# Add secrets:
SSH_PRIVATE_KEY: (your SSH private key)
VPS_HOST: 123.45.67.89
```

---

## 🌐 Domain & SSL

### Step 1: Configure DNS

**Cloudflare:**
1. Add site to Cloudflare
2. Add DNS records:
   - Type: A
   - Name: @
   - Content: 123.45.67.89
   - Proxy: Enabled (orange cloud)

3. Add DNS records:
   - Type: A
   - Name: www
   - Content: 123.45.67.89
   - Proxy: Enabled

### Step 2: Install SSL Certificate

```bash
# Install Certbot
apt install certbot python3-certbot-nginx -y

# Get SSL certificate
certbot --nginx -d gangclawcity.my -d www.gangclawcity.my

# Auto-renewal (already configured by certbot)
certbot renew --dry-run
```

### Step 3: Update Nginx for HTTPS

Nginx config will be automatically updated by Certbot.

**Verify:**
```bash
nginx -t
systemctl restart nginx
```

---

## 📊 Monitoring

### Setup Uptime Monitoring

**Uptime Kuma:**
```bash
# Install Uptime Kuma (separate VPS or Docker)
docker run -d --name uptime-kuma \
  -p 3001:3001 \
  -v uptime-kuma:/app/data \
  --restart always \
  louislam/uptime-kuma:1
```

**Configure monitors:**
- GANGCLAWCITY homepage (https://gangclawcity.my)
- API endpoint (https://gangclawcity.my/api/health)
- OpenClaw gateway (ws://123.45.67.89:18789)

### Setup Logs

```bash
# View application logs
pm2 logs gangclawcity

# View OpenClaw logs
pm2 logs openclaw-gateway

# View Nginx logs
tail -f /var/log/nginx/access.log
tail -f /var/log/nginx/error.log
```

### Setup Alerts

**Email alerts:**
- Configure PM2 to send emails on crash
- Use monitoring service (Uptime Kuma, Pingdom)

**Discord alerts:**
```bash
# Add Discord webhook to PM2
pm2 set pm2-discord webhook https://discord.com/api/webhooks/...
```

---

## 💾 Backup & Recovery

### Database Backup

```bash
# Backup script
nano /home/deploy/backup.sh
```

**backup.sh:**
```bash
#!/bin/bash
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_DIR="/home/deploy/backups"

# Create backup directory
mkdir -p $BACKUP_DIR

# Backup PostgreSQL
pg_dump -U gangclawcity gangclawcity > $BACKUP_DIR/db-$DATE.sql

# Backup OpenClaw data
tar -czf $BACKUP_DIR/openclaw-$DATE.tar.gz /home/deploy/.openclaw

# Delete old backups (keep 7 days)
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete

echo "Backup completed: $DATE"
```

**Setup cron job:**
```bash
# Edit crontab
crontab -e

# Add daily backup at 3 AM
0 3 * * * /home/deploy/backup.sh
```

### Recovery

```bash
# Restore PostgreSQL
psql -U gangclawcity gangclawcity < backup.sql

# Restore OpenClaw
tar -xzf openclaw-backup.tar.gz -C /home/deploy/
```

---

## 🐛 Troubleshooting

### Issue: Application Won't Start

```bash
# Check logs
pm2 logs gangclawcity

# Check if port is in use
netstat -tulpn | grep 3000

# Check environment variables
pm2 env gangclawcity
```

### Issue: OpenClaw Gateway Connection Failed

```bash
# Check if gateway is running
pm2 status

# Check gateway logs
pm2 logs openclaw-gateway

# Test connection
curl ws://localhost:18789
```

### Issue: SSL Certificate Expired

```bash
# Renew certificate
certbot renew

# Check expiry
certbot certificates
```

### Issue: High Memory Usage

```bash
# Check memory
free -h

# Check PM2 memory
pm2 monit

# Restart application
pm2 restart gangclawcity

# Increase VPS RAM if needed
```

---

## 📞 Support

Need help?

- 💬 Discord: [Join our server](https://discord.gg/gangclawcity)
- 📧 Email: support@gangclawcity.my
- 📖 Docs: [gangclawcity.my/docs](https://gangclawcity.my/docs)

---

**Deployment Status:** ✅ Production Ready  
**Last Tested:** March 13, 2026  
**Tested On:** DigitalOcean Ubuntu 22.04
