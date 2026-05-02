# LazyVim 参考借鉴分析

## 最小声明

- `lifecycle`：`reference extension`
- `entrypoint`：阅读本报告，按「建议落地顺序」逐步迁移
- `outputs`：本报告；后续若进入实现，落点优先为 `settings/mappings.vim`、`settings/plugin_configs.vim`、`docs/tutorials/keybindings.md`
- `summary`：LazyVim 的价值主要在工作流组织、按键命名、发现式菜单与项目检索体验，不适合把 Neovim/Lua 插件体系直接搬入当前 Vim 配置
- `smoke`：`vim -Nu vimrc -n -es +'qa!'`
- `freeze rule`：当 `<leader>f*`、文件树、检索、Git 与 which-key 分组稳定后，本报告转为参考；若项目转向 Neovim，再重新评估 LazyVim 插件体系

## 本次对照范围

当前仓库是传统 Vim 配置：

- `vimrc` 负责设置 leader 并按顺序加载 `settings/`
- `settings/basic.vim` 管基础选项、搜索、quickfix、命令
- `settings/mappings.vim` 管快捷键
- `settings/plugins.vim` 与 `vim_manager_modules/config.sh` 管插件清单
- `settings/plugin_configs.vim` 管 NERDTree、fzf.vim、Markdown Preview、which-key 等插件行为

本机未发现真实的 `~/.config/nvim` 或 LazyVim 配置目录；可参考材料是两篇本地 LazyVim 笔记：

- `LazyVim入门教程.md`
- `LazyVim的文件操作.md`

因此，本报告比较的是「当前 Vim 配置」与「LazyVim 风格工作流」，不是两份可直接合并的配置源码。

## 当前配置已经具备的 LazyVim 类能力

1. 空格作为 leader

当前 `vimrc` 已在最早阶段设置 `mapleader` 为 空格，这和 LazyVim 常见习惯一致，适合作为后续所有工作流分组的基础。

2. 项目文件检索

当前已用 `fzf.vim` 提供 `:ProjectFiles`，在 Git 仓库中优先走 Git 文件列表，非 Git 目录回退到普通文件查找。这已经覆盖 LazyVim 中 Telescope 文件查找的核心用途。

3. 全局文本搜索

当前 `:LiveGrep` 与 `<leader>gg` 已经基于 `rg` 和 quickfix 建立项目搜索能力。它更偏 Vim 原生 quickfix 工作流，而不是 Telescope 弹窗工作流。

4. 文件树与图标

当前 NERDTree、vim-devicons、airline 已经形成侧栏、图标、状态栏组合，并且已有部分「LazyVim 风格」图标配置。

5. which-key

当前已引入 `vim-which-key`，但分组信息还比较粗，尚未完全反映现有按键。

## 最值得借鉴的方向

### 1. 补齐 `<leader>f*` 文件与查找族

LazyVim 的好用点之一是高频入口非常可预测：文件查找、文本搜索、缓冲区、历史记录都集中在 `<leader>f` 下面。

当前配置已有 `<C-p>`、`<leader>fc`、`<leader>fb`、`<leader>fh`，但缺少最直觉的：

- `<leader>ff`：项目文件查找，对齐 LazyVim 的 find files
- `<leader>fg`：项目文本搜索，对齐 LazyVim 的 live grep
- `<leader>fr`：最近文件或历史文件，对齐 recent files 思路
- `<leader>fm`：marks 或 maps，作为 Vim 原生导航入口

建议保留 `<C-p>` 与 `<leader>gf`，新增 LazyVim 风格别名，降低迁移成本。

### 2. 重新处理 `<leader>e`

LazyVim 中 `<leader>e` 常用于打开文件树；当前配置里 `<leader>e` 是编辑 `$MYVIMRC`。这个键位非常核心，不建议突然覆盖。

更稳妥的做法：

- 短期保留 `<leader>e` 编辑配置
- 新增 `<leader>ee` 或 `<leader>ft` 打开 NERDTree
- 在文档中明确 `<leader>n` 是当前文件树主入口
- 若以后决定更贴近 LazyVim，再把编辑配置迁到 `<leader>vc` 或 `<leader>ev`

