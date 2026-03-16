# GANGCLAWCITY Architecture

**Honest Truth: Built from Proven Upstream, Not From Zero**

---

## 🚨 UPSTREAM DECLARATION (NO BULLSHIT)

**This is NOT original GANGCLAWCITY code:**

| Folder | Original Upstream | Original Authors | License | What We're Doing |
|--------|------------------|------------------|---------|------------------|
| `openclaw-office/` | WW-AI-Lab/openclaw-office | WW-AI-Lab Team | MIT | Rebrand → GANGCLAWCITY Dashboard |
| `agent-town/` | @geezerrrr/agent-town | @geezerrrr | MIT | Rebrand → GANGCLAWCITY CityView |
| `ai-town/` | Convex examples | Convex Inc | MIT | Adapt → GANGCLAWCITY Lab |
| `Star-Office-UI/` | Python Flask project | Unknown | MIT | Adapt → GANGCLAWCITY Office |
| `pixel-agents/` | pablodelucca/pixel-agents | Pablo De Lucca | MIT | Adapt → GANGCLAWCITY Workspace |

**Legal Requirements:**
- ✅ We MUST preserve original LICENSE files
- ✅ We MUST credit original authors in documentation
- ✅ We CANNOT claim we wrote the upstream code
- ✅ We CAN rebrand user-facing UIs and marketing
- ✅ We CAN improve, modify, and sell as GANGCLAWCITY products

---

## Current State

GANGCLAWCITY is a **rebranding and improvement layer** over proven donor applications, not yet a fully unified product.

### **Core Integration Targets (GANGCLAWCITY Original Products)**

These 2 are our **PRIORITY** - becoming GANGCLAWCITY branded apps:

- `openclaw-office/` → **GANGCLAWCITY Dashboard** (Command Surface)
- `agent-town/` → **GANGCLAWCITY CityView** (Spatial Demo)

### **Donor Modules (To Be Adapted Later)**

These 5 are **NOT core products yet** - will become GANGCLAWCITY modules after adaptation:

- `ai-town/` → Will become **GANGCLAWCITY Lab** (R&D)
- `Star-Office-UI/` → Will become **GANGCLAWCITY Office** (Internal Workflows)
- `pixel-agents/` → Will become **GANGCLAWCITY Workspace** (Dev Tooling)

### **Shared Layers (GANGCLAWCITY Original)**

These are **OUR code** - not upstream:

- Root static landing page (`index.html`, `style.css`, `script.js`)
- `docs/`, `security/`, `skills/`, `config/`, and `scripts/`
- Automation scripts (8 `.bat` files)
- Gateway infrastructure

---

## Main Problem To Solve

The repository still carries:

- ❌ upstream package metadata (needs rebranding)
- ❌ nested repositories (needs documentation)
- ❌ duplicated status reports (needs cleanup)
- ❌ deployment configs that do not match the live tree
- ❌ browser-exposed gateway configuration patterns (CRITICAL security issue)
- ❌ upstream branding in user-facing UIs (needs removal)

---

## Target Platform Shape

**What We're Building:**

```text
GANGCLAWCITY Platform
├── GANGCLAWCITY Dashboard (from openclaw-office)
├── GANGCLAWCITY CityView (from agent-town)
├── GANGCLAWCITY Lab (from ai-town)
├── GANGCLAWCITY Office (from Star-Office-UI)
└── GANGCLAWCITY Workspace (from pixel-agents)
```

**Each product surface should:**
- ✅ Look like one brand (GANGCLAWCITY)
- ✅ Share one documentation standard
- ✅ Converge on one secure gateway model
- ✅ Remove all upstream vendor branding
- ✅ Add Malaysian market localization

---

## Target Runtime Model

```text
Browser UI (GANGCLAWCITY branded)
  -> GANGCLAWCITY app backend or proxy
  -> secured gateway broker
  -> OpenClaw gateway (wss://operator.gangniaga.my)
  -> agents, tools, models, and workflows
```

---

## Non-Negotiable Rules

### **Security:**
- 🔴 Production tokens must not be exposed to browser clients
- 🔴 Gateway tokens must be rotated immediately (CRITICAL)
- 🔴 Environment variables ONLY - no hardcoded tokens

### **Legal:**
- 🔴 Rebranding can change UI and product copy, but it must not remove required license attribution
- 🔴 Original LICENSE files must be preserved in each adapted folder
- 🔴 Attribution must remain in documentation

