#!/bin/bash

#==============================================================================
#  Common Utility Functions
#==============================================================================

# colored log
C_RESET='\033[0m'
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_BLUE='\033[0;34m'
C_YELLOW='\033[0;33m'

# usage: info "some message"
info() {
  echo -e "${C_BLUE}INFO: $1${C_RESET}"
}

# usage: success "some message"
success() {
  echo -e "${C_GREEN}SUCCESS: $1${C_RESET}"
}

# usage: warn "some message"
warn() {
  echo -e "${C_YELLOW}WARNING: $1${C_RESET}"
}

# usage: error "some message"
error() {
  echo -e "${C_RED}ERROR: $1${C_RESET}" >&2
  exit 1
}
