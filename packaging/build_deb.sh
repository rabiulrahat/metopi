#!/bin/bash

# Exit on error
set -e

echo "Building Metopi .deb package..."

# Create temporary build directory
BUILD_DIR="build/deb_build"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

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
