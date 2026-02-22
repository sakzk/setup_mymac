#!/bin/bash
set -eux

# Get the absolute path of the directory where this script is located
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

# Copy .zshrc to home directory
cp "${SCRIPT_DIR}/zsh/.zshrc" "${HOME}/.zshrc"
