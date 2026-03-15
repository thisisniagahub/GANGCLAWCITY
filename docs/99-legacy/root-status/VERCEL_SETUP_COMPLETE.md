# GANGCLAWCITY - Vercel Environment Setup

**Using Existing Token**

---

## 🔧 **STEP 1: SET VERCEL ENVIRONMENT VARIABLES**

### **Go to Vercel Dashboard:**
```
1. Login: https://vercel.com/login
2. Go to: https://vercel.com/dashboard
3. Click project: gangclawcity
4. Go to: Settings → Environment Variables
```

### **Add These Variables:**

**Variable 1:**
```
Name: VITE_GATEWAY_URL
Value: wss://operator.gangniaga.my
Environment: Production ✅
```

**Variable 2:**
```
Name: VITE_GATEWAY_TOKEN
Value: <GATEWAY_TOKEN>
Environment: Production ✅
```

**Variable 3:**
```
Name: VITE_SESSION_KEY
Value: agent:main:main
Environment: Production ✅
```

**Variable 4:**
```
Name: VITE_MOCK
Value: false
Environment: Production ✅
```

### **Save & Redeploy:**
```
1. Click "Save" after adding all variables
2. Go to Deployments tab
3. Click "Redeploy" on latest deployment
4. Wait 2-5 minutes for deployment
```

---

## 🚀 **STEP 2: DEPLOY DASHBOARD (OpenClaw Office)**

### **Option A: Deploy via Vercel CLI**

```bash
# Navigate to dashboard
cd G:\PROJECT-4\GANGCLAWCITY\openclaw-office

# Install Vercel CLI if not installed
npm install -g vercel

# Login to Vercel
vercel login

# Deploy
vercel --prod
```

### **Option B: Deploy via Vercel Dashboard**

```
1. Go to: https://vercel.com/new
2. Click "Import Git Repository"
3. Select: thisisniagahub/GANGCLAWCITY
4. Root Directory: openclaw-office
5. Framework: Vite
6. Build Command: pnpm build (or npm run build)
7. Output Directory: dist
8. Environment Variables:
   - VITE_GATEWAY_URL=wss://operator.gangniaga.my
   - VITE_GATEWAY_TOKEN=<GATEWAY_TOKEN>
   - VITE_SESSION_KEY=agent:main:main
   - VITE_MOCK=false
9. Click "Deploy"
```

---

## 🎮 **STEP 3: DEPLOY AGENT TOWN**

### **Via Vercel Dashboard:**

```
1. Go to: https://vercel.com/new
2. Import Git Repository
3. Select: thisisniagahub/GANGCLAWCITY
4. Root Directory: agent-town
5. Framework: Next.js
6. Build Command: pnpm build (or npm run build)
7. Output Directory: .next
8. Environment Variables:
   - NEXT_PUBLIC_GATEWAY_URL=wss://operator.gangniaga.my
   - NEXT_PUBLIC_GATEWAY_TOKEN=<GATEWAY_TOKEN>
   - NODE_ENV=production
9. Click "Deploy"
```

---

## 🧪 **STEP 4: TEST GATEWAY CONNECTION**

### **Test Landing Page:**
```
URL: https://gangclawcity.vercel.app/
Check:
□ Page loads
□ Title: "GANGCLAWCITY — Malaysia Agent City OS"
□ All sections visible
□ Email capture form works
□ Navigation works
```

### **Test Dashboard (After Deploy):**
```
URL: https://gangclawcity-dashboard.vercel.app/
Check:
□ Dashboard loads
□ Connects to gateway
□ Shows NiagaBot agents
□ Real-time updates working
□ No console errors
```

### **Test Agent Town (After Deploy):**
```
URL: https://gangclawcity-demo.vercel.app/
Check:
□ Game loads
□ Agents visible
□ Controls working
□ Connects to gateway
```

---

## 📊 **STEP 5: VERIFICATION CHECKLIST**

### **Landing Page:**
```
[ ] https://gangclawcity.vercel.app/ loads
[ ] Title correct
[ ] All 8 districts visible
[ ] Email capture form functional
[ ] Responsive design works
[ ] All assets loaded (CSS, JS, Images)
```

### **Dashboard:**
```
[ ] Deploys successfully
[ ] Connects to wss://operator.gangniaga.my
[ ] Authenticates with token
[ ] Lists NiagaBot agents
[ ] Shows real-time updates
[ ] No errors in console
```

### **Agent Town:**
```
[ ] Deploys successfully
[ ] Game loads
[ ] Agents animated
[ ] Connects to gateway
[ ] Controls responsive
```

### **Gateway:**
```
[ ] Gateway accessible
[ ] Token authentication works
[ ] Agents list returned
[ ] Real-time events received
```

---

## 🎯 **QUICK ACCESS URLS:**

```
Landing Page: https://gangclawcity.vercel.app/
Dashboard: https://gangclawcity-dashboard.vercel.app/ (after deploy)
Agent Town: https://gangclawcity-demo.vercel.app/ (after deploy)
GitHub: https://github.com/thisisniagahub/GANGCLAWCITY
Vercel Dashboard: https://vercel.com/dashboard
```

---

## ⚠️ **IMPORTANT NOTES:**

### **Using Existing Token:**
```
✅ Token: <GATEWAY_TOKEN>
✅ This token is exposed in documentation
✅ For testing only
✅ Rotate token in production
```

### **Security Warning:**
```
⚠️ Token is public in GitHub repo
⚠️ Token is public in Vercel environment
⚠️ For production: Rotate token on VPS
⚠️ Update all environment variables with new token
```

---

## 📞 **NEXT STEPS:**

1. ✅ Set Vercel Environment Variables (NOW)
2. ⏳ Deploy Dashboard (NEXT)
3. ⏳ Deploy Agent Town (NEXT)
4. ⏳ Test all deployments (NEXT)
5. ⏳ Rotate token on VPS (LATER)

---

**START WITH STEP 1 NOW!** 🚀
