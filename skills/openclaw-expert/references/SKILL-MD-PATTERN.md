# OpenClaw SKILL.md Pattern - Official Reference Guide

**Based on Official OpenClaw Documentation:**
- https://docs.openclaw.ai/skills
- https://github.com/openclaw/openclaw
- https://openclaw.ai

---

## 📋 Complete Template (Official Format)

```markdown
---
name: skill-name-kebab-case
description: Clear, specific description for model matching (max 120 chars)
version: 1.0.0
author: Your Name
metadata: {"openclaw":{"emoji":"🔧","requires":{"bins":["bash"],"os":["linux","darwin"],"env":["API_KEY"]}}}
user-invocable: true
---

# Skill Name

## What it does
One paragraph description of what this skill accomplishes.

## Inputs needed
- REQUIRED_VAR: Description of what this is and how to set it
- OPTIONAL_VAR: Description with default value

## Workflow
1. Step 1: First action
2. Step 2: Second action
3. Step 3: Third action

## Guardrails
- Never do X (security/safety constraint)
- Always verify Y (validation requirement)
- Stop after Z (termination condition)

## Failure handling
- If command fails: Show exact error and stop
- If data missing: State what's missing, don't fabricate
- If ambiguous: Ask for clarification

## Examples
User: "Example trigger phrase"
Assistant: "Expected response with output format"
```

---

## 🏷️ Metadata Fields Reference (Official Specification)

### Required Fields

| Field | Type | Description | Example |
|-------|------|-------------|---------|
| `name` | string | Unique skill identifier (kebab-case) | `disk-cleanup-helper` |
| `description` | string | Controls discoverability & model matching | `Clean temp files and free disk space safely` |

### Optional Fields

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `version` | string | - | Skill version (semver) |
| `author` | string | - | Skill author name |
| `user-invocable` | boolean | `true` | Shows in slash command menu |
| `disable-model-invocation` | boolean | `false` | Removes from model context (manual-only) |
| `command-dispatch` | string | - | Bypasses model, calls tool directly |

### Metadata Object (MUST be single-line JSON)

**⚠️ CRITICAL:** OpenClaw parser supports **single-line frontmatter keys only**. The `metadata` field must be a single-line JSON object.

```json
{"openclaw":{"emoji":"🔧","requires":{"bins":["bash"],"os":["linux"],"env":["API_KEY"]}}}
```

| Field | Type | Description | Example |
|-------|------|-------------|---------|
| `openclaw.emoji` | string | Visual identifier in macOS Skills UI | `"🔧"` |
| `openclaw.requires.bins` | array | Required binaries on PATH | `["bash", "jq", "curl"]` |
| `openclaw.requires.anyBins` | array | At least one binary must exist | `["docker","podman"]` |
| `openclaw.requires.os` | array | Supported platforms | `["darwin", "linux", "win32"]` |
| `openclaw.requires.env` | array | Required env vars (or provided in config) | `["API_KEY", "DATABASE_URL"]` |
| `openclaw.requires.config` | array | Config paths that must be truthy | `["browser.enabled"]` |
| `openclaw.primaryEnv` | string | Env var for `skills.entries.<name>.apiKey` | `"GEMINI_API_KEY"` |
| `openclaw.install` | array | Installer specs (brew/node/go/uv/download) | See install example below |

### Install Metadata Example

```json
{
  "openclaw": {
    "emoji": "♊️",
    "requires": {
      "bins": ["gemini"]
    },
    "install": [
      {
        "id": "brew",
        "kind": "brew",
        "formula": "gemini-cli",
        "bins": ["gemini"],
        "label": "Install Gemini CLI (brew)"
      }
    ]
  }
}
```

---

## 🎯 Skill Design Patterns

### Keep Scope Narrow

| ✅ Good (Specific) | ❌ Bad (Vague) |
|-------------------|----------------|
| `Generate weekly report from /var/log/app` | `Manage my operations` |
| `Clean temp files in /tmp older than 7 days` | `System optimizer` |
| `Check disk usage and alert if >90%` | `System helper` |

### Prefer Read-Only First

**Progression:**
1. Start with reporting/monitoring skills
2. Once logic is trusted, add write actions
3. Make destructive actions opt-in with explicit confirmation

### Token Overhead Control

**Every eligible skill adds text to system prompt. Minimize by:**

- ✅ Keep descriptions **short and specific** (max 120 chars)
- ✅ Use `disable-model-invocation: true` for manual-only skills
- ✅ Disable skills not currently in use
- ✅ Merge skills sharing same domain (but keep scope clear)

