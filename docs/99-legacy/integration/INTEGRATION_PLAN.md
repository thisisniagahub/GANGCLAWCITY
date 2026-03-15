# 🏙️ GANGCLAWCITY Integration Plan

**Status:** ✅ Ready to Execute  
**Created:** March 13, 2026  
**Priority:** CRITICAL

---

## 🎯 Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    GANGCLAWCITY Platform                     │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                   Entry Point                         │  │
│  │              gangclawcity.my (Main Domain)            │  │
│  └──────────────────────────────────────────────────────┘  │
│                           │                                  │
│              ┌────────────┼────────────┐                    │
│              │            │            │                     │
│              ▼            ▼            ▼                     │
│  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐        │
│  │ /marketing   │ │ /demo        │ │ /dashboard   │        │
│  │              │ │              │ │              │        │
│  │ Landing Page │ │ Agent Town   │ │ OpenClaw     │        │
│  │              │ │ (Interactive)│ │ Office       │        │
│  │ - Brand story│ │ - Pixel RPG  │ │              │        │
│  │ - Email cap. │ │ - Onboarding │ │ - Monitoring │        │
│  │ - Waitlist   │ │ - Viral demo │ │ - Real-time  │        │
│  └──────────────┘ └──────────────┘ └──────────────┘        │
│                                                              │
│  ┌──────────────┐ ┌──────────────┐                          │
│  │ /lab         │ │ /research    │                          │
│  │              │ │              │                          │
│  │ AI Town      │ │ Star Office  │                          │
│  │ - Social sim │ │ - State viz  │                          │
│  │ - Memory DB  │ │ - Quick view │                          │
│  └──────────────┘ └──────────────┘                          │
└─────────────────────────────────────────────────────────────┘
```

---

## 📁 Repository Mapping

| Sub-path | Repo | Port | Purpose |
|----------|------|------|---------|
| `/` (root) | `landing-page/` | 8080 | Marketing site |
| `/demo` | `agent-town/` | 3000 | Interactive demo |
| `/dashboard` | `openclaw-office/` | 5180 | Command dashboard |
| `/lab` | `ai-town/` | 5173 | Experimental |
| `/research` | `Star-Office-UI/` | 19000 | State visualization |

---

## 🔧 Integration Steps

### **Phase 1: Unified Deployment (TODAY)**

#### **Step 1.1: Root Skaffold Configuration**

Create master `skaffold.yaml` that deploys all 5 services:

```yaml
# skaffold.yaml (root)
apiVersion: skaffold/v4beta12
kind: Config
metadata:
  name: gangclawcity-platform

