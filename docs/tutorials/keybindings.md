
# 快捷键与使用指南

本文档提供了本 Vim 配置中所有自定义快捷键和重要插件命令的参考。

本文档按“核心工作流优先”的原则组织。学习用途或个人习惯类映射会单独列出，避免和高频开发映射混在一起。

## 前置键 (Leader Key)

`Leader` 键是一个特殊的前缀键，用于触发自定义快捷键。在本配置中，`Leader` 键被映射为 **`空格`** 键。

所以，当你看到 `<leader>w` 这样的快捷键时，意味着你需要先按 `空格` 键，然后再按 `w` 键。

如果想查看 which-key 提示菜单，现在使用 `<leader><leader>`，也就是连按两次 `空格`。


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
| `<leader>ff`    | 打开项目级 FZF 文件选择器         |
| `<leader>fc`    | 打开命令面板 (`:Commands`)        |
| `<leader>fb`    | 打开缓冲区面板 (`:Buffers`)       |
| `<leader>fh`    | 打开命令历史面板 (`:History:`)    |
| `<leader>fr`    | 打开文件历史面板 (`:History`)     |
| `<leader>fm`    | 打开标记面板 (`:Marks`)           |
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
| `Y`             | 复制到行尾 (`y$`)                 |
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
| `<` / `>`       | （可视模式）缩进后保持选区        |
| `ga`            | 启动 `vim-easy-align` 交互对齐    |


### 搜索与 quickfix

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `<leader>gg`    | 用当前单词执行 `rg` 搜索并打开 quickfix |
| `<leader>gf`    | 输入模式执行 `rg` 搜索并打开 quickfix |
| `<leader>fg`    | 打开 `fzf.vim` 的 `:Rg` 交互搜索  |
| `<leader>gC`    | 查找合并冲突标记                  |
| `<leader>co`    | 打开 quickfix 窗口                |
| `<leader>cc`    | 关闭 quickfix 窗口                |
| `<leader>cn`    | 跳到下一条 quickfix 结果并居中     |
| `<leader>cp`    | 跳到上一条 quickfix 结果并居中     |
| `]q` / `[q`     | 在 quickfix 结果中前后跳转         |

### LSP、诊断与格式化

默认 profile 安装 `vim-lsp`、`vim-lsp-settings`、`asyncomplete` 与 `ALE` 后，以下快捷键在支持 LSP 的 buffer 中可用。

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `gd`            | 跳转到定义                         |
| `gr`            | 查找引用                           |
| `gi`            | 跳转到实现                         |
| `gt`            | 跳转到类型定义                     |
| `K`             | 查看悬浮文档                       |
| `[d` / `]d`     | 跳到上一条 / 下一条诊断            |
| `<leader>lr`    | 重命名符号                         |
| `<leader>la`    | 执行 code action                   |
| `<leader>lf`    | 格式化当前 buffer                  |
| `<leader>lo`    | 查看当前文档符号 / outline         |
| `<leader>ls`    | 搜索工作区符号                     |

插入模式下：

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `<Tab>`         | 补全菜单中选择下一项；无菜单时输入 Tab |
| `<S-Tab>`       | 补全菜单中选择上一项               |
| `<C-Space>`     | 强制刷新异步补全                   |
| `<CR>`          | 补全菜单打开时确认当前项           |

常用命令：

- `:CodeFormat`：优先使用 LSP 格式化；无 LSP 格式化时回退到 ALE fix。
- `:LspStatus`：查看 LSP 客户端状态。
- `:ALEInfo`：查看 ALE 对当前 buffer 的诊断、linter 与 fixer 信息。


## 插件快捷键

### NERDTree 文件浏览器

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `<C-y>`         | 切换 NERDTree 文件浏览器          |
| `<leader>ee`    | 切换 NERDTree 文件浏览器          |
| `<leader>n`     | 切换 NERDTree 文件浏览器          |
| `<leader>nf`    | 在 NERDTree 中定位并显示当前文件  |
| `<leader>ef`    | 在 NERDTree 中定位并显示当前文件  |
| `<leader>cd`    | 切换工作目录到当前文件并同步 NERDTree |
| `<Enter>`       | （在 NERDTree 中）在新标签页打开选中的文件 |

NERDTree 内部常用操作：

- `m`：打开文件系统操作菜单
- `a`：新增文件或目录
- `d`：删除节点
- `r`：重命名节点
- `c`：复制节点
- `p`：粘贴节点
- `u`：返回上一级目录
- `C`：将当前目录设为文件树根目录

### Git（vim-fugitive）

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `<leader>gs`    | 打开 Git 状态 (`:Gstatus`)         |
| `<leader>gd`    | 查看当前文件 diff (`:Gdiff`)       |
| `<leader>gD`    | 打开 Fugitive diffsplit (`:Gdiffsplit`) |
| `<leader>gc`    | Git commit (`:Gcommit`)            |
| `<leader>gb`    | Git blame (`:Gblame`)              |
| `<leader>gl`    | Git log (`:Glog`)                  |
| `<leader>gi`    | 对当前文件执行交互式暂存 (`:Git add -p %`) |
| `<leader>gp`    | Git push (`:Git push`)             |
| `<leader>gr`    | 从 Git 读取当前文件 (`:Gread`)     |
| `<leader>gw`    | 写入 Git 索引 (`:Gwrite`)          |
| `<leader>ge`    | Git edit (`:Gedit`)                |
| `<leader>gS`    | 切换 `vim-signify` Git 变更标记    |
| `]h` / `[h`     | 跳到下一个 / 上一个 Git hunk       |

也可在命令行使用 `:Git`、`:G`、`:Gdiffsplit` 等 Fugitive 命令（见 `:help fugitive`）。

### 撤销树

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `<leader>u`     | 切换 Undotree，并自动聚焦撤销树窗口 |

### Markdown 预览

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `<leader>mo`    | 打开 Markdown 浏览器预览          |
| `<leader>md`    | 打开 Markdown 浏览器预览          |
| `<leader>mp`    | 切换 Markdown 预览开关            |
| `<leader>mc`    | 关闭 Markdown 预览                |

### 测试工作流

默认使用 `vim-test` 与 Vim 内置 `:terminal` 运行测试。

| 快捷键          | 功能                               |
| --------------- | ---------------------------------- |
| `<leader>tt`    | 运行光标附近的测试                 |
| `<leader>tf`    | 运行当前文件测试                   |
| `<leader>tn`    | 重新运行最近一次测试               |
| `<leader>tv`    | 跳转到测试文件                     |

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
- `:CodeFormat` - 格式化当前 buffer
- `:ThemePaperColor` / `:ThemeGruvbox` / `:ThemeMolokai` / `:ThemeSolarized` - 切换主题
- `:W` / `:Q` / `:Wq` / `:QA` - 修正常见大写误输入命令
- `:w!!` - 通过 `sudo tee` 写入当前文件
- `:cwd` / `:cd.` - 切换本地工作目录到当前文件所在目录

命令行中输入 `%%` 会展开为当前文件所在目录，便于快速补全同目录路径。

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
11. 本机私有覆盖可写入 `~/.vimrc.before.local` 与 `~/.vimrc.local`；常用开关包括 `g:vim_settings_no_autochdir`、`g:vim_settings_keep_trailing_whitespace`、`g:vim_settings_no_restore_cursor`、`g:vim_settings_no_listchars`
12. 如需关闭默认 IDE 层，可在 `~/.vimrc.before.local` 中设置 `let g:vim_settings_no_ide = 1`
