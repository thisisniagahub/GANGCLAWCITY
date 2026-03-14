# OpenClaw Troubleshooting Guide

## 🔍 Diagnostic Commands

### Full System Check
```bash
# Comprehensive diagnostic
openclaw doctor

# Check gateway status
openclaw gateway status

# View gateway logs
openclaw gateway logs --follow

# Check channel connections
openclaw channels status

# List active sessions
openclaw sessions list

# Check skill eligibility
openclaw skills list --verbose

# Validate configuration
openclaw config validate

# Test network connectivity
openclaw network test
```

---

## 🚨 Common Issues & Solutions

### Issue 1: Gateway Won't Start

**Symptoms:**
```bash
openclaw gateway --port 18789
# Error: Port 18789 is already in use
```

**Diagnosis:**
```bash
# Check if port 18789 is in use
netstat -an | grep 18789

# Windows (PowerShell)
netstat -ano | findstr :18789

# macOS/Linux
lsof -i :18789
```

**Solutions:**

**Option A: Kill process using port**
```bash
# Windows
netstat -ano | findstr :18789
taskkill /PID <PID> /F

# macOS/Linux
lsof -ti :18789 | xargs kill -9
```

**Option B: Use different port**
```bash
openclaw gateway --port 18790

# Update config permanently
openclaw config set gateway.port 18790
```

**Option C: Restart gateway service**
```bash
# macOS (launchd)
launchctl unload ~/Library/LaunchAgents/com.openclaw.gateway.plist
launchctl load ~/Library/LaunchAgents/com.openclaw.gateway.plist

# Linux (systemd)
systemctl --user restart openclaw-gateway

# Windows (Task Scheduler)
# Restart "OpenClaw Gateway" task
```

---

### Issue 2: WhatsApp Not Connecting

**Symptoms:**
- QR code doesn't appear
- Connection timeout
- "Not authenticated" error

**Diagnosis:**
```bash
# Check WhatsApp channel status
openclaw channels status whatsapp

# View WhatsApp logs
openclaw channels logs whatsapp --follow

# Check if Baileys library is installed
npm list -g @whiskeysockets/baileys
```

**Solutions:**

**Solution 1: Re-login to WhatsApp**
```bash
# Logout completely
openclaw channels logout whatsapp

# Clear session data
rm -rf ~/.openclaw/sessions/whatsapp-*

# Re-login
openclaw channels login whatsapp

# Watch QR code in Control UI
# Open http://127.0.0.1:18789/channels/whatsapp
```

**Solution 2: Check network connectivity**
```bash
# Test WhatsApp servers
ping whatsapp.com
curl -I https://web.whatsapp.com

# Check firewall
# macOS: System Preferences → Security → Firewall
# Windows: Windows Defender Firewall
# Linux: ufw status
```

**Solution 3: Update Baileys dependency**
```bash
cd ~/.openclaw
npm install @whiskeysockets/baileys@latest

# Restart gateway
openclaw gateway restart
```

---

### Issue 3: Skills Not Loading

**Symptoms:**
- Skill not appearing in list
- Skill marked as "not eligible"
- Skill triggers but fails immediately

**Diagnosis:**
```bash
# List all skills
openclaw skills list

# Show only eligible skills
openclaw skills list --eligible

# Show missing requirements
openclaw skills list --verbose

# Check specific skill
openclaw skills info my-skill

# Full eligibility check
openclaw skills check
```

**Solutions:**

**Solution 1: Fix folder structure**
```bash
# Correct structure
~/.openclaw/skills/my-skill/
└── SKILL.md  # Must be in root

# Wrong structures (won't work):
~/.openclaw/skills/my-skill/SKILL.md/SKILL.md  # ❌ Nested
~/.openclaw/skills/my-skill.md  # ❌ Wrong filename
```

**Solution 2: Fix metadata (single-line JSON)**
```bash
# Check metadata format
head -5 ~/.openclaw/skills/my-skill/SKILL.md

# ❌ Wrong: Multi-line JSON
metadata: {
  "openclaw": {
    "emoji": "🔧"
  }
}

# ✅ Correct: Single-line JSON
metadata: {"openclaw":{"emoji":"🔧"}}
```

**Solution 3: Install missing binaries**
```bash
# Check what's missing
openclaw skills list --verbose

# Install missing binaries
# Example: if "jq" is missing
brew install jq        # macOS
apt install jq         # Debian/Ubuntu
dnf install jq         # Fedora
choco install jq       # Windows
```

