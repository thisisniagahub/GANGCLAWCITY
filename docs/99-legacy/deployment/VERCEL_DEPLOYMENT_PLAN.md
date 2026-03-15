# 🚀 GANGCLAWCITY - VERCEL DEPLOYMENT PLAN

**Date:** March 14, 2026  
**Strategy:** Frontend on Vercel + Backend on VPS  
**Status:** ⚡ FASTEST DEPLOYMENT!

---

## 🎯 ARCHITECTURE

### **Hybrid Approach:**

```
┌─────────────────────────────────────────────────────┐
│                    INTERNET                          │
└──────────────────┬──────────────────────────────────┘
                   │
         ┌─────────┴─────────┐
         │                   │
         ▼                   ▼
┌─────────────────┐  ┌──────────────────┐
│     VERCEL      │  │   YOUR VPS       │
│  (Frontend)     │  │   (Backend)      │
│                 │  │                  │
│ - Landing Page  │  │ - OpenClaw       │
│ - Dashboard     │  │   Gateway        │
│ - Agent Town    │  │   (Port 18789)   │
│ - Static Assets │  │                  │
│                 │  │ - NiagaBot       │
│                 │  │   Agents         │
└─────────────────┘  └──────────────────┘
         │                   │
         └─────────┬─────────┘
                   │
         WebSocket Connection
         ws://76.13.176.142:18789
```

---

## ✅ WHY VERCEL IS BETTER

### **Advantages:**

| Feature | Vercel | Self-Hosted |
|---------|--------|-------------|
| **Setup Time** | 5 mins | 2 hours |
| **SSL/HTTPS** | Auto ✅ | Manual setup |
| **CDN** | Global ✅ | Extra cost |
| **Scaling** | Auto ✅ | Manual |
| **Maintenance** | Zero ✅ | You manage |
| **Cost** | Free tier | RM50/month |
| **Domain** | Free .vercel.app | Pay for domain |

### **Perfect For:**

- ✅ Next.js apps (Agent Town, Dashboard)
- ✅ Static sites (Landing Page)
- ✅ React/Vite apps (OpenClaw Office)
- ✅ High traffic (Vercel auto-scales)

---

## 📋 DEPLOYMENT STEPS

### **Phase 1: Prepare Apps (30 mins)**

#### **Step 1.1: Update Landing Page**

**File:** `landing-page/vercel.json`
```json
{
  "version": 2,
  "name": "gangclawcity-landing",
  "builds": [
    { "src": "**/*", "use": "@vercel/static" }
  ],
  "routes": [
    { "src": "/(.*)", "dest": "/$1" }
  ]
}
```

---

#### **Step 1.2: Update OpenClaw Office**

**File:** `openclaw-office/vercel.json`
```json
{
  "version": 2,
  "name": "gangclawcity-dashboard",
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/static-build",
      "config": { "distDir": "dist" }
    }
  ],
  "env": {
    "VITE_GATEWAY_URL": "wss://76.13.176.142:18789",
    "VITE_MOCK": "false"
  },
  "routes": [
    { "src": "/assets/(.*)", "dest": "/assets/$1" },
    { "src": "/(.*)", "dest": "/index.html" }
  ]
}
```

**⚠️ IMPORTANT:** Need to enable WebSocket over WSS!

---

#### **Step 1.3: Update Agent Town**

**File:** `agent-town/vercel.json`
```json
{
  "version": 2,
  "name": "gangclawcity-demo",
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/next"
    }
  ],
  "env": {
    "NODE_ENV": "production"
  }
}
```

---

### **Phase 2: Deploy to Vercel (15 mins)**

#### **Option A: Vercel CLI (Recommended)**

```bash
# Install Vercel CLI
npm install -g vercel

# Login to Vercel
vercel login

# Deploy Landing Page
cd G:\PROJECT-4\GANGCLAWCITY\landing-page
vercel --prod

# Deploy Dashboard
cd G:\PROJECT-4\GANGCLAWCITY\openclaw-office
vercel --prod

# Deploy Agent Town
cd G:\PROJECT-4\GANGCLAWCITY\agent-town
vercel --prod
```

**Each deployment will give you:**
- `https://gangclawcity-landing.vercel.app`
- `https://gangclawcity-dashboard.vercel.app`
- `https://gangclawcity-demo.vercel.app`

---

#### **Option B: Vercel Dashboard (GUI)**

1. Go to https://vercel.com/new
2. Import GitHub repository
3. Select project folder
4. Configure build settings
5. Deploy!

---

### **Phase 3: Configure VPS (10 mins)**

#### **Step 3.1: Enable CORS on OpenClaw**

**File:** `/root/.openclaw/openclaw.json`

Add CORS config:
```json
{
  "gateway": {
    "cors": {
      "enabled": true,
      "origins": [
        "https://gangclawcity-landing.vercel.app",
        "https://gangclawcity-dashboard.vercel.app",
        "https://gangclawcity-demo.vercel.app",
        "https://gangclawcity.my"
      ]
    }
  }
}
```

