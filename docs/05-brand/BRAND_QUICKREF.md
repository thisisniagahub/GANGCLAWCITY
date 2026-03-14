# 🎨 GANGCLAWCITY Brand Kit - Quick Reference

**Cheat Sheet untuk team**  
**Version:** 1.0.0  
**Created:** March 13, 2026

---

## ⚡ Quick Access

### **Logo Files**
- Main Doc: `BRANDKIT.md` (full brand guide)
- Visual Demo: `BRAND_ASSETS.html` (interactive showcase)
- SVG Specs: `LOGO_FILES.md` (logo templates)

---

## 🎨 Colors (Copy-Paste)

### **Primary**
```css
--cyan-500: #00e5ff      /* Main brand color */
--magenta-500: #e040fb   /* Secondary accent */
--gold-500: #ffc400      /* Highlights, badges */
```

### **Backgrounds**
```css
--bg-primary: #06080f    /* Main background */
--bg-secondary: #0a0e1a  /* Sections */
--bg-card: #111833       /* Cards, components */
```

### **Text**
```css
--text-primary: #e8eaf0  /* Headings, body */
--text-secondary: #8b92a8  /* Secondary text */
--text-tertiary: #5c6280  /* Muted text */
```

### **Gradients**
```css
/* Main brand gradient */
background: linear-gradient(135deg, #00e5ff 0%, #e040fb 50%, #ffc400 100%);

/* Dark theme gradient */
background: linear-gradient(135deg, #06080f 0%, #0a0e1a 50%, #0d1221 100%);
```

---

## 📝 Typography (Copy-Paste)

### **Fonts**
```css
/* Import */
@import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=JetBrains+Mono:wght@400;500;600&display=swap');

/* Usage */
font-family: 'Outfit', sans-serif;        /* Main font */
font-family: 'JetBrains Mono', monospace; /* Code, data */
```

### **Headings**
```css
/* Display (Hero) */
font-size: clamp(3rem, 6vw, 5rem);
font-weight: 900;
line-height: 1.1;
letter-spacing: -0.03em;

/* H1 */
font-size: clamp(2rem, 4vw, 3rem);
font-weight: 800;
line-height: 1.2;

/* H2 */
font-size: clamp(1.5rem, 3vw, 2.25rem);
font-weight: 700;
line-height: 1.25;
```

### **Body**
```css
/* Base */
font-size: 1rem;
line-height: 1.6;
color: #8b92a8;

/* Mono (code, stats) */
font-family: 'JetBrains Mono', monospace;
font-size: 0.875rem;
```

---

## 🏷️ Logo Usage

### **Primary Logo**
```
⬡ GANGCLAWCITY
```

**Files:**
- SVG: Use for web (scalable)
- PNG: Use for images (transparent bg)
- Icon only: Favicon, social avatars

**Minimum Size:**
- Web: 120px width
- Print: 25mm width
- Icon: 32x32px

**Don't:**
- ❌ Stretch/distort
- ❌ Add effects (shadow, glow)
- ❌ Rotate
- ❌ Change colors randomly

---

## 🔣 Icons

### **District Icons**
```
🗼 Command Tower
🏪 Commerce (Lorong Niaga)
🎬 Content (Jalan Konten)
🔍 Audit (Kota Audit)
🔀 Routing (Stesen Routing)
⚙️ Automation (Zon Automasi)
🧪 Experiment (Pasar Eksperimen)
🔬 Lab (Pinggir Makmal)
```

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

## 🗣️ Voice & Tone

### **Brand Personality:** Friendly Expert

**Do:**
- ✅ Clear, plain language
- ✅ Friendly, approachable
- ✅ Malaysian context (BM + EN)
- ✅ Confident but not arrogant

**Don't:**
- ❌ Jargon, corporate speak
- ❌ Overly formal
- ❌ Generic Western examples
- ❌ Hype words ("revolutionary", "disruptive")

### **Examples**

**✅ Good:**
```
"Build your AI workforce city in minutes"
"See your agents work, move, and create value"
"Jom build your city"
```

**❌ Bad:**
```
"Leverage synergistic AI orchestration paradigms"
"Enterprise-grade workforce optimization solution"
"Initiate city construction protocol"
```

---

## 🎭 Design Principles

### **1. Spatial Organization**
```
❌ Tabs & Lists          ✅ Districts & Zones
❌ Abstract              ✅ Physical/Visual
❌ Invisible             ✅ Visible movement
```