**Solution 4: Enable skill watching**
```bash
# Check if watch is enabled
openclaw config get skills.load.watch

# Enable if false
openclaw config set skills.load.watch true
openclaw config set skills.load.watchDebounceMs 500

# Or edit config manually
nano ~/.openclaw/openclaw.json
```

---

### Issue 4: High Token Usage

**Symptoms:**
- API bills much higher than expected
- Slow response times
- Context window exhaustion

**Diagnosis:**
```bash
# Check current model
/model

# View session cost
openclaw sessions cost

# Check which skills are active
openclaw skills list --eligible

# Enable usage tracking
openclaw config set messages.usage.footer tokens
```

**Solutions:**

**Solution 1: Switch to cheaper model**
```bash
# For current session
/model haimaker/minimax-m2.5

# Or set default in config
openclaw config set agent.defaults.model.primary haimaker/minimax-m2.5
```

**Solution 2: Disable unused skills**
```bash
# List all eligible skills
openclaw skills list --eligible

# Edit skill to disable auto-invocation
nano ~/.openclaw/skills/<skill>/SKILL.md

# Add this line:
disable-model-invocation: true
```

**Solution 3: Enable three-tier routing**
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

**Solution 4: Compact sessions regularly**
```bash
# Compact current session
/compact

# Or reset entirely
/new
```

---

### Issue 5: Sandboxing Issues

**Symptoms:**
- Commands fail in group sessions
- "Permission denied" errors
- Tools not available in sandbox

**Diagnosis:**
```bash
# Check sandbox mode
openclaw config get agents.defaults.sandbox.mode

# View sandbox allowlist
openclaw config get agents.defaults.sandbox.allowlist

# Check if Docker is running
docker ps

# View sandbox logs
docker logs openclaw-sandbox-<session-id>
```

**Solutions:**

**Solution 1: Verify Docker is running**
```bash
# Check Docker status
docker ps

# If not running, start Docker Desktop
# Or on Linux:
sudo systemctl start docker
```

**Solution 2: Adjust sandbox allowlist**
```bash
# View current allowlist
openclaw config get agents.defaults.sandbox.allowlist

# Add missing tool
openclaw config set agents.defaults.sandbox.allowlist '["bash","read","write","edit","your-tool"]'

# ⚠️ Warning: Only add tools you trust!
```

**Solution 3: Disable sandbox for testing**
```bash
# ⚠️ Only for development, NOT production!
openclaw config set agents.defaults.sandbox.mode off

# Restart gateway
openclaw gateway restart
```

---

### Issue 6: Remote Access Not Working

**Symptoms:**
- Can't access from other devices
- Tailscale connection fails
- Port forwarding issues

**Diagnosis:**
```bash
# Check gateway bind address
openclaw config get gateway.bind

# Check Tailscale status
tailscale status

# Check Tailscale serve status
tailscale serve status

# Test local connectivity
curl http://127.0.0.1:18789/health
```

**Solutions:**

**Solution 1: Configure Tailscale serve**
```bash
# Set Tailscale mode in config
openclaw config set gateway.tailscale.mode serve

# Ensure bind is loopback
openclaw config set gateway.bind 127.0.0.1

# Restart gateway
openclaw gateway restart

# Get serve URL
tailscale serve status
# Output: https://your-machine.tailnet-name.ts.net
```

**Solution 2: Configure Tailscale funnel (public access)**
```bash
# ⚠️ Only for trusted users! Requires password auth.

# Set funnel mode
openclaw config set gateway.tailscale.mode funnel

# Enable password auth
openclaw config set gateway.auth.mode password

# Restart gateway
openclaw gateway restart

# Get funnel URL
tailscale funnel status
```

**Solution 3: Manual port forwarding (NOT recommended)**
```bash
# ⚠️ Only if you understand security implications!

# Set bind to all interfaces
openclaw config set gateway.bind 0.0.0.0

# Configure firewall
# macOS: System Preferences → Security → Firewall
# Windows: Windows Defender Firewall → Advanced Settings
# Linux: ufw allow 18789/tcp

# Get public IP
curl ifconfig.me

# Access via: http://YOUR_PUBLIC_IP:18789
```

---

### Issue 7: Model API Errors

**Symptoms:**
- "Invalid API key" error
- Rate limit exceeded
- Model not found

**Diagnosis:**
```bash
# Check configured model
openclaw config get agent.defaults.model.primary

# Test API key
curl -H "Authorization: Bearer YOUR_API_KEY" \
  https://api.anthropic.com/v1/models

# Check rate limits
# Anthropic: https://console.anthropic.com/settings/limits
# OpenAI: https://platform.openai.com/account/limits
```

