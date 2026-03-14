---
name: openclaw-expert
description: PAKAR OPENCLAW - Setup, konfigurasi, troubleshooting, multi-agent workflows, security hardening, optimization OpenClaw gateway
version: 1.0.0
author: GANGCLAWCITY Community
metadata: {"openclaw":{"emoji":"🦞","requires":{"bins":["node","npm"],"os":["linux","darwin","win32"]}}}
user-invocable: true
---

# OpenClaw Expert - Pakar Lengkap OpenClaw

## 🎯 Apa Skill Ini

Saya adalah **PAKAR OPENCLAW** anda — assistant yang menguasai sepenuhnya:
- Setup & installation OpenClaw
- Configuration & optimization
- Multi-agent workflows & orchestration
- Security hardening best practices
- Troubleshooting & debugging
- Skills development (SKILL.md pattern)
- ClawHub publishing
- Integration dengan tools lain

**Guna skill ini bila:**
- Nak install OpenClaw untuk pertama kali
- Ada masalah configuration atau connection
- Nak setup multi-agent workflows
- Nak create skills sendiri (SKILL.md)
- Nak optimize cost & performance
- Ada security concerns
- Nak publish skills ke ClawHub

---

## 📦 Prerequisites

### System Requirements
```bash
# Node.js
Node.js >= 22 (Node 24 recommended)

# Package Manager
pnpm (preferred), npm, atau bun

# RAM
1GB+ (Mac/Linux/Windows WSL2)

# Optional
Docker (untuk sandboxing)
Tailscale (untuk remote access)
```

### Quick Check
```bash
# Verify Node.js version
node --version  # Should be v22+

# Verify package manager
pnpm --version  # or npm --version

# Check if port 18789 is available
netstat -an | grep 18789  # Should be free
```

---

## 🚀 Installation Guide

### Method 1: One-Liner (Recommended untuk Beginners)
```bash
# macOS/Linux
curl -fsSL https://openclaw.ai/install.sh | bash

# Windows (PowerShell)
iwr https://openclaw.ai/install.ps1 -useb | iex
```

**Apa script ini buat:**
- Auto-detect platform (macOS/Windows/Linux)
- Install Node.js jika belum ada
- Install OpenClaw globally
- Run onboarding wizard

### Method 2: NPM Global Install
```bash
# Install latest version
npm install -g openclaw@latest

# Atau dengan pnpm
pnpm add -g openclaw@latest

# Verify installation
openclaw --version
```

### Method 3: Git Clone (Untuk Hackers)
```bash
# Clone repository
git clone https://github.com/openclaw/openclaw.git
cd openclaw

# Install dependencies
pnpm install

# Build
pnpm build

# Run onboarding
pnpm openclaw onboard --install-daemon

# Dev mode (auto-reload)
pnpm gateway:watch
```

### Method 4: Docker
```bash
# Docker Compose (recommended)
docker-compose up -d

# Manual setup
./docker-setup.sh

# View logs
docker-compose logs -f
```

---

## ⚙️ Configuration Deep Dive

### Config Location
```bash
# Main config file
~/.openclaw/openclaw.json

# Workspace skills
~/.openclaw/workspace/skills/

# Managed skills
~/.openclaw/skills/

# Logs
~/.openclaw/logs/
```

### Minimal Config (Quick Start)
```json
{
  "agent": {
    "model": "anthropic/claude-sonnet-4-20250514"
  }
}
```

### Production-Ready Config
```json
{
  "agent": {
    "defaults": {
      "model": {
        "primary": "anthropic/claude-sonnet-4-20250514",
        "thinking": "anthropic/claude-opus-4-5-20250514"
      },
      "sandbox": {
        "mode": "non-main"
      }
    }
  },
  "channels": {
    "whatsapp": {
      "allowFrom": ["+60123456789"],
      "groups": {
        "*": {
          "requireMention": true,
          "dmPolicy": "pairing"
        }
      }
    },
    "telegram": {
      "allowFrom": ["@username"],
      "dmPolicy": "pairing"
    }
  },
  "gateway": {
    "bind": "127.0.0.1",
    "port": 18789,
    "auth": {
      "mode": "password"
    },
    "tailscale": {
      "mode": "serve"
    }
  },
  "skills": {
    "load": {
      "watch": true,
      "watchDebounceMs": 500
    }
  },
  "messages": {
    "groupChat": {
      "mentionPatterns": ["@openclaw", "@claw"]
    },
    "usage": {
      "footer": "tokens"
    }
  }
}
```

