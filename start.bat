@echo off
chcp 65001 >nul
title SudoCG Community Server

:menu
cls
echo ========================================
echo    SudoCG Community - Control Panel
echo ========================================
echo.
echo 1. Start Server (Port 3001)
echo 2. Build Frontend
echo 3. Stop Server (Press Ctrl+C in server window)
echo 4. Exit
echo.
set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" goto start_server
if "%choice%"=="2" goto build_frontend
if "%choice%"=="3" goto stop_info
if "%choice%"=="4" goto exit_script
echo Invalid choice! Please try again.
timeout /t 2 >nul
goto menu

:start_server
cls
echo ========================================
echo Starting SudoCG Community Server...
echo ========================================
echo.
echo Server will start on: http://localhost:3001
echo Press Ctrl+C to stop the server
echo.
cd server
npm start
cd ..
pause
goto menu

:build_frontend
cls
echo ========================================
echo Building Frontend...
echo ========================================
echo.
call npm run build
if %errorlevel% neq 0 (
    echo Error: Build failed!
) else (
    echo Build completed successfully!
)
echo.
pause
goto menu

:stop_info
cls
echo ========================================
echo How to Stop the Server
echo ========================================
echo.
echo To stop the server, go to the server window
echo and press Ctrl+C, then confirm with 'Y'
echo.
pause
goto menu

:exit_script
echo.
echo Goodbye!
timeout /t 1 >nul
exit
