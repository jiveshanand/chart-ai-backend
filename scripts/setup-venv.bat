@echo off
REM Script to set up the project using Python venv on Windows

echo Setting up Chart AI Backend with Python venv...
echo ================================================
echo.

REM Get the script directory and project root
set "SCRIPT_DIR=%~dp0"
set "PROJECT_ROOT=%SCRIPT_DIR%.."

cd /d "%PROJECT_ROOT%"

REM Check Python version
echo Checking Python version...
python --version
echo.

REM Create virtual environment
echo Creating virtual environment...
if exist "venv" (
    echo Virtual environment already exists. Skipping creation.
) else (
    python -m venv venv
    echo Virtual environment created successfully!
)
echo.

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate.bat

REM Upgrade pip
echo Upgrading pip...
python -m pip install --upgrade pip
echo.

REM Install dependencies
echo Installing dependencies...
echo This may take a few minutes...
echo.

REM Core dependencies
pip install fastapi uvicorn[standard] pydantic pydantic-settings python-dotenv httpx

REM Dev dependencies
pip install pytest pytest-asyncio black ruff

REM Create requirements.txt for reference
pip freeze > requirements.txt
echo Dependencies installed successfully!
echo.

REM Create .env files from examples
echo Setting up environment files...

if not exist "services\chart-service\.env" (
    copy "services\chart-service\.env.example" "services\chart-service\.env"
    echo Created services\chart-service\.env
) else (
    echo services\chart-service\.env already exists
)

if not exist "services\data-service\.env" (
    copy "services\data-service\.env.example" "services\data-service\.env"
    echo Created services\data-service\.env
) else (
    echo services\data-service\.env already exists
)

echo.
echo Setup complete!
echo ================================================
echo To activate the virtual environment:
echo   venv\Scripts\activate
echo.
echo To run the services:
echo.
echo Terminal 1 - Chart Service:
echo   cd services\chart-service
echo   python -m uvicorn app.main:app --reload --port 8001
echo.
echo Terminal 2 - Data Service:
echo   cd services\data-service
echo   python -m uvicorn app.main:app --reload --port 8002
echo.
echo API Documentation will be available at:
echo   Chart Service: http://localhost:8001/docs
echo   Data Service:  http://localhost:8002/docs
echo.
echo To deactivate the virtual environment:
echo   deactivate
echo ================================================
pause
