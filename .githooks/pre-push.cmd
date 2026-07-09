@echo off
setlocal
set SCRIPT_PATH=%~dp0..
PowerShell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_PATH%scripts\simular-push.ps1"
exit /b %ERRORLEVEL%