### Config Sections Explained

#### 1. Agent Configuration
```json
{
  "agent": {
    "defaults": {
      "model": {
        "primary": "claude-sonnet",      // Untuk general tasks
        "thinking": "claude-opus"        // Untuk complex reasoning
      },
      "sandbox": {
        "mode": "non-main"               // Sandboxing untuk group sessions
      }
    }
  }
}
```

**Model Tiers (Cost Optimization):**
| Tier | Models | Use Case | Cost (per 1M tokens) |
|------|--------|----------|---------------------|
| Tier 1 | MiniMax M2.5, GLM-4.7 Flash | File reads, simple code | $0.07-0.30 |
| Tier 2 | Claude Sonnet 4, GPT-4o | Multi-file edits, debugging | $3-15 |
| Tier 3 | Claude Opus 4.5, GPT-5 | Complex architecture | $15-75 |

#### 2. Channel Security
```json
{
  "channels": {
    "whatsapp": {
      "allowFrom": ["+60123456789"],    // Only allow specific numbers
      "groups": {
        "*": {
          "requireMention": true,        // Must mention bot in groups
          "dmPolicy": "pairing"          // Require approval code for DMs
        }
      }
    }
  }
}
```

**DM Policy Options:**
- `"pairing"` (default) — Unknown senders get approval code
- `"open"` — Anyone can message (use with allowlist)
- `"closed"` — No DMs allowed

#### 3. Gateway Settings
```json
{
  "gateway": {
    "bind": "127.0.0.1",                // Bind to localhost only
    "port": 18789,                       // Default port
    "auth": {
      "mode": "password"                 // Password auth for remote access
    },
    "tailscale": {
      "mode": "serve"                    // Tailnet-only HTTPS
    }
  }
}
```

**Tailscale Modes:**
- `"off"` — No Tailscale automation (default)
- `"serve"` — Tailnet-only HTTPS via `tailscale serve`
- `"funnel"` — Public HTTPS via `tailscale funnel` (requires password auth)

---

## 🔐 Security Hardening Checklist

### Critical Security Measures

#### 1. Isolate Runtime
```bash
# Run in Docker container (recommended for production)
docker run -d \
  --name openclaw \
  -v ~/.openclaw:/root/.openclaw \
  -p 127.0.0.1:18789:18789 \
  openclaw/openclaw:latest

# Atau run in VM
# Separate machine untuk production use
```

#### 2. Least Privilege
```json
{
  "channels": {
    "whatsapp": {
      "allowFrom": ["+60123456789"]     // Specific numbers only
    }
  },
  "agents": {
    "defaults": {
      "sandbox": {
        "mode": "non-main",             // Docker sandbox for groups
        "allowlist": ["bash", "read", "write"],
        "denylist": ["browser", "nodes", "cron"]
      }
    }
  }
}
```

#### 3. Network Lockdown
```json
{
  "gateway": {
    "bind": "127.0.0.1",                // NEVER bind to 0.0.0.0
    "port": 18789,
    "tailscale": {
      "mode": "serve"                   // Tailnet-only access
    }
  }
}
```

**⚠️ WARNING:** Jangan expose port 18789 ke public internet tanpa:
- Password authentication
- Tailscale tunnel
- Reverse proxy dengan auth

#### 4. Vet Skills
```bash
# Before installing any skill
cd ~/.openclaw/skills/<skill-name>
cat SKILL.md                          # Read thoroughly
ls -la scripts/                       # Check for malicious scripts
grep -r "curl\|wget\|eval" .          # Look for dangerous commands

# Install from trusted sources only
clawhub install <skill> --verify
```

#### 5. Rotate Credentials
```bash
# Set up monitoring
tail -f ~/.openclaw/logs/gateway.log

# Rotate API keys regularly
# Update in config after rotation
```

### Security Red Flags 🚩

**Jangan install skill jika:**
- ❌ Ada obfuscated shell commands
- ❌ Require paste secrets into chat
- ❌ Request excessive permissions
- ❌ No author information
- ❌ Hardcoded credentials
- ❌ Misspelled package names (e.g., `claw__d__hub` vs `clawhub`)

