#!/bin/bash

# Abort the script if any command fails
set -e

# Script to perform initial setup for Ghostty

# Define the configuration directory and file path
CONFIG_DIR="${HOME}/.config/ghostty"
CONFIG_FILE="$CONFIG_DIR/config"

# --- Main Processing ---
echo "--- Setting up Ghostty configuration ---"

# Create the configuration directory if it doesn't exist
if [ ! -d "$CONFIG_DIR" ]; then
  echo "Directory not found. Creating ${CONFIG_DIR}..."
  mkdir -p "$CONFIG_DIR"
fi

# If an existing configuration file is found, create a backup
if [ -f "$CONFIG_FILE" ]; then
  BACKUP_NAME="${CONFIG_FILE}.bak.$(date +%Y%m%d-%H%M%S)"
  echo "🛡️ Existing config found. Backing up to ${BACKUP_NAME}..."
  mv "$CONFIG_FILE" "$BACKUP_NAME"
fi

# Write the settings to the configuration file (existing content will be overwritten)
echo "Writing settings to ${CONFIG_FILE}..."
cat >"$CONFIG_FILE" <<EOL
background-opacity = 0.9
font-family = "HackGen Console NF"
font-size = 14
EOL

echo "✅ Ghostty setup complete."
echo "Please restart Ghostty to apply the new settings."
