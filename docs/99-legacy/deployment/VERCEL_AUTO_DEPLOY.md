# 🚀 VERCEL AUTO-DEPLOY SETUP

**GitHub:** https://github.com/thisisniagahub/GANGCLAWCITY  
**Strategy:** Auto-deploy on every push  
**Status:** ⚡ READY TO DEPLOY!

---

## 📋 STEP-BY-STEP SETUP

### **Step 1: Push Code to GitHub**

```bash
# Navigate to project
cd G:\PROJECT-4\GANGCLAWCITY

# Initialize git (if not already)
git init
git add .
git commit -m "Initial commit: GANGCLAWCITY platform"

# Add remote repository
git remote add origin https://github.com/thisisniagahub/GANGCLAWCITY.git

# Push to GitHub
git branch -M main
git push -u origin main
```

**✅ Code is now on GitHub!**

---

### **Step 2: Connect GitHub to Vercel**

#### **Option A: Vercel Dashboard (Easiest)**

1. **Go to Vercel:** https://vercel.com/new
2. **Click:** "Import Git Repository"
3. **Select:** GitHub
4. **Authorize:** Allow Vercel to access GitHub
5. **Find:** `thisisniagahub/GANGCLAWCITY`
6. **Click:** Import

---

#### **Option B: Vercel CLI**

```bash
# Install Vercel CLI
npm install -g vercel

# Login
vercel login

# Navigate to project
cd G:\PROJECT-4\GANGCLAWCITY

# Link to Vercel
vercel link

# Select:
# - Set up and deploy: Yes
# - Which scope: Your account
# - Link to existing project: No
# - Project name: gangclawcity
# - Directory: ./
# - Want to override settings: No
```

---

### **Step 3: Configure Projects**

Vercel will auto-detect 3 projects in your monorepo:

#### **Project 1: Landing Page**

**Settings:**
```
Name: gangclawcity-landing
Framework: Other
Build Command: (none - static HTML)
Output Directory: ./
Install Command: (none)
```

**Root Directory:** `landing-page`

---

#### **Project 2: Dashboard**

**Settings:**
```
Name: gangclawcity-dashboard
Framework: Vite
Build Command: pnpm build
Output Directory: dist
Install Command: pnpm install
```

**Root Directory:** `openclaw-office`

**Environment Variables:**
```
VITE_GATEWAY_URL=ws://<VPS_IP>:18789
VITE_MOCK=false
```

---

#### **Project 3: Agent Town**

**Settings:**
```
Name: gangclawcity-demo
Framework: Next.js
Build Command: pnpm build
Output Directory: .next
Install Command: pnpm install
```

**Root Directory:** `agent-town`

**Environment Variables:**
```
NODE_ENV=production
```

---

### **Step 4: Deploy Each Project**

#### **Deploy Landing Page:**

```bash
cd G:\PROJECT-4\GANGCLAWCITY\landing-page

# Create vercel.json
cat > vercel.json << EOF
{
  "version": 2,
  "name": "gangclawcity-landing",
  "builds": [
    { "src": "**/*", "use": "@vercel/static" }
  ]
}
EOF

# Push to trigger deploy
git add vercel.json
git commit -m "Add Vercel config for landing page"
git push origin main
```

**Vercel will auto-deploy!** ✅

---

#### **Deploy Dashboard:**

```bash
cd G:\PROJECT-4\GANGCLAWCITY\openclaw-office

# Create vercel.json
cat > vercel.json << EOF
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
    "VITE_GATEWAY_URL": "ws://<VPS_IP>:18789",
    "VITE_MOCK": "false"
  }
}
EOF

# Update package.json scripts
# Add: "build": "vite build"

# Push to trigger deploy
git add vercel.json package.json
git commit -m "Add Vercel config for dashboard"
git push origin main
```

**Vercel will auto-deploy!** ✅

---

#### **Deploy Agent Town:**

```bash
cd G:\PROJECT-4\GANGCLAWCITY\agent-town

# Create vercel.json
cat > vercel.json << EOF
{
  "version": 2,
  "name": "gangclawcity-demo",
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/next"
    }
  ]
}
EOF

# Push to trigger deploy
git add vercel.json
git commit -m "Add Vercel config for agent town"
git push origin main
```

**Vercel will auto-deploy!** ✅

---

## 🎯 ALTERNATIVE: Single Project with Monorepo

If you want all 3 apps in ONE Vercel project:

### **Create Root vercel.json:**

```json
{
  "version": 2,
  "projects": [
    {
      "path": "landing-page",
      "name": "gangclawcity-landing"
    },
    {
      "path": "openclaw-office",
      "name": "gangclawcity-dashboard"
    },
    {
      "path": "agent-town",
      "name": "gangclawcity-demo"
    }
  ]
}
```

**But separate projects are better for:**
- ✅ Independent deployments
- ✅ Clear separation
- ✅ Easier management

---

## 📊 AUTO-DEPLOY WORKFLOW

### **Every time you push to GitHub:**

```bash
git add .
git commit -m "Update feature"
git push origin main
```

**Vercel automatically:**
1. ✅ Detects changes
2. ✅ Installs dependencies
3. ✅ Builds project
4. ✅ Deploys to CDN
5. ✅ Updates live site

**Deployment URL:**
```
https://gangclawcity-landing.vercel.app
https://gangclawcity-dashboard.vercel.app
https://gangclawcity-demo.vercel.app
```

---

## 🔧 VERCEL PROJECT SETTINGS

### **For Each Project:**

#### **Landing Page:**
- **Build Command:** (none)
- **Output Directory:** `./`
- **Install Command:** (none)
- **Dev Command:** (none)

