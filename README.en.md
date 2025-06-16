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

The `vim-manager` script provides a full suite of commands for easy maintenance:

-   `./vim-manager install`
    Installs the configuration, links files, and clones all plugins from the manifest.

-   `./vim-manager update`
    Pulls the latest updates for all installed plugins.

-   `./vim-manager status`
    Checks the status of symlinks and lists all managed and unmanaged plugins.

-   `./vim-manager clean`
    Removes any plugins found in the `plugins/` directory that are not listed in the manifest. A confirmation prompt is shown before deleting.

-   `./vim-manager uninstall`
    Safely removes all symlinks and the entire `plugins/` directory. Your source configuration files are not touched.

-   `./vim-manager help`
    Displays the help message with all available commands.
