#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/version.sh"
source "$SCRIPT_DIR/scripts/common.sh"

source "$SCRIPT_DIR/scripts/install_mise.sh"
