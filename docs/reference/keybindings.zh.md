---
title: "快捷键与使用指南"
date: 2026-03-13
created: 2026-03-13
category: "reference"
tags: ["vim", "快捷键", "指南", "参考"]
---

# 快捷键与使用指南

本文档提供了本 Vim 配置中所有自定义快捷键和重要插件命令的参考。

本文档按“核心工作流优先”的原则组织。学习用途或个人习惯类映射会单独列出，避免和高频开发映射混在一起。

## 前置键 (Leader Key)

`Leader` 键是一个特殊的前缀键，用于触发自定义快捷键。在本配置中，`Leader` 键被映射为 **`空格`** 键。

所以，当你看到 `<leader>w` 这样的快捷键时，意味着你需要先按 `空格` 键，然后再按 `w` 键。

如果想查看 which-key 提示菜单，现在使用 `<leader><leader>`，也就是连按两次 `空格`。

---

## 全局快捷键

以下快捷键在普通模式下可用，除非另有说明。

### 文件与会话

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `<leader>w`     | 保存当前文件 (`:w!`)              |
| `<leader>q`     | 关闭当前窗口，未保存时弹出确认 (`:confirm q`) |
| `<leader>Q`     | 强制关闭所有窗口 (`:qa!`)          |
| `<leader>e`     | 编辑 `vimrc` 文件                  |
| `<leader>vim`   | 垂直分屏打开当前默认 `vimrc`       |
| `<leader>r`     | 重新加载 `vimrc` 文件              |
| `<leader>/`     | 清除搜索高亮                      |
| `<C-p>`         | 打开项目级 FZF 文件选择器         |
| `<leader>fc`    | 打开命令面板 (`:Commands`)        |
| `<leader>fb`    | 打开缓冲区面板 (`:Buffers`)       |
| `<leader>fh`    | 打开命令历史面板 (`:History:`)    |
| `<leader>fe`    | 预填充 `:edit ` 命令              |
| `<leader>fE`    | 预填充当前目录下的 `:edit` 命令   |
| `<leader>fq`    | 关闭当前窗口，未保存时弹出确认 (`:confirm q`) |
| `<leader>fQ`    | 强制关闭全部窗口 (`:qa!`)         |
| `<leader>fw`    | 保存当前文件 (`:w`)               |
| `<leader>fx`    | 保存并退出 (`:wq`)                |

这组映射属于最核心的日常入口，建议优先记忆。

### 窗口管理

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `<C-h/j/k/l>`   | 切换到左/下/上/右侧的窗口         |
| `<leader>=`     | 均衡所有窗口大小                  |
| `<leader>+`     | 增加窗口高度（5行）               |
| `<leader>-`     | 减少窗口高度（5行）               |
| `<leader>>`     | 增加窗口宽度（5列）               |
| `<leader><`     | 减少窗口宽度（5列）               |
| `<C-w>i`        | 切换到下一个标签页                |
| `<C-w>u`        | 切换到上一个标签页                |

### 导航与编辑

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `<leader>j`     | 向下移动10行                      |
| `<leader>k`     | 向上移动10行                      |
| `j` / `k`       | 在软换行文本中按屏幕行移动         |
| `H`             | 移动到行首（非空白字符）           |
| `L`             | 移动到行尾                        |
| `*`             | 搜索当前单词并将命中居中           |
| `<C-d>` / `<C-u>` | 翻页后保持光标区域居中           |
| `<leader>d`     | 删除当前行                        |
| `<leader>a`     | 全选当前文件内容 (`ggVG`)          |
| `<leader>y`     | （可视模式）复制到系统剪贴板      |
| `<leader>p`     | 从系统剪贴板粘贴                  |
| `<leader>P`     | 从 0 号寄存器向前粘贴             |
| `<leader>pp`    | 从 0 号寄存器向后粘贴             |
| `<F2>`          | 以当前单词预填充全局替换命令       |
| `<M-j>` / `<M-k>` | 上下移动当前行或选区            |
| `<leader>ss`    | 对当前选区内容排序                |

---

### 搜索与 quickfix

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `<leader>gg`    | 用当前单词执行 `rg` 搜索并打开 quickfix |
| `<leader>gf`    | 输入模式执行 `rg` 搜索并打开 quickfix |
| `<leader>co`    | 打开 quickfix 窗口                |
| `<leader>cc`    | 关闭 quickfix 窗口                |
| `<leader>cn`    | 跳到下一条 quickfix 结果并居中     |
| `<leader>cp`    | 跳到上一条 quickfix 结果并居中     |
| `]q` / `[q`     | 在 quickfix 结果中前后跳转         |

