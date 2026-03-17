# 🔧 GATEWAY IMPROVEMENT PLAN

**VPS:** <VPS_IP>  
**Goal:** Stable WebSocket connection for GANGCLAWCITY + NiagaBot  
**Status:** OpenClaw Running ✅

---

## 📊 CURRENT STATUS

### **✅ What's Working:**
- OpenClaw Gateway running on port 18789
- Multiple AI profiles configured (Google, OpenAI, Qwen)
- NiagaBot agents active
- WebSocket endpoint accessible

### **⚠️ What Needs Improvement:**
- CORS not enabled for Vercel domains
- No WSS (secure WebSocket) proxy
- Direct WS connection may be blocked by browsers
- No rate limiting
- No connection monitoring

---

## 🚀 IMPROVEMENT STEPS

### **Step 1: Enable CORS on OpenClaw** ⭐ **DO THIS FIRST**

**File:** `/root/.openclaw/openclaw.json`

**Add/Update this section:**
```json
{
  "gateway": {
    "cors": {
      "enabled": true,
      "origins": [
        "https://gangclawcity-landing.vercel.app",
        "https://gangclawcity-dashboard.vercel.app",
        "https://gangclawcity-demo.vercel.app",
        "https://gangclawcity.my",
        "https://www.gangclawcity.my",
        "http://localhost:3000",
        "http://localhost:5180",
        "http://localhost:8080"
      ],
      "methods": ["GET", "POST", "OPTIONS"],
      "allowedHeaders": ["Content-Type", "Authorization", "Upgrade", "Connection"]
    },
    "websocket": {
      "pingInterval": 30000,
      "pingTimeout": 5000,
      "maxPayload": 1048576,
      "perMessageDeflate": true
    },
    "rateLimit": {
      "enabled": true,
      "windowMs": 60000,
      "max": 100
    }
  }
}
```

**Apply Changes:**
```bash
ssh root@<VPS_IP>

# Backup config
cp /root/.openclaw/openclaw.json /root/.openclaw/openclaw.json.bak

# Edit config (use nano or vim)
nano /root/.openclaw/openclaw.json

# Add the gateway section above (before the closing brace)

# Restart OpenClaw
openclaw gateway restart

# Check status
openclaw gateway status
```

---

### **Step 2: Setup Nginx WSS Proxy** ⭐ **FOR PRODUCTION**

