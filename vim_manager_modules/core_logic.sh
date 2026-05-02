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
    local SOURCE_DIR
    SOURCE_DIR="$(resolve_path "$SCRIPT_DIR")"

    # --- Link main configuration directory ---
    info "Linking $SOURCE_DIR -> $VIM_DIR"
    # Backup existing .vim directory if it's a real directory
    if [ -d "$VIM_DIR" ] && [ ! -L "$VIM_DIR" ]; then
        local backup_dir="$VIM_DIR.backup.$(date +%Y%m%d_%H%M%S)"
        warning "Existing .vim directory found. Backing up to $backup_dir"
        mv "$VIM_DIR" "$backup_dir" || { error "Failed to back up .vim directory. Aborting."; exit 1; }
    fi
    # Create symlink
    ln -sfn "$SOURCE_DIR" "$VIM_DIR"
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
    ln -sfn "$VIM_DIR/vimrc" "$VIMRC_FILE"
    success "vimrc file linked."

    # --- Link gvimrc file for MacVim/GUI ---
    info "Linking $VIM_DIR/vimrc -> $GVIMRC_FILE"
    if [ -f "$GVIMRC_FILE" ] && [ ! -L "$GVIMRC_FILE" ]; then
        local backup_file="$GVIMRC_FILE.backup.$(date +%Y%m%d_%H%M%S)"
        warning "Existing .gvimrc file found. Backing up to $backup_file"
        mv "$GVIMRC_FILE" "$backup_file" || { error "Failed to back up .gvimrc. Aborting."; exit 1; }
    fi
    ln -sfn "$VIM_DIR/vimrc" "$GVIMRC_FILE"
    success "gvimrc file linked."
}

install_plugins() {
    local active_profile="${1:-$DEFAULT_PLUGIN_PROFILE}"

    header "Installing Plugins"
    info "Using plugin profile: $active_profile"
    mkdir -p "$PLUGINS_DIR"

    for plugin_info in "${PLUGINS[@]}"; do
        # Split the string "repo_url dir_name" into an array
        read -r repo_url dir_name <<< "$plugin_info"
        local plugin_path="$PLUGINS_DIR/$dir_name"

        if ! plugin_in_profile "$active_profile" "$dir_name"; then
            continue
        fi

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

install_plugin_post_steps() {
    local active_profile="${1:-$DEFAULT_PLUGIN_PROFILE}"

    header "Running Plugin Post-Install Steps"

    local markdown_app="$PLUGINS_DIR/markdown-preview.nvim/app"
    if plugin_in_profile "$active_profile" "markdown-preview.nvim" && [ -d "$markdown_app" ]; then
        if command_exists yarn; then
            info "Installing markdown-preview.nvim app dependencies with yarn..."
            if (cd "$markdown_app" && yarn install --frozen-lockfile >/dev/null 2>&1); then
                success "markdown-preview.nvim app dependencies installed."
            elif (cd "$markdown_app" && yarn install >/dev/null 2>&1); then
                success "markdown-preview.nvim app dependencies installed."
            else
                warning "Failed to install markdown-preview.nvim app dependencies with yarn."
            fi
        elif command_exists npm; then
            info "Installing markdown-preview.nvim app dependencies with npm..."
            if (cd "$markdown_app" && npm install >/dev/null 2>&1); then
                success "markdown-preview.nvim app dependencies installed."
            else
                warning "Failed to install markdown-preview.nvim app dependencies with npm."
            fi
        else
            warning "markdown-preview.nvim needs npm or yarn for browser preview support."
        fi
    elif plugin_in_profile "$active_profile" "markdown-preview.nvim"; then
        info "markdown-preview.nvim is not installed yet. Skipping app dependency setup."
    else
        info "markdown-preview.nvim is outside profile '$active_profile'. Skipping app dependency setup."
    fi

    if command_exists vim; then
        info "Refreshing Vim helptags..."
        if vim -Nu "$SCRIPT_DIR/vimrc" -i NONE -n -es +'silent! helptags ALL' +q >/dev/null 2>&1; then
            success "Helptags refreshed."
        else
            warning "Failed to refresh helptags automatically."
        fi
    else
        warning "Vim is not available, so helptags were not refreshed."
    fi
}
