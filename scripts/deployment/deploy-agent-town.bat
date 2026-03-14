@echo off
REM GANGCLAWCITY - Deploy Agent Town to Vercel
REM Using Vercel CLI

echo ================================================
echo Deploying Agent Town to Vercel
echo ================================================
echo.

cd /d %~dp0

echo [1/3] Installing Vercel CLI...
echo.
npm install -g vercel

echo.
echo [2/3] Logging in to Vercel...
echo.
vercel login

echo.
echo [3/3] Deploying to Production...
echo.
vercel --prod

echo.
echo ================================================
echo Agent Town Deployment Complete!
echo ================================================
echo.
echo All deployments complete!
echo.
pause
