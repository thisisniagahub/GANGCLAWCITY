# 🔗 OpenClaw Gateway Integration Guide

**For GANGCLAWCITY Platform**  
**Version:** 1.0.0  
**Created:** March 13, 2026

---

## 📋 Overview

This guide shows how to connect GANGCLAWCITY to OpenClaw Gateway for real-time agent monitoring and control.

---

## 🎯 Architecture

```
GANGCLAWCITY Dashboard (openclaw-office)
         ↓ WebSocket
OpenClaw Gateway (ws://localhost:18789)
         ↓
OpenClaw Agent Runtime
         ↓
AI Models (Claude, GPT-4, Gemini, etc.)
```

---

## 🚀 Quick Start

### **Step 1: Install OpenClaw CLI**

```bash
npm install -g openclaw@latest
```

### **Step 2: Configure Gateway**

```bash
# Initialize OpenClaw
openclaw init

# Configure gateway
openclaw config set gateway.port 18789
openclaw config set gateway.auth.token your-secret-token
```

### **Step 3: Start Gateway**

```bash
# Start gateway server
openclaw gateway start

# Or run in background
openclaw gateway start --detach
```

### **Step 4: Verify Gateway**

```bash
# Check gateway status
openclaw gateway status

# Should show:
# Gateway running on ws://localhost:18789
```

---

## 🔧 Configure GANGCLAWCITY

### **Update openclaw-office .env.local**

Create or update `openclaw-office/.env.local`:

```bash
# Gateway Connection
VITE_GATEWAY_URL=ws://localhost:18789
VITE_GATEWAY_TOKEN=your-secret-token

# Optional: Enable mock mode (no gateway needed for testing)
VITE_MOCK=false
```

### **Update Kubernetes Deployment**

In `k8s/platform.yaml`, update OpenClaw Office deployment:

```yaml
env:
  - name: VITE_GATEWAY_URL
    value: "ws://openclaw-gateway:18789"
  - name: VITE_GATEWAY_TOKEN
    valueFrom:
      secretKeyRef:
        name: openclaw-secret
        key: gateway-token
```

---

## 🔌 WebSocket Connection

### **Connection Code (openclaw-office/src/gateway/ws-client.ts)**

```typescript
import { EventEmitter } from 'events';

export class GatewayClient extends EventEmitter {
  private ws: WebSocket | null = null;
  private url: string;
  private token: string;
  private reconnectAttempts = 0;
  private maxReconnectAttempts = 5;

  constructor(url: string, token: string) {
    super();
    this.url = url;
    this.token = token;
  }

  connect() {
    try {
      this.ws = new WebSocket(this.url, [this.token]);

      this.ws.onopen = () => {
        console.log('✅ Gateway connected');
        this.reconnectAttempts = 0;
        this.emit('connected');
      };

      this.ws.onclose = () => {
        console.log('❌ Gateway disconnected');
        this.emit('disconnected');
        this.reconnect();
      };

      this.ws.onerror = (error) => {
        console.error('Gateway error:', error);
        this.emit('error', error);
      };

      this.ws.onmessage = (event) => {
        const data = JSON.parse(event.data);
        this.handleMessage(data);
      };
    } catch (error) {
      console.error('Failed to connect to gateway:', error);
      this.reconnect();
    }
  }

  private handleMessage(data: any) {
    switch (data.type) {
      case 'agent.state.changed':
        this.emit('agentStateChange', data.payload);
        break;
      case 'task.created':
        this.emit('taskCreated', data.payload);
        break;
      case 'task.completed':
        this.emit('taskCompleted', data.payload);
        break;
      case 'approval.required':
        this.emit('approvalRequired', data.payload);
        break;
      default:
        console.warn('Unknown message type:', data.type);
    }
  }

  private reconnect() {
    if (this.reconnectAttempts >= this.maxReconnectAttempts) {
      console.error('Max reconnection attempts reached');
      this.emit('maxReconnectAttemptsReached');
      return;
    }

    this.reconnectAttempts++;
    const delay = Math.min(1000 * Math.pow(2, this.reconnectAttempts), 30000);

    console.log(`Reconnecting in ${delay}ms (attempt ${this.reconnectAttempts})`);

    setTimeout(() => this.connect(), delay);
  }

  // RPC Methods
  async rpc(method: string, params: any = {}) {
    return new Promise((resolve, reject) => {
      const id = Date.now();
      const message = {
        jsonrpc: '2.0',
        id,
        method,
        params,
      };

      const timeout = setTimeout(() => {
        reject(new Error(`RPC timeout: ${method}`));
      }, 30000);

      const handler = (data: any) => {
        if (data.id === id) {
          clearTimeout(timeout);
          this.off('message', handler);

          if (data.error) {
            reject(new Error(data.error.message));
          } else {
            resolve(data.result);
          }
        }
      };

      this.on('message', handler);
      this.ws?.send(JSON.stringify(message));
    });
  }

  // Convenience methods
  async listAgents() {
    return this.rpc('agents.list');
  }

  async listTasks() {
    return this.rpc('tasks.list');
  }

  async createTask(params: any) {
    return this.rpc('tasks.create', params);
  }

  async approveTask(taskId: string) {
    return this.rpc('approvals.approve', { taskId });
  }

  async rejectTask(taskId: string) {
    return this.rpc('approvals.reject', { taskId });
  }

  disconnect() {
    this.ws?.close();
  }
}
```

