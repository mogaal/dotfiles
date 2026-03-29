# Agent Instructions for Dotfiles Repository

This repository contains personal dotfiles for shell configuration, development environment setup, and productivity tools.

## Repository Structure

```
.
├── install.sh              # Main installation script (bash)
├── install_nerdfonts.sh    # Nerd fonts installer
├── gitconfig               # Git configuration
├── gbp.conf                # Git-buildpackage config
├── mrconfig                # Myrepos configuration
├── dput.cf                 # Debian package upload config
├── hh_blacklist            # hstr/bash history blacklist
├── kitty.conf              # Kitty terminal config
├── containers/             # Container configs
├── gittemplates/           # Git commit templates
├── gnupg/                  # GPG configuration
├── i3/                     # i3 window manager config
├── irssi/                  # IRC client config
├── nvim/                   # Neovim configuration
├── ssh/                    # SSH configuration
├── tmux/                   # Tmux configuration
│   ├── tmux.conf          # Main tmux config
│   ├── tmux.osx.conf      # macOS-specific
│   ├── tmux.linux.conf    # Linux-specific
│   └── plugins/           # Tmux plugins (including TPM)
└── zsh/                    # Zsh configuration
    ├── zshrc              # Main zshrc (loads Prezto)
    ├── zshenv             # Environment variables
    ├── zprofile           # Login shell config
    ├── zlogout            # Logout script
    ├── zpreztorc          # Prezto config
    ├── aliases            # Shell aliases
    └── functions/         # Zsh functions
        ├── git.sh         # Git utilities
        ├── k8s.sh         # Kubernetes helpers
        ├── aws.sh         # AWS utilities
        ├── os.sh          # OS utilities
        └── tmux.sh        # Tmux session helpers
```

## Build, Lint, and Test Commands

### Shell Scripts

```bash
# Make scripts executable
chmod +x install.sh install_nerdfonts.sh

# Run installation
./install.sh -i   # Install apps
./install.sh -d   # Install dotfiles

# Shellcheck (install first: brew install shellcheck)
shellcheck install.sh
shellcheck install_nerdfonts.sh

# Run specific shellcheck rule
shellcheck -e SC1090 install.sh  # SC1090: not following sourced files
```

### Tmux Plugin Tests (TPM)

```bash
cd tmux/plugins/tpm

# Run all tests
./tests/run_tests.sh

# Run a single test file
./tests/test_plugin_installation.sh

# Run specific test (via function name matching)
grep -n "^test_" tests/test_plugin_installation.sh | head -5
```

### General

```bash
# Verify bash syntax
bash -n install.sh

# Verify zsh syntax
zsh -n zsh/functions/git.sh

# Check file differences from git root
git diff --stat

# List custom functions
grep -h '^function' zsh/functions/* | cut -d' ' -f 2 | sort
```

## Code Style Guidelines

### Shell Scripts (Bash/Zsh)

**Shebang and Error Handling**
- Use `#!/usr/bin/env bash` for portability
- Include error handling: `set -Eeuo pipefail`
- Set up cleanup trap: `trap cleanup SIGINT SIGTERM ERR EXIT`
- Get script directory safely:
  ```bash
  script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
  ```

**Functions**
- Use `function name()` or `name()` syntax consistently within a file
- Declare local variables: `local var_name`
- Return early on errors: `command || return`
- Use descriptive function names with hyphens (e.g., `install_dotfiles`)

**Variables**
- Use lowercase with underscores or hyphens: `$script_dir`, `$backup_dir`
- Global constants in UPPERCASE: `DOTFILES`, `BACKUP`
- Quote variables: `"$var"` not `$var`
- Use `${var}` for clarity or with modifiers

**Conditionals**
- Bash: Use `[[ ]]` for conditionals (not `[ ]`)
- Zsh: Can use `[[ ]]` or `[ ]`
- Always quote strings: `[[ -n "$var" ]]`
- Use `==` for string comparison in `[[ ]]`

**Command Substitution**
- Prefer `$()` over backticks: `$(command)` not `\`command\``
- Use `|| return` for commands that must succeed:
  ```bash
  root=$(git rev-parse --show-toplevel) || return
  ```

**Output and Logging**
- Use echo with colors (when needed):
  ```bash
  RED='\033[0;31m'
  NC='\033[0m'
  echo -e "${RED}Error${NC}: message"
  ```
- Prefix success with `✓` and failure with `✗`:
  ```bash
  echo "✓ Package installed"
  echo "✗ Installation failed"
  ```

**Comments**
- Use `#` for single-line comments
- Include references in comments when applicable:
  ```bash
  # Taken from https://example.com/source
  ```
- Use block comments for complex logic

### Git Configuration

**Format**
- Use INI-style format: `[section]`
- Indent with tabs within sections
- Quote strings with spaces: ` branchname = "feature branch"`

**Aliases**
- Keep aliases short and memorable
- Use descriptive names for complex aliases

### Zsh Functions

**Structure**
```zsh
# Brief description
function function-name() {
  if [[ -n $1 ]]; then
    # implementation
  else
    echo "Usage: function-name <arg>"
    return 1
  fi
}
```

**Error Handling**
- Validate required arguments at start
- Return 1 on failure, 0 on success
- Print usage message when arguments missing

### Tmux Configuration

**Syntax**
- Use `set -g` for global options
- Use `set -w` for window options
- Use single quotes for strings that don't need expansion
- Group related settings together

### File Organization

**Imports/Sourcing**
- Source files with proper error handling
- Check file existence before sourcing: `[[ -e "$file" ]]`
- Use full paths or validated relative paths

**Directory Structure**
- Keep related configurations together
- Use subdirectories for plugins and complex configs
- Maintain OS-specific configs in separate files

## Best Practices

1. **Idempotency**: Scripts should be safe to run multiple times
2. **Portability**: Support both macOS (darwin*) and Linux (linux*)
3. **Error Messages**: Clear, actionable error messages
4. **Dry Runs**: Consider adding dry-run options for dangerous operations
5. **Symlinks**: Create symlinks for dotfiles, back up existing files first

## Common Patterns

**Checking Command Existence**
```bash
if command -v command_name &>/dev/null; then
  # use command
fi
```

**Safe Directory Navigation**
```bash
if cd "$directory" 2>/dev/null; then
  # do work
fi
```

**Argument Parsing**
```bash
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      usage
      return
      ;;
    *)
      POSITIONAL+=("$1")
      ;;
  esac
  shift
done
```

**Cleanup Traps**
```bash
cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # cleanup code
}
trap cleanup SIGINT SIGTERM ERR EXIT
```
