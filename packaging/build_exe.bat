@echo off
echo Building Metopi Windows package...

REM Set paths
set "SCRIPT_DIR=%~dp0"
cd %SCRIPT_DIR%\..

REM Create build directories
if not exist "dist" mkdir dist
if not exist "build" mkdir build

REM Install required tools
pip install pyinstaller
pip install pillow

REM Generate icon if not exists
if not exist "packaging\windows\metopi.ico" (
    python -c "from PIL import Image; img = Image.new('RGB', (256,256), (0,0,0)); img.save('packaging/windows/metopi.ico')"
)

REM Clean previous builds
rmdir /s /q "build" 2>nul
del /q "dist\metopi.exe" 2>nul
del /q "dist\MetopiSetup.exe" 2>nul

echo Building executable...
pyinstaller packaging/windows/metopi.spec

if not exist "dist\metopi.exe" (
    echo Error: Failed to create executable
    exit /b 1
)

echo Building installer...
if exist "%PROGRAMFILES(X86)%\NSIS\makensis.exe" (
    "%PROGRAMFILES(X86)%\NSIS\makensis.exe" packaging\windows\installer.nsi
) else if exist "%PROGRAMFILES%\NSIS\makensis.exe" (
    "%PROGRAMFILES%\NSIS\makensis.exe" packaging\windows\installer.nsi
) else (
    echo Warning: NSIS not found. Installer creation skipped.
    echo Please install NSIS from https://nsis.sourceforge.io/
    exit /b 0
)

echo.
echo Build completed successfully!
echo Executable: dist\metopi.exe
echo Installer: dist\MetopiSetup.exe
