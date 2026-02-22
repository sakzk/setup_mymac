#!/bin/bash

# Abort the script if any command fails
set -e

echo "🍺 Installing/Updating CLI tools from Brewfile.cli..."
brew bundle --file=Brewfile.cli

echo "✅ Homebrew CLI tools setup complete."
