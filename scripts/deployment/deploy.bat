@echo off
REM GANGCLAWCITY - Quick Deploy Script (No Skaffold)
REM Requires: Docker Desktop with Kubernetes enabled

echo ========================================
echo GANGCLAWCITY Platform Deployment
echo ========================================
echo.

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not running!
    echo Please start Docker Desktop first.
    exit /b 1
)

echo [1/5] Creating Kubernetes namespace...
kubectl create namespace gangclawcity --dry-run=client -o yaml | kubectl apply -f -

echo [2/5] Applying Kubernetes manifests...
kubectl apply -f k8s/platform.yaml

echo [3/5] Waiting for pods to be ready...
timeout /t 10 /nobreak >nul

echo [4/5] Checking pod status...
kubectl get pods -n gangclawcity

echo [5/5] Starting port forwarding...
echo.
echo ========================================
echo Services will be available at:
echo ========================================
echo Landing Page:  http://localhost:8080
echo Agent Town:    http://localhost:3000
echo Dashboard:     http://localhost:5180
echo AI Town:       http://localhost:5173
echo Star Office:   http://localhost:19000
echo ========================================
echo.
echo Press Ctrl+C to stop all services
echo.

REM Start port forwarding for all services
start "Landing Page" kubectl port-forward svc/landing-page -n gangclawcity 8080:80
timeout /t 2 /nobreak >nul

start "Agent Town" kubectl port-forward svc/agent-town -n gangclawcity 3000:3000
timeout /t 2 /nobreak >nul

start "Dashboard" kubectl port-forward svc/openclaw-office -n gangclawcity 5180:80
timeout /t 2 /nobreak >nul

start "AI Town" kubectl port-forward svc/ai-town -n gangclawcity 5173:80
timeout /t 2 /nobreak >nul

start "Star Office" kubectl port-forward svc/star-office-ui -n gangclawcity 19000:80
timeout /t 2 /nobreak >nul

echo All services started!
echo Opening landing page in browser...
timeout /t 3 /nobreak >nul
start http://localhost:8080

echo.
echo Deployment complete!
echo Keep this window open to maintain port forwarding.
pause
