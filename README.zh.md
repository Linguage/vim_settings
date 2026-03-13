# 便携式 Vim 配置

[English](README.en.md) | [简体中文](README.zh.md)

本仓库包含一个高度可定制的 Vim 配置，专为现代高效的工作流程设计。它配备了一个强大的管理脚本，可以一键安装并在多台设备上轻松维护。

当前推荐的使用方式是：将家目录的 `.vim` 符号链接到本目录，并让家目录的 `.vimrc` 指向本目录中的 `vimrc`。这样可以把真实生效的 Vim 配置集中放在仓库中管理。

## 核心工作流

这套配置目前重点覆盖以下几类高频工作流：

- **项目内导航**：`<C-p>` 使用标准 `fzf.vim` 进行项目级文件查找；`<C-y>` / `<leader>n` 切换文件树，`<leader>nf` 在 NERDTree 中定位当前文件。
- **命令面板工作流**：`<leader>fc` 打开命令面板，`<leader>fb` 打开缓冲区面板，`<leader>fh` 打开命令历史，尽量减少对底部命令行的依赖。
- **高频 Ex 命令**：`<leader>fe` 预填充 `:edit`，`<leader>fq` 在未保存时弹出确认后关闭窗口，`<leader>fQ` 强制退出全部，`<leader>fw` 保存，`<leader>fx` 保存并退出。
- **搜索与结果跳转**：`<leader>gg` 和 `:LiveGrep` 通过 `rg` 将结果送入 quickfix，配合 `<leader>co`、`<leader>cn`、`<leader>cp`、`[q`、`]q` 快速跳转。
- **常用编辑动作**：软换行按屏幕行移动，翻页后自动居中，`<F2>` 预填充替换命令，`<M-j>` / `<M-k>` 上下移动当前行或选区。
- **Git 操作**：通过 `vim-fugitive` 提供状态、diff、blame、log、push 等常用入口。
- **Markdown 预览**：在 Markdown 文件中可直接调用浏览器预览。
- **macOS 兼容性**：在 macOS 下优化终端 Esc 响应；输入法切换逻辑默认关闭，避免终端触发系统自动化权限弹窗。

## 可选依赖

不是所有功能都依赖系统额外安装，但下面这些依赖会明显影响体验：

- **`rg`**：用于 `:LiveGrep` 和 `<leader>gg` 的项目全文搜索。未安装时，搜索工作流会退化。
- **`fzf`**：用于 `<C-p>` 的标准项目文件查找。未安装时，会回退到内置 `:find`。
- **Nerd Font**：用于状态栏和文件树图标显示。未安装时功能仍可使用，但图标会显示异常。
- **支持 `+clipboard` 的 Vim**：用于系统剪贴板互通。未启用时，`<leader>y` / `<leader>p` 的体验会受限。
- **macOS `osascript`**：输入法切换逻辑基于 AppleScript，仅在 macOS 下有效；如需启用，请显式打开本地开关。
- **终端 Vim**：macOS 下会额外启用较短的 `ttimeoutlen`，改善 Esc 和 Alt 组合键的响应体验。

## 个人与学习型映射

除了核心工作流，这套配置还保留了一些更偏个人使用习惯的映射，例如：

- `jk` / `kj` 退出插入模式
- `H` / `L` 到行首和行尾
- `showmode` 常显
- `vimtutor`、学习计划、练习文档等入口

这些映射并非“所有机器都必须保留”的部分，后续如果要继续精简，优先从这类个人偏好入口下手。

## 主要特性

- **现代化界面**：使用 `vim-airline` 和 `vim-airline-themes` 提供美观且信息丰富的状态栏和标签栏。
- **图标支持**：集成 `vim-devicons`，为 NERDTree 提供简洁现代的文件和文件夹图标。
- **增强的文件导航**：使用 `preservim/nerdtree` 提供直观的文件系统浏览器。
- **Git 集成**：利用 `tpope/vim-fugitive` 实现 Vim 内无缝的 Git 命令操作。
- **智能编辑**：包含 `vim-surround`、`vim-commentary` 和 `auto-pairs` 等必备插件，加速常见编辑任务。
- **多语言支持**：通过 `vim-polyglot` 为多种编程语言提供丰富的语法高亮和缩进支持。

## 先决条件

