# GANGCLAWCITY

**AI Workforce Platform - Built from Proven Foundations**

---

## 🚨 HONEST TRUTH - NO BULLSHIT

**This is NOT a from-scratch project.**

GANGCLAWCITY **absorbs 5 proven upstream repositories** as starting foundations. We don't pretend to invent what already works. We take battle-tested code, **strip vendor branding**, **improve aggressively**, and ship as **GANGCLAWCITY original products**.

**What we do:**
- ✅ Take proven concepts that already work
- ✅ Remove upstream vendor branding
- ✅ Improve security, UX, and architecture
- ✅ Rebrand as GANGCLAWCITY original products
- ✅ Deploy for Malaysian market

**What we don't do:**
- ❌ Start from zero (waste of time)
- ❌ Pretend we invented everything
- ❌ Keep upstream branding in user-facing surfaces
- ❌ Claim integration before it's actually integrated

---

## 📦 UPSTREAM REPOSITORIES (PROVEN CONCEPTS)

These 5 repositories are **DONOR CODE** - proven successes we adapt, not our final products:

| Upstream Repo | Original Purpose | GANGCLAWCITY Adaptation | Status |
|---------------|------------------|------------------------|--------|
| **openclaw-office** | OpenClaw dashboard frontend | → **GANGCLAWCITY Dashboard** (Core App) | ⚠️ In Progress |
| **agent-town** | Pixel art agent visualization | → **GANGCLAWCITY CityView** (Core App) | ⚠️ In Progress |
| **ai-town** | Convex-backed simulation | → **GANGCLAWCITY Lab** (Module) | 📋 Planned |
| **Star-Office-UI** | Python office status board | → **GANGCLAWCITY Office** (Module) | 📋 Planned |
| **pixel-agents** | VS Code extension | → **GANGCLAWCITY Workspace** (Tooling) | 📋 Planned |

**Important:**
- These repos **retain their original licenses** (MIT, Apache, etc.)
- We **MUST preserve attribution** in LICENSE files
- We **CANNOT** claim we wrote the original code
- We **CAN** rebrand user-facing surfaces and improve the code

---

## 🎯 GANGCLAWCITY ORIGINAL PRODUCTS (WHAT WE'RE BUILDING)

These are **OUR apps** - adapted from upstream, but **GANGCLAWCITY branded and improved**:

### **Core Apps (Priority 1)**

#### 1. **GANGCLAWCITY Dashboard**
- **Based on:** `openclaw-office/` upstream
- **What we improve:**
  - Security hardening (no browser token exposure)
  - GANGCLAWCITY branding (remove OpenClaw/WW-AI-Lab)
  - District-based navigation (8 districts)
  - Malaysian market localization
  - Production deployment config
- **Status:** ⚠️ **In Progress** - Needs security fixes

#### 2. **GANGCLAWCITY CityView**
- **Based on:** `agent-town/` upstream
- **What we improve:**
  - GANGCLAWCITY branding (remove @geezerrrr)
  - District operations model
  - NiagaBot integration
  - Operator UX improvements
- **Status:** ⚠️ **In Progress** - Needs rebranding

---

### **Modules (Priority 2)**

#### 3. **GANGCLAWCITY Lab**
- **Based on:** `ai-town/` upstream
- **Purpose:** Experimentation and R&D
- **Status:** 📋 **Planned**

#### 4. **GANGCLAWCITY Office**
- **Based on:** `Star-Office-UI/` upstream
- **Purpose:** Internal workflow management
- **Status:** 📋 **Planned**

#### 5. **GANGCLAWCITY Workspace**
- **Based on:** `pixel-agents/` upstream
- **Purpose:** Developer tooling
- **Status:** 📋 **Planned**

---

## 🏗️ PROJECT STRUCTURE

