@echo off
REM GANGCLAWCITY - Master Agent Control
REM Usage: gangclaw-agent [agent-name] [command]
REM Created: March 14, 2026

echo ===============================================
echo GANGCLAWCITY Agent Network
echo ===============================================
echo.

cd /d %~dp0

if "%1"=="" goto show_help
if "%2"=="" goto show_help

set AGENT=%1
set COMMAND=%2

echo [AGENT] %AGENT%
echo [COMMAND] %COMMAND%
echo ===============================================
echo.

if "%AGENT%"=="doc" (
    if "%COMMAND%"=="update" (
        echo Updating documentation...
        node agents\documentation\index.js
        goto end
    )
    if "%COMMAND%"=="sanitize" (
        echo Sanitizing tokens...
        call security-scan.bat
        goto end
    )
)

if "%AGENT%"=="security" (
    if "%COMMAND%"=="scan" (
        echo Running security scan...
        call security-scan.bat
        goto end
    )
    if "%COMMAND%"=="audit" (
        echo Running full audit...
        call security-scan.bat
        goto end
    )
)

if "%AGENT%"=="deploy" (
    if "%COMMAND%"=="vercel" (
        echo Deploying to Vercel...
        call vercel-deploy-all.bat
        goto end
    )
    if "%COMMAND%"=="git" (
        echo Pushing to GitHub...
        call git-push-automated.bat
        goto end
    )
)

if "%AGENT%"=="reorganize" (
    echo Reorganizing project...
    call REORGANIZE-AUTO.bat
    goto end
)

goto show_help

:show_help
echo Available Agents:
echo   doc          - Documentation management
echo   security     - Security scanning &amp; audits
echo   deploy       - Deployment (Vercel, Git)
echo   reorganize   - Project reorganization
echo   design       - Design &amp; branding (coming soon)
echo   test         - Testing &amp; QA (coming soon)
echo   analytics    - Analytics &amp; monitoring (coming soon)
echo.
echo Commands:
echo   gangclaw-agent doc update      - Update documentation
echo   gangclaw-agent doc sanitize    - Remove exposed tokens
echo   gangclaw-agent security scan   - Security scan
echo   gangclaw-agent security audit  - Full security audit
echo   gangclaw-agent deploy vercel   - Deploy to Vercel
echo   gangclaw-agent deploy git      - Push to GitHub
echo   gangclaw-agent reorganize      - Reorganize project
echo.
echo Examples:
echo   gangclaw-agent security scan
echo   gangclaw-agent deploy vercel
echo   gangclaw-agent reorganize
echo.

:end
pause
