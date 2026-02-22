#!/bin/bash
# Abort the script if any command fails
set -e

echo "🍺 Installing/Updating GUI applications from Brewfile.gui..."
echo "⚠️ Some of these applications may require your password to complete the installation."
brew bundle --file=Brewfile.gui

echo "✅ Homebrew GUI applications setup complete."
