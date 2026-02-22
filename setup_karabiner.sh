#!/bin/bash
set -e

echo "Setting up Karabiner-Elements rules..."

# Target directory for configuration files
# Create it if it doesn't exist
TARGET_DIR="${HOME}/.config/karabiner/assets/complex_modifications"
mkdir -p "${TARGET_DIR}"

# Specify the path relative to the script's location
SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

# Copy JSON files only if no .json files already exist in the target directory
# This prevents overwriting user's custom changes.
if ! ls "${TARGET_DIR}"/*.json > /dev/null 2>&1; then
  echo "No existing Karabiner rules found. Copying default rules..."
  cp "${SCRIPT_DIR}"/karabiner_elements/*.json "${TARGET_DIR}/"
else
  echo "✅ Existing Karabiner rules found. Skipping copy to avoid overwriting user changes."
fi

echo "Karabiner-Elements JSON files have been placed."
echo "NOTE: You still need to manually enable the rules from the Karabiner-Elements GUI."