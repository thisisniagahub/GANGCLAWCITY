# 🏙️ GANGCLAWCITY Platform - Quick Start Guide

**Status:** Ready to Deploy  
**Last Updated:** March 13, 2026

---

## 🚀 Quick Deploy (5 Minutes)

### **Prerequisites**

Install these first:

```bash
# Windows (Chocolatey)
choco install docker-desktop kubernetes-cli skaffold

# macOS (Homebrew)
brew install --cask docker
brew install kubernetes-cli skaffold

# Verify installations
docker --version
kubectl version --client
skaffold version
```

### **Enable Kubernetes**

1. Open Docker Desktop
2. Go to Settings → Kubernetes
3. Check "Enable Kubernetes"
4. Click "Apply & Restart"
5. Wait 2-3 minutes for cluster to start

```bash
# Verify cluster is running
kubectl cluster-info
kubectl get nodes
```

---

## 🎯 Deploy All Services

### **Option 1: One-Command Deploy (Recommended)**

```bash
cd G:\PROJECT-4\GANGCLAWCITY

# Deploy all 5 services with hot-reload
skaffold dev
```

**What this does:**
- ✅ Builds all 5 Docker images
- ✅ Deploys to Kubernetes
- ✅ Sets up port forwarding
- ✅ Enables hot-reload (auto-deploy on file changes)

**Access URLs:**
```
Landing Page:    http://localhost:8080
Agent Town:      http://localhost:3000
Dashboard:       http://localhost:5180
AI Town:         http://localhost:5173
Star Office:     http://localhost:19000
```

---

### **Option 2: Deploy Specific Service**

```bash
# Landing Page only
skaffold dev -p landing-only

# Dashboard only
skaffold dev -p dashboard-only

# Production (selected services)
skaffold dev -p prod
```

---

### **Option 3: Manual Deploy (No Skaffold)**

```bash
cd G:\PROJECT-4\GANGCLAWCITY

# Create namespace
kubectl apply -f k8s/platform.yaml

# Deploy all services
kubectl apply -f k8s/

# Check status
kubectl get pods -n gangclawcity
kubectl get services -n gangclawcity

# Port forward manually
kubectl port-forward svc/landing-page -n gangclawcity 8080:80 &
kubectl port-forward svc/agent-town -n gangclawcity 3000:3000 &
kubectl port-forward svc/openclaw-office -n gangclawcity 5180:80 &
kubectl port-forward svc/ai-town -n gangclawcity 5173:80 &
kubectl port-forward svc/star-office-ui -n gangclawcity 19000:80 &
```

---

## 🧪 Test Deployment

### **Check All Pods**

```bash
kubectl get pods -n gangclawcity
```

**Expected output:**
```
NAME                              READY   STATUS    RESTARTS   AGE
landing-page-xxxxxxxxxx-xxxxx     1/1     Running   0          2m
agent-town-xxxxxxxxxx-xxxxx       1/1     Running   0          2m
openclaw-office-xxxxxxxxxx-xxxxx  1/1     Running   0          2m
ai-town-xxxxxxxxxx-xxxxx          1/1     Running   0          2m
star-office-ui-xxxxxxxxxx-xxxxx   1/1     Running   0          2m
```

---

### **Check All Services**

```bash
kubectl get services -n gangclawcity
```

**Expected output:**
```
NAME              TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
landing-page      ClusterIP   10.96.xxx.xxx   <none>        80/TCP     2m
agent-town        ClusterIP   10.96.xxx.xxx   <none>        3000/TCP   2m
openclaw-office   ClusterIP   10.96.xxx.xxx   <none>        80/TCP     2m
ai-town           ClusterIP   10.96.xxx.xxx   <none>        80/TCP     2m
star-office-ui    ClusterIP   10.96.xxx.xxx   <none>        80/TCP     2m
```

---

### **View Logs**

```bash
# All logs
kubectl logs -n gangclawcity -l app=landing-page
kubectl logs -n gangclawcity -l app=agent-town
kubectl logs -n gangclawcity -l app=openclaw-office

# Follow logs (real-time)
kubectl logs -n gangclawcity -l app=landing-page -f
```

---

## 🔧 Troubleshooting

### **Issue: Pods not starting**

