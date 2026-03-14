# 🎨 GANGCLAWCITY Wireframes

**3 Interactive Landing Page Concepts**  
**Created:** March 13, 2026  
**Status:** Ready for Review

---

## 📋 Overview

Tiga wireframe concepts yang **berbeza pendekatan**, sama ada nak **interactive**, **storytelling**, atau **visual contrast**.

---

## 🏗️ Wireframe #1: Interactive City Builder

**File:** `01-city-builder.html`

### Concept
Visitor **build their own GANGCLAWCITY** live di browser. Drag & drop districts, watch agents walk around, see real-time stats.

### Key Features
- ✅ Interactive canvas (Three.js / React Three Fiber)
- ✅ Drag & drop districts dari palette
- ✅ Agents animate as you add buildings
- ✅ Real-time stats update (tasks, leads, revenue)
- ✅ "Save Your City" → email capture

### Best For
- 👍 Hands-on learners
- 👍 Demo-first approach
- 👍 Viral potential (people share their city builds)

### Tech Stack
- Three.js / React Three Fiber (3D rendering)
- @dnd-kit (drag & drop)
- Zustand (state management)
- Framer Motion (animations)

### Complexity: ⭐⭐⭐⭐ (High)
**Estimated Build Time:** 3-5 days

---

## 🚶 Wireframe #2: Agent POV Scroll

**File:** `02-agent-pov-scroll.html`

### Concept
Scroll page = **walk through city with agent's eyes**. Each section = different district. Agent explains what they're doing via speech bubbles.

### Key Features
- ✅ Parallax scroll effects (multi-layer depth)
- ✅ Character-driven storytelling
- ✅ Speech bubble explanations
- ✅ District-by-district journey
- ✅ Mobile: swipe left/right to switch districts

### Best For
- 👍 Storytelling approach
- 👍 Emotional connection (characters)
- 👍 Educational (show how it works)

### Tech Stack
- GSAP ScrollTrigger (scroll animations)
- Lottie (character animations)
- Rellax.js (parallax)
- PixiJS (2D rendering)

### Complexity: ⭐⭐⭐ (Medium-High)
**Estimated Build Time:** 2-4 days

---

## ⚖️ Wireframe #3: Problem/Solution Split

**File:** `03-problem-solution-split.html`

### Concept
**Split-screen comparison**: Left = chaos (10 tabs, errors), Right = clarity (GANGCLAWCITY city). User can toggle between views.

### Key Features
- ✅ Side-by-side visual contrast
- ✅ Interactive toggle (Before/After)
- ✅ Hotspot annotations (hover problem → see solution)
- ✅ Number animations (losing money → making money)
- ✅ Success confetti on right side

### Best For
- 👍 Immediate value proposition
- 👍 Conversion-focused
- 👍 Clear ROI demonstration

### Tech Stack
- GSAP (split screen animations)
- Hover.css (hover effects)
- CountUp.js (number animations)
- Canvas Confetti (celebrations)

### Complexity: ⭐⭐ (Medium)
**Estimated Build Time:** 1-2 days

---

## 📊 Comparison Table

| Feature | #1 City Builder | #2 Agent POV | #3 Split Screen |
|---------|----------------|--------------|-----------------|
| **Interactivity** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Storytelling** | ⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| **Conversion Focus** | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Build Complexity** | High | Medium-High | Medium |
| **Mobile-Friendly** | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Viral Potential** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |
| **Educational** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |

---

## 🎯 Recommendations

### **If You Want Maximum Engagement:**
**Go with #1 (City Builder)**
- People spend 5-10 minutes playing
- Highest shareability factor
- Best for product-led growth

### **If You Want Emotional Connection:**
**Go with #2 (Agent POV)**
- Character-driven storytelling
- Best for explaining complex concepts
- Most memorable experience

### **If You Want Conversions:**
**Go with #3 (Split Screen)**
- Clear before/after contrast
- Fastest to understand (5 seconds)
- Highest click-through rate

---

## 💡 Hybrid Approach

**Recommended:** Combine elements from all three:

```
Hero Section: #3 Split Screen (instant value prop)
   ↓
Scroll Section: #2 Agent POV (storytelling)
   ↓
Interactive Demo: #1 City Builder (hands-on)
   ↓
CTA: Email capture + free trial
```

**Why:** Each section serves different purpose:
1. **Hook** (split screen - 5 seconds)
2. **Story** (agent journey - 30 seconds)
3. **Demo** (city builder - 5 minutes)
4. **Convert** (CTA - email signup)

---

## 🚀 Next Steps

### **Option A: Build All Three (Recommended)**
1. Create landing page with 3 sections
2. Each section = different wireframe concept
3. Test which section converts best
4. Double down on winner

**Timeline:** 1-2 weeks

### **Option B: Pick One & Polish**
1. Choose best concept for your audience
2. Build full landing page around it
3. A/B test variations
4. Iterate based on data

**Timeline:** 3-5 days

### **Option C: MVP Launch**
1. Use #3 (Split Screen) - fastest to build
2. Launch in 48 hours
3. Gather user feedback
4. Add #1 or #2 later

