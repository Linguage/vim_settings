# My Portable Vim Configuration

[English](README.en.md) | [简体中文](README.zh.md)

This repository contains a personalized, portable Vim setup designed for a modern and efficient workflow. It comes with a powerful management script that allows for one-click installation and easy maintenance across multiple devices.

## Documentation

- [Keybindings Reference](./docs/keybindings.en.md) - Reference for all custom keybindings and plugin commands
- [Changelog](./docs/changelog.en.md) - Version history and updates

## Key Features

- **Modern UI**: Styled with `vim-airline` and `vim-airline-themes` for a beautiful and informative statusline and tabline.
- **Icon Support**: Integrated with `nvim-web-devicons` to provide clean, modern file and folder icons in NERDTree.
- **Enhanced File Navigation**: Uses `preservim/nerdtree` for an intuitive file system explorer.
- **Git Integration**: Leverages `tpope/vim-fugitive` for seamless Git commands from within Vim.
- **Smart Editing**: Includes essential plugins like `vim-surround`, `vim-commentary`, and `auto-pairs` to speed up common editing tasks.
- **Broad Language Support**: Powered by `vim-polyglot` for rich syntax highlighting and indentation for a wide variety of languages.

## Prerequisites

1.  **Git**: Required for cloning plugins. You can check if it's installed by running `git --version`.
2.  **Nerd Font**: A font with patched-in icons is required for the UI to render correctly. We recommend [Hack Nerd Font](https://www.nerdfonts.com/font-downloads) or any other Nerd Font of your choice.

## Installation & Management

This configuration is managed by a simple yet powerful shell script: `vim-manager`.

### Quick Install

To set up this configuration on a new machine, follow these steps:

1.  Clone this repository to a location of your choice:
    ```bash
    git clone <your-repo-url> ~/vim_settings
    ```
2.  Navigate into the directory:
    ```bash
    cd ~/vim_settings
    ```
3.  Make the manager script executable:
    ```bash
    chmod +x vim-manager
    ```
4.  Run the one-click installer:
    ```bash
    ./vim-manager install
    ```

That's it! The script will automatically back up any existing Vim configuration, create the necessary symbolic links, and install all required plugins.

### Available Commands

The `vim-manager` script provides a complete set of commands for easy maintenance:

- **`./vim-manager install`** - One-click setup of configuration and all plugins
- **`./vim-manager update`** - Update all installed plugins to their latest versions
- **`./vim-manager status`** - Check configuration status and plugin health
- **`./vim-manager clean`** - Remove plugins not listed in the manifest
- **`./vim-manager uninstall`** - Complete removal of configuration (source files untouched)
- **`./vim-manager help`** - Display help information

### Modular Architecture (v3.0+)

Starting from v3.0, `vim-manager` features a modular design:

```text
vim-manager (main entry point)
vim_manager_modules/
├── config.sh      # Configuration and plugin manifest
├── helpers.sh     # Utility functions
├── core_logic.sh  # Core business logic
└── commands.sh    # Command handlers
```

This design provides:
- **Better Maintainability**: Each module focuses on specific functionality
- **Clear Code Organization**: Logic separation for easier understanding
- **Easy Extension**: New features can be developed and tested independently

## Included Plugins

| Plugin | Purpose | Description |
|--------|---------|-------------|
| `vim-airline` | Status bar | Beautiful and informative status line |
| `vim-airline-themes` | Status bar themes | Multiple themes for airline |
| `nerdtree` | File explorer | Tree-style file system browser |
| `vim-devicons` | Icon support | Provides icons for files and folders |
| `nvim-web-devicons` | Neovim icons | Neovim-specific icon support |
| `vim-fugitive` | Git integration | Powerful Git command integration |
| `vim-surround` | Surround editing | Quickly add/change/delete surrounding characters |
| `vim-commentary` | Comment toggle | Smart comment/uncomment functionality |
| `vim-polyglot` | Language support | Syntax highlighting for multiple programming languages |
| `auto-pairs` | Auto pairing | Automatic matching of brackets, quotes, etc. |
| `vim-sensible` | Sensible defaults | Provides sensible Vim default settings |

## Configuration Structure

```text
vim_settings/
├── vim-manager          # Management script (main entry)
├── vim_manager_modules/ # Script modules
├── vimrc               # Main configuration file
├── settings/           # Modular configuration
│   ├── basic.vim       # Basic settings
│   ├── ui.vim          # UI settings
│   ├── mappings.vim    # Key mappings
│   ├── plugins.vim     # Plugin loading
│   ├── plugin_configs.vim # Plugin configurations
│   └── colorscheme.vim # Theme configuration
├── colors/             # Color schemes
├── plugins/            # Plugin directory (auto-managed)
└── docs/               # Documentation
```
