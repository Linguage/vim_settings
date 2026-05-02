# 本地覆盖配置指南

本项目默认配置追求开箱即用，但有些行为很适合按机器或个人习惯调整。为了避免把私人偏好写进仓库，可以使用两个本机私有文件：

- `~/.vimrc.before.local`：在项目默认配置前加载，适合设置开关变量。
- `~/.vimrc.local`：在项目默认配置后加载，适合覆盖主题、字体和个人快捷键。

这两个文件不由仓库管理，也不会被 `vim-manager` 覆盖。

## 常用前置开关

如果想关闭自动切换到当前文件目录，在 `~/.vimrc.before.local` 中写入：

```vim
let g:vim_settings_no_autochdir = 1
```

如果想保存时保留尾随空格：

```vim
let g:vim_settings_keep_trailing_whitespace = 1
```

如果不想恢复上次编辑位置：

```vim
let g:vim_settings_no_restore_cursor = 1
```

如果不想显示制表符、行尾、尾随空格等不可见字符：

```vim
let g:vim_settings_no_listchars = 1
```

macOS 下如果确实需要退出插入模式时自动切回英文输入法：

```vim
let g:vim_settings_enable_input_method_switch = 1
```

## 启用 swapfile

项目默认准备了 `~/.local/state/vim/swap/`，但仍关闭 swapfile，避免频繁出现恢复提示。如果你更看重异常退出后的恢复能力，可以在 `~/.vimrc.local` 中启用：

```vim
set swapfile
```

## 覆盖主题

如果想默认使用浅色主题：

```vim
colorscheme PaperColor
set background=light
```

如果想继续使用深色主题，但换成 Molokai：

```vim
colorscheme molokai
set background=dark
```

## 覆盖字体

GUI Vim 或 MacVim 用户可在 `~/.vimrc.local` 中设置字体：

```vim
if has('gui_macvim')
    set guifont=Hack\ Nerd\ Font\ Mono:h14
endif
```

## 添加个人快捷键

个人映射建议放在 `~/.vimrc.local`，这样可以覆盖项目默认映射：

```vim
nnoremap <leader>ev :edit ~/.vimrc.local<CR>
nnoremap <leader>eb :edit ~/.vimrc.before.local<CR>
```

如果某个默认映射不适合你，也可以在这里重绑：

```vim
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>vc :edit $MYVIMRC<CR>
```

## 插件 profile

`vim-manager` 支持按 profile 安装、更新和查看插件：

```bash
./vim-manager install --profile minimal
./vim-manager status --profile default
./vim-manager update --profile full
```

当前 profile 含义：

- `minimal`：基础编辑与检索插件。
- `default`：完整托管插件清单，也是默认值。
- `full`：目前等同 `default`，预留给未来 optional 插件。

`clean` 会始终以完整托管清单作为保护范围，因此切到 `minimal` 不会把已安装的完整插件误判为未管理插件。