```
GANGCLAWCITY/
│
├── 📄 ROOT (GANGCLAWCITY Landing & Docs)
│   ├── index.html, style.css, script.js (Static landing page)
│   ├── QWEN.md (Master context)
│   ├── README.md (This file)
│   └── docs/ (All documentation)
│
├── 🎯 CORE APPS (Priority - GANGCLAWCITY Branded)
│   ├── openclaw-office/ → Becomes GANGCLAWCITY Dashboard
│   └── agent-town/ → Becomes GANGCLAWCITY CityView
│
├── 🧪 UPSTREAM DONORS (To Be Adapted)
│   ├── ai-town/ → Will become GANGCLAWCITY Lab
│   ├── Star-Office-UI/ → Will become GANGCLAWCITY Office
│   └── pixel-agents/ → Will become GANGCLAWCITY Workspace
│
├── 🔧 INFRASTRUCTURE
│   ├── config/docker/ (Docker Compose)
│   ├── config/k8s/ (Kubernetes manifests)
│   ├── security/ (Security audits & policies)
│   └── scripts/ (Automation scripts)
│
└── 🤖 AUTOMATION (8 Scripts Ready)
    ├── gangclaw-agent.bat (Master control)
    ├── security-scan.bat (Token scanner)
    ├── git-push-automated.bat (Safe push)
    └── vercel-deploy-all.bat (Vercel deployment)
```

---

## ⚠️ CURRENT TRUTH (NO FAKE CLAIMS)

### **What's Working:**
- ✅ All 5 upstream repos functional in their original form
- ✅ Documentation organized (Fortune 500 level)
- ✅ Security scanning automated
- ✅ Deployment scripts ready
- ✅ Gateway infrastructure live (`wss://operator.gangniaga.my`)

### **What's NOT Working:**
- ❌ No GANGCLAWCITY-branded apps shipped yet
- ❌ Upstream branding still present in user-facing UIs
- ❌ Gateway tokens exposed in code (CRITICAL - needs rotation)
- ❌ No verified end-to-end production deployment
- ❌ Root `npm` scripts are placeholders

### **What Needs Done:**

**Phase 1 (This Week):**
1. 🔴 Rotate gateway token (CRITICAL)
2. 🔴 Remove hardcoded tokens from all code
3. 🟡 Rebrand `openclaw-office` UI to GANGCLAWCITY Dashboard
4. 🟡 Rebrand `agent-town` UI to GANGCLAWCITY CityView

**Phase 2 (This Month):**
1. 🟡 Create GANGCLAWCITY-specific landing pages for each app
2. 🟡 Implement unified authentication
3. 🟡 Deploy Dashboard + CityView to Vercel
4. 🟡 Write migration guides for each module

**Phase 3 (This Quarter):**
1. 🟢 Absorb remaining 3 modules
2. 🟢 Implement district-based operations
3. 🟢 Launch waitlist and email capture
4. 🟢 First paying customers

---

## 🚀 QUICKSTART

### **For Developers:**

```bash
# 1. Clone the repo
git clone https://github.com/thisisniagahub/GANGCLAWCITY.git
cd GANGCLAWCITY

# 2. Run security scan (ALWAYS first)
.\security-scan.bat

# 3. Start Dashboard (openclaw-office)
pnpm --dir openclaw-office dev

# 4. Start CityView (agent-town)
pnpm --dir agent-town dev

# 5. Start landing page (root)
# Just open index.html in browser
```

### **For Deployment:**

```bash
# Full workflow (DO IN ORDER)
.\security-scan.bat          # Check for tokens
.\git-push-automated.bat     # Push to GitHub
.\vercel-deploy-all.bat      # Deploy to Vercel
```

---

## 🔐 SECURITY (NON-NEGOTIABLE)

**CRITICAL:** Gateway token exposed in 26+ locations

**Immediate Action Required:**
```bash
# 1. Rotate token on VPS
ssh root@<VPS_IP>
openssl rand -hex 32
nano /root/.openclaw/openclaw.json

# 2. Update Vercel environment variables
# VITE_GATEWAY_TOKEN=<NEW_TOKEN>

# 3. Run security scan
.\security-scan.bat
```