### 3. 让 which-key 真正成为入口地图

现在 which-key 只注册了少量分组名，和真实映射不完全同步。借鉴 LazyVim 的关键不是弹窗本身，而是「按键空间有清晰语义」。

建议补齐这些分组：

- `f`：文件、查找、历史
- `g`：Git 与 grep
- `b`：缓冲区
- `c`：quickfix 或 code/search candidates
- `m`：Markdown
- `n`：NERDTree
- `h`：帮助与学习
- `t`：主题

### 4. 文件树操作文档化

LazyVim 笔记中强调了文件树内创建、删除、重命名、复制、粘贴、移动等操作。当前配置已经有 NERDTree，但教程文档主要列了打开和定位。

建议把 NERDTree 内部常用键补到 `docs/tutorials/keybindings.md`：

- `m`：打开文件系统操作菜单
- `a`：新增节点
- `d`：删除节点
- `r`：重命名节点
- `x`：剪切节点
- `c`：复制节点
- `p`：粘贴节点
- `u` / `C`：目录上跳与设根

这类改动不影响 Vim 行为，但会明显提升可学性。

### 5. 搜索结果可以区分两条路线

当前 `<leader>gf` 使用 `:LiveGrep` 后进入 quickfix；fzf.vim 也自带 `:Rg`，能提供更接近 Telescope 的可预览搜索面板。

建议形成双轨：

- `<leader>fg`：`fzf.vim :Rg`，用于交互式搜索与预览
- `<leader>gf`：保留 quickfix 搜索，用于批量跳转和后续 `:cdo`

这比只保留其中一种更符合 Vim 使用习惯。

## 可选但不急的插件方向

1. 文件树替代

`neo-tree.nvim`、`nvim-tree.lua` 是 Neovim 生态插件，不适合直接进入当前 Vim 仓库。当前继续使用 NERDTree 更稳。

2. Telescope 替代

Telescope 依赖 Neovim，不建议移植。当前应把 fzf.vim 打磨到足够顺手。

3. LSP 与 Treesitter

LazyVim 的强项是 LSP、Treesitter、formatter、diagnostics。传统 Vim 也能做，但会显著增加依赖和复杂度。当前仓库定位是便携式 Vim 配置，建议先不引入。

4. 插件管理器替换

LazyVim 使用 lazy.nvim 的声明式插件管理。当前仓库已经有 `vim-manager`，且插件固定落在仓库 `plugins/`，这有利于便携与可控，不建议改成另一个插件管理体系。

## 建议落地顺序

1. 低风险按键别名

新增 `<leader>ff`、`<leader>fg` 等 LazyVim 风格入口，不删除现有键位。

2. which-key 分组补全

让提示菜单覆盖现有真实映射，避免用户只靠记忆。

3. 文档更新

更新 `docs/tutorials/keybindings.md`，尤其是 NERDTree 内部操作与 Fugitive 当前映射。当前文档中 Git 一节说没有统一 `<leader>g*` 映射，但 `vimrc` 已配置 `<leader>gs`、`<leader>gd`、`<leader>gc` 等，二者需要同步。

4. 搜索体验增强

为 fzf.vim 的 `:Rg` 增加显式入口，同时保留 quickfix 路线。

5. 视情况评估更重的开发能力

若后续目标变成代码 IDE 化，再单独评估补全、诊断、格式化、语法树能力；不要在本轮为了追 LazyVim 外观而增加过多依赖。

## 不建议迁移的内容

- 不建议把 LazyVim 的 Neovim/Lua 插件直接搬入本 Vim 配置
- 不建议马上把 `<leader>e` 从编辑 vimrc 改成文件树，除非接受肌肉记忆变化
- 不建议引入 LSP、Treesitter 作为默认必装依赖
- 不建议替换 `vim-manager` 的插件管理模型

## 结论

当前配置已经具备许多 LazyVim 风格能力，真正缺的是「入口一致性」与「文档化的发现路径」。最划算的借鉴不是换插件，而是把 `<leader>f*`、which-key 分组、文件树操作说明和搜索双轨做好。