```bash
# Check pod status
kubectl describe pod -n gangclawcity <pod-name>

# Check events
kubectl get events -n gangclawcity --sort-by='.lastTimestamp'
```

---

### **Issue: Port already in use**

```bash
# Windows: Find and kill process
netstat -ano | findstr :8080
taskkill /F /PID <PID>

# macOS/Linux
lsof -ti:8080 | xargs kill -9
```

---

### **Issue: Skaffold build fails**

```bash
# Clean build cache
skaffold config cleanup

# Rebuild from scratch
skaffold build --cache-artifacts=false

# Check Docker
docker ps
docker images
```

---

### **Issue: Kubernetes not starting**

```bash
# Reset Kubernetes cluster (Docker Desktop)
# Settings → Kubernetes → Reset Kubernetes cluster

# Or delete and recreate
kubectl delete namespace gangclawcity
kubectl create namespace gangclawcity
```

---

## 🛑 Stop Deployment

### **Stop Skaffold**
```bash
# Press Ctrl+C in terminal
```

### **Clean Up**
```bash
# Delete all resources
skaffold delete

# Or manually
kubectl delete namespace gangclawcity
```

---

## 📊 Monitor Deployment

### **Kubernetes Dashboard**

```bash
# Enable dashboard (Docker Desktop)
# Already enabled by default

# Access: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```

---

### **Resource Usage**

```bash
# CPU and Memory usage
kubectl top pods -n gangclawcity
kubectl top nodes

# Install metrics-server if not available
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

---

### **Logs (Real-time)**

```bash
# All services
kubectl logs -n gangclawcity -l app=landing-page -f &
kubectl logs -n gangclawcity -l app=agent-town -f &
kubectl logs -n gangclawcity -l app=openclaw-office -f &

# Or use stern for better log viewing
brew install stern
stern -n gangclawcity --all-namespaces .
```

---

## 🎯 Next Steps

### **After Successful Deploy:**

1. ✅ Test all 5 services
2. ✅ Verify cross-navigation works
3. ✅ Check hot-reload (edit a file, see auto-update)
4. ✅ Apply brand kit to all services
5. ✅ Add email capture to landing page
6. ✅ Connect OpenClaw gateway

---

### **Production Deployment:**

```bash
# Build for production
skaffold build -p prod

# Deploy to production cluster
skaffold run -p prod

# Or with Google Cloud Build
skaffold run -p prod --default-repo gcr.io/your-project
```

---

## 📖 Additional Resources

### **Documentation:**
- [Skaffold Docs](https://skaffold.dev/docs/)
- [Kubernetes Docs](https://kubernetes.io/docs/)
- [Docker Desktop](https://docs.docker.com/desktop/)

### **GANGCLAWCITY Docs:**
- `INTEGRATION_PLAN.md` - Full integration guide
- `BRANDKIT.md` - Brand identity system
- `ROADMAP.md` - Development timeline

---

## 🎉 Success Criteria

You'll know it's working when:

✅ All 5 pods show `Running` status  
✅ All 5 services accessible via localhost ports  
✅ Hot-reload works (edit file → auto-deploy)  
✅ Cross-navigation between services works  
✅ No errors in logs  

---

## 💡 Pro Tips

### **Faster Iteration:**

```bash
# Run in background
skaffold dev > skaffold.log 2>&1 &

# Watch specific service
kubectl get pods -n gangclawcity -w -l app=landing-page

# Quick restart
kubectl rollout restart deployment/landing-page -n gangclawcity
```

### **Debug Mode:**

```bash
# Exec into container
kubectl exec -it -n gangclawcity <pod-name> -- /bin/sh

# Copy files from container
kubectl cp -n gangclawcity <pod-name>:/app/logs ./logs
```

### **Performance:**

```bash
# Increase resource limits
kubectl edit deployment/landing-page -n gangclawcity

# Scale replicas
kubectl scale deployment/landing-page -n gangclawcity --replicas=3
```

---

**Status:** ✅ Ready to Deploy  
**Difficulty:** ⭐⭐⭐ (Intermediate)  
**Time:** 5-10 minutes

---

**🏙️ GANGCLAWCITY** — A living operating system for digital labor.  
**Built with ❤️ in Malaysia** 🇲🇾
