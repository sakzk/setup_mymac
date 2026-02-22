#!/bin/bash

# Abort the script if any command fails
set -e

echo "--- 🐙 Setting up Git configuration ---"

# --- Git user.name and user.email setup ---
if [ -n "$(git config --global user.name)" ] && [ -n "$(git config --global user.email)" ]; then
    echo "✅ Git user name and email are already configured."
else
    echo "Git user name and email are not set. Please provide them."
    read -p "Enter Git username: " GIT_USERNAME
    read -p "Enter Git email: " GIT_EMAIL

    # Update settings only if input is provided
    if [ -n "$GIT_USERNAME" ]; then
      git config --global user.name "$GIT_USERNAME"
      echo "✅ Git username set to: $(git config --global user.name)"
    else
      echo "❌ Git username was not provided. Aborting."
      exit 1
    fi

    if [ -n "$GIT_EMAIL" ]; then
      git config --global user.email "$GIT_EMAIL"
      echo "✅ Git email set to: $(git config --global user.email)"
    else
      echo "❌ Git email was not provided. Aborting."
      exit 1
    fi
fi

# --- GitHub CLI login status check ---
echo "🔎 Checking GitHub CLI login status..."
if ! command -v gh &> /dev/null; then
  echo "❌ GitHub CLI (gh) not found. Please install it first (e.g., brew install gh)."
  exit 1
fi

if ! gh auth status &> /dev/null; then
  echo "⚠️ Not logged in to GitHub CLI. Please run 'gh auth login' manually after this script."
else
  echo "✅ Logged in to GitHub CLI."
fi

echo "✅ Git setup complete."
