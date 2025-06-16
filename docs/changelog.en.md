# Changelog - The `vim-manager` Update

## Date: 2025-06-16

### Overview

This update introduces a significant enhancement to the project: a dedicated configuration management script named `vim-manager`. The primary goal of this update was to solve the challenge of portability, making it simple and fast to replicate this highly customized Vim environment on any machine with a single command.

Previously, setting up the configuration on a new device would require manual steps, including linking files and cloning a list of plugins one by one. This process was time-consuming and prone to errors.

### The Solution: `vim-manager`

The `vim-manager` is a powerful, self-contained shell script that automates the entire lifecycle of the Vim configuration. It acts as the single source of truth for plugin management and setup.

#### Key Capabilities Added:

-   **Plugin Manifest**: A clear list of all required plugins is now defined directly within the script, making it easy to add, remove, or update dependencies.

-   **One-Click Installation (`install`)**: The script handles everything: backing up existing configurations, creating symbolic links for `~/.vim` and `~/.vimrc`, and cloning all plugins from the manifest.

-   **Automated Updates (`update`)**: Keeps all plugins current by automatically pulling the latest changes from their repositories.

-   **Health & Status Check (`status`)**: Provides a quick way to verify that all components are correctly installed and linked, and identifies any plugins that are not part of the official manifest.

-   **Safe Cleanup (`clean` & `uninstall`)**: Offers safe, interactive commands to remove stray plugins or to completely and cleanly uninstall the entire configuration without touching the source files.

This new, scripted approach ensures consistency, reliability, and speed, transforming this personal Vim setup into a truly portable development environment.
