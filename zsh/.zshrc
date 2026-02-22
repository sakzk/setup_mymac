# --- 1. Basic Zsh Settings ---
# Minimal settings that can only be done by Zsh itself, such as history enhancement
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# Enable autocompletion
autoload -U compinit
compinit

# Add brew binary path to PATH
eval "$(brew --prefix)/bin/brew shellenv"

# --- 2. Initialization of External Tools (eval) ---
# "Magic spells" to integrate each tool with Zsh
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)" # Often added automatically by the fzf installation script

# --- 3. Personal Settings Not Covered by Tools ---
export EDITOR='nvim'
export VISUAL='nvim'
alias nv="nvim"

alias ls='ls -G'
alias l='ls -lha'
alias g='git'
alias gs='git status -sb'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %s %Cgreen(%cr)'"
alias update='brew update && brew upgrade'
