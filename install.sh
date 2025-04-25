#!/bin/bash

echo "Installing Metopi..."

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux installation
    if command -v apt-get &> /dev/null; then
        echo "Debian/Ubuntu detected. Installing dependencies..."
        sudo apt-get update
        sudo apt-get install -y python3-pip sox
    elif command -v dnf &> /dev/null; then
        echo "Fedora detected. Installing dependencies..."
        sudo dnf install -y python3-pip sox
    elif command -v pacman &> /dev/null; then
        echo "Arch Linux detected. Installing dependencies..."
        sudo pacman -S --noconfirm python-pip sox
    else
        echo "Please install 'sox' manually for sound support"
    fi
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    echo "Windows detected. No additional dependencies needed."
fi

# Install Python package
pip install .

echo "Installation complete! Run 'metopi/python3 -m metopi.app
' to start the timer."