---

## 📊 Event Handling

### **Subscribe to Gateway Events**

```typescript
// In your React component
import { useEffect, useState } from 'react';
import { GatewayClient } from '../gateway/ws-client';

export function useGateway() {
  const [client, setClient] = useState<GatewayClient | null>(null);
  const [agents, setAgents] = useState([]);
  const [tasks, setTasks] = useState([]);

  useEffect(() => {
    const gatewayClient = new GatewayClient(
      import.meta.env.VITE_GATEWAY_URL,
      import.meta.env.VITE_GATEWAY_TOKEN
    );

    gatewayClient.on('connected', () => {
      console.log('✅ Gateway connected');
      // Fetch initial data
      gatewayClient.listAgents().then(setAgents);
      gatewayClient.listTasks().then(setTasks);
    });

    gatewayClient.on('agentStateChange', (agent) => {
      setAgents(prev => prev.map(a => 
        a.id === agent.id ? { ...a, ...agent } : a
      ));
    });

    gatewayClient.on('taskCreated', (task) => {
      setTasks(prev => [task, ...prev]);
    });

    gatewayClient.on('taskCompleted', (taskId) => {
      setTasks(prev => prev.map(t =>
        t.id === taskId ? { ...t, status: 'completed' } : t
      ));
    });

    gatewayClient.connect();
    setClient(gatewayClient);

    return () => {
      gatewayClient.disconnect();
    };
  }, []);

  return { client, agents, tasks };
}
```

---

## 🧪 Testing Without Gateway

### **Enable Mock Mode**

In `openclaw-office/.env.local`:

```bash
VITE_MOCK=true
```

### **Mock Data Generator**

```typescript
// openclaw-office/src/gateway/mock-adapter.ts

export function generateMockAgents() {
  return [
    {
      id: 'agent-1',
      name: 'Azman (Commerce)',
      avatar: '👨‍💼',
      district: 'commerce',
      status: 'active',
      currentTask: 'Researching leads',
      tasksCompleted: 15,
    },
    {
      id: 'agent-2',
      name: 'Sarah (Content)',
      avatar: '👩‍🎨',
      district: 'content',
      status: 'busy',
      currentTask: 'Writing blog post',
      tasksCompleted: 23,
    },
    {
      id: 'agent-3',
      name: 'Bot-9000 (Automation)',
      avatar: '🤖',
      district: 'automation',
      status: 'idle',
      currentTask: null,
      tasksCompleted: 142,
    },
  ];
}

export function generateMockTasks() {
  return [
    {
      id: 'task-1',
      title: 'Generate lead list',
      district: 'commerce',
      agentId: 'agent-1',
      status: 'in-progress',
      createdAt: new Date(),
    },
    {
      id: 'task-2',
      title: 'Write SEO blog post',
      district: 'content',
      agentId: 'agent-2',
      status: 'completed',
      createdAt: new Date(Date.now() - 3600000),
    },
  ];
}
```

