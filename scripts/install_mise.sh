#!/bin/bash

#==============================================================================
# mise Version Manager Installation (Optimized for Ubuntu Bash)
#==============================================================================

info "Starting mise installation on Ubuntu..."

# 1. Check and install dependencies
info "Installing prerequisites..."
sudo apt update -y && sudo apt install -y gpg wget curl ca-certificates

# 2. Add mise official repository
if [ ! -f /etc/apt/sources.list.d/mise.list ]; then
  info "Adding mise APT repository..."
  sudo install -dm 755 /etc/apt/keyrings
  wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg >/dev/null
  echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=$(dpkg --print-architecture)] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
  sudo apt update
fi

# 3. Install mise
if ! command -v mise &>/dev/null; then
  info "Installing mise package..."
  sudo apt install -y mise
  success "mise binary installed."
else
  success "mise is already installed: $(mise --version)"
fi

# 4. Configure Bash Integration
BASH_CONFIG="$HOME/.bashrc"
if ! grep -q 'mise activate bash' "$BASH_CONFIG"; then
  info "Injecting mise activation into $BASH_CONFIG..."
  cat >>"$BASH_CONFIG" <<'EOF'

# --- mise Version Manager ---
eval "$(mise activate bash)"
EOF
  success "Bash integration configured."
else
  success "mise is already configured in $BASH_CONFIG"
fi

# 5. Finalize
info "Activating mise for the current session..."
eval "$(mise activate bash)"

echo "----------------------------------------------------"
success "Installation Complete!"
echo "----------------------------------------------------"
