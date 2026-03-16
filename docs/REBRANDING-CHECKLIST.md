# 🎨 GANGCLAWCITY REBRANDING CHECKLIST

**Track Progress: From Upstream → GANGCLAWCITY Original Products**

---

## 📊 OVERALL STATUS

| App | Upstream Name | GANGCLAWCITY Name | Progress | Priority |
|-----|---------------|-------------------|----------|----------|
| 1 | openclaw-office | GANGCLAWCITY Dashboard | ⚠️ 30% | 🔴 HIGH |
| 2 | agent-town | GANGCLAWCITY CityView | ⚠️ 20% | 🔴 HIGH |
| 3 | ai-town | GANGCLAWCITY Lab | 📋 0% | 🟡 MEDIUM |
| 4 | Star-Office-UI | GANGCLAWCITY Office | 📋 0% | 🟡 MEDIUM |
| 5 | pixel-agents | GANGCLAWCITY Workspace | 📋 0% | 🟢 LOW |

**Legend:**
- 📋 Not Started (0%)
- ⚠️ In Progress (1-99%)
- ✅ Complete (100%)

---

## 🔴 PRIORITY 1: CORE APPS

### **1. GANGCLAWCITY Dashboard** (from openclaw-office)

**Current Status:** ⚠️ **30% Complete**

#### **Phase 1: Security (CRITICAL)**
- [ ] 🔴 Rotate gateway token on VPS
- [ ] 🔴 Remove hardcoded tokens from `src/App.tsx`
- [ ] 🔴 Remove hardcoded tokens from `src/components/shared/ConnectionSetupDialog.tsx`
- [ ] 🔴 Remove hardcoded tokens from `bin/openclaw-office-config.js`
- [ ] ✅ Replace all tokens with `import.meta.env.VITE_GATEWAY_TOKEN`
- [ ] ✅ Add `.env.example` with placeholder values
- [ ] ✅ Update `.gitignore` to prevent token commits

#### **Phase 2: UI Rebranding**
- [ ] 🔴 Replace "OpenClaw" with "GANGCLAWCITY" in all UI text
- [ ] 🔴 Replace "WW-AI-Lab" references with "GANGCLAWCITY"
- [ ] 🔴 Update app title to "GANGCLAWCITY Dashboard"
- [ ] 🔴 Replace logo with GANGCLAWCITY logo
- [ ] 🔴 Update color scheme to GANGCLAWCITY brand
- [ ] 🔴 Update favicon to GANGCLAWCITY icon
- [ ] 🔴 Remove "OpenClaw" from page titles
- [ ] 🔴 Update meta descriptions

#### **Phase 3: Documentation**
- [ ] ✅ Update README.md with upstream declaration
- [ ] ✅ Update package.json name to `@gangclawcity/dashboard`
- [ ] 🔴 Update all user-facing documentation
- [ ] 🔴 Add attribution to original authors (WW-AI-Lab)
- [ ] 🔴 Preserve MIT LICENSE file

#### **Phase 4: Deployment**
- [ ] 🔴 Update Vercel project name to "gangclawcity-dashboard"
- [ ] 🔴 Set environment variables on Vercel
- [ ] 🔴 Test production build
- [ ] 🔴 Deploy to `dashboard.gangclawcity.my` (or Vercel subdomain)

---

### **2. GANGCLAWCITY CityView** (from agent-town)

**Current Status:** ⚠️ **20% Complete**

#### **Phase 1: Security**
- [ ] 🔴 Audit for hardcoded tokens
- [ ] ✅ Add `.env.example` with placeholder values
- [ ] ✅ Ensure no tokens committed to Git

#### **Phase 2: UI Rebranding**
- [ ] 🔴 Replace "Agent Town" with "GANGCLAWCITY CityView"
- [ ] 🔴 Remove "@geezerrrr" branding from UI
- [ ] 🔴 Update app title to "GANGCLAWCITY CityView"
- [ ] 🔴 Replace logo with GANGCLAWCITY logo
- [ ] 🔴 Update color scheme to GANGCLAWCITY brand
- [ ] 🔴 Update favicon
- [ ] 🔴 Remove "Agent Town" from page titles
- [ ] 🔴 Update meta descriptions
- [ ] 🔴 Add district-based navigation (8 districts)

#### **Phase 3: Documentation**
- [ ] ✅ Update README.md with upstream declaration
- [ ] 🔴 Update package.json name to `@gangclawcity/cityview`
- [ ] 🔴 Update all user-facing documentation
- [ ] 🔴 Add attribution to original authors (@geezerrrr)
- [ ] 🔴 Preserve MIT LICENSE file

#### **Phase 4: Deployment**
- [ ] 🔴 Update Vercel project name to "gangclawcity-cityview"
- [ ] 🔴 Set environment variables on Vercel
- [ ] 🔴 Test production build
- [ ] 🔴 Deploy to `cityview.gangclawcity.my` (or Vercel subdomain)

---

## 🟡 PRIORITY 2: MODULES

### **3. GANGCLAWCITY Lab** (from ai-town)

**Current Status:** 📋 **0% Complete - Not Started**

#### **Phase 1: Assessment**
- [ ] 📋 Review ai-town codebase
- [ ] 📋 Identify all branding to change
- [ ] 📋 Check for security issues
- [ ] 📋 Document upstream dependencies

#### **Phase 2: Planning**
- [ ] 📋 Define GANGCLAWCITY Lab features
- [ ] 📋 Plan R&D module integration
- [ ] 📋 Design district integration