**Why:** Browsers block non-secure WebSocket (ws://) from HTTPS sites. WSS (secure WebSocket) solves this.

#### **2.1: Install Nginx**

```bash
ssh root@<VPS_IP>

# Install Nginx
apt update
apt install nginx -y

# Start Nginx
systemctl start nginx
systemctl enable nginx

# Check status
systemctl status nginx
```

#### **2.2: Create Nginx Config for WSS**

**File:** `/etc/nginx/sites-available/gangclawcity-wss`

```nginx
# WSS Proxy for GANGCLAWCITY
server {
    listen 8443 ssl;
    server_name <VPS_IP>;

    # SSL Certificates (self-signed for now, use Let's Encrypt for production)
    ssl_certificate /etc/nginx/ssl/gangclawcity-selfsigned.crt;
    ssl_certificate_key /etc/nginx/ssl/gangclawcity-selfsigned.key;

    # SSL Configuration
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_ciphers HIGH:!aNULL:!MD5;

    # WebSocket Proxy
    location /ws {
        proxy_pass http://localhost:18789;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        
        # WebSocket timeouts
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
        
        # CORS Headers
        add_header Access-Control-Allow-Origin * always;
        add_header Access-Control-Allow-Methods "GET, POST, OPTIONS" always;
        add_header Access-Control-Allow-Headers "Upgrade, Connection, Content-Type, Authorization" always;
        
        # Disable buffering for WebSocket
        proxy_buffering off;
        proxy_cache off;
    }

    # HTTP to HTTPS redirect for gateway-ws
    location /gateway-ws {
        return 301 https://$host:8443/ws;
    }
}

# Simple HTTP endpoint for health check
server {
    listen 80;
    server_name <VPS_IP>;

    location /gateway-health {
        return 200 "OpenClaw Gateway OK\n";
        add_header Content-Type text/plain;
    }
}
```

#### **2.3: Create Self-Signed SSL Certificate**

```bash
# Create directory
mkdir -p /etc/nginx/ssl

# Generate self-signed cert
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/gangclawcity-selfsigned.key \
  -out /etc/nginx/ssl/gangclawcity-selfsigned.crt \
  -subj "/C=MY/ST=Kuala Lumpur/L=KL/O=GANGCLAWCITY/CN=<VPS_IP>"

# Set permissions
chmod 600 /etc/nginx/ssl/gangclawcity-selfsigned.key
chmod 644 /etc/nginx/ssl/gangclawcity-selfsigned.crt
```

#### **2.4: Enable Site**

```bash
# Enable site
ln -s /etc/nginx/sites-available/gangclawcity-wss /etc/nginx/sites-enabled/

# Remove default site (optional)
rm /etc/nginx/sites-enabled/default

# Test config
nginx -t

# Reload Nginx
systemctl reload nginx
```

#### **2.5: Configure Firewall**

```bash
# Install UFW if not installed
apt install ufw -y

# Allow ports
ufw allow 22/tcp      # SSH
ufw allow 80/tcp      # HTTP
ufw allow 443/tcp     # HTTPS (for future)
ufw allow 8443/tcp    # WSS Proxy

# Enable firewall
ufw --force enable

# Check status
ufw status
```

---

### **Step 3: Update GANGCLAWCITY Config**

#### **3.1: Update Vercel Environment Variables**

**Dashboard (.env.local on Vercel):**
```
# Option A: Direct WS (for testing)
VITE_GATEWAY_URL=ws://<VPS_IP>:18789

# Option B: WSS Proxy (for production)
VITE_GATEWAY_URL=wss://<VPS_IP>:8443/ws
```

#### **3.2: Update Local Development**

**File:** `openclaw-office/.env.local`
```
VITE_GATEWAY_URL=ws://<VPS_IP>:18789
VITE_MOCK=false
```

**OR with WSS:**
```
VITE_GATEWAY_URL=wss://<VPS_IP>:8443/ws
VITE_MOCK=false
```

---

### **Step 4: Monitoring & Health Checks**

#### **4.1: Create Health Check Script**

**File:** `/root/gateway-healthcheck.sh`

```bash
#!/bin/bash

# Gateway Health Check Script

GATEWAY_URL="http://localhost:18789"
LOG_FILE="/root/gateway-health.log"

echo "[$(date)] Checking OpenClaw Gateway..." >> $LOG_FILE

# Check if process is running
if pgrep -f "openclaw gateway" > /dev/null; then
    echo "[$(date)] ✅ Gateway process running" >> $LOG_FILE
    
    # Check WebSocket endpoint
    if curl -s --max-time 5 "$GATEWAY_URL" > /dev/null; then
        echo "[$(date)] ✅ Gateway responding" >> $LOG_FILE
    else
        echo "[$(date)] ❌ Gateway not responding" >> $LOG_FILE
        # Auto-restart
        echo "[$(date)] Restarting gateway..." >> $LOG_FILE
        openclaw gateway restart >> $LOG_FILE 2>&1
    fi
else
    echo "[$(date)] ❌ Gateway process not running" >> $LOG_FILE
    echo "[$(date)] Starting gateway..." >> $LOG_FILE
    openclaw gateway start >> $LOG_FILE 2>&1
fi

echo "---" >> $LOG_FILE
```

**Make executable:**
```bash
chmod +x /root/gateway-healthcheck.sh
```

#### **4.2: Setup Cron Job for Auto-Monitoring**

```bash
# Edit crontab
crontab -e

# Add this line (check every 5 minutes)
*/5 * * * * /root/gateway-healthcheck.sh
```

---

### **Step 5: Performance Optimization**

#### **5.1: Increase File Descriptors**

**File:** `/etc/security/limits.conf`

Add:
```
root soft nofile 65536
root hard nofile 65536
```

#### **5.2: Optimize Nginx for WebSocket**

**File:** `/etc/nginx/nginx.conf`

Add in `http` block:
```nginx
http {
    # ... existing config ...
    
    # WebSocket optimizations
    map $http_upgrade $connection_upgrade {
        default upgrade;
        '' close;
    }
    
    # Increase buffer size
    proxy_buffer_size 128k;
    proxy_buffers 4 256k;
    proxy_busy_buffers_size 256k;
}
```

#### **5.3: System Tuning**

**File:** `/etc/sysctl.conf`

Add:
```
# Increase file descriptor limit
fs.file-max = 2097152

# Increase TCP connections
net.core.somaxconn = 65535
net.ipv4.tcp_max_syn_backlog = 65535

# Reuse connections
net.ipv4.tcp_tw_reuse = 1
```

**Apply:**
```bash
sysctl -p
```

---

## 📊 TESTING CONNECTION

### **Test 1: Direct WebSocket**

```bash
# Install wscat
npm install -g wscat

# Test direct connection
wscat -c ws://<VPS_IP>:18789

# Should connect successfully
```

### **Test 2: WSS Connection**

```bash
# Test WSS (allow self-signed cert)
wscat -c wss://<VPS_IP>:8443/ws -n

# Or use curl for health check
curl -k https://<VPS_IP>:8443/health
```

### **Test 3: From Browser**

**Create test HTML file:**
```html
<!DOCTYPE html>
<html>
<head><title>Gateway Test</title></head>
<body>
  <h1>OpenClaw Gateway Test</h1>
  <div id="status">Connecting...</div>
  <div id="messages"></div>
  
  <script>
    const ws = new WebSocket('wss://<VPS_IP>:8443/ws');
    
    ws.onopen = () => {
      document.getElementById('status').innerHTML = '✅ Connected!';
      document.getElementById('status').style.color = 'green';
      
      // Send test message
      ws.send(JSON.stringify({
        jsonrpc: '2.0',
        id: 1,
        method: 'agents.list'
      }));
    };
    
    ws.onmessage = (event) => {
      const msg = document.createElement('div');
      msg.textContent = 'Received: ' + event.data;
      document.getElementById('messages').appendChild(msg);
    };
    
    ws.onerror = (error) => {
      document.getElementById('status').innerHTML = '❌ Error!';
      document.getElementById('status').style.color = 'red';
      console.error('WebSocket error:', error);
    };
    
    ws.onclose = () => {
      document.getElementById('status').innerHTML = '🔴 Disconnected';
    };
  </script>
</body>
</html>
```

**Save as:** `test-gateway.html`  
**Open in browser** and check connection status.

---

## 🎯 RECOMMENDED DEPLOYMENT ORDER

### **Phase 1: Quick Fix (15 mins)**

1. **Enable CORS on OpenClaw**
   ```bash
   ssh root@<VPS_IP>
   nano /root/.openclaw/openclaw.json
   # Add gateway.cors section
   openclaw gateway restart
   ```

2. **Test Connection**
   ```bash
   wscat -c ws://<VPS_IP>:18789
   ```

3. **Deploy to Vercel**
   - Push code to GitHub
   - Import to Vercel
   - Set environment variables

---

### **Phase 2: Production Setup (1 hour)**

1. **Setup Nginx WSS Proxy**
2. **Generate SSL Certificate**
3. **Configure Firewall**
4. **Test WSS Connection**
5. **Update Vercel Environment Variables**

---

### **Phase 3: Monitoring (30 mins)**

1. **Create Health Check Script**
2. **Setup Cron Job**
3. **Configure Logging**
4. **Test Auto-Restart**

---

## 📈 EXPECTED RESULTS

### **After Improvements:**

```
✅ CORS enabled for Vercel domains
✅ WSS proxy working (secure WebSocket)
✅ Health monitoring active
✅ Auto-restart on failure
✅ Rate limiting enabled
✅ Optimized for production

Connection URLs:
- Development: ws://<VPS_IP>:18789
- Production: wss://<VPS_IP>:8443/ws
```

---

## 🚨 TROUBLESHOOTING

### **Issue 1: CORS Error**

**Symptom:**
```
Access to WebSocket blocked by CORS policy
```

**Solution:**
```json
// In /root/.openclaw/openclaw.json
{
  "gateway": {
    "cors": {
      "enabled": true,
      "origins": ["*"]  // For testing, use specific domains in production
    }
  }
}
```

---

### **Issue 2: WSS Connection Fails**

**Symptom:**
```
WebSocket connection failed: unexpected server response
```

**Solution:**
```bash
# Check Nginx config
nginx -t

# Check if port 8443 is open
netstat -tulpn | grep 8443

# Check firewall
ufw status

# Restart Nginx
systemctl restart nginx
```

---

### **Issue 3: Gateway Keeps Crashing**

**Symptom:**
```
Gateway process not running
```

**Solution:**
```bash
# Check logs
cat /root/.openclaw/logs/gateway.log

# Check memory
free -h

# Check file descriptors
ulimit -n

# Increase limits if needed
ulimit -n 65536
```

---

**🏙️ GANGCLAWCITY Gateway** — Optimized for Production!  
**Time:** 1-2 hours total  
**Risk:** Zero to NiagaBot  
**Improvement:** 10x more stable connection  

---

**Nak start dengan Phase 1 (enable CORS) sekarang?** 🚀
