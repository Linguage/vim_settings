# Keybindings & Usage Guide

This document provides a reference for all the custom keybindings and essential plugin commands in this Vim configuration.

This guide is organized around core workflows first. Personal or learning-oriented mappings are listed separately so they do not get mixed into the main development flow.

## Leader Key

The `Leader` key is a special key used to prefix many custom shortcuts. In this configuration, the `Leader` key is mapped to the **`Space`** bar.

So, when you see `<leader>w`, it means you should press `Space` followed by `w`.

If you want to open the which-key helper menu, use `<leader><leader>`, meaning press `Space` twice.

---

## Global Keybindings

These shortcuts are available globally in Normal mode unless specified otherwise.

### File & Session

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `<leader>w`     | Save the current file (`:w!`)        |
| `<leader>q`     | Close the current window with a save/discard prompt when modified (`:confirm q`) |
| `<leader>Q`     | Force quit all windows (`:qa!`)      |
| `<leader>e`     | Edit your `vimrc` file               |
| `<leader>vim`   | Open the active `vimrc` in a vertical split |
| `<leader>r`     | Reload your `vimrc` file             |
| `<leader>/`     | Clear search highlighting            |
| `<C-p>`         | Open the project-scoped FZF file picker |
| `<leader>fc`    | Open the command palette (`:Commands`) |
| `<leader>fb`    | Open the buffer palette (`:Buffers`) |
| `<leader>fh`    | Open the command history palette (`:History:`) |
| `<leader>fe`    | Pre-fill the `:edit ` command        |
| `<leader>fE`    | Pre-fill `:edit` from the current directory |
| `<leader>fq`    | Close the current window with a save/discard prompt when modified (`:confirm q`) |
| `<leader>fQ`    | Force quit all windows (`:qa!`)      |
| `<leader>fw`    | Save the current file (`:w`)         |
| `<leader>fx`    | Save and quit (`:wq`)                |

These are the highest-value daily entry points and worth memorizing first.

### Window Management

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `<C-h/j/k/l>`   | Navigate to window left/down/up/right|
| `<leader>=`     | Equalize window sizes                |
| `<leader>+`     | Increase window height by 5 lines    |
| `<leader>-`     | Decrease window height by 5 lines    |
| `<leader>>`     | Increase window width by 5 columns   |
| `<leader><`     | Decrease window width by 5 columns   |
| `<C-w>i`        | Go to the next tab                   |
| `<C-w>u`        | Go to the previous tab               |

### Navigation & Editing

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `<leader>j`     | Move down 10 lines                   |
| `<leader>k`     | Move up 10 lines                     |
| `j` / `k`       | Move by screen line in soft-wrapped text |
| `H`             | Go to the start of the line (non-blank)|
| `L`             | Go to the end of the line            |
| `*`             | Search the current word and recenter |
| `<C-d>` / `<C-u>` | Page and keep the cursor area centered |
| `<leader>d`     | Delete the current line              |
| `<leader>a`     | Select all text in the file (`ggVG`) |
| `<leader>y`     | (Visual mode) Yank to system clipboard|
| `<leader>p`     | Paste from system clipboard          |
| `<leader>P`     | Paste before from register `0`       |
| `<leader>pp`    | Paste after from register `0`        |
| `<F2>`          | Pre-fill a substitution using the current word or selection |
| `<M-j>` / `<M-k>` | Move the current line or selection up/down |
| `<leader>ss`    | Sort the current visual selection    |

---

### Search & Quickfix

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `<leader>gg`    | Run `rg` on the current word and open quickfix |
| `<leader>gf`    | Prompt for an `rg` pattern and open quickfix |
| `<leader>co`    | Open the quickfix window             |
| `<leader>cc`    | Close the quickfix window            |
| `<leader>cn`    | Jump to the next quickfix item and recenter |
| `<leader>cp`    | Jump to the previous quickfix item and recenter |
| `]q` / `[q`     | Move forward/backward in quickfix    |

---

## Plugin Keybindings

### NERDTree

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `<C-y>`         | Toggle the NERDTree file explorer    |
| `<leader>n`     | Toggle the NERDTree file explorer    |
| `<leader>nf`    | Find and reveal the current file in NERDTree |
| `<leader>cd`    | Change working directory to the current file and sync NERDTree |
| `<Enter>`       | (In NERDTree) Open selected file in a new tab |

### Git Integration

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `<leader>gs`    | Open Git status                      |
| `<leader>gd`    | Show Git diff for the current file   |
| `<leader>gc`    | Open Git commit                      |
| `<leader>gb`    | Show Git blame                       |
| `<leader>gl`    | Show Git log                         |
| `<leader>gp`    | Run Git push                         |
| `<leader>gr`    | Read the file from Git               |
| `<leader>gw`    | Write the file into the Git index    |
| `<leader>ge`    | Open the current file through Fugitive |

### Markdown Preview

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `<leader>mo`    | Open Markdown preview in the browser |
| `<leader>md`    | Open Markdown preview in the browser |
| `<leader>mp`    | Toggle Markdown preview              |
| `<leader>mc`    | Stop Markdown preview                |

### Insert Mode Keybindings

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `Esc`           | Exit insert mode to normal mode     |
| `<C-c>`         | Exit insert mode to normal mode     |
| `jk` / `kj`     | Quick exit from insert mode         |
| `<C-h/j/k/l>`   | Move cursor left/down/up/right in insert mode |

### Learning & Personal Mappings

| Keybinding      | Action                               |
| --------------- | ------------------------------------ |
| `<leader>ht`    | Launch `vimtutor`                    |
| `<leader>hl`    | Open the Vim learning guide          |
| `<leader>hp`    | Open the Vim practice file           |
| `<leader>hs`    | Open the Vim learning plan           |
| `<leader>hg`    | Open the Vim plugins guide           |
| `<leader>hm`    | Show the current mapping table       |
| `<leader>en`    | Switch to the English input method after enabling the input-method helper |
| `<leader>im`    | Trigger input-method switching manually after enabling the input-method helper |

## Custom Commands

This configuration provides several useful custom commands:

- `:Shell` - Open an embedded terminal when supported, otherwise launch an external terminal
- `:LiveGrep` - Prompt for an `rg` pattern and send results to quickfix
- `:ThemePaperColor` / `:ThemeGruvbox` / `:ThemeMolokai` / `:ThemeSolarized` - Switch color themes

## Tips

1. To see all available keybindings, check `settings/mappings.vim`
2. Use `:map` to inspect the current mapping table
3. To modify any keybinding, edit `settings/mappings.vim`
4. If `:LiveGrep` is unavailable, make sure `rg` is installed
5. File search uses the standard `fzf.vim` project picker; inside a Git repo it prefers Git-tracked files, and outside Git it falls back to regular file search
6. Common Ex workflows can use centered `fzf.vim` panels instead of the bottom command line: `<leader>fc` opens commands, `<leader>fb` opens buffers, and `<leader>fh` opens command history
7. Command matching is tuned to be stricter with exact matching; inside `:Commands`, use `Ctrl-x` or `Alt-Enter` to execute the highlighted command directly
8. High-frequency commands also get direct shortcuts: `<leader>fe`, `<leader>fq`, `<leader>fQ`, `<leader>fw`, and `<leader>fx`
9. Automatic macOS input-method switching is disabled by default; enable it in local config with `let g:vim_settings_enable_input_method_switch = 1`
