# OpenClaw Expert Skill

**Version:** 1.0.0  
**Last Updated:** March 13, 2026  
**Author:** OpenClaw Community  
**License:** MIT

---

## 🦞 What is This Skill?

**OpenClaw Expert** adalah skill lengkap yang menjadikan AI assistant anda sebagai **PAKAR OPENCLAW** — menguasai sepenuhnya:

- ✅ Setup & installation
- ✅ Configuration & optimization  
- ✅ Multi-agent workflows
- ✅ Security hardening
- ✅ Troubleshooting & debugging
- ✅ Skills development (SKILL.md pattern)
- ✅ ClawHub publishing
- ✅ Integration dengan tools lain

---

## 📦 Installation

### Quick Install (Recommended)

```bash
# Clone atau download skill ini
cd ~/.openclaw/skills

# Jika clone dari GitHub
git clone <repository-url> openclaw-expert

# Atau copy manual folder ini ke ~/.openclaw/skills/openclaw-expert
```

### Manual Installation

1. **Create skill directory:**
```bash
mkdir -p ~/.openclaw/skills/openclaw-expert
```

2. **Copy files:**
```
openclaw-expert/
├── SKILL.md              # Main skill file (required)
└── references/           # Reference documentation
    ├── SKILL-MD-PATTERN.md
    └── TROUBLESHOOTING.md
```

3. **Verify installation:**
```bash
openclaw skills list --eligible | grep openclaw-expert
```

---

## 🚀 Usage

### Natural Language Triggers

Skill ini akan auto-activate bila anda tanya tentang:

- "Macam mana nak install OpenClaw?"
- "Configure OpenClaw untuk WhatsApp"
- "Setup multi-agent workflows"
- "Create SKILL.md sendiri"
- "Troubleshoot OpenClaw connection"
- "Optimize token usage"
- "Secure production deployment"
- "Publish ke ClawHub"

### Slash Commands

```bash
# Manual invoke (jika enabled)
/openclaw-expert

# Example queries
/openclaw-expert Install OpenClaw untuk pertama kali
/openclaw-expert Setup three-tier model routing
/openclaw-expert Troubleshoot WhatsApp connection
```

### Example Conversations

**Example 1: First-Time Setup**
```
You: "Saya nak install OpenClaw untuk pertama kali. Bantu saya."

OpenClaw Expert: "Baik! Saya akan pandu anda step-by-step:

1. Check prerequisites dulu:
   - Node.js >= 22
   - pnpm atau npm
   
   Jom run command ni:
   ```bash
   node --version
   pnpm --version
   ```
   
   Dah tu bagi saya output dia, saya check kalau dah cukup requirements."
```

**Example 2: Multi-Agent Setup**
```
You: "Macam mana nak setup multi-agent workflows?"

OpenClaw Expert: "Untuk multi-agent workflows, ada beberapa patterns:

**Pattern 1: Two-Tier Model Routing** (Jimat 60-80% cost)

Config:
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

Pattern ni auto-route:
- Simple tasks → Sonnet ($3/M tokens)
- Complex reasoning → Opus ($75/M tokens)

Nak saya tunjuk pattern lain? Ada three-tier (95% savings) dan parent+sub-agents."
```

**Example 3: Troubleshooting**
```
You: "WhatsApp tak connect. Help!"

OpenClaw Expert: "Jom troubleshoot step-by-step:

1. Check channel status dulu:
```bash
openclaw channels status whatsapp
```

2. Logout dan re-login:
```bash
openclaw channels logout whatsapp
openclaw channels login whatsapp
```

3. Scan QR code dalam Control UI:
   - Open http://127.0.0.1:18789/channels/whatsapp
   
Output command pertama tu bagi saya, saya check apa issue."
```

---

## 📚 Reference Documentation

Skill ini datang dengan reference files lengkap:

### 1. SKILL-MD-PATTERN.md
**Complete guide untuk create SKILL.md sendiri:**
- Structure & required sections
- Metadata fields reference
- Gating mechanism explained
- Hot reload configuration
- Testing checklist
- Publishing to ClawHub
- Security best practices
- Example skills by category

### 2. TROUBLESHOOTING.md
**Comprehensive troubleshooting guide:**
- Diagnostic commands
- Common issues & solutions
- Security issues handling
- Performance optimization
- Getting help template

---

## 🛠️ Configuration

### Minimal Config

Skill ini works dengan default OpenClaw installation. No extra config needed!

### Advanced Config

Untuk customize behavior, edit `~/.openclaw/openclaw.json`:

```json
{
  "skills": {
    "load": {
      "watch": true,              // Auto-reload on changes
      "watchDebounceMs": 500,
      "extraDirs": [
        "~/.openclaw/skills"      // Default skill directory
      ]
    }
  }
}
```

---

## 🔐 Security Notes

**Skill ini adalah READ-ONLY dan tidak execute destructive actions:**

- ✅ Tidak delete files
- ✅ Tidak install packages tanpa approval
- ✅ Tidak access sensitive credentials
- ✅ Tidak make external API calls tanpa permission

**Untuk production use:**
- Run dalam Docker sandbox
- Enable sandbox mode: `agents.defaults.sandbox.mode: "non-main"`
- Review logs regularly: `tail -f ~/.openclaw/logs/gateway.log`

