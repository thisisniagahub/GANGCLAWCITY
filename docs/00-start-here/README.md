# 🏙️ GANGCLAWCITY

> **AI Workforce Operating System** — Visualizing NiagaBot agents as a living digital city

[![Status: Production Ready](https://img.shields.io/badge/status-production%20ready-green)](https://github.com/thisisniagahub/GANGCLAWCITY)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](LICENSE)
[![Malaysia First](https://img.shields.io/badge/Malaysia-First-ffcc00)](https://malaysia.digital)
[![Vercel](https://img.shields.io/badge/deployed%20on-vercel-black?logo=vercel)](https://vercel.com)

---

## 🎯 Vision

> "AI should not feel invisible. Not fragmented. Not like ten tabs, five dashboards, and zero clarity. **GANGCLAWCITY is a living digital city where NiagaBot agents work, move, coordinate, and create measurable value.**"

---

## 📋 Quick Links

- **[Dashboard](https://gangclawcity-dashboard.vercel.app)** - Real-time agent monitoring
- **[Demo](https://gangclawcity-demo.vercel.app)** - Interactive pixel art demo
- **[Landing Page](https://gangclawcity-landing.vercel.app)** - Learn more

---

## 🌟 What is GANGCLAWCITY?

**GANGCLAWCITY** is a **Malaysia-first AI workforce operating system** that visualizes **NiagaBot agents** as digital workers operating within a spatial, city-like environment.

### **🔗 Production Gateway Connection**

```
GANGCLAWCITY Frontend (Vercel)
         ↓ WSS (Secure WebSocket)
wss://operator.gangniaga.my
         ↓
OpenClaw Gateway (Authenticated)
         ↓
NiagaBot Agents (Running 24/7)
```

**Production Setup:**
- ✅ **WSS URL:** `wss://operator.gangniaga.my`
- ✅ **Auth Token:** `<GATEWAY_TOKEN>`
- ✅ **Session Key:** `agent:main:main`
- ✅ **CORS:** Pre-configured for Vercel
- ✅ **Zero Downtime:** NiagaBot continues running

---

## 🏙️ Core Metaphor

```
┌─────────────────────────────────────────────────────────────┐
│                    GANGCLAWCITY                              │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │ COMMAND  │  │ COMMERCE │  │ CONTENT  │  │  AUDIT   │   │
│  │  TOWER   │  │ DISTRICT │  │ DISTRICT │  │ DISTRICT │   │
│  │          │  │          │  │          │          │   │
│  │  🗼      │  │  🏪      │  │  🎬      │  │  🔍      │   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
│                                                             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │ ROUTING  │  │AUTOMATION│  │EXPERIMENT│  │    LAB   │   │
│  │ STATION  │  │  ZONE    │  │  MARKET  │  │  DISTRICT│   │
│  │          │  │          │  │          │          │   │
│  │  🔀      │  │  ⚙️      │  │  🧪      │  │  🔬      │   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
│                                                             │
│              Task Flow = Traffic Between Districts          │
└─────────────────────────────────────────────────────────────┘
```

### **Districts = Business Functions**
Each district represents a business function with specialized NiagaBot agents.

### **Agents = Digital Workers**
NiagaBot agents are visualized as workers with identity, role, skills, and measurable output.

### **Traffic = Task Flow**
Tasks flow between districts as visible "traffic" — bottlenecks glow red, completions animate.

### **Command Tower = Central Control**
Real-time monitoring of all NiagaBot agents with KPIs, alerts, and human oversight.

---

## ✨ Key Features

### 🎮 Spatial Visualization
- **Live City Renderer**: See NiagaBot agents working in real-time
- **Agent Avatars**: Animated characters moving between districts
- **Task Traffic**: Visible task flow with bottleneck indicators
- **Interactive Districts**: Click to open district detail panels

### 🔗 Production OpenClaw Integration
- **WSS Gateway:** `wss://operator.gangniaga.my`
- **Token Auth:** `<GATEWAY_TOKEN>`
- **Session Key:** `agent:main:main`
- **CORS Enabled:** Vercel domains pre-configured
- **Zero Downtime:** NiagaBot continues running

### 🚀 Vercel Deployment
- **Auto SSL:** Automatic HTTPS certificates
- **Global CDN:** Fast loading worldwide
- **Auto Scaling:** Handles traffic spikes
- **Zero Maintenance:** Vercel manages infrastructure

### 🇲🇾 Malaysia-First
- **Bahasa Malaysia Support:** Bilingual interface (BM + EN)
- **SME Templates:** Pre-configured for Malaysian businesses
- **Local Context:** Built for Malaysian workflow needs

---

## 🏗️ Architecture

### **Production Architecture**

```
┌──────────────────────────────────────────────────────────┐
│                         GANGCLAWCITY                      │
│                                                           │
│  ┌────────────────────────────────────────────────────┐  │
│  │                   Frontend (Vercel)                 │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────┐ │  │
│  │  │ Landing Page │  │   Dashboard  │  │   Demo   │ │  │
│  │  │              │  │  (OpenClaw)  │  │ (Phaser) │ │  │
│  │  └──────────────┘  └──────────────┘  └──────────┘ │  │
│  └────────────────────────────────────────────────────┘  │
│                           ↓ WSS                           │
│              wss://operator.gangniaga.my                  │
│                           ↓                               │
│  ┌────────────────────────────────────────────────────┐  │
│  │         OpenClaw Gateway (Production)               │  │
│  │                                                     │  │
│  │  - NiagaBot Agents                                 │  │
│  │  - AI Models (Google, OpenAI, Qwen)               │  │
│  │  - Token Authentication                            │  │
│  │  - CORS Configured                                 │  │
│  └────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────┘
```

### **Technology Stack**

| Layer | Technology | Purpose |
|-------|------------|---------|
| **Frontend** | Vercel (Next.js, Vite, React) | UI & visualization |
| **Styling** | Tailwind CSS v4 | Design system |
| **Visualization** | Phaser 3 / R3F | 2D/3D city rendering |
| **State** | Zustand | Client-side state |
| **Backend** | OpenClaw Gateway (`wss://operator.gangniaga.my`) | Agent runtime |
| **Deployment** | Vercel + Production Gateway | Production-ready |

---

## 🚀 Quick Start

### **Prerequisites**
- Node.js >= 22
- pnpm >= 9
- Gateway access token

### **Development Setup**

```bash
# Clone repository
git clone https://github.com/thisisniagahub/GANGCLAWCITY.git
cd GANGCLAWCITY

# Install dependencies for each app
cd landing-page && pnpm install && cd ..
cd openclaw-office && pnpm install && cd ..
cd agent-town && pnpm install && cd ..

# Start development
cd landing-page && pnpm dev
cd openclaw-office && pnpm dev
cd agent-town && pnpm dev
```

### **Environment Variables**

**Create `openclaw-office/.env.local`:**
```env
# Production Gateway
VITE_GATEWAY_URL=wss://operator.gangniaga.my
VITE_GATEWAY_TOKEN=<GATEWAY_TOKEN>
VITE_SESSION_KEY=agent:main:main
VITE_MOCK=false
```

---

## 📦 Project Structure

```
GANGCLAWCITY/
├── landing-page/          # Marketing site (Vercel)
├── openclaw-office/       # Dashboard (Vercel)
├── agent-town/            # Interactive demo (Vercel)
├── ai-town/               # Experimental (optional)
├── Star-Office-UI/        # Research (optional)
├── mock-gateway/          # Local testing
├── k8s/                   # Kubernetes configs
├── docker-compose.yml     # Docker setup
└── skaffold.yaml          # Skaffold deployment
```

---

## 🔗 Deployment

### **Vercel Deployment (Frontend)**

```bash
# Install Vercel CLI
npm install -g vercel

# Deploy each app
cd landing-page && vercel --prod
cd openclaw-office && vercel --prod
cd agent-town && vercel --prod
```

**Environment Variables on Vercel:**
```
VITE_GATEWAY_URL=wss://operator.gangniaga.my
VITE_GATEWAY_TOKEN=<GATEWAY_TOKEN>
VITE_SESSION_KEY=agent:main:main
VITE_MOCK=false
```

### **Gateway Access**

**Production Gateway Already Configured:**
- ✅ **URL:** `wss://operator.gangniaga.my`
- ✅ **Token:** `<GATEWAY_TOKEN>`
- ✅ **Session Key:** `agent:main:main`
- ✅ **CORS:** Allows Vercel domains
- ✅ **Rate Limiting:** 10 requests/minute

**No changes needed to gateway!**

---

## 🎯 The 8 Districts

### 1. 🗼 Menara Komando (Command Tower)
**Central Control & Oversight**
- Real-time agent monitoring
- KPI dashboards
- Alert management
- Human approval workflows

### 2. 🏪 Lorong Niaga (Commerce District)
**Lead Generation & Marketplace**
- Lead research agents
- Outreach automation
- Revenue tracking
- Marketplace integrations

### 3. 🎬 Jalan Konten (Content District)
**Content Planning & Production**
- Content strategy agents
- Auto-generation workflows
- Multi-platform publishing
- SEO optimization

### 4. 🔍 Kota Audit (Audit District)
**Research & Business Intelligence**
- Market research agents
- Competitive analysis
- Diagnostic reports
- Data visualization

### 5. 🔀 Stesen Routing (Routing Station)
**Task Handoffs & Queue Management**
- Intelligent task routing
- Queue visualization
- Priority management
- Cross-district coordination

### 6. ⚙️ Zon Automasi (Automation Zone)
**Scheduled Tasks & Cron Jobs**
- AI-native scheduling
- Background job execution
- Automated workflows
- Health monitoring

### 7. 🧪 Pasar Eksperimen (Experiment Market)
**Fast Tests & Campaigns**
- A/B testing agents
- Campaign management
- Rapid prototyping
- Results tracking

### 8. 🔬 Pinggir Makmal (Lab District)
**R&D and Future Products**
- Experimental features
- Pattern discovery
- Innovation sandbox
- Future roadmap testing

---

## 🇲🇾 Malaysia-First Mission

GANGCLAWCITY is explicitly Malaysia-focused:

### **Why Malaysia?**
- **SME Productivity**: 97% of Malaysian businesses are SMEs
- **AI Adoption Gap**: Huge whitespace in applied AI workforce operations
- **Digital Economy Growth**: Strong government support (MDEC, MIDA)
- **Local Context**: Bahasa Malaysia, local integrations, cultural alignment

### **Our Commitment**
1. **Bahasa Malaysia Support:** Full BM + English bilingual interface
2. **SME Templates:** Pre-configured for Malaysian business workflows
3. **Local Integrations:** WhatsApp, Shopee, Lazada, Malaysian payment gateways
4. **Affordable Pricing:** RM49-199/month (vs. $2000+ Western alternatives)
5. **Local Support:** Malaysia-based community & support team

---

## 📊 Success Metrics

### **Technical Metrics**
- ✅ Uptime: 99.9% (Vercel SLA)
- ✅ Load Time: < 2 seconds
- ✅ WebSocket Latency: < 100ms
- ✅ Bundle Size: < 300KB

### **Business Metrics**
- Tasks Completed/Day per district
- Leads Generated (Commerce district)
- Content Assets Produced (Content district)
- Approval Turnaround Time
- Revenue Influenced (ROI tracking)

---

## 🤝 Contributing

We welcome contributions! Please see our guidelines:

### **Ways to Contribute**
- 🐛 **Bug Reports:** [Create an issue](https://github.com/thisisniagahub/GANGCLAWCITY/issues)
- 💡 **Feature Requests:** [Suggest a feature](https://github.com/thisisniagahub/GANGCLAWCITY/issues)
- 📝 **Documentation:** Improve docs, add examples
- 🎨 **Design:** UI/UX improvements, district designs
- 💻 **Code:** Fix bugs, implement features
- 🌍 **Translations:** Add Bahasa Malaysia or other languages

### **Getting Started**
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests (`pnpm test`)
5. Submit a pull request

---

## 👥 Community

### **Join Us**
- 💬 **Discord:** [Join our Discord server](https://discord.gg/gangclawcity)
- 🐦 **Twitter:** [@gangclawcity](https://twitter.com/gangclawcity)
- 📧 **Newsletter:** [Subscribe for updates](https://gangclawcity.my/newsletter)
- 📖 **Blog:** [Read our latest posts](https://gangclawcity.my/blog)

---

## 📄 License

GANGCLAWCITY is released under the [MIT License](LICENSE).

```
Copyright (c) 2026 GANGCLAWCITY

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🙏 Acknowledgments

- **OpenClaw:** AI agent gateway ([openclaw.ai](https://openclaw.ai))
- **NiagaBot:** Production gateway at `wss://operator.gangniaga.my`
- **Vercel:** Frontend deployment platform
- **Agent Town:** Pixel RPG AI office ([github.com/geezerrrr/agent-town](https://github.com/geezerrrr/agent-town))
- **Pixel Agents:** VS Code extension ([github.com/pablodelucca/pixel-agents](https://github.com/pablodelucca/pixel-agents))

---

**Built with ❤️ in Malaysia** 🇲🇾

**GitHub:** https://github.com/thisisniagahub/GANGCLAWCITY  
**Gateway:** `wss://operator.gangniaga.my`  
**Status:** Production Ready ✅
