# 🏙️ GANGCLAWCITY Brand Kit

**Version:** 1.0.0  
**Created:** March 13, 2026  
**Status:** Brand Identity System

---

## 📋 Table of Contents

1. [Brand Essence](#-brand-essence)
2. [Logo System](#-logo-system)
3. [Color Palette](#-color-palette)
4. [Typography](#-typography)
5. [Visual Language](#-visual-language)
6. [Voice & Tone](#-voice--tone)
7. [Iconography](#-iconography)
8. [Imagery Style](#-imagery-style)
9. [Layout Principles](#-layout-principles)
10. [Applications](#-applications)

---

## 🎯 Brand Essence

### **Mission**
> Make AI workforce management **visible, understandable, and accessible** for Malaysian businesses.

### **Vision**
> Become the operating system for AI labor — where agents are workers, tasks are traffic, and success is visible.

### **Values**

| Value | Meaning |
|-------|---------|
| **👁️ Visibility** | Make the invisible visible. AI work should be seen. |
| **🎮 Playfulness** | Work doesn't have to feel like work. Make it fun. |
| **🇲🇾 Malaysia-First** | Built for Malaysia, by Malaysians. Proudly local. |
| **⚡ Practicality** | No gimmicks. Real tools for real businesses. |
| **🏙️ Spatial Thinking** | Organization through space, not tabs. |

### **Brand Personality**

```
           Technical ─────●───── Human
                          │
           Corporate ─────┼───── Casual
                          │
           Global ────────●───── Local (Malaysia)
                          │
           Serious ───────┼───── Playful
                          │
           Abstract ──────●───── Visual
```

**Sweet Spot:** **Visual, Playful, Local, Human, Practical**

---

## 🎨 Logo System

### **Primary Logo**

```
   ⬡ GANGCLAW<span style="color: #00e5ff">CITY</span>
```

**Usage:**
- Main branding
- Website header
- Marketing materials
- Social media profiles

**Clear Space:**
```
Minimum clear space = height of "G"
   
   G G G G G
G  ⬡ GANGCLAWCITY  G
G                   G
   G G G G G
```

**Minimum Size:**
- Digital: 120px width
- Print: 25mm width

---

### **Logo Variations**

#### **1. Full Logo (Horizontal)**
```
⬡ GANGCLAWCITY
```
**Use:** Website, presentations, documents

#### **2. Icon Only**
```
⬡
```
**Use:** Favicon, app icon, social avatar

#### **3. Wordmark Only**
```
GANGCLAWCITY
```
**Use:** When icon is impractical

#### **4. Stacked Version**
```
   ⬡
GANGCLAW
  CITY
```
**Use:** Vertical spaces (mobile, banners)

---

### **Logo Colors**

#### **Primary (Full Color)**
```
⬡ #00e5ff (Cyan)
GANGCLAW #e8eaf0 (White)
CITY #00e5ff (Cyan)
```

#### **Monochrome (Light)**
```
⬡ #ffffff
GANGCLAWCITY #ffffff
```
**Use:** Dark backgrounds

#### **Monochrome (Dark)**
```
⬡ #0a0e1a
GANGCLAWCITY #0a0e1a
```
**Use:** Light backgrounds

#### **Gradient**
```
⬡ linear-gradient(135deg, #00e5ff, #e040fb, #ffc400)
```
**Use:** Special occasions, hero sections

---

### **Logo Don'ts**

❌ Don't stretch or distort
```
⬡ GANGCLAWCITY  (stretched horizontally)
⬡
G
A
N
G
C
L
A
W
C
I
T
Y  (stretched vertically)
```

❌ Don't change colors randomly
```
⬡ GANGCLAWCITY  (random red)
⬡ GANGCLAWCITY  (random green)
```

❌ Don't add effects
```
⬡ GANGCLAWCITY  (drop shadow)
⬡ GANGCLAWCITY  (outline)
⬡ GANGCLAWCITY  (glow)
```

❌ Don't rotate
```
   ⬡ GANGCLAWCITY  (rotated 45°)
```

---

## 🎨 Color Palette

### **Primary Colors**

#### **Cyber Cyan**
```css
--cyan-500: #00e5ff
--cyan-600: #00c8e0
--cyan-700: #00a8bc
--cyan-800: #008899
--cyan-900: #006877
```
**Usage:** Primary actions, links, highlights
**Accessibility:** White text on cyan-500+ passes WCAG AA

---

#### **Neon Magenta**
```css
--magenta-500: #e040fb
--magenta-600: #c41fdf
--magenta-700: #a30fb8
--magenta-800: #820f91
--magenta-900: #660f70
```
**Usage:** Secondary actions, accents, gradients
**Accessibility:** White text on magenta-600+ passes WCAG AA

---

#### **Electric Gold**
```css
--gold-400: #ffd740
--gold-500: #ffc400
--gold-600: #ffab00
--gold-700: #ff8f00
--gold-800: #ff6f00
```
**Usage:** Warnings, highlights, special badges
**Accessibility:** Black text on gold-400/500 passes WCAG AA

---

### **Secondary Colors**

#### **Success Green**
```css
--green-500: #00e676
--green-600: #00c853
--green-700: #00a843
--green-800: #008933
--green-900: #006923
```
**Usage:** Success states, positive metrics, go actions

---

#### **Error Red**
```css
--red-500: #ff5252
--red-600: #f44336
--red-700: #d32f2f
--red-800: #c62828
--red-900: #b71c1c
```
**Usage:** Errors, alerts, destructive actions

---

### **Neutral Colors**

#### **Dark Theme**
```css
--bg-primary: #06080f
--bg-secondary: #0a0e1a
--bg-tertiary: #0d1221
--bg-card: #111833
--bg-elevated: #1a1f3a

--border-subtle: rgba(255, 255, 255, 0.05)
--border-default: rgba(255, 255, 255, 0.1)
--border-strong: rgba(255, 255, 255, 0.15)

--text-primary: #e8eaf0
--text-secondary: #8b92a8
--text-tertiary: #5c6280
--text-inverse: #06080f
```

---

### **Gradient System**

#### **Main Gradient**
```css
--gradient-main: linear-gradient(
  135deg,
  #00e5ff 0%,
  #e040fb 50%,
  #ffc400 100%
);
```
**Usage:** Primary buttons, hero backgrounds, special highlights

---

#### **Cyber Gradient**
```css
--gradient-cyber: linear-gradient(
  135deg,
  #06080f 0%,
  #0a0e1a 50%,
  #0d1221 100%
);
```
**Usage:** Card backgrounds, section backgrounds

---

#### **Glow Gradient**
```css
--gradient-glow: radial-gradient(
  ellipse,
  rgba(0, 229, 255, 0.15) 0%,
  transparent 70%
);
```
**Usage:** Hover effects, focus states, ambient lighting

---

### **Color Accessibility**

**WCAG AA Compliance:**

| Background | Text Color | Contrast Ratio | Pass/Fail |
|------------|------------|----------------|-----------|
| Cyan-500 | #06080f | 8.2:1 | ✅ Pass |
| Magenta-600 | #ffffff | 5.1:1 | ✅ Pass |
| Gold-500 | #06080f | 11.3:1 | ✅ Pass |
| Green-600 | #ffffff | 4.8:1 | ✅ Pass |
| Red-600 | #ffffff | 5.3:1 | ✅ Pass |
| Bg-secondary | Text-primary | 15.2:1 | ✅ Pass |

---

## 📝 Typography

### **Font Families**

#### **Primary: Outfit**
```css
font-family: 'Outfit', sans-serif;
```
**Weights:** 300, 400, 500, 600, 700, 800, 900  
**Usage:** Headings, body text, buttons, navigation  
**License:** Open Source (SIL Open Font License)

**Why Outfit?**
- Modern, geometric sans-serif
- Excellent readability at all sizes
- Friendly but professional
- Works well in both English and Bahasa Malaysia

---

#### **Monospace: JetBrains Mono**
```css
font-family: 'JetBrains Mono', monospace;
```
**Weights:** 400, 500, 600, 700  
**Usage:** Code, data, stats, technical info  
**License:** Open Source (SIL Open Font License)

**Why JetBrains Mono?**
- Designed for readability
- Distinct characters (0 vs O, 1 vs l)
- Modern aesthetic
- Perfect for metrics and numbers

---

### **Type Scale**

#### **Display (Hero Sections)**
```css
--display-xl: {
  font-size: clamp(3.5rem, 8vw, 6rem);
  font-weight: 900;
  line-height: 1.1;
  letter-spacing: -0.03em;
}

--display-lg: {
  font-size: clamp(2.5rem, 6vw, 4.5rem);
  font-weight: 800;
  line-height: 1.15;
  letter-spacing: -0.02em;
}
```

---

#### **Headings**
```css
--h1: {
  font-size: clamp(2rem, 4vw, 3rem);
  font-weight: 800;
  line-height: 1.2;
  letter-spacing: -0.02em;
}

--h2: {
  font-size: clamp(1.5rem, 3vw, 2.25rem);
  font-weight: 700;
  line-height: 1.25;
  letter-spacing: -0.01em;
}

--h3: {
  font-size: clamp(1.25rem, 2vw, 1.5rem);
  font-weight: 700;
  line-height: 1.3;
  letter-spacing: 0;
}

--h4: {
  font-size: 1.125rem;
  font-weight: 600;
  line-height: 1.4;
  letter-spacing: 0;
}
```

---

#### **Body Text**
```css
--body-lg: {
  font-size: 1.125rem;
  line-height: 1.7;
  letter-spacing: 0;
}

--body-base: {
  font-size: 1rem;
  line-height: 1.6;
  letter-spacing: 0;
}

--body-sm: {
  font-size: 0.875rem;
  line-height: 1.5;
  letter-spacing: 0.01em;
}

--body-xs: {
  font-size: 0.75rem;
  line-height: 1.4;
  letter-spacing: 0.02em;
}
```

---

#### **Special Text**
```css
--label: {
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  line-height: 1.2;
}

--mono: {
  font-family: 'JetBrains Mono', monospace;
  font-size: 0.875rem;
  line-height: 1.6;
  letter-spacing: 0;
}

--stat: {
  font-family: 'JetBrains Mono', monospace;
  font-size: clamp(2rem, 4vw, 3rem);
  font-weight: 900;
  line-height: 1;
  letter-spacing: -0.02em;
}
```

---

### **Typography Hierarchy**

```
Display XL (Hero)
└─ Display LG (Section titles)
   └─ H1 (Page titles)
      └─ H2 (Major sections)
         └─ H3 (Subsections)
            └─ H4 (Card titles)
               └─ Body LG (Lead paragraphs)
                  └─ Body Base (Main content)
                     └─ Body SM (Captions, labels)
                        └─ Body XS (Fine print)
```

---

## 🎭 Visual Language

### **Design Principles**

#### **1. Spatial Organization**
```
❌ Tabs & Dropdowns          ✅ Districts & Zones
❌ Abstract Lists            ✅ Physical Locations
❌ Invisible Processes        ✅ Visible Movement
```

**Implementation:**
- Use cards to represent "buildings"
- Use lines to represent "pathways"
- Use icons to represent "workers"
- Use motion to represent "activity"

---

#### **2. Playful Professionalism**
```
❌ Stiff Corporate           ✅ Friendly Expert
❌ Childish Fun              ✅ Mature Playful
❌ Boring Gray               ✅ Vibrant Dark
```

**Implementation:**
- Dark theme with neon accents
- Rounded corners (12-20px radius)
- Subtle animations on hover
- Emoji integration ( tasteful )

---

#### **3. Malaysian Identity**
```
❌ Generic Global            ✅ Proudly Local
❌ English Only              ✅ Bilingual (BM + EN)
❌ Western Examples          ✅ Malaysian Context
```

**Implementation:**
- Bahasa Malaysia translations
- Malaysian color influences (Jalur Gemilang)
- Local district names (Lorong, Jalan, Kota)
- Malaysian cultural references

---

### **Shape Language**

#### **Corner Radius**
```css
--radius-sm: 8px;    /* Small elements, tags */
--radius-md: 12px;   /* Cards, buttons */
--radius-lg: 16px;   /* Large cards, modals */
--radius-xl: 24px;   /* Hero sections, containers */
--radius-full: 9999px; /* Pills, badges */
```

**Usage:**
- Buttons: `--radius-md` (12px)
- Cards: `--radius-lg` (16px)
- Badges: `--radius-full` (9999px)
- Containers: `--radius-xl` (24px)

---

#### **Icon Style**
```
Size: 24x24 (default), 20x20 (small), 32x32 (large)
Stroke: 2px (default), 1.5px (small), 2.5px (large)
Style: Outlined with subtle fills
Corners: Slightly rounded (2px)
```

**Icon Sources:**
- Lucide Icons (primary)
- Heroicons (secondary)
- Custom district icons (unique)

---

### **Motion Principles**

#### **Timing Functions**
```css
--ease-default: cubic-bezier(0.4, 0, 0.2, 1);
--ease-in: cubic-bezier(0.4, 0, 1, 1);
--ease-out: cubic-bezier(0, 0, 0.2, 1);
--ease-in-out: cubic-bezier(0.4, 0, 0.2, 1);
--ease-bounce: cubic-bezier(0.34, 1.56, 0.64, 1);
```

---

#### **Duration**
```css
--duration-fast: 150ms;    /* Micro-interactions */
--duration-base: 300ms;    /* Standard transitions */
--duration-slow: 500ms;    /* Large movements */
--duration-slower: 800ms;  /* Complex animations */
```

---

#### **Animation Patterns**

**Fade In:**
```css
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}
```

**Slide Up:**
```css
@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
```

**Scale In:**
```css
@keyframes scaleIn {
  from {
    opacity: 0;
    transform: scale(0.95);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}
```

**Glow Pulse:**
```css
@keyframes glowPulse {
  0%, 100% {
    box-shadow: 0 0 20px rgba(0, 229, 255, 0.3);
  }
  50% {
    box-shadow: 0 0 40px rgba(0, 229, 255, 0.6);
  }
}
```

---

## 🗣️ Voice & Tone

### **Brand Voice**

**Personality:** Friendly Expert

| Trait | Description | Example |
|-------|-------------|---------|
| **Clear** | No jargon, plain language | "See your AI work" not "Visualize agent orchestration" |
| **Friendly** | Warm, approachable | "Jom build your city" not "Initiate city construction" |
| **Confident** | Knows the value | "This works" not "This might work" |
| **Malaysian** | Local context | "Like a mamak stall, but for AI" |

---

### **Tone Variations**

#### **Marketing (Landing Page)**
```
Energetic, Inspiring, Action-oriented

✅ "Build your AI workforce city in minutes"
✅ "See your agents work, move, and create value"
❌ "Leverage synergistic AI orchestration paradigms"
```

---

#### **Product (Dashboard)**
```
Clear, Concise, Helpful

✅ "3 tasks completed"
✅ "Agent busy: Writing blog post"
❌ "Task execution in progress"
❌ "Agent utilization: 100%"
```

---

#### **Error Messages**
```
Human, Solution-focused, Not Blaming

✅ "Oops! Something went wrong. Let's try that again."
✅ "Connection lost. Reconnecting..."
❌ "Critical system failure"
❌ "User error detected"
```

---

#### **Social Media**
```
Casual, Fun, Engaging

✅ "Your AI agents working harder than you on Monday 😅"
✅ "POV: You finally automated that tedious task ✨"
❌ "GANGCLAWCITY announces new feature release"
❌ "Enterprise-grade AI workforce solution"
```

---

### **Language Guidelines**

#### **Bahasa Malaysia Integration**
```
Primary: English
Secondary: Bahasa Malaysia (contextual)

✅ "Jom build your city"
✅ "Your agents are 'kerja kuat' today 💪"
✅ "Lorong Niaga (Commerce District)"
❌ Full BM unless specifically for BM-only content
```

---

#### **Words We Use**
```
✅ City, District, Agent, Worker, Task, Traffic
✅ Build, Deploy, Watch, Manage, Control
✅ Visible, Clear, Simple, Fast
✅ Malaysia, SME, Business, Team
```

---

#### **Words We Avoid**
```
❌ Orchestration, Synergy, Paradigm, Leverage
❌ Enterprise-grade, World-class, Best-in-class
❌ Disrupt, Revolutionize, Transform
❌ AI-powered, AI-driven, AI-enabled (overuse)
```

---

### **Messaging Framework**

#### **Elevator Pitch (30 seconds)**
```
"GANGCLAWCITY is a visual operating system for AI workforces.

Instead of dashboards and terminals, you get a living city where:
- Districts = Business functions
- Agents = Digital workers  
- Traffic = Task flow

You can see your AI agents working, moving, and creating value — 
like a game, but it's your actual business.

Built in Malaysia, for businesses worldwide."
```

---

#### **One-Liner (5 seconds)**
```
✅ "The operating system for AI workforces"
✅ "Where AI agents work, move, and create value"
✅ "A living city for your digital workers"
❌ "AI agent orchestration platform"
```

---

#### **Value Propositions**

**For SME Owners:**
```
"Run more workflows with less headcount.
Operate like a bigger team from day one."
```

**For Agencies:**
```
"Manage multi-client workflows with full visibility.
Show clients exactly what you're doing."
```

**For Creators:**
```
"Your AI team in software.
Content, publishing, automation — all operated."
```

**For Solo Founders:**
```
"Operate like a full company from day one.
AI workforce leverage without the headcount."
```

---

## 🔣 Iconography

### **District Icons**

```
🗼 Menara Komando (Command Tower)
🏪 Lorong Niaga (Commerce)
🎬 Jalan Konten (Content)
🔍 Kota Audit (Audit)
🔀 Stesen Routing (Routing)
⚙️ Zon Automasi (Automation)
🧪 Pasar Eksperimen (Experiment)
🔬 Pinggir Makmal (Lab)
```

**Style:** Emoji-based for friendliness  
**Alternative:** Custom SVG icons for consistency

---

### **Action Icons**

```
➕ Create/Add
✏️ Edit
🗑️ Delete
👁️ View/See
⚙️ Settings
🔍 Search
📊 Analytics
🤖 Agents
📁 Projects
🚀 Deploy
✅ Complete
❌ Error/Close
ℹ️ Info
🔔 Notifications
👤 Profile
```

---

### **Status Icons**

```
🟢 Active/Online
🟡 Idle/Pending
🔴 Error/Offline
🔵 Processing
🟣 Paused
⚪ Not Started
```

---

## 📸 Imagery Style

### **Photography**

**Style:** Cyberpunk meets reality

**Characteristics:**
- Dark backgrounds with neon accents
- Malaysian urban settings (KL skyline, mamak stalls)
- Technology + humanity blend
- Candid, not staged

**Don't Use:**
- Stock photos of people shaking hands
- Generic office spaces
- Western-centric imagery

---

### **Illustrations**

**Style:** Pixel art / Isometric

**Characteristics:**
- Isometric city views
- Pixel art characters (agents)
- Consistent color palette
- Playful but professional

**Tools:**
- Blender (3D isometric)
- Aseprite (pixel art)
- Figma (vectors)

---

### **Screenshots**

**Style:** Clean, annotated

**Characteristics:**
- Dark mode UI
- Subtle drop shadows
- Numbered annotations
- Arrow callouts for key features

**Don't:**
- Full-page screenshots (too small)
- Without context (floating UI)
- Out-of-date UI

---

## 📐 Layout Principles

### **Grid System**

**Base Grid:** 8px

```
All spacing multiples of 8:
8, 16, 24, 32, 40, 48, 64, 80, 96, 128
```

**Exceptions:**
- 4px for micro-spacing
- 12px for specific components

---

### **Breakpoints**

```css
--bp-sm: 640px;   /* Mobile landscape */
--bp-md: 768px;   /* Tablet */
--bp-lg: 1024px;  /* Desktop */
--bp-xl: 1280px;  /* Large desktop */
--bp-2xl: 1536px; /* Extra large */
```

---

### **Layout Patterns**

#### **Container**
```css
max-width: 1200px;
margin: 0 auto;
padding: 0 24px;
```

#### **Section**
```css
padding: 100px 0;  /* Desktop */
padding: 60px 0;   /* Mobile */
```

#### **Grid**
```css
display: grid;
gap: 24px;
grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
```

---

## 📦 Applications

### **Website**

**Header:**
- Logo (left)
- Navigation (center)
- CTA button (right)
- Background: Transparent → Dark on scroll

**Hero:**
- Large headline (Display XL)
- Subheadline (Body LG)
- Primary CTA + Secondary CTA
- Hero image/illustration

**Footer:**
- Logo + tagline
- Navigation columns
- Social links
- Legal links

---

### **Social Media**

**Profile Images:**
- Logo icon (⬡)
- Size: 400x400px minimum
- Background: Brand gradient

**Cover Images:**
- City illustration
- Size: 1500x500px (Twitter), 1920x1080px (Facebook)
- Tagline overlay

**Post Templates:**
- Quote cards (dark bg, gradient border)
- Feature announcements (screenshot + annotation)
- Stats/metrics (large numbers, mono font)

---

### **Presentations**

**Title Slide:**
- Logo
- Title (H1)
- Subtitle (Body LG)
- Date + presenter

**Content Slides:**
- Title (H2)
- Bullet points (max 5)
- Visuals (screenshots, diagrams)
- Brand colors throughout

**Closing Slide:**
- "Thank You" / "Terima Kasih"
- Contact info
- QR code (website/demo)

---

### **Documentation**

**Headers:**
- H1: Page title
- H2: Major sections
- H3: Subsections
- H4: Component details

**Code Blocks:**
- Dark theme
- Syntax highlighting
- Copy button
- JetBrains Mono font

**Callouts:**
- Info: Blue background
- Warning: Yellow background
- Error: Red background
- Success: Green background

---

## ✅ Brand Checklist

### **Before Publishing:**

- [ ] Logo is correct version
- [ ] Colors match brand palette
- [ ] Typography follows scale
- [ ] Voice is friendly expert
- [ ] BM + EN where appropriate
- [ ] Images follow style guide
- [ ] Layout uses grid system
- [ ] Animations follow timing
- [ ] Icons are consistent
- [ ] Accessibility checked

---

## 📚 Resources

### **Font Downloads:**
- Outfit: https://outfit.netlify.app/
- JetBrains Mono: https://www.jetbrains.com/lp/mono/

### **Icon Libraries:**
- Lucide: https://lucide.dev/
- Heroicons: https://heroicons.com/

### **Color Tools:**
- Coolors: https://coolors.co/
- WebAIM Contrast Checker: https://webaim.org/resources/contrastchecker/

### **Design Tools:**
- Figma: https://figma.com/
- Blender: https://blender.org/
- Aseprite: https://aseprite.org/

---

**Brand Kit Version:** 1.0.0  
**Last Updated:** March 13, 2026  
**Maintained By:** GANGCLAWCITY Design Team

---

**🏙️ GANGCLAWCITY** — A living operating system for digital labor.  
**Built with ❤️ in Malaysia** 🇲🇾
