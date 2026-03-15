# 🚀 GANGCLAWCITY - Instant Deployment

**PILIH SALAH SATU:**

---

## 🔹 Option 1: Docker Compose (RECOMMENDED - Paling Mudah!)

### **Prerequisites:**
- Docker Desktop installed dan running

### **Steps:**

1. **Start Docker Desktop**
   - Buka Docker Desktop application
   - Tunggu sehingga hijau (running)

2. **Deploy semua services**
   ```bash
   cd G:\PROJECT-4\GANGCLAWCITY
   docker-compose up --build -d
   ```

3. **Access services**
   - Landing Page: http://localhost:8080
   - Agent Town: http://localhost:3000
   - Dashboard: http://localhost:5180
   - AI Town: http://localhost:5173
   - Star Office: http://localhost:19000

4. **Stop semua services**
   ```bash
   docker-compose down
   ```

---

## 🔹 Option 2: Quick Deploy Script (Automated)

### **Prerequisites:**
- Docker Desktop running
- kubectl installed

### **Steps:**

1. **Double-click file ini:**
   ```
   deploy.bat
   ```

2. **Atau run manual:**
   ```bash
   cd G:\PROJECT-4\GANGCLAWCITY
   deploy.bat
   ```

3. **Browser akan auto-buka ke landing page!**

---

## 🔹 Option 3: Manual Build (Tanpa Docker)

### **For Landing Page:**
```bash
cd G:\PROJECT-4\GANGCLAWCITY\landing-page
python -m http.server 8080

# Open: http://localhost:8080
```

### **For Agent Town:**
```bash
cd G:\PROJECT-4\GANGCLAWCITY\agent-town
pnpm install
pnpm dev

# Open: http://localhost:3000
```

### **For OpenClaw Office:**
```bash
cd G:\PROJECT-4\GANGCLAWCITY\openclaw-office
pnpm install
pnpm dev

# Open: http://localhost:5180
```

### **For AI Town:**
```bash
cd G:\PROJECT-4\GANGCLAWCITY\ai-town
npm install
npm run dev

# Open: http://localhost:5173
```

### **For Star Office UI:**
```bash
cd G:\PROJECT-4\GANGCLAWCITY\Star-Office-UI
python -m uv run flask --app backend/app run --port 19000

# Open: http://localhost:19000
```

---

## ⚠️ Troubleshooting

### **Issue: Docker Desktop not running**
```
Solution:
1. Buka Docker Desktop application
2. Tunggu sehingga hijau
3. Cuba deploy semula
```

### **Issue: Port already in use**
```bash
# Windows - Check port
netstat -ano | findstr :8080

# Kill process
taskkill /F /PID <PID>
```

### **Issue: Build failed**
```bash
# Clean build
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

---

## 📊 Monitor Services

### **Check status:**
```bash
docker-compose ps
```

### **View logs:**
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f landing-page
```

### **Restart service:**
```bash
docker-compose restart landing-page
```

---

## 🎯 Expected Output

```
[+] Running 5/5
 ✔ Container gangclawcity-landing-page    Started
 ✔ Container gangclawcity-agent-town      Started
 ✔ Container gangclawcity-openclaw-office Started
 ✔ Container gangclawcity-ai-town         Started
 ✔ Container gangclawcity-star-office-ui  Started
```

---

## ✅ Success Criteria

All services running:
```
NAME                           STATUS
gangclawcity-landing-page      Up (healthy)
gangclawcity-agent-town        Up (healthy)
gangclawcity-openclaw-office   Up (healthy)
gangclawcity-ai-town           Up (healthy)
gangclawcity-star-office-ui    Up (healthy)
```

---

**🏙️ GANGCLAWCITY** — Built with ❤️ in Malaysia 🇲🇾
