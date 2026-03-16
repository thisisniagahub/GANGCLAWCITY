# 💻 GANGCLAWCITY Coding Standards

**Professional Code Quality Standards**

---

## 📋 TABLE OF CONTENTS

1. [General Principles](#general-principles)
2. [TypeScript Standards](#typescript-standards)
3. [React Standards](#react-standards)
4. [CSS & Tailwind](#css--tailwind)
5. [Testing Standards](#testing-standards)
6. [Git & Commits](#git--commits)
7. [Code Review](#code-review)
8. [Documentation](#documentation)

---

## 🎯 GENERAL PRINCIPLES

### **Our Philosophy:**

1. **Readability > Cleverness**
   - Write code for humans, not just machines
   - Future you will thank present you
   - If it needs a comment to explain WHY, add it

2. **Consistency > Personal Preference**
   - Follow existing patterns
   - Team standards over individual style
   - Automate enforcement where possible

3. **Simplicity > Complexity**
   - Simple code is maintainable code
   - Avoid over-engineering
   - YAGNI (You Ain't Gonna Need It)

4. **Security First**
   - No hardcoded tokens
   - Validate all inputs
   - Principle of least privilege

---

## 📘 TYPESCRIPT STANDARDS

### **File Structure:**

```typescript
// 1. Imports (grouped and sorted)
import React from 'react'
import { useState, useEffect } from 'react'
import { useRouter } from 'next/router'

// 2. Types & Interfaces
interface UserProps {
  id: string
  name: string
  email: string
}

// 3. Constants
const MAX_RETRIES = 3

// 4. Component/Function
export function UserCard({ id, name, email }: UserProps) {
  // Implementation
}
```

### **Naming Conventions:**

| Type | Convention | Example |
|------|------------|---------|
| **Variables** | camelCase | `const userName = 'John'` |
| **Functions** | camelCase | `function getUser() {}` |
| **Components** | PascalCase | `function UserCard() {}` |
| **Types/Interfaces** | PascalCase | `interface UserProps {}` |
| **Enums** | PascalCase | `enum UserRole {}` |
| **Constants** | UPPER_SNAKE_CASE | `const MAX_SIZE = 100` |
| **Files** | kebab-case | `user-card.tsx` |
| **Hooks** | camelCase with `use` prefix | `useAuth.ts` |

### **Type Safety:**

```typescript
// ✅ DO: Use explicit types for function parameters
function calculateTotal(items: CartItem[]): number {
  return items.reduce((sum, item) => sum + item.price, 0)
}

// ✅ DO: Use interfaces for objects
interface User {
  id: string
  name: string
  email: string
}

// ✅ DO: Use union types for limited values
type Status = 'pending' | 'active' | 'inactive'

// ❌ DON'T: Use `any` unless absolutely necessary
function processData(data: any) // ❌ BAD
function processData(data: unknown) // ✅ BETTER

// ✅ DO: Use generics for reusable functions
function identity<T>(arg: T): T {
  return arg
}
```

### **Error Handling:**

```typescript
// ✅ DO: Use try-catch with specific error types
try {
  await fetchUser(id)
} catch (error) {
  if (error instanceof NetworkError) {
    // Handle network error
  } else if (error instanceof ValidationError) {
    // Handle validation error
  } else {
    // Handle unknown error
    logger.error('Unexpected error:', error)
  }
}

// ✅ DO: Use Result types for expected failures
type Result<T> = Success<T> | Failure

// ❌ DON'T: Ignore errors
await fetchData() // ❌ No error handling
```

---

## ⚛️ REACT STANDARDS

### **Component Structure:**

```tsx
// ✅ DO: Functional components with hooks
import React, { useState, useEffect, useCallback } from 'react'

interface Props {
  userId: string
  onSave?: (data: UserData) => void
}

export function UserProfile({ userId, onSave }: Props) {
  // 1. Hooks first (sorted alphabetically)
  const [user, setUser] = useState<User | null>(null)
  const [loading, setLoading] = useState(true)
  const router = useRouter()

  // 2. Effects
  useEffect(() => {
    loadUser()
  }, [userId])

  // 3. Callbacks
  const handleSave = useCallback((data: UserData) => {
    onSave?.(data)
  }, [onSave])

  // 4. Render logic
  if (loading) return <LoadingSpinner />
  if (!user) return <Error message="User not found" />

  // 5. JSX return
  return (
    <div className="user-profile">
      <h2>{user.name}</h2>
      <button onClick={handleSave}>Save</button>
    </div>
  )
}
```

### **Props & State:**

```tsx
// ✅ DO: Destructure props in function signature
function UserCard({ name, email }: UserProps) {
  return <div>{name} - {email}</div>
}

// ✅ DO: Use typed state
const [count, setCount] = useState<number>(0)
const [user, setUser] = useState<User | null>(null)

// ✅ DO: Use functional updates for dependent state
setCount(prev => prev + 1)

// ❌ DON'T: Store derived values in state
// BAD
const [fullName, setFullName] = useState('')
useEffect(() => {
  setFullName(`${firstName} ${lastName}`)
}, [firstName, lastName])

// GOOD
const fullName = `${firstName} ${lastName}`
```

### **Performance:**

```tsx
// ✅ DO: Use React.memo for expensive components
export const ExpensiveList = React.memo(({ items }) => {
  return items.map(item => <ListItem key={item.id} item={item} />)
})

// ✅ DO: Use useCallback for stable function references
const handleClick = useCallback(() => {
  // Handler logic
}, [dependencies])

// ✅ DO: Use useMemo for expensive calculations
const sortedItems = useMemo(() => {
  return items.sort((a, b) => a.name.localeCompare(b.name))
}, [items])

// ❌ DON'T: Optimize prematurely
// Only memoize when you have actual performance issues
```

---

## 🎨 CSS & TAILWIND STANDARDS

### **Tailwind Best Practices:**

```tsx
// ✅ DO: Use Tailwind utility classes
<button className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
  Click me
</button>

// ✅ DO: Use @apply for repeated patterns (in CSS files)
.btn-primary {
  @apply px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700;
}

// ✅ DO: Use responsive prefixes
<div className="text-sm md:text-base lg:text-lg">
  Responsive text
</div>

// ❌ DON'T: Use inline styles
<div style={{ padding: '16px' }}>Content</div> // ❌ BAD

// ✅ DO: Use CSS variables for theme colors
<div className="text-primary-600">Themed text</div>
```

### **Design Tokens:**

```css
/* ✅ DO: Define design tokens in tailwind.config.js */
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#eff6ff',
          600: '#2563eb',
          700: '#1d4ed8',
        }
      }
    }
  }
}
```

### **Responsive Design:**

```tsx
// Mobile-first approach
<div className="
  grid 
  grid-cols-1      /* Mobile: 1 column */
  md:grid-cols-2   /* Tablet: 2 columns */
  lg:grid-cols-4   /* Desktop: 4 columns */
  gap-4
">
  {children}
</div>
```

---

## 🧪 TESTING STANDARDS

### **Test Structure:**

```typescript
// ✅ DO: Use describe/it/test blocks
import { describe, it, expect, beforeEach } from 'vitest'

describe('UserCard', () => {
  describe('rendering', () => {
    it('should display user name', () => {
      const user = { name: 'John', email: 'john@example.com' }
      render(<UserCard user={user} />)
      
      expect(screen.getByText('John')).toBeInTheDocument()
    })
  })

  describe('interactions', () => {
    it('should call onSave when save button clicked', async () => {
      const onSave = vi.fn()
      render(<UserCard user={user} onSave={onSave} />)
      
      await userEvent.click(screen.getByText('Save'))
      
      expect(onSave).toHaveBeenCalledWith(user)
    })
  })
})
```

### **Test Coverage Requirements:**

| Component Type | Minimum Coverage |
|----------------|------------------|
| Core Business Logic | 90% |
| UI Components | 80% |
| Utilities | 95% |
| API Routes | 85% |

### **Testing Best Practices:**

```typescript
// ✅ DO: Test behavior, not implementation
it('should save user data when form submitted', async () => {
  // Test what happens, not how it happens
})

// ✅ DO: Use test factories for test data
const createUser = (overrides = {}) => ({
  id: '1',
  name: 'Test User',
  email: 'test@example.com',
  ...overrides
})

// ❌ DON'T: Test implementation details
// BAD
expect(component.state.count).toBe(5)

// GOOD
expect(screen.getByText('Count: 5')).toBeInTheDocument()
```

---

## 📝 GIT & COMMITS

### **Commit Message Format:**

```
<type>(<scope>): <subject>

<body>

<footer>
```

### **Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Build/config changes

### **Examples:**

```bash
# ✅ GOOD: Clear and descriptive
feat(dashboard): add user authentication with JWT
fix(api): resolve rate limiting issue in gateway
docs(readme): update installation instructions
refactor(auth): simplify token validation logic
test(user): add unit tests for user service
chore(deps): update react to v19.0.0

# ❌ BAD: Too vague
fix: fixed stuff
update: updated files
```

### **Branch Naming:**

```bash
# Format: <type>/<description>
feature/user-authentication
fix/gateway-token-issue
docs/update-readme
refactor/auth-module
```

---

## 🔍 CODE REVIEW

### **Review Checklist:**

**Before Submitting:**
- [ ] Code follows style guide
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] No console.log or debugger
- [ ] No hardcoded tokens
- [ ] Security scan passed

**During Review:**
- [ ] Logic is correct
- [ ] Edge cases handled
- [ ] Performance considered
- [ ] Error handling present
- [ ] Code is readable
- [ ] No over-engineering

### **Review Etiquette:**

**DO:**
- ✅ Be constructive and specific
- ✅ Explain WHY something should change
- ✅ Suggest alternatives
- ✅ Acknowledge good code
- ✅ Review within 24 hours

**DON'T:**
- ❌ Make personal comments
- ❌ Say "this is wrong" without explanation
- ❌ Request unnecessary changes
- ❌ Delay reviews unnecessarily

---

## 📚 DOCUMENTATION

### **Code Comments:**

```typescript
// ✅ DO: Comment WHY, not WHAT
// Using debounce to prevent API rate limiting
const search = debounce(async (query) => {
  await api.search(query)
}, 300)

// ❌ DON'T: State the obvious
// Set count to 0
let count = 0 // ❌ BAD

// ✅ DO: Document complex logic
/**
 * Calculates the total price including:
 * - Base price
 * - Tax (varies by region)
 * - Shipping (free over $50)
 * - Discounts (if applicable)
 */
function calculateTotal(cart: Cart): number {
  // Implementation
}
```

### **JSDoc Standards:**

```typescript
/**
 * Fetches user data from the API
 * 
 * @param userId - The unique identifier of the user
 * @param options - Optional fetch configuration
 * @returns Promise resolving to user data
 * @throws {NotFoundError} If user doesn't exist
 * @throws {NetworkError} If network request fails
 * 
 * @example
 * const user = await fetchUser('123')
 * console.log(user.name)
 */
async function fetchUser(
  userId: string,
  options?: FetchOptions
): Promise<User> {
  // Implementation
}
```

---

## 🎯 PROJECT-SPECIFIC STANDARDS

### **openclaw-office/ (Dashboard):**
- Use Vite + React + TypeScript
- State management: Zustand
- Testing: Vitest + React Testing Library
- Styling: Tailwind CSS v4
- Linting: Oxlint

### **agent-town/ (CityView):**
- Use Next.js App Router
- Game engine: Phaser 3
- Styling: Tailwind CSS v4
- Linting: ESLint + Next.js config

### **ai-town/ (Lab):**
- Use Vite + React + TypeScript
- Backend: Convex
- Testing: Jest
- Styling: Tailwind CSS

---

## 📊 QUALITY METRICS

| Metric | Target | Current |
|--------|--------|---------|
| Test Coverage | >80% | 📋 TBD |
| ESLint Errors | 0 | ✅ 0 |
| TypeScript Errors | 0 | ✅ 0 |
| Build Time | <30s | 📋 TBD |
| Bundle Size | <500KB | 📋 TBD |

---

## 🛠️ TOOLING

### **Required Extensions:**

**VS Code:**
- ESLint
- Prettier
- TypeScript Hero
- Tailwind CSS IntelliSense
- GitLens

### **Pre-commit Hooks:**

```json
{
  "hooks": {
    "pre-commit": [
      "eslint src/",
      "prettier --check src/",
      "tsc --noEmit",
      "vitest run"
    ]
  }
}
```

---

**Last Updated:** March 17, 2026  
**Version:** 1.0.0 (Fortune 500 Standards)  
**Status:** ✅ **ACTIVE - Follow for All Code**

---

**💻 GANGCLAWCITY Coding Standards - Professional Quality!**  
**🚀 Consistent. Maintainable. Scalable.**