**Timeline:** 1-2 days

---

## 📱 How to View Wireframes

### **Local Testing:**
```bash
cd G:\PROJECT-4\GANGCLAWCITY\landing-page\wireframes

# Open in browser
start 01-city-builder.html
start 02-agent-pov-scroll.html
start 03-problem-solution-split.html

# Or serve with Python
python -m http.server 8080
# Open http://localhost:8080/wireframes/01-city-builder.html
```

### **Browser Testing:**
- ✅ Chrome 120+
- ✅ Firefox 120+
- ✅ Safari 17+
- ✅ Edge 120+

---

## 🎨 Design Notes

### **Color Palette (Consistent Across All)**
```
Background: #06080f, #0a0e1a
Text: #e8eaf0, #8b92a8, #5c6280
Accent Cyan: #00e5ff
Accent Magenta: #e040fb
Accent Gold: #ffc400
Accent Green: #00e676
Error Red: #ff5252
```

### **Typography**
```
Main Font: 'Courier New', monospace (for wireframes)
Production: 'Outfit' (sans-serif) + 'JetBrains Mono' (mono)
```

### **Animations**
- Smooth transitions (0.3s cubic-bezier)
- Hover effects on interactive elements
- Scroll-triggered reveals
- Number counting animations

---

## 🧪 Testing Checklist

### **Functional Testing:**
- [ ] All buttons clickable
- [ ] Drag & drop working (#1)
- [ ] Scroll animations trigger (#2)
- [ ] Toggle switch working (#3)
- [ ] Hotspot hovers responsive (#3)

### **Visual Testing:**
- [ ] Colors match design system
- [ ] Typography consistent
- [ ] Spacing/padding correct
- [ ] Icons/emojis render properly

### **Responsive Testing:**
- [ ] Desktop (1920x1080)
- [ ] Laptop (1366x768)
- [ ] Tablet (768x1024)
- [ ] Mobile (375x667)

### **Performance Testing:**
- [ ] Page load < 2 seconds
- [ ] Animations smooth (60fps)
- [ ] No console errors
- [ ] Memory usage reasonable

---

## 💬 Feedback Questions

### **For Each Wireframe:**

1. **First Impression (5 seconds)**
   - What's the first thing you notice?
   - Do you understand what this is?
   - Does it make you want to explore more?

2. **Usability (30 seconds)**
   - Is it clear what to do next?
   - Are interactive elements obvious?
   - Is the navigation intuitive?

3. **Value Proposition (1 minute)**
   - Do you understand the problem being solved?
   - Is the solution clear?
   - Would you use this?

4. **Emotional Response**
   - How does it make you feel?
   - Is it memorable?
   - Would you share this with someone?

5. **Conversion Intent**
   - Would you sign up?
   - Would you recommend to a friend?
   - What's holding you back?

---

## 📈 Success Metrics

### **For Final Landing Page:**

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Time on Page** | > 2 minutes | Google Analytics |
| **Bounce Rate** | < 40% | Google Analytics |
| **Scroll Depth** | > 70% | Hotjar |
| **CTR on CTA** | > 5% | Google Analytics |
| **Email Signups** | > 10% | Conversion rate |
| **Social Shares** | 50+ first month | Share buttons |

---

## 🔗 Related Files

- **Wireframes:** `wireframes/01-city-builder.html`
- **Wireframes:** `wireframes/02-agent-pov-scroll.html`
- **Wireframes:** `wireframes/03-problem-solution-split.html`
- **Original Landing Page:** `index.html`
- **Styles:** `style.css`
- **Scripts:** `script.js`

---

## 👥 Decision Framework

### **Choose #1 If:**
- ✅ You have 1-2 weeks to build
- ✅ Your audience is technical/savvy
- ✅ You want viral/demo-led growth
- ✅ You have design/dev resources

### **Choose #2 If:**
- ✅ You have 1 week to build
- ✅ Your audience needs education
- ✅ You want emotional storytelling
- ✅ You have character design skills

### **Choose #3 If:**
- ✅ You need to launch in 48 hours
- ✅ Your audience is busy/executives
- ✅ You want clear ROI demonstration
- ✅ You have limited resources

---

## 🎯 Final Recommendation

**Start with #3 (Split Screen)** for quick launch → **Gather feedback** → **Add #1 or #2** as interactive sections.

**Why:**
1. Fastest to market (48 hours)
2. Clear value prop immediately
3. Can iterate based on data
4. Low risk, high reward

**Then:**
- If engagement is high → Add #1 (City Builder)
- If confusion is high → Add #2 (Agent POV)
- If conversions are low → A/B test all three

---

**Created by:** AI Code Assistant  
**Date:** March 13, 2026  
**Status:** ✅ Ready for Review & Implementation

---

## 🚀 Ready to Build!

**Pick your concept and let's code!** 

```bash
# View all wireframes
cd G:\PROJECT-4\GANGCLAWCITY\landing-page\wireframes

# Open in browser
start 01-city-builder.html
start 02-agent-pov-scroll.html
start 03-problem-solution-split.html
```

**Mana kau nak build first?** 🎨
