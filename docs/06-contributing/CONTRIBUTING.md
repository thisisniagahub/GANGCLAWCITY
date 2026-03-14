# Contributing to GANGCLAWCITY

> Guidelines for contributing to the project

**Version:** 1.0.0  
**Last Updated:** March 13, 2026

---

## 🎯 Welcome!

Terima kasih kerana berminat untuk menyumbang kepada GANGCLAWCITY! We welcome contributions from everyone in the community.

This document provides guidelines and instructions for contributing.

---

## 📋 Table of Contents

- [Code of Conduct](#-code-of-conduct)
- [Getting Started](#-getting-started)
- [How to Contribute](#-how-to-contribute)
- [Development Setup](#-development-setup)
- [Coding Standards](#-coding-standards)
- [Commit Guidelines](#-commit-guidelines)
- [Pull Request Process](#-pull-request-process)
- [Bug Reports](#-bug-reports)
- [Feature Requests](#-feature-requests)

---

## 🤝 Code of Conduct

### Our Pledge

We pledge to make participation in GANGCLAWCITY a harassment-free experience for everyone, regardless of:
- Age, body size, disability
- Ethnicity, gender identity and expression
- Level of experience, nationality
- Personal appearance, race, religion
- Sexual orientation, socioeconomic status

### Expected Behavior

- ✅ Use welcoming and inclusive language
- ✅ Be respectful of differing viewpoints
- ✅ Gracefully accept constructive criticism
- ✅ Focus on what is best for the community
- ✅ Show empathy towards other community members

### Unacceptable Behavior

- ❌ Use of sexualized language or imagery
- ❌ Personal attacks, insulting/derogatory comments
- ❌ Public or private harassment
- ❌ Publishing others' private information without permission
- ❌ Other conduct inappropriate in a professional setting

**Report violations to:** conduct@gangclawcity.my

---

## 🚀 Getting Started

### 1. Fork the Repository

```bash
# Visit https://github.com/your-org/gangclawcity
# Click "Fork" button
```

### 2. Clone Your Fork

```bash
git clone https://github.com/YOUR_USERNAME/gangclawcity.git
cd gangclawcity
```

### 3. Add Upstream Remote

```bash
git remote add upstream https://github.com/your-org/gangclawcity.git
git remote -v  # Verify remotes
```

### 4. Install Dependencies

```bash
pnpm install
```

### 5. Start Development Server

```bash
pnpm dev
```

---

## 💡 How to Contribute

### Ways to Contribute

1. **🐛 Bug Reports**
   - Find a bug? Create an issue
   - Include steps to reproduce
   - Add screenshots if applicable

2. **💡 Feature Requests**
   - Suggest new features via issues
   - Explain the use case
   - Describe expected behavior

3. **📝 Documentation**
   - Improve existing docs
   - Add examples
   - Fix typos

4. **🎨 Design**
   - UI/UX improvements
   - District designs
   - Icon sets

5. **💻 Code**
   - Fix bugs
   - Implement features
   - Write tests

6. **🌍 Translations**
   - Add Bahasa Malaysia
   - Add other languages
   - Improve existing translations

7. **📢 Community**
   - Help others in discussions
   - Share your use cases
   - Write blog posts

---

## 🛠️ Development Setup

### Prerequisites

- Node.js >= 22
- pnpm >= 9
- Git
- Code editor (VS Code recommended)

### Local Development

```bash
# Install dependencies
pnpm install

# Start development server
pnpm dev

# Run linter
pnpm lint

# Run tests
pnpm test

# Build for production
pnpm build
```

### OpenClaw Setup (Optional)

For testing OpenClaw integration:

```bash
# Install OpenClaw
npm install -g openclaw@latest

# Start OpenClaw gateway
openclaw gateway --port 18789

# GANGCLAWCITY will auto-connect to gateway
```

---

## 📐 Coding Standards

### General Guidelines

1. **Follow Existing Patterns**
   - Match code style in surrounding code
   - Use established conventions
   - Keep components small and focused

2. **TypeScript**
   - Use TypeScript for all new code
   - Define proper types (avoid `any`)
   - Use interfaces for objects

3. **Naming Conventions**
   ```typescript
   // Variables and functions: camelCase
   const taskCount = 5;
   function calculateMetrics() {}

   // Components and classes: PascalCase
   const DistrictCard = () => {};
   class TaskRouter {}

   // Constants: UPPER_SNAKE_CASE
   const MAX_RETRY_COUNT = 3;

   // Files: kebab-case
   // district-card.tsx
   // task-router.ts
   ```

4. **Comments**
   - Comment **why**, not **what**
   - Keep comments up-to-date
   - Use JSDoc for public APIs

### Code Examples

**Good Component:**
```typescript
interface DistrictCardProps {
  district: District;
  onClick: (id: string) => void;
}

export function DistrictCard({ district, onClick }: DistrictCardProps) {
  return (
    <button
      onClick={() => onClick(district.id)}
      className="p-4 rounded-lg border hover:shadow-lg"
    >
      <h3 className="text-lg font-semibold">{district.name}</h3>
      <p className="text-sm text-gray-600">{district.status}</p>
    </button>
  );
}
```

**Bad Component:**
```typescript
// ❌ No types, unclear props
export default function Card({ d, handleClick }) {
  return (
    <button onClick={() => handleClick(d.id)}>
      <h3>{d.name}</h3>
      <p>{d.status}</p>
    </button>
  );
}
```

---

## 📝 Commit Guidelines

### Commit Message Format

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Adding tests
- `chore`: Build/config changes

### Examples

```bash
# Feature
feat(command-tower): add real-time task count per district

# Bug fix
fix(district-routing): resolve task routing loop issue

# Documentation
docs(readme): update installation instructions

# Refactor
refactor(gateway): simplify WebSocket connection logic

# Performance
perf(city-renderer): optimize agent sprite rendering
```

### Commit Best Practices

1. **Keep commits atomic**
   - One logical change per commit
   - Easy to revert if needed

2. **Write clear subjects**
   - Use imperative mood ("add" not "added")
   - No period at the end
   - Limit to 50 characters

3. **Add body for complex changes**
   - Explain **why**, not **what**
   - Include context
   - Reference issues/PRs

---

## 🔄 Pull Request Process

### Before Submitting

1. **Update your branch**
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Run tests**
   ```bash
   pnpm test
   ```

3. **Run linter**
   ```bash
   pnpm lint
   ```

4. **Build project**
   ```bash
   pnpm build
   ```

### Creating PR

1. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Open Pull Request**
   - Visit https://github.com/your-org/gangclawcity/pulls
   - Click "New Pull Request"
   - Select your branch

3. **Fill PR Template**
   - Describe changes
   - Link related issues
   - Add screenshots if UI changes
   - Checklist for reviewer

### PR Guidelines

**Good PR Title:**
```
feat(command-tower): add real-time task count per district
```

**Good PR Description:**
```markdown
## What changes were made?
- Added WebSocket subscription to task events
- Updated Command Tower dashboard with live counts
- Added tests for task count calculation

## Why were these changes made?
Users requested real-time visibility into task progress.

## Screenshots
[Before/After images]

## Related Issues
Closes #123
```

### Review Process

1. **Automated Checks**
   - CI/CD pipeline must pass
   - Tests must pass
   - Linter must pass

2. **Code Review**
   - Maintainer reviews code
   - Requested changes must be addressed
   - Approval required for merge

3. **Merge**
   - Squash and merge (preferred)
   - Delete branch after merge

---

## 🐛 Bug Reports

### Before Reporting

1. **Search existing issues**
   - Check if bug already reported
   - Add comment if duplicate

2. **Try to reproduce**
   - Use latest version
   - Clear browser cache
   - Try different browser

### Bug Report Template

```markdown
**Describe the bug**
Clear description of what the bug is.

**To Reproduce**
Steps to reproduce:
1. Go to '...'
2. Click on '...'
3. See error

**Expected behavior**
What you expected to happen.

**Screenshots**
If applicable, add screenshots.

**Environment:**
- OS: [e.g., Windows 11, macOS 14]
- Browser: [e.g., Chrome 120, Safari 17]
- Version: [e.g., v0.1.0]

**Additional context**
Any other details.
```

---

## 💡 Feature Requests

### Before Requesting

1. **Search existing requests**
   - Check if feature already requested
   - Upvote if duplicate

2. **Check roadmap**
   - Feature might be planned
   - See ROADMAP.md

### Feature Request Template

```markdown
**Is your feature request related to a problem?**
Clear description of the problem.

**Describe the solution you'd like**
What you want to happen.

**Describe alternatives you've considered**
Other solutions you've thought about.

**Additional context**
Any other details, mockups, etc.
```

---

## 📚 Resources

### Documentation
- [README.md](README.md) - Project overview
- [ARCHITECTURE.md](ARCHITECTURE.md) - Technical design
- [ROADMAP.md](ROADMAP.md) - Development timeline
- [VPS_DEPLOYMENT.md](VPS_DEPLOYMENT.md) - Deployment guide

### External Resources
- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [TypeScript Best Practices](https://typescriptlang.org/docs)
- [Next.js Documentation](https://nextjs.org/docs)

---

## 🏆 Recognition

Contributors will be recognized in:
- CONTRIBUTORS.md file
- Release notes
- Annual community report

**Top contributors may receive:**
- GANGCLAWCITY swag
- Free Pro account
- Invitation to beta testing
- Speaking opportunities at events

---

## ❓ Questions?

Need help? Reach out via:
- 💬 Discord: [Join our server](https://discord.gg/gangclawcity)
- 📧 Email: contributors@gangclawcity.my
- 🐦 Twitter: [@gangclawcity](https://twitter.com/gangclawcity)

---

**Terima kasih for contributing to GANGCLAWCITY! 🇲🇾**
