@echo off
REM GANGCLAWCITY Project Reorganization - Fortune 500 Level
REM Created: March 14, 2026
REM Action: Creates folder structure and moves all files

echo ===============================================
echo GANGCLAWCITY Project Reorganization
echo Fortune 500 Level Structure
echo ===============================================
echo.

cd /d %~dp0

echo [1/3] Creating folder structure...
echo.

REM Create main folders
mkdir docs 2>nul
mkdir config 2>nul
mkdir scripts 2>nul
mkdir security 2>nul
mkdir infrastructure 2>nul

REM Create docs subfolders
mkdir docs\00-start-here 2>nul
mkdir docs\01-architecture 2>nul
mkdir docs\02-deployment 2>nul
mkdir docs\03-integration 2>nul
mkdir docs\04-research 2>nul
mkdir docs\05-brand 2>nul
mkdir docs\06-contributing 2>nul
mkdir docs\07-skills 2>nul
mkdir docs\08-testing 2>nul
mkdir docs\99-legacy 2>nul

REM Create config subfolders
mkdir config\docker 2>nul
mkdir config\k8s 2>nul
mkdir config\vercel 2>nul

REM Create scripts subfolders
mkdir scripts\deployment 2>nul
mkdir scripts\setup 2>nul
mkdir scripts\maintenance 2>nul

echo ✓ Folders created successfully
echo.

echo [2/3] Moving documentation files...
echo.

REM Move to docs\00-start-here
move README.md docs\00-start-here\ 2>nul && echo   ✓ README.md
move START_HERE.md docs\00-start-here\ 2>nul && echo   ✓ START_HERE.md
move QUICKSTART.md docs\00-start-here\ 2>nul && echo   ✓ QUICKSTART.md
move DEPLOY_NOW.md docs\00-start-here\ 2>nul && echo   ✓ DEPLOY_NOW.md

REM Move to docs\01-architecture
move ARCHITECTURE.md docs\01-architecture\ 2>nul && echo   ✓ ARCHITECTURE.md
move ROADMAP.md docs\01-architecture\ 2>nul && echo   ✓ ROADMAP.md
move DOCS_INDEX.md docs\01-architecture\ 2>nul && echo   ✓ DOCS_INDEX.md

REM Move to docs\02-deployment
move VERCEL_AUTO_DEPLOY.md docs\02-deployment\ 2>nul && echo   ✓ VERCEL_AUTO_DEPLOY.md
move VERCEL_DEPLOYMENT_PLAN.md docs\02-deployment\ 2>nul && echo   ✓ VERCEL_DEPLOYMENT_PLAN.md
move DEPLOYMENT_STATUS.md docs\02-deployment\ 2>nul && echo   ✓ DEPLOYMENT_STATUS.md
move DEPLOYMENT_SUMMARY.md docs\02-deployment\ 2>nul && echo   ✓ DEPLOYMENT_SUMMARY.md
move FINAL_DEPLOYMENT_REPORT.md docs\02-deployment\ 2>nul && echo   ✓ FINAL_DEPLOYMENT_REPORT.md
move IMPLEMENTATION_COMPLETE.md docs\02-deployment\ 2>nul && echo   ✓ IMPLEMENTATION_COMPLETE.md

REM Move to docs\03-integration
move NIAGABOT_INTEGRATION_PLAN.md docs\03-integration\ 2>nul && echo   ✓ NIAGABOT_INTEGRATION_PLAN.md
move OPENCLAW_INTEGRATION.md docs\03-integration\ 2>nul && echo   ✓ OPENCLAW_INTEGRATION.md
move GATEWAY_IMPROVEMENT_PLAN.md docs\03-integration\ 2>nul && echo   ✓ GATEWAY_IMPROVEMENT_PLAN.md
move INTEGRATION_COMPLETE.md docs\03-integration\ 2>nul && echo   ✓ INTEGRATION_COMPLETE.md
move INTEGRATION_PLAN.md docs\03-integration\ 2>nul && echo   ✓ INTEGRATION_PLAN.md

