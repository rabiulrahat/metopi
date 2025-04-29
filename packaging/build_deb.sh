#!/bin/bash

# Exit on error
set -e

cleanup() {
    echo "Cleaning up..."
    # Remove Python cache files
    find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
    find . -type f -name "*.pyc" -delete
    find . -type f -name "*.pyo" -delete
    # Remove temporary build files
    rm -rf build/deb_build
}

# Ensure cleanup runs on script exit
trap cleanup EXIT

echo "Building Metopi .deb package..."

# Create temporary build directory
BUILD_DIR="build/deb_build"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Ensure build and dist directories have .trackerignore
mkdir -p build dist
touch build/.trackerignore dist/.trackerignore

# Copy debian package structure
cp -r packaging/debian/* "$BUILD_DIR/"

# Install package in the build directory
pip install --no-deps --target "$BUILD_DIR/usr/share/metopi" .

# Remove unnecessary files
find "$BUILD_DIR" -type d -name "__pycache__" -exec rm -rf {} +
find "$BUILD_DIR" -type f -name "*.pyc" -delete
find "$BUILD_DIR" -type f -name "*.pyo" -delete

# Set permissions
chmod -R 755 "$BUILD_DIR/DEBIAN"
chmod -R 755 "$BUILD_DIR/usr"

# Build the package
mkdir -p dist
dpkg-deb --build "$BUILD_DIR" "dist/metopi.deb"

echo "Package built successfully: dist/metopi.deb"
