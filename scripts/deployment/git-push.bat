@echo off
REM GANGCLAWCITY - Git Push Script

echo ========================================
echo GANGCLAWCITY - Git Push to GitHub
echo ========================================
echo.

cd /d %~dp0

echo Adding files to git...
git add .

echo.
echo Creating commit...
git commit -m "Initial commit: GANGCLAWCITY platform ready for Vercel"

echo.
echo Setting main branch...
git branch -M main

echo.
echo Connecting to GitHub repo...
git remote add origin https://github.com/thisisniagahub/GANGCLAWCITY.git 2>nul
if %errorlevel% == 0 (
    echo Repository connected!
) else (
    echo Repository already connected.
)

echo.
echo Pushing to GitHub...
git push -u origin main

echo.
echo ========================================
echo Done! Check: https://github.com/thisisniagahub/GANGCLAWCITY
echo ========================================
pause
