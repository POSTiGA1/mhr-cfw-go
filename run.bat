@echo off
setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%"

echo ========================================
echo  MHR-CFW Go
echo ========================================
echo.

if not exist "mhr-cfw-go.exe" (
    echo Error: mhr-cfw-go.exe not found.
    echo Run build.bat first to build the executable.
    pause
    exit /b 1
)

echo Starting proxy server...
echo.
echo Default: http://127.0.0.1:8080
echo.
echo Press Ctrl+C to stop.
echo ========================================
echo.

mhr-cfw-go.exe %*

pause