#### **Dashboard:**
- **Build Command:** `pnpm build`
- **Output Directory:** `dist`
- **Install Command:** `pnpm install`
- **Dev Command:** `pnpm dev`

#### **Agent Town:**
- **Build Command:** `pnpm build`
- **Output Directory:** `.next`
- **Install Command:** `pnpm install`
- **Dev Command:** `pnpm dev`

---

## ⚙️ ENVIRONMENT VARIABLES

### **Set on Vercel Dashboard:**

**Dashboard Project:**
```
VITE_GATEWAY_URL = ws://<VPS_IP>:18789
VITE_MOCK = false
```

**Agent Town Project:**
```
NODE_ENV = production
```

**Landing Page Project:**
```
NEXT_PUBLIC_DASHBOARD_URL = https://gangclawcity-dashboard.vercel.app
NEXT_PUBLIC_DEMO_URL = https://gangclawcity-demo.vercel.app
```

---

## 🚨 IMPORTANT FIXES NEEDED

### **Fix 1: Dashboard Build Script**

**File:** `openclaw-office/package.json`

Add build script:
```json
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  }
}
```

---

### **Fix 2: Agent Town Build Output**

**File:** `agent-town/next.config.ts`

Ensure standalone output:
```typescript
const nextConfig = {
  output: 'standalone',
  // ... other config
}
```

---

### **Fix 3: Enable CORS on VPS**

**File:** `/root/.openclaw/openclaw.json`

Add CORS:
```json
{
  "gateway": {
    "cors": {
      "enabled": true,
      "origins": [
        "https://gangclawcity-landing.vercel.app",
        "https://gangclawcity-dashboard.vercel.app",
        "https://gangclawcity-demo.vercel.app"
      ]
    }
  }
}
```

**Restart OpenClaw:**
```bash
ssh root@<VPS_IP>
openclaw gateway restart
```

---

## 📋 DEPLOYMENT CHECKLIST

### **Pre-Deployment:**

- [ ] Code pushed to GitHub
- [ ] Vercel account created
- [ ] GitHub connected to Vercel
- [ ] vercel.json created for each app

### **Deployment:**

- [ ] Landing Page deployed
- [ ] Dashboard deployed
- [ ] Agent Town deployed
- [ ] Environment variables set

### **Post-Deployment:**

- [ ] Test all URLs
- [ ] Verify WebSocket connection
- [ ] Check NiagaBot agents appear
- [ ] Enable CORS on VPS

---

## 🎯 QUICK START COMMANDS

### **Push to GitHub:**

```bash
cd G:\PROJECT-4\GANGCLAWCITY

# Add all files
git add .

# Commit
git commit -m "Ready for Vercel deployment"

# Push
git push -u origin main
```

**GitHub repo updated!** ✅

---

### **Deploy on Vercel:**

1. Go to https://vercel.com/new
2. Import `thisisniagahub/GANGCLAWCITY`
3. Configure 3 projects separately
4. Set environment variables
5. Click Deploy

**Auto-deploy enabled!** ✅

---

## 🔄 AUTO-DEPLOY WORKFLOW

### **From Now On:**

```bash
# Make changes
# Edit files...

# Commit and push
git add .
git commit -m "Added new feature"
git push origin main

# Vercel auto-deploys!
# Check: https://vercel.com/dashboard
```

**Every push = Auto deploy!** 🚀

---

## 📊 DEPLOYMENT URLs

After deployment, you get:

```
✅ Landing Page:
https://gangclawcity-landing.vercel.app

✅ Dashboard:
https://gangclawcity-dashboard.vercel.app

✅ Agent Town:
https://gangclawcity-demo.vercel.app
```

**Plus auto-preview for every branch!**

---

## ⚡ PRO TIPS

### **1. Preview Deployments:**

Every branch gets its own preview URL:
```
https://gangclawcity-landing-git-feature.vercel.app
```

**Perfect for testing before merge!**

---

### **2. Rollback Anytime:**

Vercel keeps all deployments. Can rollback with 1 click.

---

### **3. Custom Domain:**

Add custom domain later:
```
Settings → Domains → Add gangclawcity.my
```

**Auto SSL included!**

---

### **4. Analytics:**

Enable Vercel Analytics:
```
Settings → Analytics → Enable
```

**Free for Hobby plan!**

---

## 🎉 EXPECTED RESULT

### **After Auto-Deploy:**

```
✅ Landing Page LIVE
   URL: https://gangclawcity-landing.vercel.app
   Status: Deployed from main branch

✅ Dashboard LIVE
   URL: https://gangclawcity-dashboard.vercel.app
   Status: Deployed from main branch
   Connected to: ws://<VPS_IP>:18789

✅ Agent Town LIVE
   URL: https://gangclawcity-demo.vercel.app
   Status: Deployed from main branch

✅ NiagaBot Integration
   Status: Connected via WebSocket
   Agents: Visible in dashboard
```

---

## 🚀 NEXT STEPS

### **Right Now:**

1. **Push code to GitHub** (5 mins)
   ```bash
   cd G:\PROJECT-4\GANGCLAWCITY
   git add .
   git commit -m "Initial commit"
   git push -u origin main
   ```

2. **Import to Vercel** (10 mins)
   - Go to vercel.com/new
   - Import GitHub repo
   - Deploy 3 projects

3. **Test deployment** (5 mins)
   - Open all URLs
   - Check WebSocket connection
   - Verify NiagaBot agents

### **Later:**

1. **Add custom domain**
2. **Enable analytics**
3. **Setup WSS proxy**

---

**🏙️ GANGCLAWCITY on Vercel** — Auto-deploy from GitHub!  
**Time:** 20 minutes total  
**Cost:** FREE  
**Auto-deploy:** Every push ✅  

---

**Nak push code ke GitHub sekarang?** 🚀
