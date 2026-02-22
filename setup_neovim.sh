#!/bin/bash

# Abort the script if any command fails
set -e

# Script to set up Neovim (LazyVim) and its toolchain

# --- Function Definitions ---

# Check if Homebrew's Git is being used
check_homebrew_git() {
  echo "🔎 Checking Git installation..."
  GIT_PATH=$(which git)
  if [[ "$GIT_PATH" == "/opt/homebrew/bin/git" || "$GIT_PATH" == "/usr/local/bin/git" ]]; then
    echo "✅ Homebrew Git is in use: $GIT_PATH"
  else
    echo "⚠️ Warning: System Git ($GIT_PATH) or non-Homebrew Git is in use."
    echo "   It is recommended to use Homebrew Git for better compatibility and features."
    echo "   Please ensure Homebrew is correctly set up and its path is prioritized in your shell's PATH."
  fi
}

# Check if logged into GitHub, and if not, run setup_git.sh
check_github_login() {
  echo "🔎 Checking GitHub login status..."
  if ! command -v gh &>/dev/null; then
    echo "❌ GitHub CLI (gh) not found. Please install it first (e.g., brew install gh)."
    exit 1
  fi

  if ! gh auth status &>/dev/null; then
    echo "❌ Not logged in to GitHub CLI."
    echo "   Attempting to run setup_git.sh to configure Git and prompt for gh login..."
    # Run setup_git.sh to configure Git and prompt for gh login
    # setup_git.sh is interactive, so it waits for the user to complete the login
    ./setup_git.sh

    # After running setup_git.sh, check the login status again
    if ! gh auth status &>/dev/null; then
      echo "❌ GitHub CLI login still not complete after running setup_git.sh."
      echo "   Please ensure you complete 'gh auth login' manually."
      exit 1 # Abort Neovim setup as login is not complete
    fi
  fi
  echo "✅ Logged in to GitHub."
}

# Back up existing Neovim settings
backup_existing_nvim() {
  NVIM_CONFIG_DIR=""${HOME}"/.config/nvim"
  NVIM_DATA_DIR=""${HOME}"/.local/share/nvim"
  NVIM_STATE_DIR=""${HOME}"/.local/state/nvim"
  NVIM_CACHE_DIR=""${HOME}"/.cache/nvim" # Added to LazyVim's backup targets

  # Back up in the format .bak-YYYYMMDD-HHMMSS
  BACKUP_SUFFIX=".bak.$(date +%Y%m%d-%H%M%S)"

  if [ -d "$NVIM_CONFIG_DIR" ]; then
    echo "🛡️ Backing up existing Neovim config to ${NVIM_CONFIG_DIR}${BACKUP_SUFFIX}..."
    mv "$NVIM_CONFIG_DIR" "${NVIM_CONFIG_DIR}${BACKUP_SUFFIX}"
  fi
  if [ -d "$NVIM_DATA_DIR" ]; then
    echo "🛡️ Backing up existing Neovim data to ${NVIM_DATA_DIR}${BACKUP_SUFFIX}..."
    mv "$NVIM_DATA_DIR" "${NVIM_DATA_DIR}${BACKUP_SUFFIX}"
  fi
  if [ -d "$NVIM_STATE_DIR" ]; then
    echo "🛡️ Backing up existing Neovim state to ${NVIM_STATE_DIR}${BACKUP_SUFFIX}..."
    mv "$NVIM_STATE_DIR" "${NVIM_STATE_DIR}${BACKUP_SUFFIX}"
  fi
  if [ -d "$NVIM_CACHE_DIR" ]; then
    echo "🛡️ Backing up existing Neovim cache to ${NVIM_CACHE_DIR}${BACKUP_SUFFIX}..."
    mv "$NVIM_CACHE_DIR" "${NVIM_CACHE_DIR}${BACKUP_SUFFIX}"
  fi
}

# Install the LazyVim starter
install_lazyvim() {
  echo "🚀 Cloning LazyVim starter..."
  # Clone the starter repository directly. The backup function ensures the path is clear.
  git clone https://github.com/LazyVim/starter "${HOME}/.config/nvim"
  # Remove the original .git directory to start a fresh history.
  rm -rf "${HOME}/.config/nvim/.git"

  echo "🧹 Initializing Git repository for Neovim configuration..."
  cd "${HOME}/.config/nvim"

  # Initialize Git repository
  git init

  # Initial commit
  git add .
  git commit -m "Initial commit: LazyVim starter configuration"

  # Set up remote repository (optional)
  # If you want to manage your Neovim config with Git, uncomment the following line and set the URL.
  # Example: git remote add origin https://github.com/your_username/nvim-config.git
  # Then, push with: git push -u origin main

  cd - >/dev/null # Return to the original directory
}

# --- Main Processing ---

main() {
  echo "--- 🚀 Setting up Neovim (LazyVim) environment ---"
  check_homebrew_git # Add Homebrew Git check
  check_github_login # Add GitHub login check
  backup_existing_nvim
  install_lazyvim

  echo ""
  echo "🎉 Neovim (LazyVim) setup is complete!"
  echo ""
  echo "👇 Next Steps:"
  echo "1. Launch Neovim by typing 'nvim' in your terminal."
  echo "2. On the first launch, LazyVim will automatically install all the plugins. Please wait for it to finish."
  echo "   (If not, run ':Lazy sync' inside Neovim)"
}

# Execute script
main

