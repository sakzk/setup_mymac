#!/bin/bash
# Script to set up the Python environment with pyenv and uv

set -e

echo "--- 🐍 Setting up Python environment ---"

# Add pyenv initialization commands to .zshrc if they are not already present (for idempotency)
if ! grep -q 'eval "$(pyenv init -)"' "${HOME}/.zshrc"; then
  echo "Adding pyenv configuration to ~/.zshrc..."
  echo '' >>"${HOME}/.zshrc"
  echo '# pyenv setup' >>"${HOME}/.zshrc"
  echo 'export PYENV_ROOT="${HOME}/.pyenv"' >>"${HOME}/.zshrc"
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >>"${HOME}/.zshrc"
  echo 'eval "$(pyenv init -)"' >>"${HOME}/.zshrc"
fi

# Enable pyenv in the current shell (to use pyenv commands within the script)
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Install the latest stable version of Python (e.g., 3.13 series)
LATEST_PYTHON=$(pyenv install -l | grep -E "^\s*3\.14\.[0-9]+$" | tail -n 1 | xargs)
if [ -z "$LATEST_PYTHON" ]; then
  echo "❌ Error: Could not find latest Python 3.13.x version."
  exit 1
fi

echo "Installing Python ${LATEST_PYTHON}..."
pyenv install --skip-existing "$LATEST_PYTHON" # Use --skip-existing for idempotency
pyenv global "$LATEST_PYTHON"

# Install uv
echo "Installing uv (the fast package manager)..."
# pip install is not idempotent, so check for existence
if ! command -v uv &>/dev/null; then
  pip install uv
else
  echo "uv is already installed. Skipping installation."
fi

echo "✅ Python setup complete. Current version: $(python --version)"
echo "uv is installed. Try 'uv --version'."
echo "NOTE: Please restart your terminal or run 'source ~/.zshrc' to apply changes."
