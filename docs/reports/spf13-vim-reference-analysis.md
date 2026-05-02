# spf13-vim 参考借鉴分析

## 最小声明

- `lifecycle`：`reference extension`
- `entrypoint`：阅读本报告，按「建议落地顺序」挑选可迁入项
- `outputs`：本报告；后续若进入实现，优先落点为 `vimrc`、`settings/basic.vim`、`settings/mappings.vim`、`settings/plugin_configs.vim`、`vim_manager_modules/config.sh`、`docs/tutorials/keybindings.md`
- `summary`：spf13-vim 值得借鉴的是可覆盖配置层级、插件分组治理、状态目录集中化、常用 Vim 人体工学映射与少量经典插件；不建议迁入 Vundle、旧补全栈或整套语言插件
- `smoke`：`vim -Nu vimrc -n -es +'qa!'`
- `freeze rule`：当无依赖增强项与高价值插件候选完成取舍后，本报告转为参考；若项目目标变成完整 IDE 分发版，再重新评估插件分组与语言能力

## 本次对照范围

已将 `https://github.com/spf13/spf13-vim` 克隆到临时参考目录：

```text
/tmp/spf13-vim-reference
```

克隆到的最新提交：

```text
1ce5f23997f6dd82235c6936c5c47b3f1d1b4e50
2016-02-13T22:21:45-05:00
Merge pull request #883 from Michaelizm/3.0
```

它是一个经典但明显偏旧的 Vim 分发版，核心文件是：

- `.vimrc.before`：前置开关与用户覆盖入口
- `.vimrc.bundles`：Vundle 插件清单与插件组
- `.vimrc`：主配置、映射、插件配置与辅助函数
- `README.markdown`：插件说明和使用指南

当前仓库已经有模块化结构与自有管理脚本，因此本报告关注“可吸收设计”，不建议直接复制它的安装体系。

## 已经重合的能力

当前配置已经覆盖了 spf13-vim 的不少经典能力：

- NERDTree 文件树
- vim-airline 状态栏
- vim-surround
- auto-pairs
- vim-commentary
- vim-fugitive
- 项目文件查找，当前用 `fzf.vim` 替代 spf13-vim 的 ctrlp
- ripgrep 搜索，当前比 spf13-vim 的 ack/ag 分支更现代
- 持久撤销，当前已经把 undo 放到 `~/.local/state/vim/undo/`
- 自动 `lcd %:p:h`
- 软换行下 `j` / `k` 按屏幕行移动
- `<C-h/j/k/l>` 窗口移动
- `<leader>bg` 背景切换
- Fugitive 的 `<leader>g*` 映射，当前代码里已有，但教程文档还没完全同步

## 最值得吸收的无依赖设计

### 1. 本地覆盖层级

spf13-vim 的最大优点不是某个插件，而是覆盖层级清楚：

- `.vimrc.before.local`：插件和主配置加载前的开关
- `.vimrc.bundles.local`：本机额外插件或禁用插件
- `.vimrc.local`：主配置之后的个人覆盖
- fork 层：给分发版维护者留出团队级覆盖

当前仓库可借鉴为：

- `~/.vimrc.before.local`：早期变量，例如是否关闭自动 `lcd`、是否保留 trailing whitespace
- `~/.vimrc.local`：末尾覆盖，例如个人主题、字体、输入法行为
- 可选的 `settings/local.before.vim` 与 `settings/local.vim`：仓库内但可忽略追踪，方便便携调试

这能减少“为了个人机器改仓库默认配置”的压力。

### 2. 显式功能开关

spf13-vim 用 `g:spf13_no_*` 和 `g:spf13_keep_*` 形式把争议行为做成开关。当前配置中有一些行为是固定打开的：

- 自动切到当前文件目录
- 保存前删除尾随空格
- 全局列表字符显示
- 鼠标启用
- 自动读写

建议引入当前项目自己的命名，例如：

- `g:vim_settings_no_autochdir`
- `g:vim_settings_keep_trailing_whitespace`
- `g:vim_settings_no_restore_cursor`
- `g:vim_settings_no_listchars`

这样默认体验可以继续现代化，但用户能在本地关闭。

### 3. 状态目录集中化

spf13-vim 会集中设置 backup、swap、view、undo 目录，避免临时文件污染项目目录。当前只处理了 undo，并且关闭了 backup/swap。

建议后续考虑：

- `~/.local/state/vim/undo//`
- `~/.local/state/vim/backup//`
- `~/.local/state/vim/swap//`
- `~/.local/state/vim/view//`

如果目录集中化做好，可以重新启用 backup/swap，安全性比完全关闭更好。

### 4. 恢复上次光标位置

spf13-vim 启动文件时会跳回上次编辑位置，并对 git commit message 做特殊处理。当前配置没有这一项。

建议添加一个小型 autocmd：

- 普通文件恢复到上次位置
- `COMMIT_EDITMSG` 从第一行开始
- 提供 `g:vim_settings_no_restore_cursor` 关闭

### 5. 命令行小修正

spf13-vim 提供了一批很实用的 Vim 老派人体工学修正：

- `:W`、`:Q`、`:Wq`、`:Qa` 等大写误输入修正
- `:w!!` 用 sudo 写入当前文件
- 命令行 `%%` 展开为当前文件目录
- `:cwd` / `:cd.` 切到当前文件目录

这些不需要插件，迁入风险低，收益稳定。

### 6. 更细的尾随空格处理

当前 `StripTrailingWhitespace()` 会保留光标位置，但不会恢复搜索寄存器；自动删除也对所有文件生效。

