# 🚀 GANGCLAWCITY Start Here

**Fortune 500 Level Onboarding - Your First Day Checklist**

---

## 👋 WELCOME TO GANGCLAWCITY

**What is this?**
GANGCLAWCITY is an AI workforce platform built from 5 proven upstream repositories. We don't start from zero - we absorb successful projects, improve them, rebrand them, and ship as GANGCLAWCITY original products.

**Important:** This is NOT a from-scratch project. We're honest about our upstream origins.

---

## ⚡ QUICK START (5 MINUTES)

### **Step 1: Clone & Install**
```bash
# Clone the repository
git clone https://github.com/thisisniagahub/GANGCLAWCITY.git
cd GANGCLAWCITY

# Install root dependencies (if any)
npm install
```

### **Step 2: Security Scan (ALWAYS FIRST)**
```bash
# Run security scan before ANYTHING else
.\security-scan.bat

# ✅ Should show: NO SECURITY ISSUES FOUND
# ⚠️ If tokens found: DO NOT PROCEED - notify team
```

### **Step 3: Pick Your App**

**Dashboard (openclaw-office):**
```bash
pnpm --dir openclaw-office install
pnpm --dir openclaw-office dev
# Opens at http://localhost:5173
```

**CityView (agent-town):**
```bash
pnpm --dir agent-town install
pnpm --dir agent-town dev
# Opens at http://localhost:3000
```

---

## 📋 FIRST DAY CHECKLIST

### **Morning: Context Building (2 hours)**

**Watch/Read:**
- [ ] [`/README.md`](../../README.md) - Project overview (15 min)
- [ ] [`/docs/UPSTREAM-DECLARATION.md`](../UPSTREAM-DECLARATION.md) - Upstream origins (20 min)
- [ ] [`/docs/01-architecture/ARCHITECTURE.md`](../01-architecture/ARCHITECTURE.md) - Technical architecture (30 min)
- [ ] [`/docs/SECURITY.md`](../SECURITY.md) - Security policies (20 min)
- [ ] [`/docs/CODING_STANDARDS.md`](../CODING_STANDARDS.md) - Code standards (30 min)
- [ ] [`/docs/DOCS_INDEX.md`](../DOCS_INDEX.md) - Documentation map (15 min)

**Understand:**
- [ ] What are the 5 upstream repos?
- [ ] What is GANGCLAWCITY rebranding?
- [ ] Where is the gateway running?
- [ ] What's your role in the project?

---

### **Afternoon: Hands-On (3 hours)**

**Setup Development Environment:**
- [ ] Node.js v22+ installed
- [ ] pnpm installed (`npm install -g pnpm`)
- [ ] Git configured with SSH key
- [ ] VS Code extensions installed
- [ ] `.env.local` created (see QUICKSTART.md)

**Run Your First App:**
- [ ] Clone repo successfully
- [ ] Run security scan (clean)
- [ ] Install dependencies
- [ ] Start dev server
- [ ] App loads without errors
- [ ] No console errors

**Make Your First Change:**
- [ ] Find a small issue (typo, UI text)
- [ ] Create branch: `feature/your-name-first-change`
- [ ] Make change
- [ ] Run linter: `pnpm lint`
- [ ] Run tests: `pnpm test`
- [ ] Commit with conventional commit message
- [ ] Create PR

---

## 🎯 ROLE-BASED PATHS

### **Developer (Building Features)**

**Read These:**
1. [`/docs/06-contributing/CONTRIBUTING.md`](../06-contributing/CONTRIBUTING.md) - How to contribute
2. [`/docs/CODING_STANDARDS.md`](../CODING_STANDARDS.md) - Code standards
3. [`/docs/08-testing/TESTING_GUIDE.md`](../08-testing/TESTING_GUIDE.md) - Testing guide

**Setup:**
```bash
# Install your app dependencies
pnpm --dir openclaw-office install  # Dashboard
pnpm --dir agent-town install       # CityView

# Create .env.local
cp .env.example .env.local
# Edit with your values (use <GATEWAY_TOKEN> placeholder)
```

**Your First Week:**
- Day 1: Setup & onboarding (this checklist)
- Day 2-3: First small PR (bug fix or typo)
- Day 4-5: First feature PR
- Week 2: Regular contributions

---

### **DevOps (Deployment & Infrastructure)**

**Read These:**
1. [`/docs/02-deployment/DEPLOYMENT.md`](../02-deployment/DEPLOYMENT.md) - Deployment guide
2. [`/docs/SECURITY.md`](../SECURITY.md) - Security policies
3. [`/security/SECURITY_AUDIT_*.md`](../../security/) - Security audits

**Access Required:**
- [ ] GitHub repository access
- [ ] Vercel team access
- [ ] VPS SSH access (if production role)
- [ ] Gateway config access

**Your First Week:**
- Day 1: Understand current deployment
- Day 2: Test local deployment (Docker)
- Day 3: Vercel deployment test
- Day 4: Security audit review
- Day 5: Deployment automation

---

### **Designer (UI/UX)**

