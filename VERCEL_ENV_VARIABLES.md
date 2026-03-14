# GANGCLAWCITY - Vercel Environment Variables

**For Testing with Existing Token**

---

## 🔧 **SET VERCEL ENVIRONMENT VARIABLES:**

### **Go to Vercel Dashboard:**
```
1. https://vercel.com/dashboard
2. Select project: gangclawcity
3. Settings → Environment Variables
4. Add each variable below
```

---

## 📋 **ENVIRONMENT VARIABLES:**

### **Production Environment:**

```env
# Gateway Connection
VITE_GATEWAY_URL=wss://operator.gangniaga.my
VITE_GATEWAY_TOKEN=053adc82f8d2600b32c397c12f3517745b76a4deabf926b9
VITE_SESSION_KEY=agent:main:main

# App Settings
VITE_MOCK=false
VITE_APP_NAME=GANGCLAWCITY
VITE_APP_VERSION=1.0.0
```

### **Preview Environment (Optional):**
```env
# Same as production for testing
VITE_GATEWAY_URL=wss://operator.gangniaga.my
VITE_GATEWAY_TOKEN=053adc82f8d2600b32c397c12f3517745b76a4deabf926b9
VITE_SESSION_KEY=agent:main:main
VITE_MOCK=false
```

### **Development Environment (Optional):**
```env
# Local testing
VITE_GATEWAY_URL=ws://localhost:18789
VITE_GATEWAY_TOKEN=053adc82f8d2600b32c397c12f3517745b76a4deabf926b9
VITE_SESSION_KEY=agent:main:main
VITE_MOCK=false
```

---

## 🚀 **AFTER SETTING VARIABLES:**

### **Redeploy on Vercel:**
```
1. Go to: https://vercel.com/dashboard
2. Select: gangclawcity project
3. Deployments → Click "Redeploy" on latest deployment
4. Wait for deployment to complete (~2-5 mins)
```

### **Or Trigger New Deployment:**
```bash
# Make small change and push
git commit --allow-empty -m "chore: Trigger redeploy"
git push origin master
```

---

## 🧪 **TEST CHECKLIST:**

### **Landing Page:**
```
□ Visit: https://gangclawcity.vercel.app/
□ Check navbar loads
□ Check hero section visible
□ Check 8 districts display
□ Check email capture form
□ Check footer loads
□ Test responsive design (mobile)
□ Test scroll animations
```

### **Assets:**
```
□ CSS loads (style.css)
□ JavaScript loads (script.js)
□ Images load (hero-city.png)
□ Fonts load (Google Fonts)
□ Icons display (emoji)
```

### **Features:**
```
□ Particle animation works
□ Navigation links work
□ Scroll to sections works
□ Email form visible
□ Stats counter animation
□ Mobile menu toggle
```

### **Gateway Connection (If Dashboard Deployed):**
```
□ Connect to wss://operator.gangniaga.my
□ Authenticate with token
□ List agents
□ Display agent status
□ Real-time updates
```

---

## 📊 **TEST RESULTS TEMPLATE:**

```
Date: ___________
Tester: ___________

Landing Page:
[ ] Navbar ✅
[ ] Hero ✅
[ ] Districts ✅
[ ] Email Form ✅
[ ] Footer ✅

Assets:
[ ] CSS ✅
[ ] JS ✅
[ ] Images ✅
[ ] Fonts ✅

Features:
[ ] Animations ✅
[ ] Navigation ✅
[ ] Responsive ✅
[ ] Email Form ✅

Gateway (if applicable):
[ ] Connection ✅
[ ] Auth ✅
[ ] Agents List ✅
[ ] Real-time ✅

Issues Found:
_________________________________
_________________________________

Overall Status: PASS / FAIL
```

---

## 🎯 **NEXT STEPS AFTER TESTING:**

### **If All Tests Pass:**
```
✅ Landing page functional
✅ All assets loading
✅ Features working
✅ Ready for production

Next: Token rotation on VPS
```

### **If Issues Found:**
```
1. Document issues
2. Fix in code
3. Commit & push
4. Vercel auto-redeploys
5. Retest
```

---

## 📞 **QUICK ACCESS:**

```
Vercel Dashboard: https://vercel.com/dashboard
Project: gangclawcity
URL: https://gangclawcity.vercel.app/
GitHub: https://github.com/thisisniagahub/GANGCLAWCITY
```

---

**SET ENV VARIABLES & TEST NOW!** 🚀
