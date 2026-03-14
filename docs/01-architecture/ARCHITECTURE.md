# 🏗️ GANGCLAWCITY Architecture

**Version:** 2.0.0 (Production-Aligned)  
**Last Updated:** March 14, 2026  
**Status:** ✅ Aligned with QWEN.md v2.0

---

## 🎯 System Overview

### **Production Architecture**

```
┌──────────────────────────────────────────────────────────┐
│                    GANGCLAWCITY                           │
│                                                           │
│  Frontend Layer (Vercel - Global CDN)                    │
│  ┌────────────────────────────────────────────────────┐  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────┐ │  │
│  │  │ Landing Page │  │   Dashboard  │  │   Demo   │ │  │
│  │  │  (Next.js)   │  │  (Vite+R3F)  │  │ (Phaser) │ │  │
│  │  └──────────────┘  └──────────────┘  └──────────┘ │  │
│  └────────────────────────────────────────────────────┘  │
│                           ↓ WSS                           │
│              wss://operator.gangniaga.my                  │
│                           ↓                               │
│  Backend Layer (Your VPS - 76.13.176.142)                │
│  ┌────────────────────────────────────────────────────┐  │
│  │  Nginx (SSL Termination - Ports 80, 443)           │  │
│  │         ↓                                           │  │
│  │  OpenClaw Gateway (Port 18789)                     │  │
│  │         ↓                                           │  │
│  │  NiagaBot Agents (Running 24/7)                    │  │
│  └────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────┘
```

### **Key Principles**

1. **Zero Downtime** - NiagaBot continues running
2. **WSS Connection** - Secure WebSocket to operator.gangniaga.my
3. **Token Auth** - Existing gateway token
4. **Vercel Frontend** - Auto SSL + CDN
5. **Existing Backend** - No VPS changes needed

---

## 🏛️ Architecture Layers

### **1. Frontend Layer (Vercel)**

**Deployment:**
- Landing Page: `https://gangclawcity-landing.vercel.app`
- Dashboard: `https://gangclawcity-dashboard.vercel.app`
- Demo: `https://gangclawcity-demo.vercel.app`

**Technology:**
- Next.js 16 (Landing)
- Vite + React 19 (Dashboard)
- Phaser 3 (Demo)
- Tailwind CSS v4
- Zustand (State)

**Connection:**
```javascript
// All apps connect to same gateway
const gateway = {
  url: 'wss://operator.gangniaga.my',
  token: '053adc82f8d2600b32c397c12f3517745b76a4deabf926b9',
  session: 'agent:main:main'
};
```

---

### **2. Gateway Layer (VPS)**

