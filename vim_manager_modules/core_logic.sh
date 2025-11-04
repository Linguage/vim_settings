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
