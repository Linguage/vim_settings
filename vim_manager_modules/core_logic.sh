#!/bin/bash

# ============================================================================
# Vim Manager - Core Logic Module
# ============================================================================

# --- Core Functions ---

link_config() {
    header "Linking Configuration"
    local VIM_DIR="$HOME/.vim"
    local VIMRC_FILE="$HOME/.vimrc"
    local GVIMRC_FILE="$HOME/.gvimrc"

    # --- Link main configuration directory ---
    info "Linking $SCRIPT_DIR -> $VIM_DIR"
    # Backup existing .vim directory if it's a real directory
    if [ -d "$VIM_DIR" ] && [ ! -L "$VIM_DIR" ]; then
        local backup_dir="$VIM_DIR.backup.$(date +%Y%m%d_%H%M%S)"
        warning "Existing .vim directory found. Backing up to $backup_dir"
        mv "$VIM_DIR" "$backup_dir" || { error "Failed to back up .vim directory. Aborting."; exit 1; }
    fi
    # Create symlink
    ln -sf "$SCRIPT_DIR" "$VIM_DIR"
    success "Configuration directory linked."

    # --- Link vimrc file ---
    info "Linking $VIM_DIR/vimrc -> $VIMRC_FILE"
    # Backup existing .vimrc if it's a real file
    if [ -f "$VIMRC_FILE" ] && [ ! -L "$VIMRC_FILE" ]; then
        local backup_file="$VIMRC_FILE.backup.$(date +%Y%m%d_%H%M%S)"
        warning "Existing .vimrc file found. Backing up to $backup_file"
        mv "$VIMRC_FILE" "$backup_file" || { error "Failed to back up .vimrc. Aborting."; exit 1; }
    fi
    # Create symlink
    ln -sf "$VIM_DIR/vimrc" "$VIMRC_FILE"
    success "vimrc file linked."

    # --- Link gvimrc file for MacVim/GUI ---
    info "Linking $VIM_DIR/vimrc -> $GVIMRC_FILE"
    if [ -f "$GVIMRC_FILE" ] && [ ! -L "$GVIMRC_FILE" ]; then
        local backup_file="$GVIMRC_FILE.backup.$(date +%Y%m%d_%H%M%S)"
        warning "Existing .gvimrc file found. Backing up to $backup_file"
        mv "$GVIMRC_FILE" "$backup_file" || { error "Failed to back up .gvimrc. Aborting."; exit 1; }
    fi
    ln -sf "$VIM_DIR/vimrc" "$GVIMRC_FILE"
    success "gvimrc file linked."
}

install_plugins() {
    header "Installing Plugins"
    mkdir -p "$PLUGINS_DIR"

    for plugin_info in "${PLUGINS[@]}"; do
        # Split the string "repo_url dir_name" into an array
        read -r repo_url dir_name <<< "$plugin_info"
        local plugin_path="$PLUGINS_DIR/$dir_name"

        if [ -d "$plugin_path/.git" ]; then
            info "Plugin '$dir_name' already installed. Skipping."
        else
            info "Installing plugin '$dir_name'..."
            if git clone --depth 1 "$repo_url" "$plugin_path" >/dev/null 2>&1; then
                success "Plugin '$dir_name' installed successfully."
            else
                error "Failed to install plugin '$dir_name'."
            fi
        fi
    done
}

check_copilot_requirements() {
    header "Checking GitHub Copilot Requirements"
    
    # Check Node.js
    if command -v node >/dev/null 2>&1; then
        local node_version=$(node --version)
        success "Node.js found: $node_version"
    else
        error "Node.js is required for GitHub Copilot but not found."
        info "Please install Node.js from https://nodejs.org/"
        return 1
    fi
    
    # Check Vim version
    if command -v vim >/dev/null 2>&1; then
        local vim_version=$(vim --version | head -1)
        success "Vim found: $vim_version"
        
        # Check if Vim version is 9.0.0185 or higher
        local version_num=$(vim --version | grep -o 'IMproved [0-9]\+\.[0-9]\+' | grep -o '[0-9]\+\.[0-9]\+' | head -1)
        if [ -n "$version_num" ]; then
            local major=$(echo "$version_num" | cut -d. -f1)
            local minor=$(echo "$version_num" | cut -d. -f2)
            if [ "$major" -ge 9 ] && [ "$minor" -ge 0 ]; then
                success "Vim version meets requirements (9.0.0185+)"
            else
                warning "Vim version may be too old. GitHub Copilot requires Vim 9.0.0185 or newer."
            fi
        fi
    else
        error "Vim not found. Please install Vim first."
        return 1
    fi
    
    return 0
}

setup_copilot() {
    header "Setting up GitHub Copilot"
    
    # Check if copilot.vim is installed
    local copilot_path="$PLUGINS_DIR/copilot.vim"
    if [ ! -d "$copilot_path" ]; then
        error "GitHub Copilot plugin not found. Run install first."
        return 1
    fi
    
    info "GitHub Copilot plugin is installed."
    info "To complete setup, please:"
    echo ""
    echo "  1. Start Vim: ${BLUE}vim${NC}"
    echo "  2. Run setup: ${BLUE}:Copilot setup${NC}"
    echo "  3. Follow the authentication instructions"
    echo ""
    info "Useful Copilot commands:"
    echo "  ${BLUE}:Copilot status${NC}  - Check status"
    echo "  ${BLUE}:Copilot enable${NC}  - Enable Copilot"
    echo "  ${BLUE}:Copilot disable${NC} - Disable Copilot"
    echo ""
    success "Copilot setup information provided."
}