**Security Rules:**
- ✅ NEVER commit real tokens to Git
- ✅ ALWAYS use `<GATEWAY_TOKEN>` placeholder in docs
- ✅ Run `security-scan.bat` before EVERY git push
- ✅ Use environment variables, not hardcoded values
- ✅ Rotate tokens every 90 days

---

## 📊 SUCCESS METRICS

### **Technical Metrics:**
| Metric | Current | Target |
|--------|---------|--------|
| Root directory items | 35 | < 25 |
| Documentation organized | 100% | 100% ✅ |
| Exposed tokens | 26+ ⚠️ | 0 |
| Apps with GANGCLAWCITY branding | 0% | 100% |
| Production deployments | 0 | 3 |

### **Business Metrics:**
| Metric | Current | Target |
|--------|---------|--------|
| Landing page live | ✅ Yes | ✅ Yes |
| Dashboard functional | ⚠️ Needs rebrand | ✅ GANGCLAWCITY branded |
| CityView functional | ⚠️ Needs rebrand | ✅ GANGCLAWCITY branded |
| Waitlist capture | ❌ Not ready | ✅ Q2 2026 |
| First paying customer | ❌ None | ✅ Q3 2026 |

---

## 📚 DOCUMENTATION

**Start Here:**
1. [`docs/00-start-here/START_HERE.md`](docs/00-start-here/START_HERE.md) - First-day checklist
2. [`docs/00-start-here/QUICKSTART.md`](docs/00-start-here/QUICKSTART.md) - Local setup commands
3. [`docs/01-architecture/ARCHITECTURE.md`](docs/01-architecture/ARCHITECTURE.md) - Technical design
4. [`docs/02-deployment/DEPLOYMENT_STATUS.md`](docs/02-deployment/DEPLOYMENT_STATUS.md) - Deployment truth

**Full Index:** [`docs/DOCS_INDEX.md`](docs/DOCS_INDEX.md)

---

## 🎯 WHY THIS APPROACH WINS

**Competitor Approach:**
- ❌ Build from zero (takes years)
- ❌ Reinvent everything (waste of resources)
- ❌ No proven track record

**GANGCLAWCITY Approach:**
- ✅ Start with 5 proven successes (already works)
- ✅ Improve what's already good (faster iteration)
- ✅ Focus on Malaysian market (local advantage)
- ✅ Ship in weeks, not years (speed to market)

**The Real Talk:**
> We're not here to pretend we invented AI agents. We're here to **take what already works**, make it **better**, **branded as ours**, and **sell it to Malaysian SMEs** who need practical AI workforce solutions TODAY.

---

## 📞 QUICK REFERENCE

```yaml
Gateway_URL: wss://operator.gangniaga.my
Gateway_Token: <GATEWAY_TOKEN> (ROTATE NOW!)
Session_Key: agent:main:main
VPS_IP: <VPS_IP>
SSH_Command: ssh root@<VPS_IP>

GitHub: https://github.com/thisisniagahub/GANGCLAWCITY
Vercel: Deploying soon

Master_Script: gangclaw-agent.bat
Security_Scan: security-scan.bat
Git_Push: git-push-automated.bat
Vercel_Deploy: vercel-deploy-all.bat
Reorganize: REORGANIZE-AUTO.bat
Upgrade: UPGRADE-ALL.bat
```

---

## 🧠 LICENSE & ATTRIBUTION

**This repository contains:**
- Original GANGCLAWCITY code (MIT License)
- Adapted upstream code (various licenses - see each folder)

**Attribution Requirements:**
- ✅ We MUST preserve original LICENSE files
- ✅ We MUST credit original authors
- ✅ We CANNOT claim we wrote upstream code
- ✅ We CAN rebrand user-facing surfaces
- ✅ We CAN improve and sell as GANGCLAWCITY products

**See each subfolder for specific license terms.**

---

**Last Updated:** March 17, 2026  
**Version:** 4.0.0 (Honest Upstream Declaration)  
**Status:** ⚠️ **In Progress - Token Rotation Required**

---

**🧠 GANGCLAWCITY - Built from Proven Success, Not Zero!**  
**🚀 No Fake Claims. Real Products. Malaysian Market.**
