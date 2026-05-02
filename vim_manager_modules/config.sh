#!/bin/bash

# ============================================================================
# Vim Manager - Configuration Module
# ============================================================================

# --- Configuration ---
VERSION="3.3"
UPDATED="2026-03-13"

# Directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."
PLUGINS_DIR="$SCRIPT_DIR/plugins"

# --- Plugin Manifest ---
# List of all plugins to be managed. Format: "repo_url plugin_directory_name"
PLUGINS=(
    "https://github.com/vim-airline/vim-airline.git vim-airline"
    "https://github.com/vim-airline/vim-airline-themes.git vim-airline-themes"
    "https://github.com/preservim/nerdtree.git nerdtree"
    "https://github.com/ryanoasis/vim-devicons.git vim-devicons"
    "https://github.com/tpope/vim-fugitive.git vim-fugitive"
    "https://github.com/tpope/vim-surround.git vim-surround"
    "https://github.com/tpope/vim-repeat.git vim-repeat"
    "https://github.com/tpope/vim-commentary.git vim-commentary"
    "https://github.com/mhinz/vim-signify.git vim-signify"
    "https://github.com/sheerun/vim-polyglot.git vim-polyglot"
    "https://github.com/jiangmiao/auto-pairs.git auto-pairs"
    "https://github.com/tpope/vim-sensible.git vim-sensible"
    "https://github.com/mbbill/undotree.git undotree"
    "https://github.com/junegunn/vim-easy-align.git vim-easy-align"
    "https://github.com/junegunn/fzf.vim.git fzf.vim"
    "https://github.com/chrisbra/csv.vim.git csv.vim"
    "https://github.com/iamcco/markdown-preview.nvim.git markdown-preview.nvim"
    "https://github.com/liuchengxu/vim-which-key.git vim-which-key"
)

# --- Plugin Profiles ---
# default/full keep today's complete managed plugin set.
# minimal keeps only the portable editing/search core.
DEFAULT_PLUGIN_PROFILE="default"
PLUGIN_PROFILES=("minimal" "default" "full")
MINIMAL_PLUGIN_NAMES=(
    "vim-sensible"
    "vim-surround"
    "vim-repeat"
    "vim-commentary"
    "auto-pairs"
    "vim-polyglot"
    "fzf.vim"
    "vim-which-key"
)

is_valid_plugin_profile() {
    local profile="$1"
    local known_profile
    for known_profile in "${PLUGIN_PROFILES[@]}"; do
        if [ "$profile" = "$known_profile" ]; then
            return 0
        fi
    done
    return 1
}

available_plugin_profiles() {
    local IFS=","
    echo "${PLUGIN_PROFILES[*]}"
}

plugin_in_profile() {
    local profile="$1"
    local plugin_name="$2"
    local minimal_name

    case "$profile" in
        minimal)
            for minimal_name in "${MINIMAL_PLUGIN_NAMES[@]}"; do
                if [ "$plugin_name" = "$minimal_name" ]; then
                    return 0
                fi
            done
            return 1
            ;;
        default|full)
            return 0
            ;;
    esac

    return 1
}

# --- External Tool Checks ---
REQUIRED_TOOLS=(
    "git"
    "vim"
    "rg"
    "fzf"
    "node"
)

# --- Colors and Formatting ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'