**Restart OpenClaw:**
```bash
pm2 restart all
# Or
openclaw gateway restart
```

---

#### **Step 3.2: Setup WSS Proxy (Optional)**

If Vercel can't connect to ws:// directly:

**Install Nginx on VPS:**
```bash
apt install nginx -y
```

**Create Nginx config:**
```nginx
server {
    listen 443 ssl;
    server_name api.gangclawcity.my;

    # SSL certificates (auto from Certbot)
    ssl_certificate /etc/letsencrypt/live/api.gangclawcity.my/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/api.gangclawcity.my/privkey.pem;

    # WebSocket proxy
    location /ws {
        proxy_pass http://localhost:18789;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host $host;
        
        # Allow CORS from Vercel
        add_header Access-Control-Allow-Origin *;
        add_header Access-Control-Allow-Methods "GET, POST, OPTIONS";
        add_header Access-Control-Allow-Headers "Upgrade, Connection";
    }
}
```

**Then update Vercel env:**
```
VITE_GATEWAY_URL=wss://api.gangclawcity.my/ws
```

---

### **Phase 4: Connect Everything (5 mins)**

#### **Update Environment Variables on Vercel:**

**Dashboard:**
```
VITE_GATEWAY_URL=ws://76.13.176.142:18789
VITE_MOCK=false
```

**Agent Town:**
```
NODE_ENV=production
NEXT_PUBLIC_GATEWAY_URL=ws://76.13.176.142:18789
```

**Landing Page:**
```
NEXT_PUBLIC_DASHBOARD_URL=https://gangclawcity-dashboard.vercel.app
NEXT_PUBLIC_DEMO_URL=https://gangclawcity-demo.vercel.app
```

---

## 🎯 QUICK DEPLOYMENT SCRIPT

### **One-Command Deploy:**

```bash
#!/bin/bash
# deploy-to-vercel.sh

echo "🚀 Deploying GANGCLAWCITY to Vercel..."

# Deploy Landing Page
echo "📄 Deploying Landing Page..."
cd landing-page
vercel --prod
LANDING_URL=$(vercel ls --prod)
cd ..

# Deploy Dashboard
echo "📊 Deploying Dashboard..."
cd openclaw-office
vercel --prod
DASHBOARD_URL=$(vercel ls --prod)
cd ..

# Deploy Agent Town
echo "🎮 Deploying Agent Town..."
cd agent-town
vercel --prod
DEMO_URL=$(vercel ls --prod)
cd ..

echo ""
echo "✅ Deployment Complete!"
echo ""
echo "Landing Page: $LANDING_URL"
echo "Dashboard: $DASHBOARD_URL"
echo "Agent Town: $DEMO_URL"
echo ""
echo "Next: Update environment variables on Vercel dashboard"
```

---

## ⚠️ IMPORTANT CONSIDERATIONS

### **WebSocket Limitations on Vercel:**

**Problem:** Vercel serverless doesn't support WebSocket natively

**Solutions:**

1. **Use WSS Proxy on VPS** (Recommended)
   ```
   Vercel → wss://api.gangclawcity.my/ws → VPS OpenClaw
   ```

2. **Use Vercel Edge Functions** (Advanced)
   - More complex setup
   - Requires Edge runtime

3. **Use External WebSocket Service**
   - Pusher, Ably, or Socket.io
   - Extra cost but easier

---

### **Best Approach: Hybrid**

```
Vercel Frontend (HTTPS)
       ↓
Nginx on VPS (WSS Proxy)
       ↓
OpenClaw Gateway (WS)
```

**Benefits:**
- ✅ Vercel handles frontend
- ✅ VPS handles backend
- ✅ SSL/HTTPS automatic
- ✅ WebSocket works perfectly

---

## 📊 COST COMPARISON

### **Vercel Only (Frontend):**

| Plan | Cost | Includes |
|------|------|----------|
| **Hobby** | FREE | ✅ Unlimited deployments<br>✅ 100GB bandwidth<br>✅ Auto SSL |
| **Pro** | $20/month | ✅ Everything in Hobby<br>✅ More bandwidth<br>✅ Analytics |

**Recommended:** Start with FREE Hobby plan!

---

### **VPS Only (Backend):**

| Component | Cost |
|-----------|------|
| **VPS** | RM50/month (existing) |
| **OpenClaw** | FREE |
| **Nginx** | FREE |
| **Total** | RM50/month |

---

### **Total Cost:**

```
Vercel (Frontend): FREE
VPS (Backend): RM50/month
Domain: RM10/month (optional)
─────────────────────────────
Total: RM60/month (~$13)
```

**VS Self-Hosted Everything:**
```
VPS: RM50/month
Your Time: 10+ hours
Maintenance: Ongoing
─────────────────────────────
Total: RM50/month + your time
```