---

## 🤖 Multi-Agent Workflows

### Pattern 1: Two-Tier Model Routing (Cost Optimization)

**Config:**
```json
{
  "agents": {
    "defaults": {
      "model": {
        "primary": "anthropic/claude-sonnet-4-20250514",
        "thinking": "anthropic/claude-opus-4-5-20250514"
      }
    }
  }
}
```

**How it works:**
- `primary` → General work (file ops, simple code, docs) — **$3/M tokens**
- `thinking` → Auto-triggers for complex reasoning — **$75/M tokens**

**Cost Savings:** 60-80% vs single-tier Opus

### Pattern 2: Three-Tier Production Setup

**Manual Model Switching:**
```bash
# Switch model mid-session
/model haimaker/minimax-m2.5      # Cheap model for file reads
/model anthropic/claude-opus-4-5  # Expensive model for complex tasks
```

**Three-Tier Config:**
```json
{
  "models": {
    "providers": {
      "haimaker": {
        "baseUrl": "https://api.haimaker.ai/v1",
        "apiKey": "${HAIMAKER_API_KEY}",
        "models": [
          { "id": "auto", "name": "Haimaker Auto-Router" }
        ]
      }
    }
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "haimaker/auto"
      }
    }
  }
}
```

**Tier Allocation:**
| Tier | Models | Volume | Cost |
|------|--------|--------|------|
| Tier 1 | MiniMax M2.5, GLM-4.7 Flash | 80% | $0.07-0.30/M |
| Tier 2 | Claude Sonnet 4, GPT-4o | 15% | $3-15/M |
| Tier 3 | Claude Opus 4.5, GPT-5 | 5% | $15-75/M |

**Total Cost:** ~$3.50/day vs $75/day (95% savings!)

### Pattern 3: Parent + Sub-Agents Orchestration

**Workflow Example: Content Pipeline**

```
[User Request] → [Project Coordinator Agent]
                      ↓ (spawns sub-agents)
         ┌────────────┼────────────┐
         ↓            ↓            ↓
   [SEO Research] [Writer] [Image Designer]
         ↓            ↓            ↓
         └────────────┼────────────┘
                      ↓
              [Aggregated Response]
```

**Implementation:**
```bash
# Terminal 1: SEO Research Agent (cheap model)
openclaw --model haimaker/minimax-m2.5 \
  "Research keywords for 'AI automation' and create content brief in SEO_BRIEF.md"

# Terminal 2: Writer Agent (mid-tier model)
openclaw --model anthropic/claude-sonnet-4 \
  "Read SEO_BRIEF.md and write 2,500 word blog post in BLOG_DRAFT.md"

# Terminal 3: Image Designer (expensive model for creative)
openclaw --model anthropic/claude-opus-4-5 \
  "Read BLOG_DRAFT.md and generate DALL-E 3 prompt for hero image"
```

### Pattern 4: Agent-to-Agent Handoffs (Filesystem Coordination)

**Use Case: Large Codebase Refactoring**

```bash
# Step 1: Research Agent (distill context)
openclaw --model haimaker/minimax-m2.5 \
  "Read entire /src/auth directory, summarize architecture to AUTH_CONTEXT.md"

# Step 2: Implementation Agent (execute changes)
openclaw --model anthropic/claude-opus-4-5 \
  "Read AUTH_CONTEXT.md, refactor session handling, run tests after each change"

# Step 3: QA Agent (verify changes)
openclaw --model anthropic/claude-sonnet-4 \
  "Review changes in /src/auth, run full test suite, report any failures"
```

**Benefits:**
- Avoids feeding 200K+ tokens through expensive model
- Research agent does heavy lifting (cheap)
- Implementation agent focuses on execution (expensive but efficient)

---

## 🛠️ Troubleshooting Guide

### Common Issues & Solutions

#### Issue 1: Gateway Won't Start
```bash
# Check if port 18789 is in use
netstat -an | grep 18789

# Kill process using port (Windows)
netstat -ano | findstr :18789
taskkill /PID <PID> /F

# Or change port
openclaw gateway --port 18790
```

#### Issue 2: WhatsApp Not Connecting
```bash
# Re-login to WhatsApp
openclaw channels logout whatsapp
openclaw channels login whatsapp

# Check QR code in Control UI
# Open http://127.0.0.1:18789/channels/whatsapp
```

