@echo off
REM GANGCLAWCITY - Automated Vercel Deployment
REM Deploys all 3 apps to Vercel
REM Created: March 14, 2026

echo ===============================================
echo GANGCLAWCITY - Vercel Deployment
echo ===============================================
echo.

cd /d %~dp0

echo [PRE-CHECK] Verifying Vercel CLI...
echo.

vercel --version >nul 2>&1
if errorlevel 1 (
    echo ⚠ Vercel CLI not found!
    echo.
    echo Install with: npm install -g vercel
    echo.
    pause
    exit /b 1
)

echo ✓ Vercel CLI found
echo.

echo [1/4] Deploying Landing Page...
echo.

cd landing-page
call vercel --prod
if errorlevel 1 (
    echo ⚠ Landing Page deployment failed!
    echo.
    pause
    exit /b 1
)
cd ..

echo.
echo ✓ Landing Page deployed
echo.

echo [2/4] Deploying Dashboard...
echo.

cd openclaw-office
call vercel --prod
if errorlevel 1 (
    echo ⚠ Dashboard deployment failed!
    echo.
    pause
    exit /b 1
)
cd ..

echo.
echo ✓ Dashboard deployed
echo.

echo [3/4] Deploying Agent Town...
echo.

cd agent-town
call vercel --prod
if errorlevel 1 (
    echo ⚠ Agent Town deployment failed!
    echo.
    pause
    exit /b 1
)
cd ..

echo.
echo ✓ Agent Town deployed
echo.

echo [4/4] Setting environment variables reminder...
echo.

echo ===============================================
echo ⚠ IMPORTANT: Set Environment Variables
echo ===============================================
echo.
echo On Vercel Dashboard, set for EACH app:
echo.
echo   VITE_GATEWAY_URL=wss://operator.gangniaga.my
echo   VITE_GATEWAY_TOKEN=^<YOUR_ROTATED_TOKEN^>
echo   VITE_SESSION_KEY=agent:main:main
echo   VITE_MOCK=false
echo.
echo Dashboard: https://vercel.com/dashboard
echo.
echo ===============================================
echo.
echo ✓ All apps deployed successfully!
echo.
echo Production URLs:
echo   - Landing: https://gangclawcity-landing.vercel.app
echo   - Dashboard: https://gangclawcity-dashboard.vercel.app
echo   - Demo: https://gangclawcity-demo.vercel.app
echo.
pause
