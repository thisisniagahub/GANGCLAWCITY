@echo off
REM GANGCLAWCITY - Deploy All to Vercel
REM Dashboard + Agent Town

echo ================================================
echo GANGCLAWCITY - Full Deployment
echo ================================================
echo.

cd /d %~dp0

echo [1/4] Deploying Landing Page (Already deployed)
echo   URL: https://gangclawcity.vercel.app/
echo   Status: LIVE
echo.

echo [2/4] Deploying Dashboard...
echo.
cd openclaw-office
call vercel --prod
cd ..

echo.
echo [3/4] Deploying Agent Town...
echo.
cd agent-town
call vercel --prod
cd ..

echo.
echo [4/4] Deployment Summary
echo ================================================
echo   Landing Page: https://gangclawcity.vercel.app/
echo   Dashboard: [URL from Vercel]
echo   Agent Town: [URL from Vercel]
echo ================================================
echo.

pause
