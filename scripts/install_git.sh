#!/bin/bash

#==============================================================================
# Git Installation and Configuration (Ubuntu Version)
#==============================================================================

info "Checking and installing Git..."

# 1. Install Git via APT
if command -v git &>/dev/null; then
  GIT_VERSION=$(git --version | awk '{print $3}')
  success "Git is already installed (version: $GIT_VERSION)."
else
  info "Git not detected. Installing via APT..."
  sudo apt update
  sudo apt install -y git

  if [ $? -eq 0 ]; then
    GIT_VERSION=$(git --version | awk '{print $3}')
    success "Git $GIT_VERSION installed successfully!"
  else
    error "Git installation failed. Please check APT repositories."
  fi
fi

echo ""
info "Checking Git configuration..."

# 2. Check Git identity
GIT_USER_NAME=$(git config --global user.name)
GIT_USER_EMAIL=$(git config --global user.email)

if [ -z "$GIT_USER_NAME" ] || [ -z "$GIT_USER_EMAIL" ]; then
  warn "Git user information is not configured."
  info "Please configure your Git identity manually later:"
  echo ""
  echo "  git config --global user.name \"Your Name\""
  echo "  git config --global user.email \"your.email@example.com\""
  echo ""
else
  success "Git is configured with:"
  info "  Name: $GIT_USER_NAME"
  info "  Email: $GIT_USER_EMAIL"
fi

# 3. Set recommended Git configurations
info "Setting recommended Git configurations..."

# Set default branch name to main
git config --global init.defaultBranch main

# Enable colors in Git output
git config --global color.ui auto

# Set pull strategy (false means merge, true means rebase)
# Given your architecture background, 'false' is safer for shared history
git config --global pull.rebase false

# Credential helper for Linux (Caching in memory for 1 hour)
# Since we don't have osxkeychain, 'cache' is the standard for Linux
git config --global credential.helper 'cache --timeout=3600'

# Set core editor to vim (as per your request)
if command -v vim &>/dev/null; then
  git config --global core.editor vim
  success "Default editor set to Vim."
else
  warn "Vim not found, Git will use system default editor."
fi

success "Git configuration completed!"
echo ""
