@echo off
echo Installing Metopi...

REM Check if Python is installed
python --version > nul 2>&1
if errorlevel 1 (
    echo Python is not installed! Please install Python 3.6 or later.
    echo Visit: https://www.python.org/downloads/
    pause
    exit /b 1
)

REM Install the package
python -m pip install .

echo.
echo Installation complete! Run 'metopi' to start the timer.
echo.

pause
