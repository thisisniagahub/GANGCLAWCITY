# 🔗 NIAGABOT ↔️ GANGCLAWCITY INTEGRATION PLAN

**Date:** March 14, 2026  
**Status:** NiagaBot Running, GANGCLAWCITY Ready to Deploy  
**VPS:** <VPS_IP>

---

## 📊 CURRENT SITUATION

### **✅ What's Running on VPS:**

1. **OpenClaw Gateway** ✅
   - Port: 18789
   - Config: `/root/.openclaw/openclaw.json`
   - Status: Active with multiple profiles
   - Connected to: Google Antigravity, OpenAI Codex

2. **NiagaBot Agents** ✅
   - Running via PM2 (currently idle)
   - Using OpenClaw workspace
   - Multiple Google profiles configured

3. **Other Services** ✅
   - LiveKit server (voice calls)
   - Qdrant (vector DB)
   - Redis (caching)
   - QuranPulse (separate project)

### **❌ What's Not Connected:**

- GANGCLAWCITY dashboard not deployed
- No visual interface for NiagaBot
- No task monitoring/visualization
- OpenClaw running but no UI to manage it

---

## 🎯 INTEGRATION APPROACH

### **Option 1: Connect GANGCLAWCITY to Existing OpenClaw (RECOMMENDED)**

**How it works:**
```
NiagaBot → OpenClaw Gateway (ws://localhost:18789) ← GANGCLAWCITY Dashboard
```

**Benefits:**
- ✅ No changes to NiagaBot needed
- ✅ OpenClaw already configured
- ✅ GANGCLAWCITY just adds UI layer
- ✅ Zero downtime for NiagaBot

**Implementation:**
1. Deploy GANGCLAWCITY dashboard on VPS
2. Configure dashboard to connect to `ws://localhost:18789`
3. Dashboard will show NiagaBot agents in real-time
4. Can monitor, manage, and control NiagaBot visually

---

### **Option 2: Deploy GANGCLAWCITY as Separate OpenClaw Instance**

**How it works:**
```
NiagaBot → OpenClaw Gateway 1 (port 18789)
GANGCLAWCITY → OpenClaw Gateway 2 (port 18790)
```

**Benefits:**
- ✅ Complete separation
- ✅ No risk to NiagaBot
- ✅ Independent testing

**Drawbacks:**
- ❌ Double resource usage
- ❌ Two separate systems
- ❌ More complex management

---

### **Option 3: Migrate NiagaBot to GANGCLAWCITY**

**How it works:**
```
NiagaBot + GANGCLAWCITY → Single OpenClaw Gateway
```

**Benefits:**
- ✅ Unified system
- ✅ Single dashboard

**Drawbacks:**
- ❌ Risk of breaking NiagaBot
- ❌ Requires downtime
- ❌ Complex migration

---

## 🚀 RECOMMENDED: OPTION 1 (Connect to Existing)

### **Architecture:**

```
┌─────────────────────────────────────────────────────┐
│                  VPS: <VPS_IP>                  │
│                                                      │
│  ┌────────────────────────────────────────────────┐ │
│  │           OpenClaw Gateway (Port 18789)        │ │
│  │           Already Running ✅                    │ │
│  │                                                │ │
│  │  ┌──────────────┐  ┌──────────────┐           │ │
│  │  │  NiagaBot    │  │  Other Bots  │           │ │
│  │  │   Agents     │  │   & Agents   │           │ │
│  │  └──────────────┘  └──────────────┘           │ │
│  └────────────────────────────────────────────────┘ │
│                          ▲                          │
│                          │ WebSocket                │
│                          │                          │
│  ┌───────────────────────┴────────────────────────┐ │
│  │        GANGCLAWCITY Dashboard (Port 5180)      │ │
│  │        (Deploy This)                           │ │
│  │                                                │ │
│  │  - Visual agent monitoring                     │ │
│  │  - Task management UI                          │ │
│  │  - District organization                       │ │
│  │  - Real-time status                            │ │
│  └────────────────────────────────────────────────┘ │
│                                                      │
│  ┌────────────────────────────────────────────────┐ │
│  │        Nginx Reverse Proxy (Port 80/443)       │ │
│  │                                                │ │
│  │  gangclawcity.my → Dashboard                   │ │
│  └────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────┘
                    ▲
                    │ Internet
                    │
         Users Access Dashboard
```

