const WebSocket = require('ws');
const express = require('express');
const cors = require('cors');
const http = require('http');

const PORT = process.env.PORT || 18789;

// Mock data
const mockAgents = [
  {
    id: 'agent-1',
    name: 'Azman (Commerce)',
    avatar: '👨‍💼',
    district: 'commerce',
    status: 'active',
    currentTask: 'Researching leads',
    tasksCompleted: 15,
    lastSeen: new Date().toISOString()
  },
  {
    id: 'agent-2',
    name: 'Sarah (Content)',
    avatar: '👩‍🎨',
    district: 'content',
    status: 'busy',
    currentTask: 'Writing blog post',
    tasksCompleted: 23,
    lastSeen: new Date().toISOString()
  },
  {
    id: 'agent-3',
    name: 'Bot-9000 (Automation)',
    avatar: '🤖',
    district: 'automation',
    status: 'idle',
    currentTask: null,
    tasksCompleted: 142,
    lastSeen: new Date().toISOString()
  },
  {
    id: 'agent-4',
    name: 'Ali (Audit)',
    avatar: '🔍',
    district: 'audit',
    status: 'active',
    currentTask: 'Analyzing competitors',
    tasksCompleted: 31,
    lastSeen: new Date().toISOString()
  }
];

const mockTasks = [
  {
    id: 'task-1',
    title: 'Generate lead list',
    description: 'Research and compile list of 100 potential customers',
    district: 'commerce',
    agentId: 'agent-1',
    status: 'in-progress',
    priority: 'high',
    createdAt: new Date(Date.now() - 3600000).toISOString(),
    completedAt: null
  },
  {
    id: 'task-2',
    title: 'Write SEO blog post',
    description: 'Create 2000-word article about AI automation',
    district: 'content',
    agentId: 'agent-2',
    status: 'completed',
    priority: 'medium',
    createdAt: new Date(Date.now() - 7200000).toISOString(),
    completedAt: new Date().toISOString()
  },
  {
    id: 'task-3',
    title: 'Schedule social media posts',
    description: 'Queue posts for next week across all platforms',
    district: 'content',
    agentId: 'agent-2',
    status: 'pending',
    priority: 'low',
    createdAt: new Date().toISOString(),
    completedAt: null
  },
  {
    id: 'task-4',
    title: 'Run daily backup',
    description: 'Automated daily system backup',
    district: 'automation',
    agentId: 'agent-3',
    status: 'completed',
    priority: 'high',
    createdAt: new Date(Date.now() - 86400000).toISOString(),
    completedAt: new Date(Date.now() - 82800000).toISOString()
  }
];

const mockSessions = [
  {
    id: 'session-1',
    userId: 'user-123',
    agentCount: 4,
    activeTasks: 2,
    startedAt: new Date(Date.now() - 300000).toISOString()
  }
];

const mockSkills = [
  { id: 'skill-1', name: 'Lead Research', district: 'commerce' },
  { id: 'skill-2', name: 'Email Outreach', district: 'commerce' },
  { id: 'skill-3', name: 'Blog Writing', district: 'content' },
  { id: 'skill-4', name: 'Social Media', district: 'content' },
  { id: 'skill-5', name: 'Data Analysis', district: 'audit' },
  { id: 'skill-6', name: 'Report Generation', district: 'audit' },
  { id: 'skill-7', name: 'Task Scheduling', district: 'automation' },
  { id: 'skill-8', name: 'System Monitoring', district: 'automation' }
];

// Express app for HTTP API
const app = express();
app.use(cors());
app.use(express.json());

// Health check
app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    uptime: process.uptime(),
    timestamp: new Date().toISOString(),
    agentsConnected: mockAgents.length,
    tasksProcessed: mockTasks.filter(t => t.status === 'completed').length
  });
});

// HTTP API endpoints
app.get('/api/agents', (req, res) => {
  res.json({ agents: mockAgents });
});

app.get('/api/tasks', (req, res) => {
  const { status, district } = req.query;
  let filtered = mockTasks;
  
  if (status) {
    filtered = filtered.filter(t => t.status === status);
  }
  if (district) {
    filtered = filtered.filter(t => t.district === district);
  }
  
  res.json({ tasks: filtered });
});

app.get('/api/sessions', (req, res) => {
  res.json({ sessions: mockSessions });
});

app.get('/api/skills', (req, res) => {
  const { district } = req.query;
  let filtered = mockSkills;
  
  if (district) {
    filtered = filtered.filter(s => s.district === district);
  }
  
  res.json({ skills: filtered });
});

// Create HTTP server
const server = http.createServer(app);

// WebSocket server
const wss = new WebSocket.Server({ server });

// Connected clients
const clients = new Set();

// Broadcast to all clients
function broadcast(data) {
  const message = JSON.stringify(data);
  clients.forEach(client => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(message);
    }
  });
}

// Handle WebSocket connections
wss.on('connection', (ws) => {
  console.log('✅ Client connected');
  clients.add(ws);
  
  // Send welcome message
  ws.send(JSON.stringify({
    type: 'connected',
    message: 'Connected to mock OpenClaw Gateway',
    timestamp: new Date().toISOString()
  }));
  
  // Handle messages
  ws.on('message', (message) => {
    try {
      const data = JSON.parse(message);
      console.log('📩 Received:', data);
      
      // Handle RPC calls
      if (data.method) {
        handleRpc(ws, data);
      }
    } catch (error) {
      console.error('❌ Error parsing message:', error);
    }
  });
  
  // Handle disconnection
  ws.on('close', () => {
    console.log('❌ Client disconnected');
    clients.delete(ws);
  });
  
  ws.on('error', (error) => {
    console.error('❌ WebSocket error:', error);
  });
});