---

## 插件快捷键

### NERDTree 文件浏览器

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `<C-y>`         | 切换 NERDTree 文件浏览器          |
| `<leader>n`     | 切换 NERDTree 文件浏览器          |
| `<leader>nf`    | 在 NERDTree 中定位并显示当前文件  |
| `<leader>cd`    | 切换工作目录到当前文件并同步 NERDTree |
| `<Enter>`       | （在 NERDTree 中）在新标签页打开选中的文件 |

### Git 集成

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `<leader>gs`    | 打开 Git 状态                     |
| `<leader>gd`    | 查看当前文件 Git diff             |
| `<leader>gc`    | 打开 Git commit                   |
| `<leader>gb`    | 查看 Git blame                    |
| `<leader>gl`    | 查看 Git log                      |
| `<leader>gp`    | 执行 Git push                     |
| `<leader>gr`    | 从 Git 读取版本                   |
| `<leader>gw`    | 将当前文件写入 Git 索引           |
| `<leader>ge`    | 用 Fugitive 打开当前文件          |

### Markdown 预览

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `<leader>mo`    | 打开 Markdown 浏览器预览          |
| `<leader>md`    | 打开 Markdown 浏览器预览          |
| `<leader>mp`    | 切换 Markdown 预览开关            |
| `<leader>mc`    | 关闭 Markdown 预览                |

### CSV 工作流

`csv.vim` 没有占用新的全局快捷键，但在打开 `csv` / `tsv` 文件后会自动按列排列，并高亮当前列。
为了避免卡顿，这个自动排列只对不超过 2 MB 的文件启用。

常用命令：
- `:CSVTable`：按表格方式查看当前 CSV
- `:%ArrangeColumn`：手动将整个文件按列排列
- `:CSVSort`：按列排序
- `:WhatColumn`：查看光标当前所在列

### 插入模式快捷键

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `Esc`           | 退出插入模式返回普通模式          |
| `<C-c>`         | 退出插入模式返回普通模式          |
| `jk` / `kj`     | 快速退出插入模式返回普通模式      |
| `<C-h/j/k/l>`   | 在插入模式下移动光标（左/下/上/右）|

### 学习与个人映射

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `<leader>ht`    | 启动 `vimtutor`                    |
| `<leader>hl`    | 打开 Vim 学习指南                  |
| `<leader>hp`    | 打开 Vim 练习文件                  |
| `<leader>hs`    | 打开 Vim 学习计划                  |
| `<leader>hg`    | 打开 Vim 插件指南                  |
| `<leader>hm`    | 输出当前映射列表                   |
| `<leader>t` / `<leader>th` | 打开主题选择菜单            |
| `<leader>en`    | 手动切换到英文输入法，仅在启用输入法切换功能后可用 |
| `<leader>im`    | 手动触发输入法切换，仅在启用输入法切换功能后可用 |

## 自定义命令

本配置还提供了一些有用的自定义命令：

- `:Shell` - 在支持时打开内置终端，否则打开外部终端
- `:LiveGrep` - 输入 ripgrep 搜索模式并将结果送入 quickfix
- `:ThemePaperColor` / `:ThemeGruvbox` / `:ThemeMolokai` / `:ThemeSolarized` - 切换主题

## 提示

1. 要查看所有可用的快捷键，可以查看 `settings/mappings.vim` 文件
2. 使用 `:map` 命令可以查看当前所有映射
3. 要修改任何快捷键，请编辑 `settings/mappings.vim` 文件
4. 如果 `:LiveGrep` 不可用，请先确认系统中已安装 `rg`
5. 文件查找默认使用 `fzf.vim` 的标准项目选择器；在 Git 仓库中优先列出 Git 跟踪文件，非 Git 目录则回退到普通文件查找
6. 常用 Ex 命令可通过居中的 `fzf.vim` 面板替代底部命令行：`<leader>fc` 打开命令面板，`<leader>fb` 打开缓冲区面板，`<leader>fh` 打开命令历史
7. 命令面板匹配已调成更收敛的精确匹配；若想直接执行命令，可在 `:Commands` 面板里使用 `Ctrl-x` 或 `Alt-Enter`
8. 对高频命令额外提供了直达键：`<leader>fe`、`<leader>fq`、`<leader>fQ`、`<leader>fw`、`<leader>fx`
9. macOS 输入法自动切换默认关闭；如需启用，请在本地配置中设置 `let g:vim_settings_enable_input_method_switch = 1`
10. CSV 文件现在由 `csv.vim` 增强处理；如果要重新安装该插件，可运行 `./vim-manager install` 或 `./vim-manager update`