### **Product:**
- 🔴 `openclaw-office/` and `agent-town/` get priority before the other donor modules
- 🔴 User-facing surfaces must say "GANGCLAWCITY", not upstream names
- 🔴 No fake claims - be honest about upstream origins

---

## Recommended Migration Order

### **Phase 1: Security & Declaration (This Week)**
1. 🔴 Rotate gateway token (CRITICAL)
2. 🔴 Remove hardcoded tokens from all code
3. ✅ Declare upstream origins honestly (DONE - this doc)
4. 🟡 Remove upstream branding from user-facing UIs

### **Phase 2: Core Apps Rebranding (This Month)**
1. Stabilize `openclaw-office/` → Rebrand as GANGCLAWCITY Dashboard
2. Stabilize `agent-town/` → Rebrand as GANGCLAWCITY CityView
3. Create GANGCLAWCITY-specific landing pages
4. Deploy to Vercel with GANGCLAWCITY branding

### **Phase 3: Module Absorption (This Quarter)**
1. Fold in `Star-Office-UI/` → GANGCLAWCITY Office
2. Fold in `ai-town/` → GANGCLAWCITY Lab
3. Reposition `pixel-agents/` → GANGCLAWCITY Workspace
4. Unified authentication across all apps

---

## Architecture Layers

**What's Ours vs What's Upstream:**

```
┌─────────────────────────────────────────┐
│  GANGCLAWCITY Landing Page              │ ← OURS (Original)
│  (index.html, style.css, script.js)     │
├─────────────────────────────────────────┤
│  GANGCLAWCITY Dashboard                 │ ← REBRANDING (from openclaw-office)
│  (Command Surface)                      │
├─────────────────────────────────────────┤
│  GANGCLAWCITY CityView                  │ ← REBRANDING (from agent-town)
│  (Spatial Operations)                   │
├─────────────────────────────────────────┤
│  GANGCLAWCITY Lab                       │ ← PLANNED (from ai-town)
│  (R&D, Experiments)                     │
├─────────────────────────────────────────┤
│  GANGCLAWCITY Office                    │ ← PLANNED (from Star-Office-UI)
│  (Internal Workflows)                   │
├─────────────────────────────────────────┤
│  GANGCLAWCITY Workspace                 │ ← PLANNED (from pixel-agents)
│  (Dev Tooling)                          │
├─────────────────────────────────────────┤
│  Gateway Infrastructure                 │ ← OURS (Original)
│  (wss://operator.gangniaga.my)          │
└─────────────────────────────────────────┘
```

---

## Current Status Summary

| Component | Origin | Status | Next Action |
|-----------|--------|--------|-------------|
| Landing Page | GANGCLAWCITY Original | ✅ Live | Add email capture |
| Dashboard | openclaw-office upstream | ⚠️ Needs Rebrand | Remove upstream branding |
| CityView | agent-town upstream | ⚠️ Needs Rebrand | Remove upstream branding |
| Lab | ai-town upstream | 📋 Planned | Assess & adapt |
| Office | Star-Office-UI upstream | 📋 Planned | Assess & adapt |
| Workspace | pixel-agents upstream | 📋 Planned | Assess & adapt |
| Gateway | GANGCLAWCITY Original | ✅ Live | 🔴 Rotate token |
| Docs | GANGCLAWCITY Original | ✅ Complete | Keep updated |
| Scripts | GANGCLAWCITY Original | ✅ Complete | Keep maintained |

---

## Success Criteria

**Phase 1 Complete When:**
- ✅ Token rotated
- ✅ No hardcoded tokens in code
- ✅ Upstream declared honestly

**Phase 2 Complete When:**
- ✅ Dashboard says "GANGCLAWCITY", not "OpenClaw"
- ✅ CityView says "GANGCLAWCITY", not "Agent Town"
- ✅ Both deployed to Vercel with GANGCLAWCITY branding
- ✅ Upstream attribution preserved in docs

**Phase 3 Complete When:**
- ✅ All 5 modules absorbed
- ✅ Unified authentication
- ✅ District-based operations live
- ✅ First paying customers

---

**Last Updated:** March 17, 2026  
**Version:** 2.0.0 (Honest Upstream Declaration)  
**Status:** ⚠️ **In Progress - Token Rotation Required**

---

**🧠 GANGCLAWCITY Architecture - Built from Proven Success, Not Zero!**  
**🚨 No Fake Claims. Real Products. Honest Origins.**
