# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Ubuntu server setup scripts that automate installation of development tools. Uses a modular architecture where each tool has its own installation script sourced by the main `install.sh`.

## Commands

```bash
# Run the full setup (installs mise, git, go)
bash install.sh

# Individual installation scripts
bash scripts/install_mise.sh
bash scripts/install_git.sh
bash scripts/install_go.sh
```

Note: Use `bash` not `sh` to run scripts.

## Architecture

```
install.sh          # Entry point - sources all scripts
version.sh          # Default versions (GO_VERSION, SQLITE_VERSION)
scripts/
  common.sh         # Shared utilities: info(), success(), warn(), error()
  install_mise.sh   # Installs mise via APT repository
  install_git.sh    # Installs git via APT and configures git identity
  install_go.sh     # Installs Go via mise, configures GOPATH/GOBIN
  install_sqlite3.sh # Installs SQLite3 via APT
```

### Script Pattern

Each install script:
- Is idempotent (safe to run multiple times)
- Checks if tool exists before installing
- Sources `common.sh` for logging functions
- Appends shell configuration to `~/.bashrc`

### Shared Utilities (scripts/common.sh)

- `info "message"` - Blue INFO output
- `success "message"` - Green SUCCESS output
- `warn "message"` - Yellow WARNING output
- `error "message"` - Red ERROR output and exits

### Default Versions (version.sh)

- `DEFAULT_GO_VERSION=1.26.2`
- `DEFAULT_SQLITE_VERSION=3.53.0`
