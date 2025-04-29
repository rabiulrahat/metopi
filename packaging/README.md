# Metopi Packaging

This directory contains scripts and configuration files for building installable packages for different platforms.

## Building for Linux (.deb package)

Requirements:
- dpkg (for building Debian package)
- Python 3.6 or higher
- pip

To build the .deb package:
```bash
./packaging/build_deb.sh
```
The package will be created at `dist/metopi.deb`

To install:
```bash
sudo dpkg -i dist/metopi.deb
sudo apt-get install -f  # Install any missing dependencies
```

## Building for Windows (.exe)

Requirements:
- Windows OS
- Python 3.6 or higher
- pip

To build the executable:
```batch
packaging\build_exe.bat
```
The executable will be created at `dist/metopi.exe`

## Package Contents

### Debian Package
- Application installed to `/usr/share/metopi/`
- Desktop entry for application menu
- Icon in appropriate hicolor directory

### Windows Package
- Standalone executable with all dependencies bundled
- No installation required - just run the exe
