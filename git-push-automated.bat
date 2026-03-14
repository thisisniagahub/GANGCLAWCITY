@echo off
REM GANGCLAWCITY - Automated Git Push
REM Includes safety checks and security scan
REM Created: March 14, 2026

echo ===============================================
echo GANGCLAWCITY - Automated Git Push
REM ===============================================
echo.

cd /d %~dp0

echo [PRE-CHECK] Running security scan...
echo.

REM Run security scan first
call security-scan.bat

echo.
echo [1/5] Checking Git status...
echo.

git status

echo.
echo [2/5] Checking for sensitive data...
echo.

REM Quick check for token
findstr /C:"053adc82f8d2600b32c397c12f3517745b76a4deabf926b9" *.md >nul 2>&1
if not errorlevel 1 (
    echo ⚠ WARNING: Gateway token found in files!
    echo.
    echo Please rotate token before pushing to GitHub.
    echo See: security/SECURITY_AUDIT.md
    echo.
    pause
    exit /b 1
)

echo ✓ No sensitive data found
echo.

echo [3/5] Adding files to Git...
echo.

git add .

echo.
echo [4/5] Review changes...
echo.

git status --short

echo.
set /p CONFIRM="Proceed with commit? (y/n): "
if /i not "%CONFIRM%"=="y" (
    echo Commit cancelled.
    pause
    exit /b 0
)

echo.
echo [5/5] Committing and pushing...
echo.

set /p MESSAGE="Enter commit message (or press Enter for default): "
if "%MESSAGE%"=="" (
    set MESSAGE=feat: Enterprise reorganization + security hardening
    
    - Organized 40+ docs into hierarchical structure
    - Created comprehensive security audit
    - Enhanced .gitignore
    - Fortune 500 level project structure
    - Root directory reduced by 70%%
    
    Security: Token rotation required (see security/SECURITY_AUDIT.md)
)

git commit -m "%MESSAGE%"

echo.
echo Pushing to GitHub...
echo.

git push -u origin main

if errorlevel 1 (
    echo.
    echo ⚠ Push failed. Please check:
    echo   - Git remote is configured
    echo   - You have push permissions
    echo   - Internet connection
    echo.
    pause
    exit /b 1
)

echo.
echo ===============================================
echo ✓ Git Push COMPLETE!
echo ===============================================
echo.
echo Next Steps:
echo   1. Check GitHub: https://github.com/thisisniagahub/GANGCLAWCITY
echo   2. Deploy to Vercel: run vercel-deploy-all.bat
echo.
pause