#### **Phase 3: Execution**
- [ ] 📋 Follow same checklist as Dashboard (above)
- [ ] 📋 Rebrand as GANGCLAWCITY Lab
- [ ] 📋 Add attribution to Convex Inc

---

### **4. GANGCLAWCITY Office** (from Star-Office-UI)

**Current Status:** 📋 **0% Complete - Not Started**

#### **Phase 1: Assessment**
- [ ] 📋 Review Star-Office-UI codebase
- [ ] 📋 Identify all branding to change
- [ ] 📋 Check for security issues
- [ ] 📋 Document upstream dependencies

#### **Phase 2: Planning**
- [ ] 📋 Define GANGCLAWCITY Office features
- [ ] 📋 Plan internal workflow integration
- [ ] 📋 Design business pack structure

#### **Phase 3: Execution**
- [ ] 📋 Follow same checklist as Dashboard (above)
- [ ] 📋 Rebrand as GANGCLAWCITY Office
- [ ] 📋 Add attribution to original authors

---

### **5. GANGCLAWCITY Workspace** (from pixel-agents)

**Current Status:** 📋 **0% Complete - Not Started**

#### **Phase 1: Assessment**
- [ ] 📋 Review pixel-agents codebase
- [ ] 📋 Identify all branding to change
- [ ] 📋 Check for security issues
- [ ] 📋 Document upstream dependencies

#### **Phase 2: Planning**
- [ ] 📋 Define GANGCLAWCITY Workspace features
- [ ] 📋 Plan VS Code extension adaptation
- [ ] 📋 Design developer tooling integration

#### **Phase 3: Execution**
- [ ] 📋 Follow same checklist as Dashboard (above)
- [ ] 📋 Rebrand as GANGCLAWCITY Workspace
- [ ] 📋 Add attribution to Pablo De Lucca

---

## 🎯 CRITICAL PATH (THIS WEEK)

**Week of March 17-24, 2026:**

### **Must Complete (Priority 0):**
1. [ ] 🔴 **Rotate gateway token** (CRITICAL - Security)
2. [ ] 🔴 **Remove all hardcoded tokens** from openclaw-office
3. [ ] 🔴 **Remove all hardcoded tokens** from agent-town
4. [ ] 🔴 **Run security-scan.bat** to verify clean

### **Should Complete (Priority 1):**
1. [ ] 🔴 **Rebrand Dashboard UI** (remove OpenClaw branding)
2. [ ] 🔴 **Rebrand CityView UI** (remove Agent Town branding)
3. [ ] 🔴 **Update package.json names** for both apps

### **Nice to Complete (Priority 2):**
1. [ ] 🟡 **Deploy Dashboard** to Vercel
2. [ ] 🟡 **Deploy CityView** to Vercel
3. [ ] 🟡 **Test both apps** with production gateway

---

## 📊 REBRANDING PROGRESS TRACKER

### **Files That Need Changes (Per App):**

**openclaw-office → GANGCLAWCITY Dashboard:**
```
Files to check:
- src/App.tsx (token removal, branding)
- src/components/shared/ConnectionSetupDialog.tsx (token removal)
- src/components/**/*.tsx (UI text replacement)
- public/favicon.ico (replace logo)
- index.html (title, meta tags)
- package.json (name, description)
- README.md (upstream declaration)
- bin/openclaw-office-config.js (token removal)
```

**agent-town → GANGCLAWCITY CityView:**
```
Files to check:
- app/**/*.tsx (UI text replacement)
- components/**/*.tsx (UI text replacement)
- public/favicon.ico (replace logo)
- app/layout.tsx (title, meta tags)
- package.json (name, description)
- README.md (upstream declaration)
```

---

## ✅ COMPLETED TASKS

### **Documentation (100% Complete):**
- [x] ✅ Update main README.md with honest upstream declaration
- [x] ✅ Update QWEN.md with upstream repo table
- [x] ✅ Update ARCHITECTURE.md with upstream declaration
- [x] ✅ Create UPSTREAM-DECLARATION.md (comprehensive)
- [x] ✅ Create REBRANDING-CHECKLIST.md (this file)

### **Security Awareness:**
- [x] ✅ Document token exposure in SECURITY_AUDIT.md
- [x] ✅ Create security-scan.bat automation
- [x] ✅ Add token patterns to .gitignore

---

## 🎉 DEFINITION OF DONE

**An app is considered "Fully Rebranded" when:**

1. ✅ **Security:**
   - No hardcoded tokens
   - Environment variables only
   - .env.example present
   - .gitignore updated

2. ✅ **UI Rebranding:**
   - All upstream names removed from user-facing UI
   - GANGCLAWCITY branding applied
   - Logo replaced
   - Colors aligned with brand

3. ✅ **Documentation:**
   - Upstream declared honestly
   - Original authors credited
   - LICENSE file preserved
   - README updated

4. ✅ **Deployment:**
   - Deployed to Vercel
   - GANGCLAWCITY domain/subdomain
   - Environment variables set
   - Production build working

---

## 📈 PROGRESS METRICS

**Overall Progress:**
- Dashboard: 30% ⚠️
- CityView: 20% ⚠️
- Lab: 0% 📋
- Office: 0% 📋
- Workspace: 0% 📋

**Weighted Average:** 10% Complete (Phase 1: Declaration Done)

**Next Milestone:** 50% (Dashboard + CityView fully rebranded)

---

**Last Updated:** March 17, 2026  
**Next Review:** March 24, 2026  
**Owner:** GANGCLAWCITY Team

---

**🎨 GANGCLAWCITY Rebranding - From Upstream to Original Products!**  
**🚀 No Fake Claims. Real Progress. Honest Work.**
