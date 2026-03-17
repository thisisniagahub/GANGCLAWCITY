# 🔐 GANGCLAWCITY Security Policy

**Enterprise-Grade Security Standards**

---

## 🚨 CRITICAL SECURITY ALERT

**Status:** ⚠️ **CRITICAL - ACTION REQUIRED**

**Issue:** Gateway token exposed in 26+ locations  
**Severity:** CRITICAL  
**Action:** IMMEDIATE TOKEN ROTATION REQUIRED

**Rotate Token NOW:**
```bash
# 1. SSH to VPS
ssh root@<VPS_IP>

# 2. Generate new token
openssl rand -hex 32

# 3. Update config
nano /root/.openclaw/openclaw.json

# 4. Restart gateway
openclaw gateway restart

# 5. Update Vercel environment variables
# Visit: https://vercel.com/dashboard → Settings → Environment Variables
# Update VITE_GATEWAY_TOKEN in all projects
```

---

## 📋 TABLE OF CONTENTS

1. [Security Principles](#security-principles)
2. [Token Management](#token-management)
3. [Secret Storage](#secret-storage)
4. [Access Control](#access-control)
5. [Vulnerability Reporting](#vulnerability-reporting)
6. [Security Scanning](#security-scanning)
7. [Incident Response](#incident-response)
8. [Compliance](#compliance)

---

## 🛡️ SECURITY PRINCIPLES

### **Non-Negotiable Rules:**

1. **NEVER commit secrets to Git**
   - No tokens, API keys, passwords, or credentials
   - Use environment variables ONLY
   - `.env` files MUST be in `.gitignore`

2. **ALWAYS use secure storage**
   - Vercel Secrets for deployment
   - Environment variables for local dev
   - Vault for production secrets (planned)

3. **ROTATE credentials regularly**
   - Gateway tokens: Every 90 days
   - API keys: Every 90 days
   - SSH keys: Annually

4. **SCAN before every push**
   - Run `security-scan.bat` before `git push`
   - Check for exposed tokens
   - Verify `.gitignore` compliance

5. **LEAST PRIVILEGE access**
   - Minimum permissions required
   - Role-based access control (RBAC)
   - Regular access reviews

---

## 🔑 TOKEN MANAGEMENT

### **Gateway Token**

**Current Status:** ⚠️ **EXPOSED - ROTATE IMMEDIATELY**

**Token Locations (MUST FIX):**
- ❌ `QWEN.md` - 7 occurrences
- ❌ `docs/01-architecture/ARCHITECTURE.md` - 4 occurrences
- ❌ `openclaw-office/src/App.tsx` - 1 occurrence
- ❌ `openclaw-office/src/components/shared/ConnectionSetupDialog.tsx` - 1 occurrence
- ❌ 19+ other locations

**Fix Required:**
```typescript
// ❌ BEFORE (INSECURE)
const token = "<GATEWAY_TOKEN>";

// ✅ AFTER (SECURE)
const token = import.meta.env.VITE_GATEWAY_TOKEN;
```

### **Token Rotation Schedule**

| Token Type | Rotation Frequency | Last Rotated | Next Due |
|------------|-------------------|--------------|----------|
| Gateway Token | 90 days | Unknown | 🔴 **NOW** |
| Vercel API | 90 days | - | - |
| GitHub PAT | 90 days | - | - |
| SSH Keys | 365 days | - | - |

---

## 🗄️ SECRET STORAGE

### **Approved Storage Methods:**

#### **1. Environment Variables (Development)**
```bash
# .env.local (NEVER commit this file)
VITE_GATEWAY_TOKEN=<YOUR_TOKEN_HERE>
VITE_GATEWAY_URL=wss://operator.gangniaga.my
VITE_SESSION_KEY=agent:main:main
```

#### **2. Vercel Secrets (Production)**
```bash
# Set via Vercel Dashboard
# Settings → Environment Variables → Add New
# Scope: Production, Preview, Development
```

#### **3. GitHub Secrets (CI/CD)**
```bash
# Repository Settings → Secrets and variables → Actions
# Add repository secrets
```

### **NEVER Use:**
- ❌ Hardcoded in source code
- ❌ Committed to Git (even in private repos)
- ❌ Shared in Slack, email, or chat
- ❌ Stored in plain text files
- ❌ Logged in console or logs

---

## 🔒 ACCESS CONTROL

### **Repository Access**

| Role | Permissions | Who |
|------|-------------|-----|
| **Admin** | Full access | Project owners |
| **Maintainer** | Push, merge PRs | Lead developers |
| **Developer** | Push to branches | Development team |
| **Contributor** | Create PRs | External contributors |
| **Viewer** | Read-only | Stakeholders |

### **Production Access**

| System | Access Level | Authorization |
|--------|--------------|---------------|
| VPS (<VPS_IP>) | SSH key only | Admin only |
| Vercel Dashboard | SSO required | Dev team |
| Gateway Config | Token required | Services only |
| Database | Connection string | Backend only |

---

## 🐛 VULNERABILITY REPORTING

### **How to Report:**

**DO:**
- ✅ Email: security@gangclawcity.my
- ✅ GitHub Security Advisory (private)
- ✅ Encrypted message via Signal/Keybase

**DON'T:**
- ❌ Open public GitHub issue
- ❌ Post in public channels
- ❌ Share on social media

### **Response Time:**
- **Critical:** 24 hours
- **High:** 48 hours
- **Medium:** 1 week
- **Low:** 2 weeks

### **What to Include:**
1. Description of vulnerability
2. Steps to reproduce
3. Impact assessment
4. Suggested fix (if any)
5. Your contact info

---

## 🔍 SECURITY SCANNING

### **Automated Scans:**

#### **Pre-Commit Scan:**
```bash
# Run before EVERY commit
.\security-scan.bat

# Checks:
# - Exposed gateway tokens
# - .env files in repo
# - .gitignore compliance
# - Hardcoded credentials
```

#### **CI/CD Scan:**
```yaml
# GitHub Actions (planned)
- name: Security Scan
  run: |
    npm audit
    git-secrets --scan
    trufflehog git file://. --since-commit HEAD --results=high,medium
```

### **Manual Audit Checklist:**

**Before Production Deploy:**
- [ ] Run `security-scan.bat`
- [ ] Check `git log` for accidental commits
- [ ] Verify environment variables set
- [ ] Review `.env.example` (no real values)
- [ ] Check dependencies for vulnerabilities
- [ ] Audit API keys and tokens

---

## 🚨 INCIDENT RESPONSE

### **If Token is Compromised:**

**IMMEDIATE (Within 1 hour):**

1. **Rotate Token on VPS:**
   ```bash
   ssh root@<VPS_IP>
   openssl rand -hex 32
   nano /root/.openclaw/openclaw.json
   openclaw gateway restart
   ```

2. **Update All Environment Variables:**
   - Vercel Dashboard → All projects
   - Local `.env.local` files
   - CI/CD secrets

3. **Revoke Old Token:**
   - Invalidate in gateway config
   - Add to blocklist

**WITHIN 24 HOURS:**

4. **Audit Logs:**
   - Review gateway access logs
   - Check for unauthorized actions
   - Identify scope of exposure

5. **Document Incident:**
   - Timeline of events
   - What was exposed
   - Actions taken
   - Lessons learned

6. **Notify Stakeholders:**
   - Team members
   - Affected users (if any)
   - Management

---

## 📊 SECURITY COMPLIANCE

### **Alignment with Standards:**

| Standard | Status | Notes |
|----------|--------|-------|
| **OWASP Top 10** | ⚠️ Partial | A01 (Broken Access Control) - In Progress |
| **CIS Controls** | ⚠️ Partial | Control 3 (Data Protection) - In Progress |
| **SOC 2 Type II** | 📋 Planned | CC6.1 (Logical Access) - Future |
| **GDPR** | ⚠️ Review | Data handling - Needs assessment |
| **PDPA (Malaysia)** | ⚠️ Review | Personal data - Needs assessment |

### **Security Metrics:**

| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| Token rotation compliance | 0% ⚠️ | 100% | 🔴 Critical |
| Security scan before push | 50% ⚠️ | 100% | 🟡 Needs Work |
| Exposed secrets in repo | 26+ ❌ | 0 | 🔴 Critical |
| Dependencies audited | 0% ⚠️ | 100% | 🟡 Planned |
| Team security training | 0% ⚠️ | 100% | 🟡 Planned |

---

## 🛠️ SECURITY TOOLS

### **Installed:**
- ✅ `security-scan.bat` - Token scanner
- ✅ `.gitignore` - Comprehensive ignore rules
- ✅ `sanitize-tokens.bat` - Token sanitization

### **Planned:**
- 📋 `git-secrets` - Pre-commit hook
- 📋 `trufflehog` - Secret scanner
- 📋 `npm audit` - Dependency audit
- 📋 `snyk` - Security monitoring
- 📋 HashiCorp Vault - Secret management

---

## 📚 SECURITY DOCUMENTATION

**Related Docs:**
- [`/security/SECURITY_AUDIT_2026-03-14.md`](../security/SECURITY_AUDIT_2026-03-14.md) - Latest audit report
- [`/security/API_KEY_SECURITY.md`](../security/API_KEY_SECURITY.md) - API key security guide
- [`/docs/UPSTREAM-DECLARATION.md`](UPSTREAM-DECLARATION.md) - Upstream origins
- [`/docs/REBRANDING-CHECKLIST.md`](REBRANDING-CHECKLIST.md) - Security checklist

---

## 🎯 SECURITY CHECKLIST

### **For Developers:**

**Every Day:**
- [ ] Run `security-scan.bat` before push
- [ ] Check for accidental token commits
- [ ] Verify `.env` files not staged

**Every Week:**
- [ ] Review git history for sensitive data
- [ ] Check dependency updates
- [ ] Audit API key usage

**Every Month:**
- [ ] Rotate development tokens
- [ ] Review access permissions
- [ ] Update security documentation

### **For DevOps:**

**Every Day:**
- [ ] Monitor gateway logs
- [ ] Check for unusual activity
- [ ] Verify backups

**Every Week:**
- [ ] Review production access
- [ ] Audit environment variables
- [ ] Check SSL/TLS certificates

**Every Month:**
- [ ] Rotate production tokens
- [ ] Security patch review
- [ ] Incident response drill

---

## 📞 SECURITY CONTACTS

**Security Team:**
- Email: security@gangclawcity.my
- Signal: [Private channel]
- Keybase: @gangclawcity

**Emergency Contacts:**
- Admin: admin@gangniaga.my
- VPS Provider: Hetzner/DigitalOcean support
- Vercel Support: https://vercel.com/support

---

## 🔐 PGP KEY

**For sensitive communications:**

```
-----BEGIN PGP PUBLIC KEY BLOCK-----
[To be added - Generate and publish]
-----END PGP PUBLIC KEY BLOCK-----
```

**Fingerprint:** [To be added]

---

**Last Updated:** March 17, 2026  
**Version:** 1.0.0 (Enterprise Security Policy)  
**Next Review:** April 17, 2026  
**Owner:** Security Lead  
**Status:** ⚠️ **CRITICAL - Token Rotation Required**

---

**🔐 GANGCLAWCITY Security - Enterprise Grade!**  
**🚨 No Compromises. Real Security. Professional Standards.**