1.  **Git**：用于克隆插件。可以通过运行 `git --version` 检查是否已安装。
2.  **Nerd Font**：需要安装支持图标的字体。我们推荐使用 [Hack Nerd Font](https://www.nerdfonts.com/font-downloads) 或其他 Nerd Font 字体。

## 安装与管理

本配置通过一个简单而强大的 shell 脚本 `vim-manager` 进行管理。

### 快速安装

在新机器上设置此配置，请按照以下步骤操作：

1.  将本仓库克隆到您选择的位置：
    ```bash
    git clone <your-repo-url> ~/vim_settings
    ```
2.  进入目录：
    ```bash
    cd ~/vim_settings
    ```
3.  使管理脚本可执行：
    ```bash
    chmod +x vim-manager
    ```
4.  运行一键安装程序：
    ```bash
    ./vim-manager install
    ```

安装完成！脚本将自动备份现有的 Vim 配置，创建必要的符号链接，并安装所有必需的插件。

### 可用命令

`vim-manager` 脚本提供了一套完整的命令，方便维护：

- **`./vim-manager install`** - 一键安装配置和所有插件
- **`./vim-manager update`** - 更新所有已安装的插件到最新版本
- **`./vim-manager status`** - 检查符号链接、托管插件和未托管插件状态
- **`./vim-manager clean`** - 清理不在管理清单中的插件目录
- **`./vim-manager uninstall`** - 移除由脚本创建的符号链接，不删除仓库本身
- **`./vim-manager help`** - 显示帮助信息

### 模块化架构

从 v3.0 开始，`vim-manager` 采用模块化设计：

```text
vim-manager (主入口)
vim_manager_modules/
├── config.sh      # 配置和插件清单
├── helpers.sh     # 工具函数
├── core_logic.sh  # 核心业务逻辑
└── commands.sh    # 命令处理器
```

这种设计提供了：
- **更好的可维护性**：每个模块专注特定功能
- **清晰的代码组织**：逻辑分离，易于理解
- **便于扩展**：新功能可以独立开发和测试

辅助维护脚本统一收纳在 `scripts/` 目录中。当前保留的辅助脚本是 `scripts/cleanup.sh`，用于清理项目根目录中的临时文件和空目录。

## 包含的插件

| 插件 | 功能 | 描述 |
|------|------|------|
| `vim-airline` | 状态栏 | 美观且信息丰富的状态栏 |
| `vim-airline-themes` | 状态栏主题 | 为 airline 提供多种主题 |
| `nerdtree` | 文件浏览器 | 树形文件系统浏览器 |
| `vim-devicons` | 图标支持 | 为文件和文件夹提供图标 |
| `vim-fugitive` | Git 集成 | 强大的 Git 命令集成 |
| `vim-surround` | 包围编辑 | 快速添加/修改/删除包围字符 |
| `vim-commentary` | 注释切换 | 智能注释/取消注释 |
| `vim-polyglot` | 语言支持 | 多种编程语言的语法高亮 |
| `auto-pairs` | 自动配对 | 自动匹配括号、引号等 |
| `vim-sensible` | 合理默认 | 提供合理的 Vim 默认设置 |
| `markdown-preview.nvim` | Markdown 预览 | 在浏览器中预览 Markdown |
| `vim-which-key` | 快捷键提示 | 显示 Leader 键可用分组与命令 |

## 配置结构

```text
vim_settings/
├── vim-manager          # 管理脚本（主入口）
├── vim_manager_modules/ # 脚本模块
├── scripts/            # 辅助维护脚本
├── vimrc               # 主配置文件
├── settings/           # 模块化配置
│   ├── basic.vim       # 基础设置
│   ├── ui.vim          # 界面设置
│   ├── mappings.vim    # 按键映射
│   ├── plugins.vim     # 插件加载
│   ├── plugin_configs.vim # 插件配置
│   └── colorscheme.vim # 主题配置
├── colors/             # 颜色主题
├── plugins/            # 插件目录（自动管理）
└── docs/               # 文档
```

-   `./vim-manager install`
    安装配置，链接文件，并从清单中克隆所有插件。

-   `./vim-manager update`
    更新所有已安装的插件到最新版本。

-   `./vim-manager status`
    检查符号链接状态，并列出所有托管和非托管的插件。

-   `./vim-manager clean`
    移除 `plugins/` 目录中未在清单中列出的插件。删除前会显示确认提示。

-   `./vim-manager uninstall`
    安全地移除由 `vim-manager install` 创建的符号链接。仓库目录和其中的插件文件不会被删除。

-   `./vim-manager help`
    显示包含所有可用命令的帮助信息。

## 文档

- [快捷键指南](./docs/reference/keybindings.zh.md) - 所有自定义快捷键和插件命令的参考
- [更新日志](./docs/history/changelog.zh.md) - 版本更新历史记录
- [历史总结](./docs/history/update-summary.md) - 早期重构与文档更新总结
- [管理脚本计划](./docs/plans/vim-manager-device-plan.md) - `vim-manager` 的整理与演进计划
- [遗留文档](./docs/legacy/vim-manager-docs.md) - 旧版脚本分析与历史说明

## 故障排除

如果遇到任何问题，请尝试以下步骤：

1. 确保您已安装 Nerd Font 并在终端中启用
2. 运行 `./vim-manager status` 检查配置状态
3. 如果 `status` 显示 `all-the-icons` 或 `nvim-web-devicons` 这类 `Unmanaged` 项，说明它们是历史遗留目录，可通过 `./vim-manager clean` 清理
4. 查看 `:checkhealth` 的输出以获取更多诊断信息

## 贡献

欢迎提交问题和拉取请求。请确保您的更改符合项目的代码风格。

## 许可证

[MIT 许可证](LICENSE)
