@echo off
REM ========================================
REM GANGCLAWCITY - COMPLETE SETUP & DEPLOY
REM ========================================
REM This script will:
REM 1. Check prerequisites
REM 2. Deploy all services
REM 3. Open all services in browser
REM ========================================

echo.
echo ========================================
echo GANGCLAWCITY - Complete Setup
echo ========================================
echo.

REM Step 1: Check if Docker is running
echo [1/6] Checking Docker...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Docker is not running!
    echo.
    echo Please:
    echo 1. Open Docker Desktop
    echo 2. Wait until it shows "running"
    echo 3. Run this script again
    echo.
    pause
    exit /b 1
)
echo Docker is running! OK
echo.

REM Step 2: Check if services are already running
echo [2/6] Checking existing services...
docker-compose ps | findstr "Up" >nul 2>&1
if %errorlevel% equ 0 (
    echo Services already running!
    echo Stopping existing services...
    docker-compose down
) else (
    echo No existing services found. Continuing...
)
echo.

REM Step 3: Build and deploy all services
echo [3/6] Building and deploying all services...
echo This will take 3-5 minutes for first build...
echo.
docker-compose up --build -d

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Deployment failed!
    echo Check Docker Desktop for details.
    pause
    exit /b 1
)
echo.

REM Step 4: Wait for services to start
echo [4/6] Waiting for services to start...
timeout /t 15 /nobreak >nul
echo.

REM Step 5: Check status
echo [5/6] Checking service status...
echo.
docker-compose ps
echo.

REM Step 6: Open services in browser
echo [6/6] Opening services in browser...
echo.
echo ========================================
echo GANGCLAWCITY is now running!
echo ========================================
echo.
echo Services available at:
echo.
echo Landing Page:     http://localhost:8080
echo Agent Town:       http://localhost:3000
echo Dashboard:        http://localhost:5180
echo AI Town:          http://localhost:5173
echo Star Office:      http://localhost:19000
echo.
echo ========================================
echo.

REM Open landing page automatically
echo Opening landing page...
timeout /t 3 /nobreak >nul
start http://localhost:8080

echo.
echo ========================================
echo IMPORTANT:
echo ========================================
echo.
echo Keep this window OPEN to maintain services.
echo.
echo To stop all services:
echo   docker-compose down
echo.
echo To view logs:
echo   docker-compose logs -f
echo.
echo To restart:
echo   docker-compose restart
echo.
echo ========================================
echo.
echo Deployment complete! Enjoy GANGCLAWCITY!
echo.
pause
