@echo off
REM Colors for output (Windows 10+ supports ANSI colors)
setlocal enabledelayedexpansion

echo.
echo =====================================
echo Hello World Azure - Setup Script
echo =====================================
echo.

REM Check Node.js installation
echo Checking Node.js installation...
node --version >nul 2>&1
if errorlevel 1 (
    echo Error: Node.js is not installed. Please install Node.js 18+
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
echo [OK] Node.js %NODE_VERSION% found
echo.

REM Check npm installation
echo Checking npm installation...
npm --version >nul 2>&1
if errorlevel 1 (
    echo Error: npm is not installed. Please install npm
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
echo [OK] npm %NPM_VERSION% found
echo.

REM Install dependencies
echo Installing dependencies...
call npm install
if errorlevel 1 (
    echo Error: Failed to install dependencies
    pause
    exit /b 1
)
echo [OK] Dependencies installed successfully
echo.

REM Copy environment file
if not exist .env (
    echo Creating .env file...
    copy .env.example .env >nul
    echo [OK] .env file created
    echo.
)

REM Run tests
echo Running tests...
call npm test
if errorlevel 1 (
    echo Warning: Some tests failed. Check logs above.
    echo.
) else (
    echo [OK] All tests passed
    echo.
)

REM Summary
echo =====================================
echo Setup Complete!
echo =====================================
echo.

echo Next steps:
echo 1. Start the app:        npm start
echo 2. Run in dev mode:      npm run dev
echo 3. Run tests:            npm test
echo 4. Build Docker image:   docker build -t hello-world-azure .
echo 5. Deploy:               Push to GitHub and let Azure DevOps handle it!
echo.

echo Access points:
echo - Main endpoint:  http://localhost:3000/
echo - API endpoint:   http://localhost:3000/api/hello?name=YourName
echo - Health check:   http://localhost:3000/health
echo.

pause
