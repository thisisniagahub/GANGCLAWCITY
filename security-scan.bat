@echo off
REM GANGCLAWCITY Security Scanner
REM Scans for exposed tokens and sensitive data
REM Created: March 14, 2026

echo ===============================================
echo GANGCLAWCITY Security Scanner
REM ===============================================
echo.

cd /d %~dp0

setlocal enabledelayedexpansion

REM Known token to search for
set "TOKEN=053adc82f8d2600b32c397c12f3517745b76a4deabf926b9"

echo [1/3] Scanning for exposed gateway token...
echo.

set "FOUND=0"

REM Search in .md files
for %%f in (*.md docs\*.md docs\*\*.md) do (
    findstr /C:"%TOKEN%" "%%f" >nul 2>&1
    if not errorlevel 1 (
        echo   ⚠ FOUND in: %%f
        set /a FOUND+=1
    )
)

echo.
echo [2/3] Scanning for environment variables...
echo.

REM Check for .env files that shouldn't be committed
if exist ".env" (
    echo   ⚠ WARNING: .env file found (should be in .gitignore)
    set /a FOUND+=1
)

if exist ".env.local" (
    echo   ⚠ WARNING: .env.local file found
    set /a FOUND+=1
)

echo.
echo [3/3] Checking .gitignore...
echo.

REM Check if .gitignore exists
if exist ".gitignore" (
    echo   ✓ .gitignore found
    findstr /C:".env" ".gitignore" >nul 2>&1
    if not errorlevel 1 (
        echo   ✓ .env is ignored
    ) else (
        echo   ⚠ WARNING: .env not in .gitignore
        set /a FOUND+=1
    )
) else (
    echo   ⚠ WARNING: No .gitignore found
    set /a FOUND+=1
)

echo.
echo ===============================================

if %FOUND% EQU 0 (
    echo ✓ NO SECURITY ISSUES FOUND
    echo ===============================================
    echo.
    echo Your project is secure!
) else (
    echo ⚠ FOUND %FOUND% SECURITY ISSUE(S)
    echo ===============================================
    echo.
    echo CRITICAL ACTION REQUIRED:
    echo.
    echo 1. Rotate gateway token on VPS:
    echo    ssh root@76.13.176.142
    echo    openssl rand -hex 32
    echo    nano /root/.openclaw/openclaw.json
    echo.
    echo 2. Replace token in all files with:
    echo    ^<GATEWAY_TOKEN^>
    echo.
    echo 3. Run this scanner again to verify
    echo.
)

echo.
pause