### Constants in Config, Not Body

```markdown
# ❌ Bad: Hardcoded path
Read logs from /var/log/myapp

# ✅ Good: Documented variable
Read logs from LOG_DIR (configured in settings, default: /var/log/myapp)
```

---

## 🔒 Security Best Practices

### For Skill Authors

**DO:**
- ✅ Request minimum permissions necessary
- ✅ Validate all inputs
- ✅ Sanitize outputs
- ✅ Use environment variables for secrets
- ✅ Document guardrails clearly
- ✅ Include failure handling

**DON'T:**
- ❌ Hardcode API keys or credentials
- ❌ Instruct users to paste secrets into chat
- ❌ Request excessive permissions
- ❌ Use obfuscated shell commands
- ❌ Access irrelevant internal URLs/APIs

### For Skill Users

**Before Installing:**
1. Read every SKILL.md (code review)
2. Inspect scripts inside skill folder
3. Run on sandbox/disposable machine first
4. Keep exec approvals on until trusted

**Red Flags:**
- 🚩 Misspelled package names (e.g., `claw__d__hub` vs `clawhub`)
- 🚩 Attempts to access irrelevant internal URLs/APIs
- 🚩 Leaked system instructions in responses
- 🚩 Hidden markdown formatting
- 🚩 Requests for excessive credentials

---

## 🧪 Testing Checklist

### Pre-Test Setup

```bash
# 1. Verify skill is detected
openclaw skills list

# 2. Check eligibility
openclaw skills list --eligible

# 3. Inspect requirements
openclaw skills info my-skill

# 4. Check missing requirements
openclaw skills list --verbose
```

### Test Scenarios

| Scenario | What to Verify |
|----------|----------------|
| **Missing input** | Skill asks for required paths/credentials |
| **Missing binary** | Skill reports missing requirement gracefully |
| **Command failure** | Skill shows error text and stops |
| **Data missing** | Skill states what's missing (no fabrication) |
| **Output format** | Results match specified format exactly |
| **Guardrail trigger** | Skill refuses prohibited actions |
| **Edge cases** | Skill handles empty/invalid inputs |

### Security Testing

1. **Read SKILL.md** — Treat like code review
2. **Inspect scripts** — Check any embedded scripts in skill folder
3. **Run in sandbox** — Test on disposable machine first
4. **Keep exec approvals on** — Until you trust the behavior

---

## 🔄 Hot Reload Configuration

### Enable Skill Watching

**Config location:** `~/.openclaw/openclaw.json`

```json
{
  "skills": {
    "load": {
      "watch": true,
      "watchDebounceMs": 500,
      "extraDirs": [
        "/path/to/custom/skills"
      ]
    }
  }
}
```

### Iteration Workflow

1. Run the skill
2. Identify where it went wrong
3. Edit `SKILL.md`
4. Run again on next turn (no restart needed!)

### If Changes Don't Take Effect

1. Confirm `skills.load.watch: true` in config
2. Start a **new agent session** (some environments cache skills snapshot at session start)
3. Run `openclaw skills check` to verify reload
4. Check logs for parse errors: `tail -f ~/.openclaw/logs/gateway.log`

---

## 📦 Publishing to ClawHub

### Pre-Publish Checklist

```markdown
## Before Publishing

- [ ] SKILL.md has clear name and specific description
- [ ] metadata is single-line JSON (validated)
- [ ] requires.bins lists only necessary binaries
- [ ] requires.os matches tested platforms
- [ ] Guardrails prevent destructive actions
- [ ] No secrets or hardcoded credentials
- [ ] Output format is deterministic
- [ ] Failure handling is documented
- [ ] Examples show expected behavior
- [ ] Tested on sandbox/disposable machine
- [ ] README.md is clear and complete
- [ ] No trademark infringement in name
```

### Distribution Options

| Method | Best For | Requirements |
|--------|----------|--------------|
| **Git repo (private)** | Team skills | GitHub/GitLab repo |
| **ClawHub (public)** | Community skills | Open-source, security review |
| **npm package** | Enterprise distribution | Existing npm infrastructure |

### ClawHub Submission

**Repository:** https://github.com/openclaw/clawhub

**Requirements:**
- Clear README with use case
- No secrets in code
- Explicit `requires` list
- Safe defaults
- Guardrails against extra actions
- Security self-assessment

**Review Process:**
1. Automated security scan (ClawDex)
2. Community review period
3. Maintainer approval
4. Published to registry

---

## 🛠️ Troubleshooting Quick Reference