#### Issue 3: Skills Not Loading
```bash
# Check skill eligibility
openclaw skills list --verbose

# Verify skill structure
ls -la ~/.openclaw/skills/<skill>/
# Should have SKILL.md in root

# Check metadata (must be single-line JSON)
cat ~/.openclaw/skills/<skill>/SKILL.md | head -5

# Reload skills
openclaw skills reload
```

#### Issue 4: High Token Usage
```bash
# Check which skills are active
openclaw skills list --eligible

# Disable unused skills
# Edit config: set "disable-model-invocation": true

# Switch to cheaper model
/model haimaker/minimax-m2.5

# Enable usage tracking
openclaw config set messages.usage.footer tokens
```

#### Issue 5: Sandboxing Issues
```bash
# Check sandbox mode
openclaw config get agents.defaults.sandbox.mode

# If "non-main", group sessions run in Docker
# Verify Docker is running
docker ps

# Check sandbox allowlist
openclaw config get agents.defaults.sandbox.allowlist
```

#### Issue 6: Remote Access Not Working
```bash
# Verify Tailscale is running
tailscale status

# Check Tailscale mode in config
openclaw config get gateway.tailscale.mode

# If "serve", get URL
tailscale serve status

# If "funnel", ensure password auth is enabled
openclaw config get gateway.auth.mode
```

### Debug Commands

```bash
# Full system check
openclaw doctor

# Gateway logs
openclaw gateway logs --follow

# Channel status
openclaw channels status

# Session info
openclaw sessions list

# Skill eligibility
openclaw skills list --verbose

# Config validation
openclaw config validate

# Network connectivity
openclaw network test
```

---

## 📝 Creating Custom Skills (SKILL.md Pattern)

### SKILL.md Structure

**Minimum Valid Structure:**
```markdown
---
name: my-skill
description: Clear, specific description for model matching.
metadata: {"openclaw":{"emoji":"🔧","requires":{"bins":["bash"],"os":["linux","darwin"]}}}
---

# Skill Name

## What it does
One paragraph description.

## Inputs needed
- REQUIRED_VAR: description
- OPTIONAL_VAR: description

## Workflow
1. Step 1
2. Step 2
3. Step 3

## Guardrails
- Never do X
- Always verify Y
- Stop after Z

## Failure handling
- If command fails, show error and stop
- If data missing, state what's missing
```

### Production-Ready Template

```markdown
---
name: disk-cleanup-helper
description: Clean temporary files and free disk space safely.
metadata: {"openclaw":{"emoji":"🧹","requires":{"bins":["df","rm","find"],"os":["linux","darwin"]}}}
user-invocable: true
---

# Disk Cleanup Helper

## What it does
Safely cleans temporary files to free disk space. Reports before/after usage.

## Inputs needed
- TARGET_DIR: Directory to clean (default: /tmp)
- DRY_RUN: If true, only show what would be deleted (default: false)

## Workflow
1. Check disk usage before cleanup with `df -h TARGET_DIR`
2. Find temp files older than 7 days: `find TARGET_DIR -type f -mtime +7`
3. If DRY_RUN=true, list files without deleting
4. If DRY_RUN=false, delete files and report count
5. Check disk usage after cleanup
6. Report space freed

## Guardrails
- Never delete files newer than 7 days
- Never delete files in /var/log or /etc
- Never delete files owned by root
- Stop if disk usage doesn't decrease
- Ask for confirmation before deleting >1GB

## Failure handling
- If `find` fails, show exact error and stop
- If `rm` fails, list which files couldn't be deleted
- If disk usage increases, report anomaly and stop

## Examples
User: "Clean /tmp"
Assistant: "Found 1.2GB in temp files. Delete? [y/n]"

User: "Dry run cleanup in /var/tmp"
Assistant: "Would delete 500MB in 23 files. No changes made."
```

### Metadata Fields Reference

**Required:**
- `name` — Skill identifier (must be unique)
- `description` — Controls discoverability & model matching

**Recommended:**
- `metadata.openclaw.emoji` — Visual identifier in UI (e.g., `"🔧"`)
- `user-invocable` — Shows in slash command menu (`true`/`false`)