### **2. Playful Professionalism**
```
❌ Stiff corporate       ✅ Friendly expert
❌ Childish fun          ✅ Mature playful
❌ Boring gray           ✅ Vibrant dark
```

### **3. Malaysian Identity**
```
❌ Generic global        ✅ Proudly local
❌ English only          ✅ Bilingual (BM + EN)
❌ Western examples      ✅ Malaysian context
```

---

## 📐 Layout

### **Spacing (8px Grid)**
```
4, 8, 16, 24, 32, 40, 48, 64, 80, 96, 128px
```

### **Container**
```css
max-width: 1200px;
margin: 0 auto;
padding: 0 24px;
```

### **Section Padding**
```css
padding: 100px 0;  /* Desktop */
padding: 60px 0;   /* Mobile */
```

### **Border Radius**
```css
--radius-sm: 8px;     /* Small elements */
--radius-md: 12px;    /* Cards, buttons */
--radius-lg: 16px;    /* Large cards */
--radius-xl: 24px;    /* Hero sections */
--radius-full: 9999px; /* Pills, badges */
```

---

## 🎬 Animations

### **Timing**
```css
--duration-fast: 150ms;   /* Micro-interactions */
--duration-base: 300ms;   /* Standard transitions */
--duration-slow: 500ms;   /* Large movements */
```

### **Easing**
```css
--ease-default: cubic-bezier(0.4, 0, 0.2, 1);
--ease-bounce: cubic-bezier(0.34, 1.56, 0.64, 1);
```

### **Common Animations**
```css
/* Fade In */
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

/* Slide Up */
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

/* Scale In */
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

---

## 📱 Social Media

### **Profile Images**
- **Size:** 400x400px minimum
- **Content:** Logo icon (⬡)
- **Background:** Brand gradient or solid color

### **Cover Images**
- **Twitter:** 1500x500px
- **Facebook:** 1920x1080px
- **LinkedIn:** 1584x396px
- **Content:** City illustration + tagline

### **Post Templates**
- **Quote cards:** Dark bg, gradient border
- **Features:** Screenshot + annotation
- **Stats:** Large numbers, mono font

---

## ✅ Pre-Flight Checklist

Before publishing anything:

### **Visual**
- [ ] Logo is correct version
- [ ] Colors match brand palette
- [ ] Typography follows scale
- [ ] Images follow style guide
- [ ] Icons are consistent

### **Content**
- [ ] Voice is friendly expert
- [ ] BM + EN where appropriate
- [ ] No jargon/corporate speak
- [ ] Malaysian context used
- [ ] Accessibility checked

### **Technical**
- [ ] File formats correct (SVG/PNG)
- [ ] Sizes optimized
- [ ] Alt text for images
- [ ] Contrast ratios pass WCAG
- [ ] Responsive tested

---

## 🔗 Resources

### **Fonts**
- [Outfit](https://outfit.netlify.app/)
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/)

### **Icons**
- [Lucide Icons](https://lucide.dev/)
- [Heroicons](https://heroicons.com/)

### **Tools**
- [Figma](https://figma.com/) - Design
- [Coolors](https://coolors.co/) - Color palettes
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/) - Accessibility

---

## 📞 Brand Guardians

**Questions about brand usage?**

- **Design Lead:** [TBD]
- **Marketing Lead:** [TBD]
- **Documentation:** `BRANDKIT.md`, `BRAND_ASSETS.html`

---

## 🚀 Quick Start Template

### **HTML Boilerplate**
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>GANGCLAWCITY</title>
  
  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">
  
  <!-- Favicon -->
  <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
</head>
<body>
  <!-- Content -->
</body>
</html>
```

### **CSS Variables**
```css
:root {
  /* Colors */
  --cyan-500: #00e5ff;
  --magenta-500: #e040fb;
  --gold-500: #ffc400;
  --bg-primary: #06080f;
  --bg-secondary: #0a0e1a;
  --text-primary: #e8eaf0;
  
  /* Typography */
  --font-main: 'Outfit', sans-serif;
  --font-mono: 'JetBrains Mono', monospace;
  
  /* Spacing */
  --radius-md: 12px;
  --radius-lg: 16px;
}
```

---

**Last Updated:** March 13, 2026  
**Next Review:** April 13, 2026

---

**🏙️ GANGCLAWCITY** — A living operating system for digital labor.  
**Built with ❤️ in Malaysia** 🇲🇾