---

## 🧪 Testing

### Verify Installation

```bash
# Check if skill is loaded
openclaw skills list --eligible | grep openclaw-expert

# View skill details
openclaw skills info openclaw-expert

# Test trigger
openclaw agent --message "Macam mana nak install OpenClaw?"
```

### Test Scenarios

| Scenario | Expected Behavior |
|----------|-------------------|
| Install question | Step-by-step installation guide |
| Config question | Detailed config explanation |
| Troubleshoot | Diagnostic commands + solutions |
| Multi-agent | Workflow patterns + examples |
| Create skill | SKILL.md template + best practices |

---

## 📦 Updates

### Check for Updates

```bash
# Jika install dari Git
cd ~/.openclaw/skills/openclaw-expert
git pull origin main
```

### Manual Update

1. Download latest version dari repository
2. Replace files in `~/.openclaw/skills/openclaw-expert/`
3. Reload skills: `openclaw skills reload`

---

## 🤝 Contributing

### Nak Tambah Features?

1. **Fork repository**
2. **Create branch:** `git checkout -b feature/my-feature`
3. **Make changes** (keep SKILL.md under 500 lines, move details to references/)
4. **Test thoroughly**
5. **Submit PR**

### Contribution Guidelines

- Keep core SKILL.md focused (under 500 lines)
- Move detailed documentation to `references/` folder
- Include examples for all major use cases
- Document security considerations
- Test on sandbox before submitting

---

## 🐛 Known Issues

### Issue: Skill Not Loading

**Cause:** Metadata format error (multi-line JSON)

**Fix:**
```bash
# Check metadata format
head -5 ~/.openclaw/skills/openclaw-expert/SKILL.md

# Ensure single-line JSON
# ❌ Wrong:
metadata: {
  "openclaw": {...}
}

# ✅ Correct:
metadata: {"openclaw":{...}}
```

### Issue: Slow Response on First Load

**Cause:** Large skill file loading into context

**Fix:**
- Skill ini optimized dengan reference files
- Details loaded on-demand sahaja
- First response mungkin lambat, subsequent responses laju

---

## 📊 Performance Metrics

| Metric | Value |
|--------|-------|
| **SKILL.md Size** | ~500 lines (optimized) |
| **Reference Files** | 2 comprehensive guides |
| **Load Time** | <1s (after first load) |
| **Token Overhead** | Minimal (details in references) |
| **Test Coverage** | All major use cases covered |

---

## 🎯 Use Cases

### 1. First-Time Users
**Problem:** Tak tahu macam mana nak start dengan OpenClaw

**Solution:** Skill ini provide step-by-step installation guide + onboarding

### 2. Advanced Users
**Problem:** Nak optimize cost, setup multi-agent, secure production

**Solution:** Deep dive guides untuk advanced topics

### 3. Skill Developers
**Problem:** Nak create skills sendiri tapi tak tahu format

**Solution:** Complete SKILL.md pattern guide + examples

### 4. Production Admins
**Problem:** Ada issues dalam production, perlu troubleshoot cepat

**Solution:** Comprehensive troubleshooting guide

---

## 📞 Support

### Documentation

- **OpenClaw Docs:** https://docs.openclaw.ai
- **Skill Pattern Guide:** See `references/SKILL-MD-PATTERN.md`
- **Troubleshooting:** See `references/TROUBLESHOOTING.md`

### Community

- **Discord:** https://discord.gg/openclaw
- **Reddit:** r/openclaw
- **GitHub:** https://github.com/openclaw/openclaw

### Report Issues

Found a bug or missing feature? Create issue di repository dengan template:

```markdown
**Issue:** Brief description

**Expected:** What should happen

**Actual:** What actually happened

**Steps to Reproduce:**
1. ...
2. ...

**System Info:**
- OS: ...
- OpenClaw version: ...
```

---

## 📜 License

MIT License — sama seperti OpenClaw.

**You can:**
- ✅ Use untuk personal/commercial projects
- ✅ Modify dan customize
- ✅ Distribute copies
- ✅ Create derivative works

**Attribution appreciated but not required.**

---

## 🙏 Acknowledgments

Skill ini dibuat berdasarkan:
- **OpenClaw Documentation:** https://docs.openclaw.ai
- **Community Skills:** ClawHub marketplace
- **Real-World Use Cases:** Brilworks, Haimaker, community reports
- **Security Best Practices:** OpenClaw security guide, Microsoft guidance

**Special Thanks:**
- OpenClaw core team
- ClawHub contributors
- Community members who shared their skills

---

## 📈 Version History

### v1.0.0 (March 13, 2026)
**Initial Release:**
- ✅ Complete OpenClaw expert knowledge
- ✅ Installation & configuration guides
- ✅ Multi-agent workflow patterns
- ✅ Security hardening checklist
- ✅ Troubleshooting guide
- ✅ SKILL.md pattern reference
- ✅ Cost optimization strategies
- ✅ ClawHub publishing guide

---

**Last Updated:** March 13, 2026  
**Maintained By:** OpenClaw Community  
**Contact:** Discord #skills-development channel
