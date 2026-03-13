# My Portable Vim Configuration

[English](README.en.md) | [简体中文](README.zh.md)

This repository contains a personalized, portable Vim setup designed for a modern and efficient workflow. It comes with a powerful management script that allows for one-click installation and easy maintenance across multiple devices.

The recommended setup is to symlink your home `.vim` directory to this repository and let your home `.vimrc` point to `vimrc` in this directory. That keeps the real, active Vim configuration under versioned workspace management.

## Core Workflows

The current configuration is optimized around a few high-frequency workflows:

- **Project navigation**: use `<C-p>` with `:find`, `<C-y>` / `<leader>n` to toggle the file tree, and `<leader>f` to reveal the current file in NERDTree.
- **Search and jump**: `<leader>gg` and `:LiveGrep` send `rg` results into quickfix, then `<leader>co`, `<leader>cn`, `<leader>cp`, `[q`, and `]q` drive result navigation.
- **Editing flow**: soft-wrapped movement follows screen lines, paging recenters automatically, `<F2>` pre-fills substitution commands, and `<M-j>` / `<M-k>` move the current line or selection.
- **Git workflow**: `vim-fugitive` provides direct status, diff, blame, log, push, read, and write entry points.
- **Markdown preview**: Markdown files can be previewed directly in the browser.
- **macOS compatibility**: terminal Esc handling is tightened on macOS, and input-method switching is enabled only when `osascript` is available.

## Optional Dependencies

Not every feature requires extra system tools, but these dependencies materially affect the experience:

- **`rg`**: required for `:LiveGrep` and `<leader>gg` project-wide search. Without it, the search workflow degrades.
- **Nerd Font**: required for correct statusline and file-tree icon rendering.
- **Vim with `+clipboard`**: needed for smooth system clipboard integration.
- **macOS `osascript`**: the input-method switching logic currently depends on AppleScript and is macOS-specific.
- **Terminal Vim**: on macOS the configuration applies a shorter `ttimeoutlen` to improve Esc and Alt-key responsiveness.

## Personal And Learning Mappings

The configuration also includes a smaller set of mappings that are more personal than foundational, for example:

- `jk` / `kj` to leave Insert mode
- `H` / `L` for line start and end
- always showing mode information
- shortcuts for `vimtutor`, learning notes, and practice files

If you want to keep simplifying the setup later, these personal or learning-oriented mappings are the safest place to trim first.

## Documentation

- [Keybindings Reference](./docs/reference/keybindings.en.md) - Reference for all custom keybindings and plugin commands
- [Changelog](./docs/history/changelog.en.md) - Version history and updates
- [Historical Summary](./docs/history/update-summary.md) - Notes from the earlier refactor and documentation pass
- [Manager Plan](./docs/plans/vim-manager-device-plan.md) - Cleanup and evolution plan for `vim-manager`
- [Legacy Notes](./docs/legacy/vim-manager-docs.md) - Older script analysis kept for reference

## Key Features

- **Modern UI**: Styled with `vim-airline` and `vim-airline-themes` for a beautiful and informative statusline and tabline.
- **Icon Support**: Integrated with `vim-devicons` to provide clean, modern file and folder icons in NERDTree.
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
- **`./vim-manager status`** - Check symlinks, managed plugins, and unmanaged plugin directories
- **`./vim-manager clean`** - Remove plugin directories not listed in the manifest
- **`./vim-manager uninstall`** - Remove symlinks created by the manager without deleting the repository
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

Auxiliary maintenance scripts are now collected under `scripts/`. The remaining helper script is `scripts/cleanup.sh`, which cleans temporary files and empty directories under the project root.

## Included Plugins

| Plugin | Purpose | Description |
|--------|---------|-------------|
| `vim-airline` | Status bar | Beautiful and informative status line |
| `vim-airline-themes` | Status bar themes | Multiple themes for airline |
| `nerdtree` | File explorer | Tree-style file system browser |
| `vim-devicons` | Icon support | Provides icons for files and folders |
| `vim-fugitive` | Git integration | Powerful Git command integration |
| `vim-surround` | Surround editing | Quickly add/change/delete surrounding characters |
| `vim-commentary` | Comment toggle | Smart comment/uncomment functionality |
| `vim-polyglot` | Language support | Syntax highlighting for multiple programming languages |
| `auto-pairs` | Auto pairing | Automatic matching of brackets, quotes, etc. |
| `vim-sensible` | Sensible defaults | Provides sensible Vim default settings |
| `markdown-preview.nvim` | Markdown preview | Preview Markdown in a browser |
| `vim-which-key` | Key hinting | Shows available Leader key groups and commands |

## Configuration Structure

```text
vim_settings/
├── vim-manager          # Management script (main entry)
├── vim_manager_modules/ # Script modules
├── scripts/             # Auxiliary maintenance scripts
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
    ├── reference/      # Active references such as keybindings
    ├── history/        # Changelogs and historical summaries
    ├── plans/          # Planning documents
    ├── legacy/         # Outdated but preserved reference docs
    └── notes/          # Personal notes and writing experiments
```

## Notes On Legacy Plugin Directories

If `./vim-manager status` reports entries such as `all-the-icons` or `nvim-web-devicons` as unmanaged, they are leftover directories from an older plugin set. They are no longer required by the current Vim configuration and can be removed with `./vim-manager clean`.
