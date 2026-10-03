@echo off
rem Contenta Converter MCP launcher for the Claude Code plugin. Starts the app's own MCP server
rem ("contenta serve") and passes stdin/stdout straight through; nothing else runs, nothing is downloaded.
rem Lookup order: CONTENTASOFT_CC_EXE override, per-user install, PATH, Program Files.
rem If the app is not installed: node index.js (the full launcher) when Node.js exists, otherwise
rem stub.ps1 (Windows PowerShell, always present) serves one tool, get_started, with the download link.
setlocal
set "EXE="
if defined CONTENTASOFT_CC_EXE if exist "%CONTENTASOFT_CC_EXE%" set "EXE=%CONTENTASOFT_CC_EXE%"
if not defined EXE if exist "%LOCALAPPDATA%\Programs\ContentaConverter\contenta.exe" set "EXE=%LOCALAPPDATA%\Programs\ContentaConverter\contenta.exe"
if not defined EXE for /f "delims=" %%P in ('where contenta.exe 2^>nul') do if not defined EXE set "EXE=%%P"
if not defined EXE if exist "%ProgramFiles%\ContentaConverter\contenta.exe" set "EXE=%ProgramFiles%\ContentaConverter\contenta.exe"
if not defined EXE if exist "%ProgramFiles(x86)%\ContentaConverter\contenta.exe" set "EXE=%ProgramFiles(x86)%\ContentaConverter\contenta.exe"
if defined EXE goto run
where node >nul 2>nul
if not errorlevel 1 goto node
powershell -NoProfile -NonInteractive -ExecutionPolicy Bypass -File "%~dp0stub.ps1"
exit /b %errorlevel%
:node
node "%~dp0index.js"
exit /b %errorlevel%
:run
"%EXE%" serve
exit /b %errorlevel%
