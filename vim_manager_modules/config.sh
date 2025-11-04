#!/bin/bash

# ============================================================================
# Vim Manager - Configuration Module
# ============================================================================

# --- Configuration ---
VERSION="3.1"
UPDATED="2025-06-17"

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
    "https://github.com/ryanoasis/vim-devicons.git all-the-icons"
    "https://github.com/nvim-tree/nvim-web-devicons.git nvim-web-devicons"
    "https://github.com/tpope/vim-fugitive.git vim-fugitive"
    "https://github.com/tpope/vim-surround.git vim-surround"
    "https://github.com/tpope/vim-commentary.git vim-commentary"
    "https://github.com/sheerun/vim-polyglot.git vim-polyglot"
    "https://github.com/jiangmiao/auto-pairs.git auto-pairs"
    "https://github.com/tpope/vim-sensible.git vim-sensible"
    "https://github.com/iamcco/markdown-preview.nvim.git markdown-preview.nvim"
)

# --- Colors and Formatting ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'
