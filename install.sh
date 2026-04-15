#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

. "$SCRIPT_DIR/version.sh"
. "$SCRIPT_DIR/scripts/common.sh"

. "$SCRIPT_DIR/scripts/install_mise.sh"
. "$SCRIPT_DIR/scripts/install_git.sh"
