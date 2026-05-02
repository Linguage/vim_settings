# 便携式 Vim 配置

本仓库包含一套可定制的 Vim 配置与现代终端下的使用习惯，附带 `vim-manager` 脚本，支持一键安装、更新与卸载插件清单，便于在多台机器上维护。

## 主要特性

- **模块化配置**：`vimrc` + `settings/` 分文件加载，结构与职责清晰。
- **现代化界面**：`vim-airline`、标签栏与图标（需配合 Nerd Font）。
- **文件树**：NERDTree 浏览与在当前文件中定位。
- **Git**：`vim-fugitive` 等在编辑器内常用操作。
- **编辑增强**：`vim-surround`、`vim-commentary`、`auto-pairs` 等。
- **多语言语法**：`vim-polyglot`。
- **Markdown 预览**、**`<leader>` 按键提示**（`markdown-preview.nvim`、`vim-which-key`，以当前插件清单为准）。

## 先决条件

1. **Git**：用于克隆插件仓库（`git --version`）。
2. **Nerd Font**（推荐）：终端需使用带图标的字体，参见 [Nerd Fonts](https://www.nerdfonts.com/font-downloads)。

## 安装与管理

### 快速安装

```bash
git clone <你的仓库地址> ~/vim_settings
cd ~/vim_settings
chmod +x vim-manager
./vim-manager install
```

安装脚本会按需创建备份、符号链接并从清单克隆插件。完成后可用 `./vim-manager status` 自检。

### 常用命令

- `./vim-manager install` — 安装配置与清单内插件  
- `./vim-manager update` — 更新已安装插件  
- `./vim-manager status` — 配置与插件状态  
- `./vim-manager clean` — 删除清单外插件目录（有确认提示）  
- `./vim-manager uninstall` — 移除链接与 `plugins/`（不删除本仓库源码）  
- `./vim-manager help` — 帮助  

### vim-manager 模块结构（v3.0 起）

```text
vim-manager
vim_manager_modules/
├── config.sh      # 配置与插件清单
├── helpers.sh     # 输出与共用的小函数
├── core_logic.sh  # 链接、克隆等核心逻辑
└── commands.sh    # install/update 等命令
```

## 包含的插件（与 `config.sh` 中清单同步）

| 插件 | 作用 |
|------|------|
| vim-airline / vim-airline-themes | 状态栏与主题 |
| nerdtree | 文件树 |
| vim-devicons / nvim-web-devicons / all-the-icons | 图标（部分视环境加载） |
| vim-fugitive | Git |
| vim-surround / vim-commentary / auto-pairs | 编辑体验 |
| vim-polyglot / vim-sensible | 语法与合理默认 |
| markdown-preview.nvim | Markdown 预览 |
| vim-which-key | `<leader>` 提示菜单 |

具体 URL 与目录名以 `vim_manager_modules/config.sh` 内 `PLUGINS` 为准。

## 仓库结构（节选）

```text
vim_settings/
├── vim-manager
├── vim_manager_modules/
├── vimrc
├── settings/
├── colors/
├── plugins/          # 由 vim-manager 管理
└── docs/
    ├── INDEX.md      # 文档总索引（docs 根目录仅此一篇说明索引）
    ├── tutorials/    # tutorial.md、keybindings.md
    ├── legacy/       # changelog.md、internal/…
    ├── specs/
    ├── jobs/
    ├── legacy/
    ├── reports/
    └── work-notes/
```

## 文档

- **[文档索引](docs/INDEX.md)**：`docs/` 全目录导航  
- **[上手教程](docs/tutorials/tutorial.md)**：安装与日常维护  
- **[快捷键](docs/tutorials/keybindings.md)**  
- **[更新日志](docs/legacy/changelog.md)**  
更细的文档边界见 [docs/specs/BLUEPRINT.md](docs/specs/BLUEPRINT.md)。

## 故障排除

1. 确认终端字体为 Nerd Font。  
2. 执行 `./vim-manager status`。  
3. 在 Vim 中可用 `:checkhealth`（若适用）查看诊断。

## 贡献与许可证

欢迎 Issue / PR。许可证以仓库根目录提供的许可文件为准（若有）；未单独提供时以作者声明为准。
