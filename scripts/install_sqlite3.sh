#!/bin/bash

#==============================================================================
# SQLite3 Installation (Ubuntu Version)
#==============================================================================

info "Checking and installing SQLite3..."

# 1. Install SQLite3 via APT
if command -v sqlite3 &>/dev/null; then
  SQLITE_VERSION=$(sqlite3 --version | awk '{print $1}')
  success "SQLite3 is already installed (version: $SQLITE_VERSION)."
else
  info "SQLite3 not detected. Installing via APT..."
  sudo apt update
  sudo apt install -y sqlite3 libsqlite3-dev

  if [ $? -eq 0 ]; then
    SQLITE_VERSION=$(sqlite3 --version | awk '{print $1}')
    success "SQLite3 $SQLITE_VERSION installed successfully!"
  else
    error "SQLite3 installation failed. Please check APT repositories."
  fi
fi

echo ""
info "SQLite3 installation completed!"
echo ""
