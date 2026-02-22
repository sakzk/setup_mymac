# .PHONY: A magic incantation to ensure commands run even if a file with the same name as the target exists
.PHONY: all-auto all-lang all-manual brew-cli brew-gui defaults ghostty git go help karabiner nvim ocaml python zsh

all-auto: defaults zsh brew-cli 
	@echo "✅ Automated setup tasks completed."

all-manual: karabiner ghostty git nvim brew-gui
	@echo "✅ Manual setup tasks completed."

all-lang: python
	@echo "✅ Language installation tasks completed."

# macOS system settings
defaults:
	@./setup_defaults.sh

brew-cli:
	@./setup_homebrew_cli.sh

brew-gui:
	@./setup_homebrew_gui.sh

ghostty:
	@./setup_ghostty.sh

zsh:
	@./setup_zsh.sh

# Karabiner-Elements settings
karabiner:
	@./setup_karabiner.sh

# Git setup
git:
	@./setup_git.sh

# Neovim related setup
nvim: git
	@./setup_neovim.sh

# Python setup
python: brew-cli
	@./setup_python.sh

# Display help message
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Recommended Workflow:"
	@echo "  1. make all-auto   (Installs CLI tools and system settings)"
	@echo "  2. make all-manual   (Installs GUI apps and requires user interaction)"
	@echo "  3. make all-lang     (Optional: Installs language environments)"
	@echo ""
	@echo "Available Targets:"
	@echo "  all-auto       Run all fully automated setup tasks."
	@echo "  all-manual     Run tasks that require manual operations (GUI apps)."
	@echo "  defaults       Setup macOS defaults."
	@echo "  brew-cli       Install Homebrew CLI packages from Brewfile.cli."
	@echo "  brew-gui       Install Homebrew GUI packages from Brewfile.gui."
	@echo "  ghostty        Setup Ghostty terminal."
	@echo "  zsh            Stow zsh configuration."
	@echo "  karabiner      Setup Karabiner-Elements configuration."
	@echo "  git            Setup Git configuration (interactive)."
	@echo "  nvim           Setup Neovim and LazyVim."
	@echo "  go             Setup Go environment."
	@echo "  python         Setup Python environment."