---

## 📋 STEP-BY-STEP DEPLOYMENT

### **Phase 1: Prepare VPS (30 mins)**

#### **Step 1.1: Clean Disk Space**
```bash
ssh root@<VPS_IP>

# Remove old Docker images
docker image prune -a --force

# Remove old OpenClaw backups
rm /root/.openclaw/openclaw.json.bak.*

# Clean apt cache
apt clean && apt autoremove -y

# Check disk space
df -h
# Target: < 60% used
```

#### **Step 1.2: Install Missing Tools**
```bash
# Install kubectl
curl -LO "https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/
kubectl version --client

# Install Skaffold
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
chmod +x skaffold
mv skaffold /usr/local/bin/
skaffold version

# Install Docker Compose plugin
docker compose version
# If not installed:
apt install docker-compose-plugin -y
```

---

### **Phase 2: Deploy GANGCLAWCITY (1 hour)**

#### **Step 2.1: Clone Repository**
```bash
cd /root
git clone https://github.com/your-org/gangclawcity.git
cd gangclawcity
```

#### **Step 2.2: Create Environment File**
```bash
cat > .env << EOF
NODE_ENV=production
NEXT_PUBLIC_SITE_URL=https://gangclawcity.my
OPENCLAW_GATEWAY_URL=ws://localhost:18789
NEXTAUTH_SECRET=$(openssl rand -base64 32)
NEXTAUTH_URL=https://gangclawcity.my
EOF
```

#### **Step 2.3: Deploy with Docker Compose**
```bash
# Create simple docker-compose.yml for GANGCLAWCITY only
cat > docker-compose.gangclawcity.yml << EOF
version: '3.8'

services:
  landing-page:
    build: ./landing-page
    ports:
      - "8080:80"
    restart: unless-stopped

  openclaw-office:
    build: ./openclaw-office
    ports:
      - "5180:80"
    environment:
      - VITE_GATEWAY_URL=ws://host.docker.internal:18789
      - VITE_MOCK=false
    restart: unless-stopped
    extra_hosts:
      - "host.docker.internal:host-gateway"

  agent-town:
    build: ./agent-town
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    restart: unless-stopped

EOF

# Deploy
docker compose -f docker-compose.gangclawcity.yml up --build -d
```

#### **Step 2.4: Check Deployment**
```bash
# Check containers
docker compose -f docker-compose.gangclawcity.yml ps

# View logs
docker compose -f docker-compose.gangclawcity.yml logs -f

# Test endpoints
curl http://localhost:8080
curl http://localhost:5180
curl http://localhost:3000
```

---

### **Phase 3: Connect to NiagaBot (15 mins)**

#### **Step 3.1: Configure Dashboard**
```bash
# Update openclaw-office .env
cd /root/gangclawcity/openclaw-office
cat > .env.local << EOF
VITE_GATEWAY_URL=ws://<VPS_IP>:18789
VITE_GATEWAY_TOKEN=your-token-if-needed
VITE_MOCK=false
EOF
```

#### **Step 3.2: Verify Connection**
```bash
# Test WebSocket connection from dashboard
docker exec -it <openclaw-office-container-id> sh
wget -qO- http://localhost:18789/health
# Should return OpenClaw status
```

#### **Step 3.3: Check if NiagaBot Agents Appear**
1. Open browser: `http://<VPS_IP>:5180`
2. Navigate to Dashboard
3. Check if NiagaBot agents are visible
4. Verify real-time updates

---

### **Phase 4: Setup Nginx Reverse Proxy (30 mins)**

#### **Step 4.1: Install Nginx**
```bash
apt install nginx -y
```

#### **Step 4.2: Create Nginx Config**
```bash
cat > /etc/nginx/sites-available/gangclawcity << EOF
server {
    listen 80;
    server_name gangclawcity.my www.gangclawcity.my;

    # Landing Page
    location / {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }

    # Dashboard
    location /dashboard {
        proxy_pass http://localhost:5180;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host \$host;
    }

    # Agent Town (Demo)
    location /demo {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
    }

    # WebSocket support for OpenClaw
    location /gateway-ws {
        proxy_pass http://localhost:18789;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host \$host;
    }
}
EOF

# Enable site
ln -s /etc/nginx/sites-available/gangclawcity /etc/nginx/sites-enabled/

# Test config
nginx -t

# Reload Nginx
systemctl reload nginx
```