**Read These:**
1. [`/docs/05-brand/BRANDKIT.md`](../05-brand/BRANDKIT.md) - Brand guidelines
2. [`/docs/REBRANDING-CHECKLIST.md`](../REBRANDING-CHECKLIST.md) - Rebranding progress
3. [`/docs/CODING_STANDARDS.md#css--tailwind`](../CODING_STANDARDS.md#css--tailwind) - CSS standards

**Tools:**
- Figma (design)
- VS Code (implementation)
- Git (version control)

**Your First Week:**
- Day 1: Brand guidelines review
- Day 2-3: Current UI audit
- Day 4-5: First rebranding PR

---

### **QA/Tester**

**Read These:**
1. [`/docs/08-testing/TESTING_GUIDE.md`](../08-testing/TESTING_GUIDE.md) - Testing strategy
2. [`/docs/CODING_STANDARDS.md#testing-standards`](../CODING_STANDARDS.md#testing-standards) - Test standards
3. [`/docs/SECURITY.md`](../SECURITY.md) - Security testing

**Your First Week:**
- Day 1: Understand testing requirements
- Day 2: Review existing tests
- Day 3-4: Write missing tests
- Day 5: QA checklist creation

---

## 📚 ESSENTIAL DOCUMENTATION

### **Must Read (Tier 1):**
| Doc | Time | Purpose |
|-----|------|---------|
| [`README.md`](../../README.md) | 15 min | Project overview |
| [`START_HERE.md`](START_HERE.md) | 10 min | This checklist |
| [`UPSTREAM-DECLARATION.md`](../UPSTREAM-DECLARATION.md) | 20 min | Upstream origins |
| [`SECURITY.md`](../SECURITY.md) | 20 min | Security rules |

### **Role-Specific (Tier 2):**
| Role | Read These |
|------|------------|
| Developer | CODING_STANDARDS, CONTRIBUTING, TESTING_GUIDE |
| DevOps | DEPLOYMENT, SECURITY, VPS_SETUP |
| Designer | BRANDKIT, DESIGN_SYSTEM, REBRANDING-CHECKLIST |
| QA | TESTING_GUIDE, QA_CHECKLIST, SECURITY |

### **Reference (Tier 3):**
- Market research: [`/docs/04-research/`](../04-research/)
- Skills: [`/skills/`](../../skills/)
- Legacy: [`/docs/99-legacy/`](../99-legacy/)

---

## 🛡️ SECURITY FIRST

### **NON-NEGOTIABLE RULES:**

1. **ALWAYS run security scan before git push:**
   ```bash
   .\security-scan.bat
   ```

2. **NEVER commit tokens:**
   - Use `<GATEWAY_TOKEN>` placeholder
   - Store real tokens in `.env.local` (gitignored)
   - Use Vercel Secrets for production

3. **ALWAYS check for accidental commits:**
   ```bash
   git status
   git diff --staged
   ```

4. **If you expose a token:**
   - STOP immediately
   - Notify team
   - Rotate token on VPS
   - Update all environments

---

## 🎯 SUCCESS METRICS

### **Day 1 Goals:**
- [ ] Environment setup complete
- [ ] Security scan passed
- [ ] First app running locally
- [ ] Read all Tier 1 docs

### **Week 1 Goals:**
- [ ] First PR merged
- [ ] Understand upstream origins
- [ ] Know where to find docs
- [ ] Security-conscious workflow

### **Month 1 Goals:**
- [ ] Regular contributions
- [ ] Deep understanding of architecture
- [ ] Can mentor new contributors
- [ ] Security best practices automatic

---

## 🆘 NEED HELP?

### **Common Issues:**

**"pnpm command not found":**
```bash
npm install -g pnpm
```

**"Port already in use":**
```bash
# Kill process on port 5173 (Windows)
netstat -ano | findstr :5173
taskkill /PID <PID> /F
```

**"Security scan found tokens":**
- Check `.env.local` not committed
- Replace hardcoded tokens with env vars
- Run `.\sanitize-tokens.bat`

**"App won't start":**
1. Check Node.js version: `node -v` (need v22+)
2. Delete `node_modules/` and reinstall
3. Check `.env.local` configuration
4. See [`QUICKSTART.md`](QUICKSTART.md) for detailed troubleshooting

### **Where to Ask:**

**Technical Questions:**
- GitHub Issues (tag: `question`)
- Team Slack/Discord
- Pair with senior dev

**Security Issues:**
- Email: security@gangclawcity.my
- DO NOT post in public channels

**Documentation Issues:**
- Open PR with suggested fix
- Tag: `documentation`

---

## 📞 QUICK REFERENCE

### **Essential Commands:**

```bash
# Security
.\security-scan.bat          # Scan for tokens
.\sanitize-tokens.bat        # Sanitize exposed tokens

# Development
pnpm --dir openclaw-office dev    # Start Dashboard
pnpm --dir agent-town dev         # Start CityView
pnpm --dir ai-town dev            # Start Lab

# Git
git status                   # Check changes
git add .                    # Stage changes
git commit -m "feat: ..."    # Commit with message
git push                     # Push to GitHub

# Deployment
.\git-push-automated.bat     # Safe git push
.\vercel-deploy-all.bat      # Deploy to Vercel
```

### **Essential URLs:**

| Resource | URL |
|----------|-----|
| GitHub | https://github.com/thisisniagahub/GANGCLAWCITY |
| Vercel Dashboard | https://vercel.com/dashboard |
| Gateway | wss://operator.gangniaga.my |
| Documentation | `/docs/DOCS_INDEX.md` |

---

## ✅ CHECKLIST COMPLETE?

**Congratulations!** You're ready to contribute to GANGCLAWCITY.

**Next Steps:**
1. Find your first issue in GitHub Issues
2. Create a branch
3. Make your change
4. Run tests & linter
5. Create PR
6. Celebrate! 🎉

---

**Last Updated:** March 17, 2026  
**Version:** 2.0.0 (Fortune 500 Onboarding)  
**Status:** ✅ **ACTIVE - Required Reading for All**

---

**🚀 GANGCLAWCITY - Professional Onboarding!**  
**🎯 Clear. Structured. Efficient.**