**Solutions:**

**Solution 1: Update API key**
```bash
# Set new API key
openclaw config set agent.apiKey sk-ant-YOUR_NEW_KEY

# Or edit config manually
nano ~/.openclaw/openclaw.json
```

**Solution 2: Switch model provider**
```bash
# Switch to different provider
/model openai/gpt-4o

# Or set default
openclaw config set agent.defaults.model.primary openai/gpt-4o
```

**Solution 3: Handle rate limits**
```bash
# Enable automatic retry
openclaw config set agent.retry.onRateLimit true

# Set backoff strategy
openclaw config set agent.retry.backoffMs 5000

# Or switch to higher tier
# Anthropic: Upgrade to Claude Max
# OpenAI: Upgrade to Tier 5+
```

---

### Issue 8: Channel Message Not Delivered

**Symptoms:**
- Messages sent but no response
- "Message queued" but never delivered
- Channel shows "disconnected"

**Diagnosis:**
```bash
# Check channel status
openclaw channels status

# View message queue
openclaw messages queue

# Check channel logs
openclaw channels logs <channel> --follow

# Test message send
openclaw message send --to +1234567890 --message "Test"
```

**Solutions:**

**Solution 1: Clear message queue**
```bash
# View queued messages
openclaw messages queue

# Clear queue
openclaw messages clear

# Restart gateway
openclaw gateway restart
```

**Solution 2: Check mention patterns (groups)**
```bash
# View mention patterns
openclaw config get messages.groupChat.mentionPatterns

# Add mention pattern
openclaw config set messages.groupChat.mentionPatterns '["@openclaw", "@claw"]'

# Or disable mention requirement (NOT recommended for large groups)
openclaw config set channels.whatsapp.groups.*.requireMention false
```

**Solution 3: Re-authenticate channel**
```bash
# Logout
openclaw channels logout <channel>

# Clear session
rm -rf ~/.openclaw/sessions/<channel>-*

# Re-login
openclaw channels login <channel>
```

---

## 🛡️ Security Issues

### Issue: Suspicious Skill Behavior

**Symptoms:**
- Skill tries to access unrelated files
- Unexpected network requests
- Attempts to install packages

**Immediate Actions:**
```bash
# 1. Stop gateway immediately
openclaw gateway stop

# 2. Remove suspicious skill
rm -rf ~/.openclaw/skills/<suspicious-skill>

# 3. Review recent activity
tail -1000 ~/.openclaw/logs/gateway.log | grep -i "exec\|curl\|wget"

# 4. Rotate compromised credentials
# Update all API keys that might have been exposed
```

**Prevention:**
```bash
# Always review SKILL.md before installing
cat ~/.openclaw/skills/<skill>/SKILL.md

# Check for dangerous patterns
grep -r "curl\|wget\|eval\|exec" ~/.openclaw/skills/<skill>/

# Use sandbox mode
openclaw config set agents.defaults.sandbox.mode non-main
```

---

## 📊 Performance Optimization

### Issue: Slow Response Times

**Diagnosis:**
```bash
# Check model response time
openclaw sessions stats

# Monitor system resources
top  # or htop
```

**Solutions:**

**Solution 1: Reduce context size**
```bash
# Compact session
/compact

# Or start fresh
/new
```

**Solution 2: Use faster model**
```bash
# Switch to faster model
/model haimaker/minimax-m2.5

# Or configure thinking level
/think low
```

**Solution 3: Disable verbose output**
```bash
/verbose off
```

---

## 📞 Getting Help

### Official Support Channels

- **Documentation:** https://docs.openclaw.ai
- **GitHub Issues:** https://github.com/openclaw/openclaw/issues
- **Discord:** https://discord.gg/openclaw
- **Reddit:** r/openclaw

### Before Asking for Help

**Gather this information:**
```bash
# System info
openclaw --version
node --version
uname -a

# Config validation
openclaw config validate

# Recent logs
tail -200 ~/.openclaw/logs/gateway.log

# Skill eligibility
openclaw skills list --verbose

# Channel status
openclaw channels status
```

**Template for help requests:**
```markdown
**Issue:** Brief description

**Steps to reproduce:**
1. ...
2. ...

**Expected behavior:** ...

**Actual behavior:** ...

**System info:**
- OS: ...
- Node.js: ...
- OpenClaw version: ...

**Logs:**
```
[paste relevant logs]
```

**What I've tried:**
- ...
```

---

**Last Updated:** March 13, 2026  
**Version:** 1.0.0  
**Maintained By:** OpenClaw Community