**Existing Setup (DON'T MODIFY):**

```yaml
OpenClaw Gateway:
  URL: wss://operator.gangniaga.my
  Internal Port: 18789
  External Port: 443 (via Nginx)
  Protocol: WebSocket Secure (WSS)
  
Authentication:
  Mode: token
  Token: 053adc82f8d2600b32c397c12f3517745b76a4deabf926b9
  Session Key: agent:main:main
  Rate Limit: 10 req/60s
  
CORS:
  Enabled: true
  Allowed:
    - *.vercel.app
    - operator.gangniaga.my
    - localhost:*
```

**Nginx Configuration (Existing):**
```nginx
server {
    listen 443 ssl;
    server_name operator.gangniaga.my;
    
    location /ws {
        proxy_pass http://localhost:18789;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
    }
}
```

---

### **3. Agent Layer (NiagaBot)**

**Running Agents:**
- Multiple AI profiles active
- Google Antigravity (Primary)
- OpenAI Codex (Secondary)
- Qwen Portal (Alternative)

**Status:**
- ✅ Running 24/7
- ✅ 6-9 days uptime
- ✅ Zero downtime required
- ✅ Managed by OpenClaw

---

## 📊 Data Flow

### **User Action → Gateway → Agent**

```
1. User clicks "Assign Task" (Dashboard)
   ↓
2. Dashboard sends WebSocket message
   {
     "jsonrpc": "2.0",
     "id": 1,
     "method": "tasks.create",
     "params": { ... }
   }
   ↓
3. WSS connection to operator.gangniaga.my
   ↓
4. OpenClaw Gateway authenticates token
   ↓
5. Routes to appropriate NiagaBot agent
   ↓
6. Agent executes task
   ↓
7. Result sent back via WebSocket
   ↓
8. Dashboard UI updates in real-time
```

---

### **Agent Event → Dashboard**

```
1. NiagaBot agent completes task
   ↓
2. OpenClaw broadcasts event
   {
     "type": "task.completed",
     "payload": { "taskId": "...", "status": "done" }
   }
   ↓
3. WSS pushes to all connected clients
   ↓
4. Dashboard receives event
   ↓
5. UI updates (agent moves, task marked complete)
```

---

## 🔐 Security Architecture

### **Authentication Flow**

```
Client → WSS → Nginx → OpenClaw → Token Validation → Access Granted
```

**Token Storage:**
```env
# ✅ CORRECT: Environment variable
VITE_GATEWAY_TOKEN=053adc82f8d2600b32c397c12f3517745b76a4deabf926b9

# ❌ WRONG: Hardcoded in code
const token = "053adc82f8d2600b32c397c12f3517745b76a4deabf926b9";
```

**Rate Limiting:**
- 10 requests per 60 seconds
- Automatic backoff on limit
- Exempt loopback (localhost)

---

## 🌐 Network Topology

### **Production Network**

```
Internet
    ↓
Vercel Edge Network (Global CDN)
    ↓ (HTTPS/WSS)
Your VPS (76.13.176.142)
    ↓
Nginx (SSL Termination)
    ↓
OpenClaw Gateway (Port 18789)
    ↓
NiagaBot Agents
```

### **Firewall Rules**

```
✅ Inbound:
- Port 443 (WSS via Nginx)
- Port 80 (HTTP → HTTPS redirect)

❌ Blocked:
- Direct access to 18789
- All other ports

✅ Outbound:
- AI model APIs (Google, OpenAI)
- Vercel (bidirectional)
```

---

## 📦 Component Architecture

### **Landing Page Component**

```
┌─────────────────────────────────────┐
│         Landing Page                │
│  ┌───────────────────────────────┐  │
│  │  Hero Section                 │  │
│  │  - Particle background        │  │
│  │  - Email capture form         │  │
│  └───────────────────────────────┘  │
│  ┌───────────────────────────────┐  │
│  │  Districts Showcase           │  │
│  │  - 8 district cards           │  │
│  └───────────────────────────────┘  │
│  ┌───────────────────────────────┐  │
│  │  Navigation                   │  │
│  │  - Links to Dashboard/Demo    │  │
│  └───────────────────────────────┘  │
└─────────────────────────────────────┘
```

### **Dashboard Component**

```
┌─────────────────────────────────────┐
│         Dashboard                   │
│  ┌───────────────────────────────┐  │
│  │  PlatformNav                  │  │
│  │  - Cross-app navigation       │  │
│  └───────────────────────────────┘  │
│  ┌───────────────────────────────┐  │
│  │  Agent Grid                   │  │
│  │  - Real-time status           │  │
│  │  - Animated avatars           │  │
│  └───────────────────────────────┘  │
│  ┌───────────────────────────────┐  │
│  │  Task Queue                   │  │
│  │  - Pending tasks              │  │
│  │  - Task flow visualization    │  │
│  └───────────────────────────────┘  │
│  ┌───────────────────────────────┐  │
│  │  Metrics Panel                │  │
│  │  - KPIs                       │  │
│  │  - Charts                     │  │
│  └───────────────────────────────┘  │
└─────────────────────────────────────┘
```

---

## 🔄 State Management

### **Zustand Store Structure**

```typescript
interface GatewayStore {
  // Connection state
  connected: boolean;
  connecting: boolean;
  error: string | null;
  
  // Gateway config
  config: {
    url: string; // 'wss://operator.gangniaga.my'
    token: string; // from env
    session: string; // 'agent:main:main'
  };
  
  // Agents
  agents: Agent[];
  
  // Tasks
  tasks: Task[];
  pendingApprovals: Task[];
  
  // Actions
  connect: () => void;
  disconnect: () => void;
  subscribeToEvents: () => void;
}
```

---

## 📈 Performance Architecture

### **Optimization Strategies**

**Frontend:**
- Code splitting per district
- Lazy loading 3D assets
- Image optimization (WebP)
- CDN caching (Vercel)

**WebSocket:**
- Message batching (100ms)
- Compression (permessage-deflate)
- Reconnection with exponential backoff
- Heartbeat every 30s

**Expected Metrics:**
```
✅ Page Load: < 2 seconds
✅ WebSocket Latency: < 100ms
✅ First Contentful Paint: < 1.5s
✅ Bundle Size: < 300KB (gzipped)
```

---

## 🛡️ Error Handling

### **Connection Errors**

```typescript
// Reconnection strategy
class GatewayClient {
  reconnectAttempts = 0;
  maxReconnects = 10;
  
  onDisconnect() {
    const delay = 1000 * Math.pow(2, this.reconnectAttempts);
    setTimeout(() => this.connect(), delay);
    this.reconnectAttempts++;
  }
}
```

### **Error Boundaries**

```typescript
// Dashboard error boundary
<ErrorBoundary fallback={<ErrorScreen />}>
  <Dashboard />
</ErrorBoundary>
```

---

## 📊 Monitoring Architecture

### **Client-Side Monitoring**

```javascript
// Performance metrics
const metrics = {
  connectionTime: Date.now() - wsOpenTime,
  messageLatency: lastMessageTime - sentTime,
  reconnectionCount: reconnectAttempts
};

// Send to analytics
analytics.track('gateway_metrics', metrics);
```

### **Server-Side Monitoring**

```bash
# VPS monitoring (existing)
ssh root@76.13.176.142

# Check gateway
pgrep -f "openclaw gateway"

# Check Nginx
systemctl status nginx

# Check Docker
docker ps
```

---

## 🎯 Deployment Architecture

### **Vercel Deployment Flow**

```
1. git push origin main
   ↓
2. Vercel detects changes
   ↓
3. Auto build (pnpm build)
   ↓
4. Deploy to CDN
   ↓
5. New deployment active
   ↓
6. Dashboard connects to gateway
```

### **Environment Variables**

```env
# Vercel Dashboard Settings
VITE_GATEWAY_URL=wss://operator.gangniaga.my
VITE_GATEWAY_TOKEN=053adc82f8d2600b32c397c12f3517745b76a4deabf926b9
VITE_SESSION_KEY=agent:main:main
VITE_MOCK=false
```

---

## 🚨 Critical Constraints

### **DO NOT CHANGE:**

```
❌ VPS configuration
❌ Gateway token
❌ Gateway URL
❌ CORS origins
❌ Nginx config
❌ OpenClaw settings
```

### **CAN MODIFY:**

```
✅ Frontend code (Vercel)
✅ Environment variables (Vercel dashboard)
✅ UI/UX design
✅ Brand colors
✅ Component structure
```

---

## 📚 Reference Diagrams

### **Full Stack Flow**

```
User Browser
    ↓
Vercel CDN (HTTPS)
    ↓
Dashboard React App
    ↓
WebSocket Connection (WSS)
    ↓
Nginx Reverse Proxy
    ↓
OpenClaw Gateway
    ↓
NiagaBot Agent
    ↓
AI Model API
```

---

**Architecture Status:** ✅ Production-Ready  
**Last Verified:** March 14, 2026  
**Aligned With:** QWEN.md v2.0  

---

**🏗️ GANGCLAWCITY Architecture** — Built for scale, deployed on Vercel, powered by existing OpenClaw Gateway ✅