spf13-vim 的函数会保存并恢复 `@/`，这点可以吸收。自动删除则建议从“全局所有文件”改成“默认开启但可关闭”，或至少给特殊文件类型留出口。

### 7. 可视模式缩进后保持选区

spf13-vim 使用：

```vim
vnoremap < <gv
vnoremap > >gv
```

这是非常经典的小增强，建议直接迁入。

### 8. `Y` 与 `D` / `C` 语义对齐

spf13-vim 把 `Y` 设为 `y$`。这符合很多 Vim 用户预期：`D` 删除到行尾，`C` 改到行尾，`Y` 也应复制到行尾。

建议迁入。

### 9. 合并冲突快速定位

spf13-vim 有 `<leader>fc` 查找冲突标记。当前 `<leader>fc` 已被 fzf 命令面板占用，不宜照搬键位。

建议改成：

- `<leader>gc` 不合适，已是 Git commit
- `<leader>gC` 或 `<leader>cx`：查找 `<<<<<<<` / `=======` / `>>>>>>>`

也可以用插件 `conflict-marker.vim`，但第一步先用无依赖映射足够。

## 值得考虑的插件候选

### 1. `vim-repeat`

当前已有 `vim-surround`，但没有 `vim-repeat`。`vim-repeat` 能让许多插件操作更自然地被 `.` 重复，是低成本高收益插件。

建议优先级：高。

### 2. `undotree`

当前已有持久撤销，但没有可视化撤销树。spf13-vim 用 `<leader>u` 打开 Undotree，这对长期写作、重构和配置调整都很有用。

建议优先级：高。

### 3. `vim-signify`

spf13-vim 用 `vim-signify` 提供 Git 变更标记。当前有 Fugitive，但没有轻量级 gutter diff signs。

建议优先级：中高。若引入，需要同步 airline hunks 或 signcolumn 行为。

### 4. `tabular` 或现代替代 `vim-easy-align`

spf13-vim 用 Tabularize 对齐 `=`、`:`、`,`、`|` 等。当前有 CSV 专用能力，但没有通用文本对齐。

建议优先级：中。若选择现代替代，`vim-easy-align` 可能更顺手；若追求经典稳定，`tabular` 足够。

### 5. `conflict-marker.vim`

合并冲突标记高亮、跳转与处理值得补，但可以先用无依赖搜索映射替代。

建议优先级：中。

### 6. `easymotion`

spf13-vim 使用 EasyMotion 提升长距离移动。当前配置已经有较多导航增强，但没有同类能力。

建议优先级：中低。它会占用 `<leader><leader>` 风格按键，而当前 which-key 也使用 `<leader><leader>`，需要谨慎。

### 7. `tagbar`

Tagbar 对基于 ctags 的结构导航有价值，但依赖外部 ctags。当前项目定位偏便携，适合作为可选插件组，不宜默认强依赖。

建议优先级：中低。

## 不建议迁入的内容

### 1. Vundle 插件管理

spf13-vim 用 Vundle 是历史选择。当前仓库已有 `vim-manager` 和固定插件目录，更适合本项目的便携目标。

### 2. ctrlp

当前已有 `fzf.vim` 和 `rg`。ctrlp 曾经经典，但现在没有必要回退。

### 3. ack.vim / ag 优先

当前已经以 `rg` 为主，保留即可。

### 4. neocomplete、neocomplcache、旧 YouCompleteMe 默认栈

这些属于旧时代补全方案，依赖复杂，和当前轻便 Vim 配置目标不匹配。

### 5. Syntastic 作为默认诊断

Syntastic 曾经经典，但默认引入会增加外部 checker 复杂度。若以后做诊断能力，应单独评估 ALE、LSP 或更现代方案。

### 6. 大量语言插件组

spf13-vim 默认含 PHP、Ruby、Python、JavaScript、HTML、Haskell、Scala、Go、Elixir 等语言组。当前项目更适合保持通用 Vim 配置，语言能力应按需作为可选组进入。

## 建议落地顺序

1. 先做无依赖增强

- 本地覆盖加载点
- 功能开关
- 恢复光标位置
- `:W` / `:Q` / `:w!!`
- `%%` 当前目录展开
- 可视缩进保留选区
- `Y -> y$`
- `StripTrailingWhitespace()` 恢复搜索寄存器
- 合并冲突搜索映射

2. 再做插件小增量

- `vim-repeat`
- `undotree`
- `vim-signify`
- `tabular` 或 `vim-easy-align`
- 视情况加入 `conflict-marker.vim`

3. 最后再评估插件组治理

如果插件数量继续增长，再为 `vim-manager` 增加 profile / group 概念，例如：

- `core`
- `search`
- `git`
- `writing`
- `programming`
- `language-extra`

这比一次性把 spf13-vim 的大型插件矩阵搬进来更稳。

## 和 LazyVim 报告的关系

LazyVim 报告给出的重点是“现代入口一致性”：`<leader>f*`、which-key、搜索体验。

spf13-vim 报告给出的重点是“经典 Vim 分发版治理”：本地覆盖、开关、状态目录、低依赖编辑增强、经典小插件。

两者可以合并成一条路线：

- LazyVim 负责启发现代工作流入口
- spf13-vim 负责补上 Vim 分发版的长期维护经验

## 结论

spf13-vim 不适合被整套迁入，但非常适合作为“老派 Vim 配置成熟度清单”。当前仓库最该吸收的是：本地覆盖层级、可关闭的默认行为、集中状态目录、恢复光标位置、命令行人体工学、`vim-repeat` 与 `undotree`。这些改动既符合当前便携式 Vim 配置定位，也不会把项目拖向过重的 IDE 分发版。