---

## 🔐 Security

### **Device Auth Bypass (Development Only)**

```bash
# WARNING: Only for local development!
openclaw config set gateway.controlUi.dangerouslyDisableDeviceAuth true

# Restart gateway after
openclaw gateway restart
```

### **Production Authentication**

```bash
# Generate secure token
openssl rand -hex 32

# Set in gateway config
openclaw config set gateway.auth.token <your-secure-token>

# Use in GANGCLAWCITY
VITE_GATEWAY_TOKEN=<your-secure-token>
```

---

## 📈 Monitoring

### **Gateway Health Check**

```typescript
async function checkGatewayHealth() {
  try {
    const response = await fetch('http://localhost:18789/health');
    const data = await response.json();
    
    return {
      status: data.status, // 'healthy' | 'unhealthy'
      uptime: data.uptime,
      agentsConnected: data.agentsConnected,
      tasksProcessed: data.tasksProcessed,
    };
  } catch (error) {
    console.error('Gateway health check failed:', error);
    return null;
  }
}
```

### **Metrics to Track**

```typescript
// Gateway metrics
interface GatewayMetrics {
  // Connection
  connected: boolean;
  uptime: number;
  reconnectCount: number;
  
  // Agents
  totalAgents: number;
  activeAgents: number;
  idleAgents: number;
  
  // Tasks
  totalTasks: number;
  pendingTasks: number;
  completedTasks: number;
  failedTasks: number;
  
  // Performance
  avgTaskDuration: number;
  tasksPerMinute: number;
  errorRate: number;
}
```

---

## 🛠️ Troubleshooting

### **Issue: Can't connect to gateway**

```bash
# Check if gateway is running
openclaw gateway status

# Check port
netstat -ano | findstr :18789

# Restart gateway
openclaw gateway restart
```

### **Issue: Authentication failed**

```bash
# Verify token
openclaw config get gateway.auth.token

# Regenerate token
openclaw config set gateway.auth.token $(openssl rand -hex 32)

# Update .env.local
# Restart GANGCLAWCITY dashboard
```

### **Issue: WebSocket keeps disconnecting**

```typescript
// Check reconnect logic
// Ensure exponential backoff is implemented
// Max reconnect attempts should be 5-10
```

---

## 📖 API Reference

### **RPC Methods**

| Method | Description | Parameters |
|--------|-------------|------------|
| `agents.list` | List all agents | `{ status?: string }` |
| `agents.get` | Get agent details | `{ agentId: string }` |
| `tasks.list` | List all tasks | `{ status?: string, district?: string }` |
| `tasks.create` | Create new task | `{ title, district, agentId? }` |
| `tasks.complete` | Mark task complete | `{ taskId: string }` |
| `approvals.list` | List pending approvals | `{}` |
| `approvals.approve` | Approve task | `{ taskId: string }` |
| `approvals.reject` | Reject task | `{ taskId: string, reason?: string }` |
| `sessions.list` | List active sessions | `{}` |
| `skills.list` | List available skills | `{ district?: string }` |

---

## 🎯 Next Steps

After gateway integration:

1. ✅ Test WebSocket connection
2. ✅ Verify agent list populates
3. ✅ Test task creation
4. ✅ Test approval workflow
5. ✅ Monitor real-time updates
6. ✅ Add error handling
7. ✅ Implement reconnection logic

---

**Status:** Ready for Integration  
**Difficulty:** ⭐⭐⭐ (Intermediate)  
**Time:** 30-60 minutes

---

**🏙️ GANGCLAWCITY** — A living operating system for digital labor.  
**Built with ❤️ in Malaysia** 🇲🇾
