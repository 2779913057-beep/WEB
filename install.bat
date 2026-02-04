@echo off
chcp 65001 >nul
echo ========================================
echo SudoCG Community - Installation Script
echo ========================================
echo.

echo [1/4] Installing frontend dependencies...
call npm install
if %errorlevel% neq 0 (
    echo Error: Failed to install frontend dependencies
    pause
    exit /b 1
)

echo.
echo [2/4] Installing server dependencies...
cd server
call npm install
if %errorlevel% neq 0 (
    echo Error: Failed to install server dependencies
    cd ..
    pause
    exit /b 1
)
cd ..

echo.
echo [3/4] Building frontend...
call npm run build
if %errorlevel% neq 0 (
    echo Error: Failed to build frontend
    pause
    exit /b 1
)

echo.
echo [4/4] Installation completed!
echo.
echo ========================================
echo You can now run 'start.bat' to launch the server
echo ========================================
pause
