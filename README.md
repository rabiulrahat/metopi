# Metopi

A modern, cross-platform countdown timer with a sleek interface and useful features.

## Features

- Clean, modern interface
- Multiple color themes
- Fullscreen mode
- Sound notifications
- Keyboard shortcuts
- Cross-platform support

## Installation

### Linux (Debian/Ubuntu)

You can install Metopi using the provided .deb package:

```bash
# Build the package
./packaging/build_deb.sh

# Install the package
sudo dpkg -i dist/metopi.deb
sudo apt-get install -f  # Install dependencies if needed
```

After installation, you can:
- Run `metopi` from terminal
- Find Metopi in your applications menu

### Windows

You have two options for Windows installation:

1. Using the installer:
   - Run the packaging/build_exe.bat script
   - Run the generated dist/MetopiSetup.exe
   - Launch Metopi from the Start Menu

2. Portable version:
   - Run the packaging/build_exe.bat script
   - Use the generated dist/metopi.exe directly

## Development

### Requirements

- Python 3.6 or higher
- Tkinter (usually comes with Python)
- pip (Python package manager)

### Setup Development Environment

```bash
# Clone the repository
https://github.com/rabiulrahat/metopi.git
cd metopi

# Install in development mode
pip install -e .
```

### Building Packages

For detailed packaging instructions, see [packaging/README.md](packaging/README.md)

## Usage

- Set minutes and seconds using the input fields
- Start/Pause: Space bar or ▶ button
- Reset: R key or ↺ button
- Change color: C key or 🎨 button
- Toggle fullscreen: F11 or ⛶ button
- Exit fullscreen: Escape key

## License

MIT License - see LICENSE file for details