// Handle RPC methods
function handleRpc(ws, request) {
  const { method, params = {}, id } = request;
  
  let result = null;
  let error = null;
  
  try {
    switch (method) {
      case 'agents.list':
        result = { agents: mockAgents };
        break;
      
      case 'agents.get':
        result = mockAgents.find(a => a.id === params.agentId);
        if (!result) throw new Error('Agent not found');
        break;
      
      case 'tasks.list':
        let tasks = mockTasks;
        if (params.status) {
          tasks = tasks.filter(t => t.status === params.status);
        }
        if (params.district) {
          tasks = tasks.filter(t => t.district === params.district);
        }
        result = { tasks };
        break;
      
      case 'tasks.create':
        const newTask = {
          id: `task-${Date.now()}`,
          title: params.title || 'New task',
          description: params.description || '',
          district: params.district || 'general',
          agentId: params.agentId || null,
          status: 'pending',
          priority: params.priority || 'medium',
          createdAt: new Date().toISOString(),
          completedAt: null
        };
        mockTasks.push(newTask);
        result = { task: newTask };
        
        // Broadcast new task
        broadcast({
          type: 'task.created',
          payload: newTask
        });
        break;
      
      case 'tasks.complete':
        const task = mockTasks.find(t => t.id === params.taskId);
        if (!task) throw new Error('Task not found');
        task.status = 'completed';
        task.completedAt = new Date().toISOString();
        result = { task };
        
        // Broadcast completion
        broadcast({
          type: 'task.completed',
          payload: { taskId: task.id }
        });
        break;
      
      case 'approvals.list':
        result = { 
          approvals: mockTasks.filter(t => t.status === 'pending_approval') 
        };
        break;
      
      case 'approvals.approve':
        const approvalTask = mockTasks.find(t => t.id === params.taskId);
        if (!approvalTask) throw new Error('Task not found');
        approvalTask.status = 'approved';
        result = { task: approvalTask };
        break;
      
      case 'approvals.reject':
        const rejectTask = mockTasks.find(t => t.id === params.taskId);
        if (!rejectTask) throw new Error('Task not found');
        rejectTask.status = 'rejected';
        result = { task: rejectTask };
        break;
      
      case 'sessions.list':
        result = { sessions: mockSessions };
        break;
      
      case 'skills.list':
        let skills = mockSkills;
        if (params.district) {
          skills = skills.filter(s => s.district === params.district);
        }
        result = { skills };
        break;
      
      default:
        throw new Error(`Unknown method: ${method}`);
    }
    
    // Send response
    if (id) {
      ws.send(JSON.stringify({
        jsonrpc: '2.0',
        id,
        result
      }));
    }
  } catch (err) {
    error = { message: err.message };
    
    if (id) {
      ws.send(JSON.stringify({
        jsonrpc: '2.0',
        id,
        error
      }));
    }
  }
}

// Simulate agent activity
function simulateAgentActivity() {
  setInterval(() => {
    const agent = mockAgents[Math.floor(Math.random() * mockAgents.length)];
    const activities = [
      'Working on task',
      'Researching',
      'Analyzing data',
      'Generating report',
      'Communicating with team',
      'Taking a break'
    ];
    
    agent.currentTask = activities[Math.floor(Math.random() * activities.length)];
    agent.lastSeen = new Date().toISOString();
    
    // Broadcast state change
    broadcast({
      type: 'agent.state.changed',
      payload: agent
    });
    
    console.log(`🔄 Agent ${agent.name} updated: ${agent.currentTask}`);
  }, 10000); // Every 10 seconds
}

// Simulate task completion
function simulateTaskCompletion() {
  setInterval(() => {
    const pendingTasks = mockTasks.filter(t => t.status === 'in-progress');
    
    if (pendingTasks.length > 0) {
      const task = pendingTasks[Math.floor(Math.random() * pendingTasks.length)];
      
      // 30% chance to complete
      if (Math.random() < 0.3) {
        task.status = 'completed';
        task.completedAt = new Date().toISOString();
        
        // Update agent stats
        const agent = mockAgents.find(a => a.id === task.agentId);
        if (agent) {
          agent.tasksCompleted++;
        }
        
        // Broadcast completion
        broadcast({
          type: 'task.completed',
          payload: { taskId: task.id }
        });
        
        console.log(`✅ Task completed: ${task.title}`);
      }
    }
  }, 15000); // Every 15 seconds
}

// Start server
server.listen(PORT, () => {
  console.log('=============================================');
  console.log('🚀 Mock OpenClaw Gateway Started!');
  console.log('=============================================');
  console.log(`📡 WebSocket: ws://localhost:${PORT}`);
  console.log(`🌐 HTTP API: http://localhost:${PORT}`);
  console.log(`📊 Health: http://localhost:${PORT}/health`);
  console.log('=============================================');
  console.log('Mock Agents:', mockAgents.length);
  console.log('Mock Tasks:', mockTasks.length);
  console.log('Mock Skills:', mockSkills.length);
  console.log('=============================================');
  console.log('Press Ctrl+C to stop');
  console.log('=============================================');
  
  // Start simulations
  simulateAgentActivity();
  simulateTaskCompletion();
});

// Graceful shutdown
process.on('SIGINT', () => {
  console.log('\n\nShutting down...');
  wss.clients.forEach(client => {
    client.close();
  });
  server.close(() => {
    console.log('Server closed');
    process.exit(0);
  });
});