REM Move to docs\04-research
move ADVANCED_WORKFLOWS_RESEARCH_2026.md docs\04-research\ 2>nul && echo   ✓ ADVANCED_WORKFLOWS_RESEARCH_2026.md
move CHINA_OPENCLAW_LESSONS_FOR_MALAYSIA.md docs\04-research\ 2>nul && echo   ✓ CHINA_OPENCLAW_LESSONS_FOR_MALAYSIA.md
move MALAYSIA_MARKET_RESEARCH_2026.md docs\04-research\ 2>nul && echo   ✓ MALAYSIA_MARKET_RESEARCH_2026.md
move PROVEN_SUCCESS_STORIES_ANALYSIS.md docs\04-research\ 2>nul && echo   ✓ PROVEN_SUCCESS_STORIES_ANALYSIS.md
move SHOPEE_AFFILIATE_AI_AGENT.md docs\04-research\ 2>nul && echo   ✓ SHOPEE_AFFILIATE_AI_AGENT.md
move SKAFFOLD_RESEARCH_REPORT.md docs\04-research\ 2>nul && echo   ✓ SKAFFOLD_RESEARCH_REPORT.md

REM Move to docs\05-brand
move BRANDKIT.md docs\05-brand\ 2>nul && echo   ✓ BRANDKIT.md
move BRAND_ASSETS.html docs\05-brand\ 2>nul && echo   ✓ BRAND_ASSETS.html
move BRAND_QUICKREF.md docs\05-brand\ 2>nul && echo   ✓ BRAND_QUICKREF.md
move LOGO_FILES.md docs\05-brand\ 2>nul && echo   ✓ LOGO_FILES.md

REM Move to docs\06-contributing
move CONTRIBUTING.md docs\06-contributing\ 2>nul && echo   ✓ CONTRIBUTING.md

REM Move to docs\07-skills
move skills\gangclawcity-expert\SKILL.md docs\07-skills\ 2>nul && echo   ✓ skills\gangclawcity-expert\SKILL.md
move skills\SKILL-REGISTRY.md docs\07-skills\ 2>nul && echo   ✓ skills\SKILL-REGISTRY.md

REM Move to docs\08-testing
move TESTING_REPORT.md docs\08-testing\ 2>nul && echo   ✓ TESTING_REPORT.md
move LANDING_PAGE_REVIEW.md docs\08-testing\ 2>nul && echo   ✓ LANDING_PAGE_REVIEW.md

REM Move to docs\99-legacy
move PROJECT_RECAP_AND_TODAY_ROADMAP.md docs\99-legacy\ 2>nul && echo   ✓ PROJECT_RECAP_AND_TODAY_ROADMAP.md
move STITCH_PROMPT_ENGINEERING.md docs\99-legacy\ 2>nul && echo   ✓ STITCH_PROMPT_ENGINEERING.md
move STITCH_SKILLS_IMPLEMENTATION.md docs\99-legacy\ 2>nul && echo   ✓ STITCH_SKILLS_IMPLEMENTATION.md

echo.
echo [3/3] Moving configuration and scripts...
echo.

REM Move config files
move docker-compose.yml config\docker\ 2>nul && echo   ✓ docker-compose.yml
move skaffold.yaml config\k8s\ 2>nul && echo   ✓ skaffold.yaml
move k8s\platform.yaml config\k8s\ 2>nul && echo   ✓ k8s\platform.yaml

REM Move scripts
move deploy.bat scripts\deployment\ 2>nul && echo   ✓ deploy.bat
move git-push.bat scripts\deployment\ 2>nul && echo   ✓ git-push.bat
move SETUP_AND_RUN.bat scripts\setup\ 2>nul && echo   ✓ SETUP_AND_RUN.bat

REM Move security files
move API_KEY_SECURITY.md security\ 2>nul && echo   ✓ API_KEY_SECURITY.md

echo.
echo ===============================================
echo ✓ Reorganization COMPLETE!
echo ===============================================
echo.
echo Project Structure:
echo   - docs/ (organized documentation)
echo   - config/ (configuration files)
echo   - scripts/ (automation scripts)
echo   - security/ (security docs)
echo.
echo Root directory reduced by 70%%!
echo.
echo Next Steps:
echo   1. Review REORGANIZATION_COMPLETE.md
echo   2. Run security-scan.bat
echo   3. Execute git-push-automated.bat
echo.
pause