**Gating (via metadata):**
```json
{
  "metadata": {
    "openclaw": {
      "emoji": "🔧",
      "requires": {
        "bins": ["bash", "jq", "curl"],      // Required binaries
        "os": ["linux", "darwin"],            // Supported OS
        "env": ["API_KEY", "DATABASE_URL"]    // Required env vars
      }
    }
  }
}
```

**⚠️ Critical:** `metadata` must be **single-line JSON**. Multi-line JSON causes parser failures!

### Gating Mechanism

**How Gating Works:**
OpenClaw filters skills at load time based on:
1. Environment (OS, architecture)
2. Config settings
3. Binaries present on PATH
4. Environment variables

**Debug Gating:**
```bash
# List all skills
openclaw skills list

# Show only eligible skills
openclaw skills list --eligible

# Show missing requirements
openclaw skills list --verbose

# Check specific skill
openclaw skills info my-skill
```

**Common Gating Examples:**
```json
// OS gating (Linux/Mac only)
"requires": {"os": ["linux", "darwin"]}

// Binary gating (requires specific tools)
"requires": {"bins": ["df", "ps", "uptime"]}

// Environment variable gating
"requires": {"env": ["API_KEY", "DATABASE_URL"]}

// Combined gating
"requires": {
  "bins": ["bash"],
  "os": ["linux"],
  "env": ["LOG_DIR"]
}
```

### Hot Reload

**Enable Skill Watching:**
```json
{
  "skills": {
    "load": {
      "watch": true,
      "watchDebounceMs": 500
    }
  }
}
```

**Iteration Workflow:**
1. Run the skill
2. Identify where it went wrong
3. Edit `SKILL.md`
4. Run again on next turn (no restart needed!)

**If Changes Don't Take Effect:**
1. Confirm `skills.load.watch: true` in config
2. Start a **new agent session** (some environments cache skills snapshot)
3. Run `openclaw skills check` to verify reload

### Testing Skills

**Testing Workflow:**
```bash
# 1. Verify skill is detected
openclaw skills list

# 2. Check eligibility
openclaw skills list --eligible

# 3. Inspect requirements
openclaw skills info my-skill

# 4. Test in chat
# Run via slash command: /my-skill
# Or natural language trigger

# 5. Review execution
# Check for command failures, missing data, guardrail violations
```

**Common Test Scenarios:**

| Test | What to Verify |
|------|----------------|
| Missing input | Skill asks for required paths/credentials |
| Missing binary | Skill reports missing requirement gracefully |
| Command failure | Skill shows error text and stops |
| Data missing | Skill states what's missing (no fabrication) |
| Output format | Results match specified format exactly |

---

## 📦 Publishing to ClawHub

### Pre-Publish Checklist

```markdown
## Before Publishing

- [ ] SKILL.md has clear name and specific description
- [ ] metadata is single-line JSON
- [ ] requires.bins lists only necessary binaries
- [ ] requires.os matches tested platforms
- [ ] Guardrails prevent destructive actions
- [ ] No secrets or hardcoded credentials
- [ ] Output format is deterministic
- [ ] Failure handling is documented
- [ ] Examples show expected behavior
- [ ] Tested on sandbox/disposable machine
```

### Distribution Options

| Method | Best For | Tradeoffs |
|--------|----------|-----------|
| Git repo (private) | Team skills | Simple, auditable, manual install |
| ClawHub (public) | Community skills | Discoverable, requires open-source standards |
| npm package | Enterprise distribution | Convenient for orgs with existing npm infra |

### Publishing to ClawHub

**ClawHub Repository:** https://github.com/openclaw/clawhub

**Requirements:**
- Clear README
- No secrets in code
- Explicit `requires` list
- Safe defaults
- Guardrails against extra actions

**Security Warning:**
> ⚠️ **Real threat:** In early 2026, malicious OpenClaw skills were distributed through ClawHub, including skills that attempted to install infostealers. **Always review before installing.**

---

## 💰 Cost Optimization

### Model Tier Strategy

**Without Optimization:**
```json
{
  "agent": {
    "model": "anthropic/claude-opus-4-5"  // $75/M tokens
  }
}
```
**Daily Cost:** $75 for 1M tokens  
**Monthly Cost:** $2,250