profiles:
  # Development - run all services
  - name: dev
    build:
      local:
        push: false
      artifacts:
        - image: gangclawcity/landing-page
          context: ./landing-page
        - image: gangclawcity/agent-town
          context: ./agent-town
        - image: gangclawcity/openclaw-office
          context: ./openclaw-office
        - image: gangclawcity/ai-town
          context: ./ai-town
        - image: gangclawcity/star-office-ui
          context: ./Star-Office-UI
    deploy:
      kubectl:
        manifests:
          - k8s/*.yaml
    portForward:
      - resourceType: service
        resourceName: landing-page
        port: 80
        localPort: 8080
      - resourceType: service
        resourceName: agent-town
        port: 3000
        localPort: 3000
      - resourceType: service
        resourceName: openclaw-office
        port: 80
        localPort: 5180
      - resourceType: service
        resourceName: ai-town
        port: 80
        localPort: 5173
      - resourceType: service
        resourceName: star-office-ui
        port: 80
        localPort: 19000

  # Production - selective deploy
  - name: prod
    build:
      googleCloudBuild:
        diskSizeGb: 300
        machineType: N1_HIGHCPU_32
    deploy:
      kubectl: {}
```

---

#### **Step 1.2: Kubernetes Ingress Controller**

Create `k8s/ingress.yaml` for routing:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: gangclawcity-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - gangclawcity.my
        - www.gangclawcity.my
      secretName: gangclawcity-tls
  rules:
    - host: gangclawcity.my
      http:
        paths:
          # Landing Page (root)
          - path: /()(.*)
            pathType: Prefix
            backend:
              service:
                name: landing-page
                port:
                  number: 80
          
          # Agent Town (/demo)
          - path: /demo/(.*)
            pathType: Prefix
            backend:
              service:
                name: agent-town
                port:
                  number: 3000
          
          # OpenClaw Office (/dashboard)
          - path: /dashboard/(.*)
            pathType: Prefix
            backend:
              service:
                name: openclaw-office
                port:
                  number: 80
          
          # AI Town (/lab)
          - path: /lab/(.*)
            pathType: Prefix
            backend:
              service:
                name: ai-town
                port:
                  number: 80
          
          # Star Office (/research)
          - path: /research/(.*)
            pathType: Prefix
            backend:
              service:
                name: star-office-ui
                port:
                  number: 80
```

---

#### **Step 1.3: Shared Navigation Component**

Add navigation bar to ALL apps with consistent branding:

**Create:** `components/PlatformNav.tsx` (copy to all repos)

```tsx
import React from 'react';

export function PlatformNav() {
  const navItems = [
    { href: '/', label: 'Home', active: true },
    { href: '/demo', label: 'Demo', active: false },
    { href: '/dashboard', label: 'Dashboard', active: false },
    { href: '/lab', label: 'Lab', active: false },
    { href: '/research', label: 'Research', active: false },
  ];

  return (
    <nav className="platform-nav">
      <div className="nav-brand">
        <span className="logo-icon">⬡</span>
        <span className="logo-text">GANGCLAW<span className="accent">CITY</span></span>
      </div>
      
      <div className="nav-links">
        {navItems.map((item) => (
          <a 
            key={item.href}
            href={item.href}
            className={`nav-link ${item.active ? 'active' : ''}`}
          >
            {item.label}
          </a>
        ))}
      </div>

      <div className="nav-actions">
        <a href="/dashboard" className="btn btn-primary">
          Launch Dashboard
        </a>
      </div>

      <style jsx>{`
        .platform-nav {
          display: flex;
          align-items: center;
          justify-content: space-between;
          padding: 16px 24px;
          background: rgba(6, 8, 15, 0.95);
          backdrop-filter: blur(20px);
          border-bottom: 1px solid rgba(0, 229, 255, 0.1);
          position: sticky;
          top: 0;
          z-index: 1000;
        }

        .nav-brand {
          display: flex;
          align-items: center;
          gap: 12px;
          font-size: 1.5rem;
          font-weight: 800;
        }

        .logo-icon {
          color: #00e5ff;
          font-size: 2rem;
          filter: drop-shadow(0 0 12px rgba(0, 229, 255, 0.5));
        }

        .accent {
          color: #00e5ff;
        }

        .nav-links {
          display: flex;
          gap: 24px;
        }

        .nav-link {
          color: #8b92a8;
          text-decoration: none;
          font-weight: 500;
          transition: color 0.3s;
          position: relative;
        }

        .nav-link:hover {
          color: #e8eaf0;
        }

        .nav-link.active {
          color: #00e5ff;
        }

        .nav-link.active::after {
          content: '';
          position: absolute;
          bottom: -4px;
          left: 0;
          right: 0;
          height: 2px;
          background: linear-gradient(90deg, #00e5ff, #e040fb);
          border-radius: 2px;
        }

        .btn {
          padding: 10px 20px;
          border-radius: 12px;
          font-weight: 600;
          text-decoration: none;
          transition: all 0.3s;
        }

        .btn-primary {
          background: linear-gradient(135deg, #00e5ff 0%, #e040fb 100%);
          color: #06080f;
        }

        .btn-primary:hover {
          transform: translateY(-2px);
          box-shadow: 0 8px 24px rgba(0, 229, 255, 0.4);
        }

        @media (max-width: 768px) {
          .platform-nav {
            flex-direction: column;
            gap: 16px;
          }

          .nav-links {
            flex-wrap: wrap;
            justify-content: center;
            gap: 16px;
          }
        }
      `}</style>
    </nav>
  );
}
```

---

### **Phase 2: Brand Integration (TODAY)**

#### **Step 2.1: Apply Brand Kit to All Apps**

Update each app's styling to match brand guidelines:

**Landing Page:**
- ✅ Already using brand colors
- ✅ Already using Outfit font
- ✅ Already using particle effects
- ⚠️ Need: Add platform navigation

**Agent Town:**
- Update colors to brand palette
- Add Outfit font
- Add platform navigation
- Update logo to GANGCLAWCITY branding

**OpenClaw Office:**
- Update Tailwind config with brand colors
- Add Outfit font
- Add platform navigation
- Update logo

**AI Town:**
- Update CSS variables with brand colors
- Add Outfit font
- Add platform navigation

**Star-Office-UI:**
- Update Flask templates with brand colors
- Add Outfit font
- Add platform navigation

---

#### **Step 2.2: Shared CSS Variables**

Create `styles/brand.css` for all apps:

```css
:root {
  /* Brand Colors */
  --cyan-500: #00e5ff;
  --cyan-600: #00c8e0;
  --magenta-500: #e040fb;
  --magenta-600: #c41fdf;
  --gold-500: #ffc400;
  --gold-600: #ffab00;
  --green-500: #00e676;
  --red-500: #ff5252;

  /* Backgrounds */
  --bg-primary: #06080f;
  --bg-secondary: #0a0e1a;
  --bg-tertiary: #0d1221;
  --bg-card: #111833;
  --bg-elevated: #1a1f3a;

  /* Text */
  --text-primary: #e8eaf0;
  --text-secondary: #8b92a8;
  --text-tertiary: #5c6280;

  /* Typography */
  --font-main: 'Outfit', -apple-system, BlinkMacSystemFont, sans-serif;
  --font-mono: 'JetBrains Mono', monospace;

  /* Spacing */
  --radius-sm: 8px;
  --radius-md: 12px;
  --radius-lg: 16px;
  --radius-xl: 24px;
  --radius-full: 9999px;

  /* Gradients */
  --gradient-main: linear-gradient(135deg, #00e5ff 0%, #e040fb 50%, #ffc400 100%);
  --gradient-cyber: linear-gradient(135deg, #06080f 0%, #0a0e1a 50%, #0d1221 100%);
  
  /* Shadows */
  --glow-cyan: 0 0 20px rgba(0, 229, 255, 0.3);
  --glow-magenta: 0 0 20px rgba(224, 64, 251, 0.3);
}
```

---

### **Phase 3: Cross-Promotion (TOMORROW)**

#### **Step 3.1: Landing Page → Demo/Dashboard**

Add CTAs on landing page:

```html
<!-- In landing-page/index.html, update hero section -->
<div class="hero-actions">
  <a href="#solution" class="btn btn-primary">
    <span>Explore the City</span>
    <svg><!-- arrow icon --></svg>
  </a>
  <a href="/demo" class="btn btn-ghost">
    <span>🎮 Try Interactive Demo</span>
  </a>
  <a href="/dashboard" class="btn btn-ghost">
    <span>📊 Launch Dashboard</span>
  </a>
</div>
```

---

#### **Step 3.2: Agent Town → Dashboard**

Add "Launch Full Dashboard" button in Agent Town:

```tsx
// In agent-town/components/PlatformNav.tsx
<div className="nav-actions">
  <a href="/dashboard" className="btn btn-primary">
    📊 Full Dashboard
  </a>
</div>
```

---

#### **Step 3.3: Dashboard → Demo**

Add "Try Demo" link in OpenClaw Office:

```tsx
// In openclaw-office/src/components/PlatformNav.tsx
<a href="/demo" className="btn btn-ghost">
  🎮 Interactive Demo
</a>
```

---

### **Phase 4: Shared Authentication (DAY 3)**

#### **Step 4.1: Implement JWT Token Sharing**

All apps share same auth token via localStorage:

```typescript
// Shared auth utility (copy to all apps)
export function getAuthToken() {
  return localStorage.getItem('gangclawcity_token');
}

export function setAuthToken(token: string) {
  localStorage.setItem('gangclawcity_token', token);
}

export function removeAuthToken() {
  localStorage.removeItem('gangclawcity_token');
}
```

---

#### **Step 4.2: Auth Guard Component**

Create shared auth guard:

```tsx
// components/AuthGuard.tsx
import { useEffect, useState } from 'react';
import { useRouter } from 'next/router';
import { getAuthToken } from '../lib/auth';

export function AuthGuard({ children }: { children: React.ReactNode }) {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const router = useRouter();

  useEffect(() => {
    const token = getAuthToken();
    if (!token) {
      router.push('/login');
      return;
    }
    setIsAuthenticated(true);
  }, []);

  if (!isAuthenticated) {
    return <div>Loading...</div>;
  }

  return <>{children}</>;
}
```

---

## 📅 Execution Timeline

### **Day 1 (TODAY): Infrastructure**
- [ ] Create root `skaffold.yaml`
- [ ] Create `k8s/ingress.yaml`
- [ ] Create `k8s/services.yaml`
- [ ] Test unified deployment
- [ ] Create `PlatformNav` component
- [ ] Deploy all 5 services

**Success Criteria:**
```bash
skaffold dev

# Should deploy:
✅ landing-page (port 8080)
✅ agent-town (port 3000)
✅ openclaw-office (port 5180)
✅ ai-town (port 5173)
✅ star-office-ui (port 19000)

# Access:
✅ http://localhost:8080 → Landing page
✅ http://localhost:3000 → Agent Town
✅ http://localhost:5180 → Dashboard
✅ http://localhost:5173 → AI Town
✅ http://localhost:19000 → Star Office
```

---

### **Day 2: Brand Integration**
- [ ] Apply brand colors to all apps
- [ ] Add Outfit font to all apps
- [ ] Add PlatformNav to all apps
- [ ] Test cross-app navigation
- [ ] Add email capture to landing page

**Success Criteria:**
- All apps have consistent branding
- Navigation works between apps
- Email capture form functional

---

### **Day 3: Polish & Launch**
- [ ] Add auth token sharing
- [ ] Add cross-promotion CTAs
- [ ] Test full user journey
- [ ] Performance optimization
- [ ] Deploy to production

**Success Criteria:**
```
User Journey:
1. Land on landing-page → Sign up for waitlist
2. Click "Try Demo" → Play Agent Town
3. Click "Full Dashboard" → Open OpenClaw Office
4. All navigation works seamlessly
5. Branding consistent throughout
```

---

## 🚀 Deployment Commands

### **Local Development:**
```bash
cd G:\PROJECT-4\GANGCLAWCITY

# Deploy all services with hot-reload
skaffold dev

# Or deploy selectively
skaffold dev -p landing-page-only
skaffold dev -p dashboard-only
```

### **Production:**
```bash
# Build all images
skaffold build

# Deploy to cluster
skaffold run

# Or with Google Cloud Build
skaffold run -p prod
```

---

## 📊 Monitoring

### **Health Checks:**
```bash
# Check all pods
kubectl get pods

# Check all services
kubectl get services

# Check ingress
kubectl get ingress

# View logs
kubectl logs -l app=landing-page
kubectl logs -l app=agent-town
kubectl logs -l app=openclaw-office
```

### **Port Forwarding (if needed):**
```bash
# Forward all services
kubectl port-forward svc/landing-page 8080:80 &
kubectl port-forward svc/agent-town 3000:3000 &
kubectl port-forward svc/openclaw-office 5180:80 &
kubectl port-forward svc/ai-town 5173:80 &
kubectl port-forward svc/star-office-ui 19000:80 &
```

---

## ✅ Integration Checklist

### **Infrastructure**
- [ ] Root skaffold.yaml created
- [ ] Kubernetes ingress configured
- [ ] All services deployable
- [ ] Port forwarding working

### **Branding**
- [ ] Brand colors applied to all apps
- [ ] Outfit font added to all apps
- [ ] PlatformNav component in all apps
- [ ] Logo consistent across apps

### **Navigation**
- [ ] Cross-app links working
- [ ] PlatformNav in all apps
- [ ] Breadcrumbs implemented
- [ ] 404 page with navigation

### **Authentication**
- [ ] JWT token sharing implemented
- [ ] Auth guard component working
- [ ] Login/logout flows tested
- [ ] Session persistence working

### **Launch Ready**
- [ ] All tests passing
- [ ] Performance optimized
- [ ] Accessibility checked
- [ ] Documentation complete

---

## 🎯 Success Metrics

### **Technical:**
- ✅ All 5 services deployable via single command
- ✅ Cross-app navigation seamless
- ✅ Branding consistent across platform
- ✅ Load time < 3 seconds per app

### **User Experience:**
- ✅ User can navigate from landing → demo → dashboard
- ✅ No broken links or 404s
- ✅ Consistent look and feel
- ✅ Clear value proposition at each step

### **Business:**
- ✅ Email capture on landing page
- ✅ Demo engagement tracking
- ✅ Dashboard activation metrics
- ✅ User journey analytics

---

**Status:** Ready to Execute  
**Priority:** CRITICAL  
**ETA:** 3 days to full integration

---

**🏙️ GANGCLAWCITY** — A living operating system for digital labor.  
**Built with ❤️ in Malaysia** 🇲🇾
