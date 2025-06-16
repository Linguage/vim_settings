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