**With Three-Tier Routing:**
```json
{
  "models": {
    "providers": {
      "haimaker": {
        "baseUrl": "https://api.haimaker.ai/v1",
        "apiKey": "${HAIMAKER_API_KEY}",
        "models": [{ "id": "auto", "name": "Auto-Router" }]
      }
    }
  },
  "agents": {
    "defaults": {
      "model": { "primary": "haimaker/auto" }
    }
  }
}
```

**Tier Allocation:**
- Tier 1 (80%): MiniMax M2.5 @ $0.30/M = $0.24
- Tier 2 (15%): Claude Sonnet @ $15/M = $2.25
- Tier 3 (5%): Claude Opus @ $75/M = $3.75

**Daily Cost:** $3.50 for 1M tokens  
**Monthly Cost:** $105  
**Savings:** **95% ($2,145/month!)**

### Manual Cost Control

```bash
# Check current model
/model

# Switch to cheap model for simple tasks
/model haimaker/minimax-m2.5

# Switch to expensive model for complex tasks
/model anthropic/claude-opus-4-5

# Enable usage tracking
openclaw config set messages.usage.footer tokens

# View session cost
openclaw sessions cost
```

### Token Efficiency Tips

1. **Keep skills lean** — Under 500 lines in SKILL.md
2. **Use reference files** — Move details to `references/` folder
3. **Disable unused skills** — `disable-model-invocation: true`
4. **Use two-tier routing** — Let OpenClaw auto-decide model
5. **Compact sessions regularly** — `/compact` command

---

## 🎯 Use Cases by Industry

### 1. Marketing Agencies
**Workflow:** Content pipeline automation

**Agents:**
- SEO Strategist (keyword research, SERP analysis)
- Blog Writer (long-form content)
- Image Designer (DALL-E 3)
- Social Media Agent (scheduling)
- Project Coordinator (orchestration)

**Results:** 4 blogs/week + social content  
**Time Saved:** 15-20 hours/week  
**Cost:** $50-200/month API

### 2. Software Development
**Workflow:** Sprint coordination & code review

**Agents:**
- Sprint Coordinator (daily standups)
- Code Review Prep (PR analysis)
- Documentation Agent (API docs)
- QA Checklist (test generation)
- Client Reporting (weekly metrics)

### 3. Founders/Indie Builders
**Workflow:** Personal assistant + coding helper

**Agents:**
- Personal Assistant (inbox, calendar)
- Research Agent (competitive analysis)
- Coding Agent (bug fixes, features)
- Email Drafter (investor updates)

**User Testimonial:**
> "It's running my company." — @therno

### 4. DevOps/IT
**Workflow:** System monitoring & remediation

**Agents:**
- Health Check Agent (scheduled checks)
- Alert Handler (PagerDuty/Sentry webhooks)
- Remediation Agent (auto-fix common issues)

**User Testimonial:**
> "Autonomously running tests on my app and capturing errors through a sentry webhook then resolving them and opening PRs... The future is here." — @nateliason

---

## 📚 Quick Reference Commands

### Installation & Setup
```bash
# Install
npm install -g openclaw@latest

# Onboard
openclaw onboard --install-daemon

# Start gateway
openclaw gateway --port 18789

# Check status
openclaw status
```

### Channel Management
```bash
# Login to channel
openclaw channels login whatsapp

# Logout
openclaw channels logout whatsapp

# Check status
openclaw channels status

# List channels
openclaw channels list
```

### Session Management
```bash
# List sessions
openclaw sessions list

# Reset session
openclaw sessions reset

# Compact context
openclaw sessions compact

# View cost
openclaw sessions cost
```

### Skills Management
```bash
# List skills
openclaw skills list

# List eligible skills
openclaw skills list --eligible

# Show missing requirements
openclaw skills list --verbose

# Check specific skill
openclaw skills info <skill-name>

# Reload skills
openclaw skills reload

# Install from ClawHub
clawhub install <skill-slug>

# Uninstall
clawhub uninstall <skill-slug>
```

### Chat Commands (Send in any channel)
```
/status          — Compact session status (model + tokens, cost)
/new or /reset   — Reset the session
/compact         — Compact session context (summary)
/think <level>   — Set thinking level: off|minimal|low|medium|high|xhigh
/verbose on|off  — Toggle verbose output
/usage off|tokens|full — Per-response usage footer
/restart         — Restart gateway (owner-only in groups)
/activation mention|always — Group activation toggle
```

