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
    echo "  copilot      Setup and manage GitHub Copilot."
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
    
    # Check Copilot requirements
    check_copilot_requirements
    
    link_config
    install_plugins
    setup_copilot
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
    
    # --- Check GitHub Copilot ---
    info "4. Checking GitHub Copilot Status..."
    local copilot_path="$PLUGINS_DIR/copilot.vim"
    if [ -d "$copilot_path" ]; then
        success "GitHub Copilot plugin is installed."
        
        # Check Node.js
        if command -v node >/dev/null 2>&1; then
            local node_version=$(node --version)
            success "Node.js available: $node_version"
        else
            warning "Node.js not found (required for Copilot)"
        fi
        
        # Check Vim version
        if command -v vim >/dev/null 2>&1; then
            local vim_version=$(vim --version | head -1 | grep -o 'IMproved [0-9]\+\.[0-9]\+' | grep -o '[0-9]\+\.[0-9]\+')
            if [ -n "$vim_version" ]; then
                success "Vim version: $vim_version"
                local major=$(echo "$vim_version" | cut -d. -f1)
                if [ "$major" -ge 9 ]; then
                    success "Vim version meets Copilot requirements"
                else
                    warning "Vim version may be too old for Copilot (requires 9.0.0185+)"
                fi
            fi
        fi
        
        info "Run './vim-manager copilot' for Copilot management options."
    else
        warning "GitHub Copilot plugin not found."
        info "Run './vim-manager install' to install all plugins."
    fi
}

do_uninstall() {
    header "Uninstalling Vim Configuration"
    info "This will remove symlinks and the entire plugins directory."
    warning "Your actual configuration in $SCRIPT_DIR will NOT be deleted."
    echo ""
    read -p "Are you absolutely sure you want to uninstall? [y/N] " response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        info "Uninstallation cancelled."
        exit 0
    fi

    # --- Remove Symlinks ---
    info "Removing symlinks..."
    rm -f "$HOME/.vimrc" "$HOME/.gvimrc"
    if [ -L "$HOME/.vim" ]; then
        rm "$HOME/.vim"
    fi
    success "Symlinks removed."

    # --- Remove Plugins Directory ---
    info "Removing plugins directory..."
    if [ -d "$PLUGINS_DIR" ]; then
        rm -rf "$PLUGINS_DIR"
        success "Plugins directory removed."
    else
        info "Plugins directory not found, skipping."
    fi

    success "Uninstallation complete."
}

do_copilot() {
    header "GitHub Copilot Management"
    
    # Check if copilot.vim is installed
    local copilot_path="$PLUGINS_DIR/copilot.vim"
    if [ ! -d "$copilot_path" ]; then
        error "GitHub Copilot plugin not found."
        info "Run './vim-manager install' to install all plugins including Copilot."
        exit 1
    fi
    
    # Check requirements
    if ! check_copilot_requirements; then
        exit 1
    fi
    
    echo ""
    info "GitHub Copilot Plugin Status: ${GREEN}Installed${NC}"
    echo ""
    
    echo "Available actions:"
    echo "  ${BLUE}1${NC} - Setup Copilot authentication"
    echo "  ${BLUE}2${NC} - Check Copilot status"
    echo "  ${BLUE}3${NC} - View Copilot keybindings"
    echo "  ${BLUE}4${NC} - Open Copilot documentation"
    echo "  ${BLUE}q${NC} - Quit"
    echo ""
    
    while true; do
        read -p "Choose an action [1-4/q]: " choice
        case $choice in
            1)
                info "Starting Vim for Copilot setup..."
                echo ""
                echo "In Vim, run: ${BLUE}:Copilot setup${NC}"
                echo "Follow the authentication instructions."
                echo "Press any key to open Vim..."
                read -n 1
                vim -c "echo 'Run :Copilot setup to authenticate'" -c "echo 'Press any key to continue...'" -c "call getchar()"
                ;;
            2)
                info "Starting Vim to check Copilot status..."
                vim -c "Copilot status" -c "echo 'Press any key to exit...'" -c "call getchar()" -c "quit"
                ;;
            3)
                info "GitHub Copilot Keybindings:"
                echo ""
                echo "  ${BLUE}Ctrl+G${NC}     - Accept suggestion"
                echo "  ${BLUE}Ctrl+]${NC}     - Next suggestion"
                echo "  ${BLUE}Ctrl+[${NC}     - Previous suggestion"
                echo "  ${BLUE}Ctrl+\\${NC}     - Dismiss suggestion"
                echo ""
                echo "Exit insert mode:"
                echo "  ${BLUE}ESC${NC}        - Standard exit"
                echo "  ${BLUE}jk${NC} or ${BLUE}kj${NC}   - Quick exit"
                echo ""
                ;;
            4)
                info "Opening Copilot documentation..."
                if command -v open >/dev/null 2>&1; then
                    open "https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-in-your-ide"
                elif command -v xdg-open >/dev/null 2>&1; then
                    xdg-open "https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-in-your-ide"
                else
                    echo "Please visit: https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-in-your-ide"
                fi
                ;;
            q|Q)
                info "Exiting Copilot management."
                break
                ;;
            *)
                warning "Invalid choice. Please try again."
                ;;
        esac
        echo ""
    done
}