**Vercel saves you time!** ⏰

---

## 🚀 RECOMMENDED DEPLOYMENT ORDER

### **Today (1 hour total):**

1. **Deploy Landing Page to Vercel** (15 mins)
   ```bash
   cd landing-page
   vercel --prod
   ```

2. **Deploy Dashboard to Vercel** (15 mins)
   ```bash
   cd openclaw-office
   # Update vercel.json with VPS IP
   vercel --prod
   ```

3. **Test Connection** (15 mins)
   - Open dashboard URL
   - Check if connects to VPS OpenClaw
   - Verify NiagaBot agents appear

4. **Deploy Agent Town** (15 mins)
   ```bash
   cd agent-town
   vercel --prod
   ```

### **Tomorrow (30 mins):**

1. **Setup Custom Domain** (if you have one)
2. **Configure Nginx WSS Proxy**
3. **Add Analytics**

---

## ✅ VERCEL DEPLOYMENT CHECKLIST

### **Pre-Deployment:**

- [ ] Create Vercel account (free)
- [ ] Install Vercel CLI
- [ ] Update vercel.json for each app
- [ ] Set environment variables

### **Deployment:**

- [ ] Deploy Landing Page
- [ ] Deploy Dashboard
- [ ] Deploy Agent Town
- [ ] Test all URLs

### **Post-Deployment:**

- [ ] Test WebSocket connection
- [ ] Verify NiagaBot agents visible
- [ ] Setup custom domain (optional)
- [ ] Configure CORS on VPS
- [ ] Setup WSS proxy (if needed)

---

## 🎯 QUICK START COMMANDS

### **Deploy Landing Page NOW:**

```bash
# Install Vercel
npm install -g vercel

# Login
vercel login

# Deploy
cd G:\PROJECT-4\GANGCLAWCITY\landing-page
vercel --prod

# Get URL
vercel ls --prod
# Output: https://your-project.vercel.app
```

**Done! Landing page is LIVE!** ✅

---

### **Deploy Dashboard:**

```bash
cd G:\PROJECT-4\GANGCLAWCITY\openclaw-office

# Create vercel.json
cat > vercel.json << EOF
{
  "version": 2,
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/static-build",
      "config": { "distDir": "dist" }
    }
  ],
  "env": {
    "VITE_GATEWAY_URL": "ws://76.13.176.142:18789",
    "VITE_MOCK": "false"
  }
}
EOF

# Deploy
vercel --prod
```

**Dashboard is LIVE!** ✅

---

## 🎉 FINAL RESULT

### **You Get:**

```
✅ Landing Page: https://gangclawcity-landing.vercel.app
✅ Dashboard: https://gangclawcity-dashboard.vercel.app
✅ Agent Town: https://gangclawcity-demo.vercel.app

✅ Connected to: ws://76.13.176.142:18789
✅ Showing: NiagaBot agents
✅ SSL: Automatic ✅
✅ CDN: Global ✅
✅ Scaling: Auto ✅
```

### **NiagaBot:**
- ✅ Continues running on VPS
- ✅ Zero downtime
- ✅ Zero risk
- ✅ Now has visual dashboard!

---

## 🚨 POTENTIAL ISSUES & SOLUTIONS

### **Issue 1: WebSocket Can't Connect**

**Solution:** Use WSS proxy on VPS
```nginx
# Nginx config on VPS
location /ws {
    proxy_pass http://localhost:18789;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "Upgrade";
}
```

Then update Vercel env:
```
VITE_GATEWAY_URL=wss://your-vps-ip/ws
```

---

### **Issue 2: CORS Errors**

**Solution:** Enable CORS on OpenClaw
```json
// /root/.openclaw/openclaw.json
{
  "gateway": {
    "cors": {
      "enabled": true,
      "origins": ["*"]
    }
  }
}
```

---

### **Issue 3: Build Fails**

**Solution:** Check Node.js version
```bash
node --version
# Should be 18+ for Vercel

# If not, update:
nvm install 22
nvm use 22
```

---

## 📈 NEXT STEPS

### **Immediate (Now):**

1. **Deploy Landing Page** (5 mins)
2. **Test it works** (2 mins)
3. **Deploy Dashboard** (10 mins)
4. **Connect to VPS** (5 mins)

### **Later Today:**

1. **Deploy Agent Town** (10 mins)
2. **Setup custom domain** (15 mins)
3. **Configure WSS proxy** (15 mins)

### **Tomorrow:**

1. **Add analytics**
2. **Optimize performance**
3. **User testing**

---

**🏙️ GANGCLAWCITY on Vercel** — Fastest deployment!  
**Time:** 1 hour total  
**Cost:** FREE (Hobby plan)  
**Risk:** Zero to NiagaBot  

---

**Nak start deploy landing page sekarang?** 🚀