### Configuration
```bash
# Get config value
openclaw config get <key>

# Set config value
openclaw config set <key> <value>

# Validate config
openclaw config validate

# Edit config manually
openclaw config edit
```

### Debugging
```bash
# Full system check
openclaw doctor

# Gateway logs
openclaw gateway logs --follow

# Network test
openclaw network test

# Skill check
openclaw skills check
```

---

## 🔗 Resources & Documentation

### Official Resources
- **Website:** https://openclaw.ai
- **GitHub:** https://github.com/openclaw/openclaw (310k ⭐)
- **Documentation:** https://docs.openclaw.ai
- **ClawHub:** https://github.com/openclaw/clawhub
- **Discord:** Community server
- **Install Script:** https://openclaw.ai/install.sh

### Key Documentation Pages
- **Getting Started:** Installation + onboarding
- **Configuration Reference:** All keys with examples
- **Gateway Runbook:** Operational guide
- **Security Guide:** Full security model + hardening
- **Multi-Agent Workflows:** Orchestration patterns
- **Platform Guides:** Windows, Linux, macOS, iOS, Android
- **Troubleshooting:** Debug common failures
- **CLI Reference:** All commands
- **Skills Guide:** Creating & publishing skills

### Community Resources
- **Brilworks Blog:** "What Is OpenClaw?" — agency use case
- **Haimaker Blog:** "Multi-Agent Workflows" — cost optimization
- **Reddit:** r/openclaw — community discussions
- **Showcase:** Community projects

---

## ⚠️ Security Reality Check

> **Critical distinction:** Chatbots can be wrong (annoying). **Agents can be wrong AND take actions** with persistent credentials.

**Microsoft's Guidance:**
> "OpenClaw should be treated like **untrusted code execution with persistent credentials** — not appropriate for standard personal/enterprise workstations."

### Hardening Checklist
- 🛡️ **Isolate runtime:** VM/container or separate machine
- 🔐 **Least privilege:** Separate accounts, narrow OAuth scopes
- 🚫 **Lock down networking:** Bind to loopback only
- ✅ **Vet skills/plugins:** Treat like executable code
- 🔄 **Rotate credentials:** Logging, alerts, rebuild plan

---

## 🎯 When to Use This Skill

**Guna skill ini bila:**

1. ✅ **First-time setup** — Nak install OpenClaw untuk pertama kali
2. ✅ **Configuration help** — Ada masalah config atau connection
3. ✅ **Multi-agent workflows** — Nak setup parent + sub-agents
4. ✅ **Cost optimization** — Nak reduce LLM costs dengan model routing
5. ✅ **Create custom skills** — Nak buat SKILL.md sendiri
6. ✅ **Troubleshooting** — Ada issues yang tak tahu solve
7. ✅ **Security hardening** — Nak secure production deployment
8. ✅ **Publish to ClawHub** — Nak publish skills ke marketplace

**Jangan guna bila:**

1. ❌ **Simple questions** — Guna model primary je cukup
2. ❌ **Quick tasks** — File reads, simple code — model tier 1 cukup
3. ❌ **Non-OpenClaw topics** — Skill ini specific untuk OpenClaw sahaja

---

## 📊 Key Takeaways

### OpenClaw Strengths
| Feature | Status |
|---------|--------|
| **Self-hosted gateway** | ✅ 20+ channels, 1 runtime |
| **Multi-agent orchestration** | ✅ Parent + sub-agents |
| **Persistent memory** | ✅ Across sessions |
| **Tool use** | ✅ Browser, files, APIs, cron |
| **Cost optimization** | ✅ 95% savings with 3-tier routing |
| **Security hardening** | ✅ Sandboxing, TCC, pairing |
| **Skills platform** | ✅ ClawHub marketplace |
| **Model flexibility** | ✅ Claude, GPT, Gemini, MiniMax, GLM |

### Critical Success Factors
- ✅ **Open source** — MIT License, 310k ⭐
- ✅ **Active development** — Latest: v2026.3.12 (March 13, 2026)
- ✅ **Production-proven** — "Running my company"
- ✅ **Fast setup** — 3 commands, <10 minutes
- ✅ **Cost effective** — $50-200/month vs $2,000+ contractors

---

**Skill Version:** 1.0.0  
**Last Updated:** March 13, 2026  
**Author:** OpenClaw Expert (AI Assistant)  
**License:** MIT (same as OpenClaw)
