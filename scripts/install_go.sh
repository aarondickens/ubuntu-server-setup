#!/bin/bash

#==============================================================================
# Go (Golang) Installation via mise (Ubuntu Bash Edition - Minimal)
#==============================================================================

info "Checking and installing Go via mise..."

# 1. Install Go via mise
# Check if Go is already installed via mise
if mise list go 2>/dev/null | grep -q 'go'; then
  CURRENT_GO_VERSION=$(go version 2>/dev/null || echo "not active")
  success "Go is already installed via mise."
  info "Current active version: $CURRENT_GO_VERSION"
else
  # Use default version if not set in environment
  GO_TARGET_VERSION="${DEFAULT_GO_VERSION:-latest}"
  info "No Go versions found. Installing version ($GO_TARGET_VERSION) via mise..."

  # Install and set as global default
  mise use -g "go@${GO_TARGET_VERSION}"

  if [ $? -eq 0 ]; then
    # Reload mise for current bash session
    eval "$(mise activate bash)"
    INSTALLED_VERSION=$(go version 2>/dev/null || echo "unknown")
    success "Go $INSTALLED_VERSION installed and set as global default!"
  else
    error "Failed to install Go via mise."
  fi
fi

echo ""
info "Configuring Go environment variables..."

# 2. Configure Environment Variables
BASH_CONFIG="$HOME/.bashrc"
GOPATH_DIR="$HOME/go"

# Check if GOPATH is already configured in .bashrc
if ! grep -q 'export GOPATH=' "$BASH_CONFIG"; then
  info "Adding Go environment variables to $BASH_CONFIG..."
  {
    echo ''
    echo '# --- Go Configuration ---'
    echo 'export GOPATH="$HOME/go"'
    echo 'export GOBIN="$GOPATH/bin"'
    echo 'export PATH="$GOBIN:$PATH"'
  } >>"$BASH_CONFIG"
  success "Go environment variables added to $BASH_CONFIG"
else
  success "Go environment variables already configured in $BASH_CONFIG"
fi

# Set environment variables for the current running script session
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

# 3. Create GOPATH directory structure
if [ ! -d "$GOPATH_DIR" ]; then
  info "Creating GOPATH directory at $GOPATH_DIR..."
  mkdir -p "$GOPATH_DIR"/{bin,src,pkg}
  success "GOPATH directory structure created."
else
  success "GOPATH directory already exists at $GOPATH_DIR"
fi

echo ""
info "Go environment setup complete!"
info "GOPATH: $GOPATH"
info "GOBIN: $GOBIN"
info "Go version: $(go version)"
echo ""