| Problem | Likely Cause | Solution |
|---------|--------------|----------|
| Skill not listed | Wrong folder/filename | Confirm `SKILL.md` in scanned directory |
| Skill listed but not eligible | Missing binary | Install binary or remove from `requires.bins` |
| Skill listed but not eligible | Missing env var | Set env var or remove from `requires.env` |
| Skill listed but not eligible | OS mismatch | Adjust `requires.os` or use on supported OS |
| Skill triggers but fails | Tool policy blocks exec | Skills don't grant permissions; adjust tool policy |
| Metadata parse errors | Multi-line JSON | Ensure metadata is single-line JSON |
| Edits don't take effect | Watch not enabled | Confirm `skills.load.watch: true`; start new session |

### Debug Commands

```bash
# Full eligibility check
openclaw skills check

# List all skills with details
openclaw skills list --verbose

# Check specific skill
openclaw skills info <skill-name>

# Show only eligible skills
openclaw skills list --eligible

# Reload skills manually
openclaw skills reload

# Validate config
openclaw config validate
```

---

## 📚 Example Skills by Category

### 1. System Monitoring

```markdown
---
name: disk-usage-monitor
description: Monitor disk usage and alert if above threshold.
metadata: {"openclaw":{"emoji":"💾","requires":{"bins":["df"],"os":["linux","darwin"]}}}
---

# Disk Usage Monitor

## What it does
Checks disk usage and alerts if any partition exceeds threshold.

## Inputs needed
- THRESHOLD: Alert threshold percentage (default: 90)
- MOUNT_POINT: Specific mount to check (optional, default: all)

## Workflow
1. Run `df -h` to get disk usage
2. Parse output for each mount point
3. Check if usage exceeds THRESHOLD
4. If exceeded, alert with details and recommendations
5. If all clear, report current usage

## Guardrails
- Never auto-delete files
- Always show exact percentage
- Alert only if threshold exceeded

## Failure handling
- If `df` fails, show error and stop
- If parsing fails, show raw output
```

### 2. Development Tools

```markdown
---
name: git-status-summary
description: Provide concise git status summary with actionable insights.
metadata: {"openclaw":{"emoji":"📊","requires":{"bins":["git"],"os":["linux","darwin","win32"]}}}
---

# Git Status Summary

## What it does
Analyzes git status and provides actionable summary.

## Workflow
1. Run `git status --porcelain`
2. Categorize changes (staged, unstaged, untracked)
3. Run `git diff --stat` for staged changes
4. Provide summary with recommendations

## Output format
- Branch name + ahead/behind status
- Staged changes count
- Unstaged changes count
- Untracked files count
- Recommended next action

## Guardrails
- Never auto-commit
- Never auto-push
- Always show full status on request
```

### 3. API Integration

```markdown
---
name: weather-checker
description: Check current weather and forecast using wttr.in API.
metadata: {"openclaw":{"emoji":"🌤️","requires":{"bins":["curl"],"os":["linux","darwin","win32"]}}}
---

# Weather Checker

## What it does
Fetches current weather and forecast from wttr.in API.

## Inputs needed
- LOCATION: City name or coordinates (default: current IP location)
- DAYS: Forecast days (1-3, default: 1)

## Workflow
1. Validate LOCATION format
2. Fetch from `wttr.in/{LOCATION}?format=j1`
3. Parse JSON response
4. Format and display current conditions + forecast

## Output format
- Current: Temperature, condition, humidity, wind
- Forecast: High/low, condition, precipitation chance

## Guardrails
- Never cache responses >10 minutes
- Always cite wttr.in as source
- Max 3 days forecast

## Failure handling
- If API fails, show error and suggest retry
- If location invalid, ask for clarification
```

---

## 🎓 Learning Resources

### Official Documentation
- **Creating Skills:** https://docs.openclaw.ai/skills/creating-skills
- **Skill Structure:** https://docs.openclaw.ai/skills/skill-structure
- **Publishing Guide:** https://docs.openclaw.ai/skills/publishing
- **Security Best Practices:** https://docs.openclaw.ai/security/skills

### Community Resources
- **ClawHub:** https://github.com/openclaw/clawhub
- **Reddit:** r/openclaw — Skill discussions
- **Discord:** #skills-development channel
- **Showcase:** Community skill examples

### Video Tutorials
- "Building Your First OpenClaw Skill" (15 min)
- "Advanced Skill Patterns" (30 min)
- "Security Hardening for Skills" (20 min)

---

**Last Updated:** March 13, 2026  
**Version:** 1.0.0  
**Maintained By:** OpenClaw Community
