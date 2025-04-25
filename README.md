# Metopi

A modern, cross-platform countdown timer with a clean interface and customizable display.

## Features

- Clean, minimalist design
- Fullscreen mode
- Customizable colors
- Cross-platform sound notifications
- Keyboard shortcuts
- Easy time input

## Installation

### Windows

```bash
# Clone the repository
git clone https://github.com/rabiulrahat/metopi.git
cd metopi

# Install using pip
pip install .
```

### Linux

```bash
# Install system dependencies (for sound)
sudo apt-get install sox    # For Debian/Ubuntu
# OR
sudo dnf install sox        # For Fedora
# OR
sudo pacman -S sox         # For Arch Linux

# Clone and install
git clone https://github.com/rabiulrahat/metopi.git
cd metopi
pip install .
```

## Usage

After installation, run Metopi from the terminal:

```bash
metopi
```

### Controls

- **Time Input**: Enter minutes and seconds directly
- **Space**: Start/Pause timer
- **R**: Reset timer
- **C**: Change color
- **F11**: Toggle fullscreen
- **Esc**: Exit fullscreen
- **Q**: Quit

## Development

To run from source:

```bash
python -m metopi.app
```

## License

MIT License

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request
