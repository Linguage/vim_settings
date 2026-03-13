#!/bin/bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$REPO_DIR/vim_manager_modules/config.sh"
source "$REPO_DIR/vim_manager_modules/helpers.sh"

install_macos() {
    if ! command_exists brew; then
        error "Homebrew is required on macOS but was not found."
        echo "Install Homebrew first, then rerun this script:"
        echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
        exit 1
    fi

    local packages=(git vim ripgrep fzf node)
    info "Installing macOS dependencies with Homebrew: ${packages[*]}"
    brew install "${packages[@]}"

    local fzf_install
    fzf_install="$(brew --prefix)/opt/fzf/install"
    if [ -x "$fzf_install" ]; then
        info "Installing fzf shell integration..."
        "$fzf_install" --key-bindings --completion --no-update-rc >/dev/null 2>&1 || \
            warning "fzf shell integration setup did not complete cleanly."
    fi

    warning "Optional Nerd Font install: brew install --cask font-hack-nerd-font"
}

install_apt() {
    info "Installing Linux dependencies with apt..."
    sudo apt-get update
    sudo apt-get install -y git vim ripgrep fzf nodejs npm
    warning "Install a Nerd Font separately if you want file-tree and airline icons."
}

install_dnf() {
    info "Installing Linux dependencies with dnf..."
    sudo dnf install -y git vim ripgrep fzf nodejs npm
    warning "Install a Nerd Font separately if you want file-tree and airline icons."
}

install_pacman() {
    info "Installing Linux dependencies with pacman..."
    sudo pacman -Sy --needed git vim ripgrep fzf nodejs npm
    warning "Install a Nerd Font separately if you want file-tree and airline icons."
}

main() {
    header "Installing Vim Configuration Dependencies"

    case "$(uname -s)" in
        Darwin)
            install_macos
            ;;
        Linux)
            if command_exists apt-get; then
                install_apt
            elif command_exists dnf; then
                install_dnf
            elif command_exists pacman; then
                install_pacman
            else
                error "Unsupported Linux package manager. Please install git, vim, ripgrep, fzf, nodejs, and npm manually."
                exit 1
            fi
            ;;
        *)
            error "Unsupported operating system. Please install dependencies manually."
            exit 1
            ;;
    esac

    success "External dependencies installed."
    echo ""
    info "Next step: run '$REPO_DIR/vim-manager install' to link config and install plugins."
}

main "$@"
