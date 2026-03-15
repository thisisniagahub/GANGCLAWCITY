# 📋 GANGCLAWCITY Quick Reference

**Version:** 2.0.0  
**Last Updated:** March 14, 2026  
**Purpose:** Fast navigation for reorganized structure

---

## 🎯 Find What You Need Fast

### **New to GANGCLAWCITY?**
```
Start Here → /docs/00-start-here/README.md
Quick Start → /docs/00-start-here/QUICKSTART.md
```

### **Deploying?**
```
Vercel Deploy → /docs/02-deployment/VERCEL_AUTO_DEPLOY.md
VPS Deploy → /docs/02-deployment/VPS_DEPLOYMENT.md
Quick Deploy → /docs/02-deployment/DEPLOY_NOW.md
```

### **Architecture?**
```
System Design → /docs/01-architecture/ARCHITECTURE.md
Roadmap → /docs/01-architecture/ROADMAP.md
```

### **Integrating?**
```
OpenClaw → /docs/03-integration/OPENCLAW_INTEGRATION.md
NiagaBot → /docs/03-integration/NIAGABOT_INTEGRATION_PLAN.md
```

### **Security?**
```
Security Audit → /security/SECURITY_AUDIT_2026-03-14.md
API Keys → /security/API_KEY_SECURITY.md
```

### **Brand?**
```
Brand Guidelines → /docs/05-brand/BRANDKIT.md
Logo Usage → /docs/05-brand/LOGO_FILES.md
Assets → /docs/05-brand/BRAND_ASSETS.html
```

---

## 📁 Directory Map

```
GANGCLAWCITY/
│
├── 📖 Documentation → /docs/
├── ⚙️  Configurations → /config/
├── 🛠️  Scripts → /scripts/
├── 🔒 Security → /security/
├── 🏗️  Infrastructure → /infrastructure/
├── 📦 Applications → /apps/ (agent-town/, openclaw-office/, etc.)
│
└── 📄 Critical Files (Root)
    ├── QWEN.md ⚠️ CRITICAL: Master context
    ├── LICENSE
    ├── .gitignore
    └── REORGANIZATION_REPORT.md
```

---

## 🔐 Security Alert

**⚠️ CRITICAL:** Gateway token exposed in documentation!

**Action Required:**
1. Read `/security/SECURITY_AUDIT_2026-03-14.md`
2. Rotate token immediately
3. Remove hardcoded tokens from code
4. Update all environment variables

---

## 📊 Documentation Categories

| Number | Category | Files | Purpose |
|--------|----------|-------|---------|
| 00 | Start Here | 4 | Newcomer guides |
| 01 | Architecture | 3 | System design |
| 02 | Deployment | 9 | Deploy guides |
| 03 | Integration | 5 | API integration |
| 04 | Research | 6 | Market research |
| 05 | Brand | 4 | Brand assets |
| 06 | Contributing | 1 | How to help |
| 07 | Skills | 4 | OpenClaw skills |
| 08 | Testing | 3 | Test reports |
| 99 | Legacy | 2 | Archived docs |

---

## 🚀 Common Commands

### **Development**
```bash
# Landing Page
cd landing-page && pnpm dev

# Dashboard
cd openclaw-office && pnpm dev

# Demo
cd agent-town && pnpm dev
```

### **Deployment**
```bash
# Run deployment script
/scripts/deployment/deploy.bat

# Git push
/scripts/deployment/git-push.bat
```

### **Setup**
```bash
# Full setup
/scripts/setup/SETUP_AND_RUN.bat
```

---

## 📞 Quick Links

| Resource | Location |
|----------|----------|
| Full Documentation Index | `/docs/DOCS_INDEX.md` |
| Reorganization Report | `/REORGANIZATION_REPORT.md` |
| Security Audit | `/security/SECURITY_AUDIT_2026-03-14.md` |
| Master Context | `/QWEN.md` |

---

## 🎯 What Stayed in Root

**Keep These:**
- ✅ `QWEN.md` - Critical master context
- ✅ `LICENSE` - Legal requirement
- ✅ `.gitignore` - Git rules
- ✅ `REORGANIZATION_REPORT.md` - This reorganization

**Moved:**
- ❌ All other `.md` files → `/docs/`
- ❌ Config files → `/config/`
- ❌ Scripts → `/scripts/`

---

## 📈 Structure Benefits

**Before:**
- 61 items in root
- Scattered documentation
- No security folder
- Mixed configs

**After:**
- 18 items in root (70% reduction)
- Organized documentation
- Security audit completed
- Centralized configs

---

*Quick Reference - GANGCLAWCITY*  
*Built with ❤️ in Malaysia 🇲🇾*
