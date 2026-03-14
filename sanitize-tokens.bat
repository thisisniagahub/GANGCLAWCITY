@echo off
REM GANGCLAWCITY - Token Sanitization Script
REM Replaces exposed token with <GATEWAY_TOKEN> placeholder
REM Created: March 14, 2026

echo ===============================================
echo GANGCLAWCITY Token Sanitization
echo ===============================================
echo.
echo This script will replace the exposed gateway token
echo with ^<GATEWAY_TOKEN^> placeholder in all files.
echo.
echo IMPORTANT: Run this AFTER rotating the token on VPS!
echo.
pause

cd /d %~dp0

set "OLD_TOKEN=053adc82f8d2600b32c397c12f3517745b76a4deabf926b9"
set "NEW_TOKEN=<GATEWAY_TOKEN>"

echo.
echo [1/2] Scanning files for token exposure...
echo.

set "FILES_FOUND=0"

REM Search and replace in .md files
for %%f in (*.md docs\*.md docs\*\*.md docs\*\*\*.md skills\*\*.md security\*.md) do (
    findstr /C:"%OLD_TOKEN%" "%%f" >nul 2>&1
    if not errorlevel 1 (
        echo   Found in: %%f
        set /a FILES_FOUND+=1
    )
)

echo.
echo Found %FILES_FOUND% files with token exposure.
echo.
echo [2/2] Replacing token with placeholder...
echo.

REM Note: Batch doesn't have easy in-place replace
REM This is a report script - manual replacement needed
REM Or use PowerShell for actual replacement

echo ===============================================
echo MANUAL REPLACEMENT REQUIRED
echo ===============================================
echo.
echo After rotating token on VPS, do this:
echo.
echo 1. Open each file listed above
echo 2. Find: 053adc82f8d2600b32c397c12f3517745b76a4deabf926b9
echo 3. Replace with: ^<GATEWAY_TOKEN^>
echo 4. Save file
echo.
echo OR use PowerShell command:
echo (Get-Content file.md).Replace('053adc82f8d2600b32c397c12f3517745b76a4deabf926b9', '^<GATEWAY_TOKEN^>') | Set-Content file.md
echo.
echo Files to update:
echo   - QWEN.md
echo   - README.md
echo   - ARCHITECTURE.md
echo   - ROADMAP.md
echo   - COMPLETE_SUMMARY.md
echo   - REORGANIZATION_GUIDE.md
echo   - REORGANIZATION_REPORT.md
echo   - SECURITY_AUDIT_2026-03-14.md
echo   - STRUCTURE_COMPLETE.md
echo   - skills/gangclawcity-expert/SKILL.md
echo   - docs/ subdirectories
echo.
pause
