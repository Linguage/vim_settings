# Keybindings & Usage Guide

This document provides a reference for all the custom keybindings and essential plugin commands in this Vim configuration.

## Leader Key

The `Leader` key is a special key used to prefix many custom shortcuts. In this configuration, the `Leader` key is mapped to the **`Space`** bar.

So, when you see `<leader>w`, it means you should press `Space` followed by `w`.

---

## Global Keybindings

These shortcuts are available globally in Normal mode unless specified otherwise.

### File & Session

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `<leader>w`     | Save the current file (`:w!`)        |
| `<leader>q`     | Close the current window (`:q`)      |
| `<leader>Q`     | Force quit all windows (`:qa!`)      |
| `<leader>e`     | Edit your `vimrc` file               |
| `<leader>r`     | Reload your `vimrc` file             |
| `<leader>/`     | Clear search highlighting            |

### Window Management

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `<C-h/j/k/l>`   | Navigate to window left/down/up/right|
| `<leader>=`     | Equalize window sizes                |
| `<leader>+`     | Increase window height by 5 lines    |
| `<leader>-`     | Decrease window height by 5 lines    |
| `<leader>>`     | Increase window width by 5 columns   |
| `<leader><`     | Decrease window width by 5 columns   |

### Navigation & Editing

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `<leader>j`     | Move down 10 lines                   |
| `<leader>k`     | Move up 10 lines                     |
| `H`             | Go to the start of the line (non-blank)|
| `L`             | Go to the end of the line            |
| `<leader>d`     | Delete the current line              |
| `<leader>a`     | Select all text in the file (`ggVG`) |
| `<leader>y`     | (Visual mode) Yank to system clipboard|
| `<leader>p`     | Paste from system clipboard          |

---

## Plugin Keybindings

### NERDTree

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `<leader>n`     | Toggle the NERDTree file explorer    |
| `<leader>f`     | Find and reveal the current file in NERDTree |
| `<Enter>`       | (In NERDTree) Open selected file in a new tab |

### GitHub Copilot AI Assistant

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `<C-g>`         | (Insert mode) Accept Copilot suggestion |
| `<C-]>`         | (Insert mode) Next suggestion        |
| `<C-[>`         | (Insert mode) Previous suggestion    |
| `<C-\>`         | (Insert mode) Dismiss suggestion     |

### Insert Mode Keybindings

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `Esc`           | Exit insert mode to normal mode     |
| `<C-c>`         | Exit insert mode to normal mode     |
| `jk` / `kj`     | Quick exit from insert mode         |
| `<C-h/j/k/l>`   | Move cursor left/down/up/right in insert mode |

## Custom Commands

This configuration provides several useful custom commands:

- `:Copilot setup` - Set up GitHub Copilot authentication
- `:Copilot status` - Check Copilot status
- `:Copilot enable` - Enable Copilot
- `:Copilot disable` - Disable Copilot
- `:Format` - Format the current file (if supported)
- `:W` - Save file with root privileges
- `:Q` - Quit current window
- `:Wq` or `:X` - Save and quit

## Tips

1. GitHub Copilot requires an active GitHub Copilot subscription
2. Run `:Copilot setup` for initial authentication when first using Copilot
3. To see all available keybindings, check the `mappings.vim` file
4. Use `:map` command to see all current mappings
5. To modify any keybinding, edit the `settings/mappings.vim` file
