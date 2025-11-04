#!/bin/bash

# ============================================================================
# Vim Manager - Commands Module
# ============================================================================

# --- Command Functions ---

show_help() {
    header "Vim Manager v$VERSION"
    echo "A portable manager for your Vim configuration."
    echo ""
    echo "Usage: $0 <command>"
    echo ""
    echo "Commands:"
    echo "  install      Install the Vim configuration and all plugins."
    echo "  update       Update all plugins to their latest versions."
    echo "  clean        Remove any plugins not listed in the manifest."
    echo "  status       Check the status of the configuration and plugins."
    echo "  uninstall    Remove the Vim configuration and all installed components."
    echo "  help         Show this help message."
    echo ""
}

do_install() {
    header "Starting Installation"
    if ! command_exists git; then
        error "Git is not installed. Please install Git to continue."
        exit 1
    fi
    
    link_config
    install_plugins
    success "Installation complete!"
}

do_update() {
    header "Updating All Managed Plugins"
    if [ ! -d "$PLUGINS_DIR" ]; then
        error "Plugins directory not found. Have you run 'install' first?"
        exit 1
    fi

    for plugin_info in "${PLUGINS[@]}"; do
        read -r repo_url dir_name <<< "$plugin_info"
        local plugin_path="$PLUGINS_DIR/$dir_name"

        if [ -d "$plugin_path/.git" ]; then
            info "Updating '$dir_name'..."
            # Store current directory, cd, pull, and cd back
            (cd "$plugin_path" && git pull --rebase --autostash >/dev/null 2>&1)
            success "'$dir_name' updated."
        else
            warning "Plugin '$dir_name' not found. Run 'install' to install it."
        fi
    done
    success "All plugins have been processed."
}

do_clean() {
    header "Cleaning Unmanaged Plugins"
    if [ ! -d "$PLUGINS_DIR" ]; then
        info "Plugins directory does not exist. Nothing to clean."
        exit 0
    fi

    local unmanaged_plugins=()
    for dir in "$PLUGINS_DIR"/*/; do
        if [ -d "$dir" ]; then
            local dir_name=$(basename "$dir")
            local is_managed=false
            for plugin_info in "${PLUGINS[@]}"; do
                read -r _ managed_name <<< "$plugin_info"
                if [ "$dir_name" == "$managed_name" ]; then
                    is_managed=true
                    break
                fi
            done
            if [ "$is_managed" == false ]; then
                unmanaged_plugins+=("$dir")
            fi
        fi
    done

    if [ ${#unmanaged_plugins[@]} -eq 0 ]; then
        success "No unmanaged plugins found to clean."
        exit 0
    fi

    info "The following unmanaged plugins will be REMOVED:"
    for plugin_path in "${unmanaged_plugins[@]}"; do
        warning "  - $(basename "$plugin_path")"
    done
    echo ""
    read -p "Are you sure you want to proceed? [y/N] " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        for plugin_path in "${unmanaged_plugins[@]}"; do
            info "Removing $(basename "$plugin_path")..."
            rm -rf "$plugin_path"
            success "Removed."
        done
        success "Plugin directory cleaned."
    else
        info "Clean operation cancelled."
    fi
}

do_status() {
    header "Checking Configuration Status"

    # --- Check Symlinks ---
    info "1. Checking Symlinks..."
    local VIM_DIR="$HOME/.vim"
    local VIMRC_FILE="$HOME/.vimrc"

    if [ -L "$VIM_DIR" ] && [ "$(readlink "$VIM_DIR")" == "$SCRIPT_DIR" ]; then
        success "~/.vim is correctly linked."
    else
        error "~/.vim is not linked correctly. Run 'install'."
    fi

    if [ -L "$VIMRC_FILE" ] && [ "$(readlink "$VIMRC_FILE")" == "$VIM_DIR/vimrc" ]; then
        success "~/.vimrc is correctly linked."
    else
        error "~/.vimrc is not linked correctly. Run 'install'."
    fi
    echo ""

    # --- Check Managed Plugins ---
    info "2. Checking Managed Plugins..."
    for plugin_info in "${PLUGINS[@]}"; do
        read -r repo_url dir_name <<< "$plugin_info"
        local plugin_path="$PLUGINS_DIR/$dir_name"

        if [ -d "$plugin_path/.git" ]; then
            local commit=$(cd "$plugin_path" && git rev-parse --short HEAD)
            success "Installed: $dir_name ($commit)"
        else
            warning "Missing:   $dir_name"
        fi
    done
    echo ""

    # --- Check for Unmanaged Plugins ---
    info "3. Checking for Unmanaged Plugins..."
    local found_unmanaged=false
    for dir in "$PLUGINS_DIR"/*/; do
        if [ -d "$dir" ]; then
            local dir_name=$(basename "$dir")
            local is_managed=false
            for plugin_info in "${PLUGINS[@]}"; do
                read -r _ managed_name <<< "$plugin_info"
                if [ "$dir_name" == "$managed_name" ]; then
                    is_managed=true
                    break
                fi
            done
            if [ "$is_managed" == false ]; then
                warning "Unmanaged: $dir_name (Not in manifest)"
                found_unmanaged=true
            fi
        fi
    done

    if [ "$found_unmanaged" == false ]; then
        success "No unmanaged plugins found."
    fi
    echo ""
}

do_uninstall() {
    header "Uninstalling Vim Configuration"
    info "This will remove symlinks and the entire plugins directory."
    warning "Your actual configuration in $SCRIPT_DIR will NOT be deleted."
}
