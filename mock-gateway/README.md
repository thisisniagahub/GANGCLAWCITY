# Mock OpenClaw Gateway

**Mock gateway untuk testing GANGCLAWCITY dashboard tanpa OpenClaw sebenar**

---

## 🚀 Quick Start

### **Install Dependencies:**

```bash
cd mock-gateway
npm install
```

### **Start Gateway:**

```bash
npm start
```

Gateway akan running di:
- WebSocket: `ws://localhost:18789`
- HTTP API: `http://localhost:18789`
- Health: `http://localhost:18789/health`

---

## 📊 Features

### **Mock Data:**
- ✅ 4 AI Agents (Commerce, Content, Automation, Audit)
- ✅ Multiple tasks with different statuses
- ✅ Skills per district
- ✅ Active sessions

### **WebSocket Events:**
```javascript
// Subscribe to events
ws.on('message', (data) => {
  const event = JSON.parse(data);
  
  switch(event.type) {
    case 'agent.state.changed':
      console.log('Agent updated:', event.payload);
      break;
    case 'task.created':
      console.log('New task:', event.payload);
      break;
    case 'task.completed':
      console.log('Task done:', event.payload);
      break;
  }
});
```

### **RPC Methods:**
```javascript
// List all agents
ws.send(JSON.stringify({
  jsonrpc: '2.0',
  id: 1,
  method: 'agents.list'
}));

// Create task
ws.send(JSON.stringify({
  jsonrpc: '2.0',
  id: 2,
  method: 'tasks.create',
  params: {
    title: 'New task',
    district: 'commerce',
    priority: 'high'
  }
}));

// Complete task
ws.send(JSON.stringify({
  jsonrpc: '2.0',
  id: 3,
  method: 'tasks.complete',
  params: {
    taskId: 'task-1'
  }
}));
```

---

## 🌐 HTTP API

### **Get All Agents:**
```bash
curl http://localhost:18789/api/agents
```

### **Get Tasks:**
```bash
curl http://localhost:18789/api/tasks?status=completed
```

### **Get Skills:**
```bash
curl http://localhost:18789/api/skills?district=content
```

### **Health Check:**
```bash
curl http://localhost:18789/health
```

---

## 🧪 Testing with Dashboard

### **Connect Dashboard:**

In your dashboard code, connect to mock gateway:

```javascript
const ws = new WebSocket('ws://localhost:18789');

ws.on('open', () => {
  console.log('✅ Connected to mock gateway');
  
  // Request agents list
  ws.send(JSON.stringify({
    jsonrpc: '2.0',
    id: 1,
    method: 'agents.list'
  }));
});

ws.on('message', (data) => {
  const message = JSON.parse(data);
  
  if (message.type === 'agent.state.changed') {
    // Update UI with new agent state
    updateAgent(message.payload);
  }
});
```

---

## 📈 Simulated Activity

Mock gateway automatically simulates:

1. **Agent Activity** (every 10s):
   - Agents change current task
   - Status updates broadcast to all clients

2. **Task Completion** (every 15s):
   - Random tasks get completed
   - Agent stats updated
   - Completion events broadcast

---

## 🛠️ Customization

### **Add More Agents:**

Edit `server.js`:

```javascript
const mockAgents = [
  // ... existing agents
  {
    id: 'agent-5',
    name: 'New Agent',
    avatar: '👤',
    district: 'commerce',
    status: 'active',
    currentTask: 'Starting...',
    tasksCompleted: 0,
    lastSeen: new Date().toISOString()
  }
];
```

### **Change Update Frequency:**

```javascript
// Faster updates (5 seconds instead of 10)
setInterval(() => {
  // ... simulation code
}, 5000);
```

---

## 🎯 Use Cases

### **1. Dashboard Development:**
- Test real-time updates
- Verify WebSocket connection
- Debug event handling

### **2. UI Testing:**
- Test loading states
- Verify error handling
- Check reconnection logic

### **3. Demo Purposes:**
- Show live agent activity
- Demonstrate task flow
- Display metrics

---

## 📊 Sample Output

```
=============================================
🚀 Mock OpenClaw Gateway Started!
=============================================
📡 WebSocket: ws://localhost:18789
🌐 HTTP API: http://localhost:18789
📊 Health: http://localhost:18789/health
=============================================
Mock Agents: 4
Mock Tasks: 4
Mock Skills: 8
=============================================
Press Ctrl+C to stop
=============================================

🔄 Agent Azman (Commerce) updated: Researching
✅ Task completed: Generate lead list
🔄 Agent Sarah (Content) updated: Writing content
```

---

## 🔧 Troubleshooting

### **Issue: Port already in use**

```bash
# Windows
netstat -ano | findstr :18789
taskkill /F /PID <PID>

# Change port
PORT=18790 npm start
```

### **Issue: Can't connect**

```bash
# Check if server is running
curl http://localhost:18789/health

# Check firewall
# Allow port 18789
```

---

## 📖 API Reference

### **WebSocket RPC Methods:**

| Method | Description | Parameters |
|--------|-------------|------------|
| `agents.list` | List all agents | - |
| `agents.get` | Get agent by ID | `agentId` |
| `tasks.list` | List tasks | `status?`, `district?` |
| `tasks.create` | Create new task | `title`, `district?`, `priority?` |
| `tasks.complete` | Mark task complete | `taskId` |
| `approvals.list` | List pending approvals | - |
| `approvals.approve` | Approve task | `taskId` |
| `approvals.reject` | Reject task | `taskId` |
| `sessions.list` | List active sessions | - |
| `skills.list` | List skills | `district?` |

### **HTTP Endpoints:**

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/health` | Health check |
| GET | `/api/agents` | List agents |
| GET | `/api/tasks` | List tasks |
| GET | `/api/sessions` | List sessions |
| GET | `/api/skills` | List skills |

---

**Status:** Ready for testing  
**Port:** 18789  
**Protocol:** WebSocket + HTTP  

---

**🏙️ GANGCLAWCITY** — Built with ❤️ in Malaysia 🇲🇾