---

### **Phase 5: Setup SSL (15 mins)**

#### **Step 5.1: Install Certbot**
```bash
apt install certbot python3-certbot-nginx -y
```

#### **Step 5.2: Get SSL Certificate**
```bash
certbot --nginx -d gangclawcity.my -d www.gangclawcity.my

# Auto-renewal setup (already configured)
certbot renew --dry-run
```

---

## 🔗 CONNECTION DETAILS

### **OpenClaw Gateway Config:**

**Current Setup:**
- Port: 18789
- Config: `/root/.openclaw/openclaw.json`
- Status: Running
- Connected: NiagaBot agents

**GANGCLAWCITY Connection:**
```javascript
// GANGCLAWCITY will connect as a client
const ws = new WebSocket('ws://localhost:18789');

// Subscribe to agent events
ws.send(JSON.stringify({
  jsonrpc: '2.0',
  id: 1,
  method: 'agents.list'
}));

// Receive NiagaBot agent updates
ws.on('message', (data) => {
  const event = JSON.parse(data);
  if (event.type === 'agent.state.changed') {
    // Update GANGCLAWCITY UI with NiagaBot agent status
  }
});
```

---

## 📊 EXPECTED RESULTS

### **After Integration:**

1. **Visual Dashboard** ✅
   - See all NiagaBot agents in GANGCLAWCITY
   - Real-time status updates
   - Task monitoring

2. **Agent Management** ✅
   - Assign tasks to NiagaBot agents
   - Monitor agent performance
   - View agent history

3. **Task Visualization** ✅
   - See tasks as "traffic" between districts
   - Track task completion
   - Identify bottlenecks

4. **No Downtime** ✅
   - NiagaBot continues running
   - No interruption to existing bots
   - Zero risk migration

---

## 🎯 ALTERNATIVE: Quick Test First

### **Test Locally Before VPS:**

```bash
# On your local machine (Windows)
cd G:\PROJECT-4\GANGCLAWCITY

# Update openclaw-office/.env.local
cat > openclaw-office/.env.local << EOF
VITE_GATEWAY_URL=ws://<VPS_IP>:18789
VITE_MOCK=false
EOF

# Run dashboard locally
cd openclaw-office
pnpm install
pnpm dev

# Open: http://localhost:5180
# Should connect to your VPS OpenClaw and show NiagaBot agents!
```

**This is the FASTEST way to test!** ✅

---

## ⚠️ IMPORTANT NOTES

### **Security:**

1. **Firewall Rules:**
```bash
# Allow only necessary ports
ufw allow 80/tcp    # HTTP
ufw allow 443/tcp   # HTTPS
ufw allow 22/tcp    # SSH
# Block 18789 from external access (internal only)
ufw deny 18789/tcp
```

2. **Authentication:**
- Enable OpenClaw auth token
- Use HTTPS for dashboard
- Setup NextAuth.js for GANGCLAWCITY

### **Performance:**

- Monitor RAM usage (currently 6.2GB free)
- Watch CPU load (currently 3.67 average)
- Consider upgrading to 4 CPU cores if needed

---

## 🚀 RECOMMENDED NEXT STEPS

### **Today:**

1. **Quick Test (30 mins)**
   ```bash
   # Local testing
   cd G:\PROJECT-4\GANGCLAWCITY\openclaw-office
   echo "VITE_GATEWAY_URL=ws://<VPS_IP>:18789" > .env.local
   echo "VITE_MOCK=false" >> .env.local
   pnpm dev
   ```

2. **If Test Successful:**
   - Deploy to VPS
   - Setup Nginx
   - Configure SSL

### **Tomorrow:**

1. **Full Deployment**
2. **Domain Configuration**
3. **SSL Setup**
4. **User Testing**

---

**🏙️ GANGCLAWCITY ↔️ NIAGABOT** — Integration Ready!  
**Recommended Approach:** Test locally first, then deploy to VPS  
**Risk Level:** ✅ Zero risk to NiagaBot  
**ETA:** 30 mins for test, 2 hours for full deployment

---

**Nak start dengan quick test sekarang?** 🚀
