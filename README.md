# 便携式 Vim 配置

项目当前版本：**v3.3**（以 [`vim_manager_modules/config.sh`](vim_manager_modules/config.sh) 中 `VERSION` 为准）。

本仓库包含可在终端下长期使用的 Vim 配置，附带 **`vim-manager`** 管理脚本：`install` / `deps` / `bootstrap` / `update` / `status` / `clean` / `uninstall` / `help`，并支持 `--profile minimal|default|full` 插件 profile。完整文档入口见 **`[docs/INDEX.md](docs/INDEX.md)`**（`docs/` 根目录仅存此索引与各子目录）。

## 主要特性

- **模块化配置**：`vimrc` + `settings/` 分文件加载。
- **现代化界面**：`vim-airline`、图标（需 **Nerd Font**）。
- **浏览与检索**：NERDTree、**fzf.vim** 项目文件选择（`<C-p>` / `:ProjectFiles`）、ripgrep 与 quickfix。
- **编辑与语言**：`vim-surround`、`vim-commentary`、`auto-pairs`、`vim-polyglot`、`csv.vim`。
- **经典增强**：`vim-repeat`、`undotree`、`vim-signify`、`vim-easy-align`。
- **Markdown 预览**：`markdown-preview.nvim`。
- **按键提示**：`vim-which-key`（双击 `<leader><leader>` 弹出菜单）。
- macOS 下可选**输入法切换**脚本（默认关闭，见 `settings/mappings.vim` 注释）。

## 先决条件

1. **Git**：克隆插件、`vim-manager status`。
2. **Nerd Font**（推荐）：[Nerd Fonts](https://www.nerdfonts.com/font-downloads)。
3. 安装过程中脚本会检测 **`vim`、`rg`、`fzf`、`node`**（及部分场景 `yarn/npm`）；缺失时请先执行 `./vim-manager deps`，或使用下方「全自动」脚本。

## 安装与管理

### 方式 A：从零一键（依赖 + 配置 + 插件）

```bash
git clone <你的仓库地址> ~/vim_settings
cd ~/vim_settings
chmod +x vim-manager scripts/bootstrap.sh scripts/install_dependencies.sh
./scripts/bootstrap.sh
```

### 方式 B：仅链接与插件（已自行装好依赖）

```bash
chmod +x vim-manager
./vim-manager install
```

完成后建议执行 `./vim-manager status` 自检。

### 常用命令（`vim-manager`）

| 命令 | 说明 |
|------|------|
| `./vim-manager deps` | 安装外部依赖（如 `vim`、`rg`、`fzf`、`node` 等） |
| `./vim-manager install` | 链接配置、安装清单内插件及插件后置步骤 |
| `./vim-manager bootstrap` | 先 `deps` 再 `install` |
| `./vim-manager update` | 更新插件并 rerun 后置步骤 |
| `./vim-manager status` | 检查依赖、符号链接、托管/未托管插件 |
| `./vim-manager clean` | 删除清单外插件目录（有确认提示） |
| `./vim-manager uninstall` | 移除脚本创建的符号链接（不删除本仓库源码） |
| `./vim-manager help` | 帮助 |

`install` / `update` / `status` / `clean` 可附加 `--profile minimal|default|full`。不传参数时使用 `default`；`minimal` 只处理基础编辑与检索插件；`full` 当前等同 `default`。`clean` 始终以完整托管清单保护已安装插件，避免 profile 切换造成误删。

**辅助脚本**（`scripts/`）：

- `scripts/install_dependencies.sh` — 依赖安装
- `scripts/bootstrap.sh` — 等价于远端设计的「全流程」入口
- `scripts/cleanup.sh` — 清理仓库根目录常见临时文件

### vim-manager 模块结构

```text
vim-manager
vim_manager_modules/
├── config.sh      # 版本、插件清单、REQUIRED_TOOLS
├── helpers.sh
├── core_logic.sh  # 链接、克隆、后置步骤等
└── commands.sh    # install / deps / bootstrap / …
```

## 插件清单

与 `vim_manager_modules/config.sh` 中 **`PLUGINS`** 保持一致，当前包含但不限于：`vim-airline`、`nerdtree`、`vim-devicons`、`vim-fugitive`、`vim-surround`、`vim-repeat`、`vim-commentary`、`vim-signify`、`vim-polyglot`、`auto-pairs`、`vim-sensible`、`undotree`、`vim-easy-align`、**`fzf.vim`**、**`csv.vim`**、`markdown-preview.nvim`、`vim-which-key`。具体以清单为准。

## 仓库目录（节选）

```text
vim_settings/
├── vim-manager
├── vim_manager_modules/
├── scripts/
├── vimrc
├── settings/
├── colors/
├── plugins/
└── docs/
    ├── INDEX.md
    ├── tutorials/
    ├── legacy/
    ├── specs/
    ├── jobs/
    ├── reports/
    └── work-notes/
```

## 文档（简体中文）

| 文档 | 说明 |
|------|------|
| [docs/INDEX.md](docs/INDEX.md) | 文档总索引 |
| [docs/tutorials/tutorial.md](docs/tutorials/tutorial.md) | 上手与日常维护 |
| [docs/tutorials/keybindings.md](docs/tutorials/keybindings.md) | 快捷键参考 |
| [docs/tutorials/local-overrides.md](docs/tutorials/local-overrides.md) | 本地覆盖配置与插件 profile |
| [docs/legacy/changelog.md](docs/legacy/changelog.md) | 更新摘要与历史变更 |
| [docs/specs/BLUEPRINT.md](docs/specs/BLUEPRINT.md) | 蓝图与文档边界 |
| [Agents.md](Agents.md) | 项目与人机协同约定 |

## 持久化撤销

远端配置将 Vim 状态目录集中在 `~/.local/state/vim/` 下：撤销历史放在 `undo//`，备份文件放在 `backup//`，视图信息放在 `view//`。`swap//` 目录会预先准备，但默认仍关闭 swapfile，避免恢复提示打扰。

## 本地覆盖

如需保留个人偏好而不改仓库默认配置，可创建本机私有文件：

- `~/.vimrc.before.local`：在默认配置前加载，适合设置 `g:vim_settings_no_autochdir`、`g:vim_settings_keep_trailing_whitespace`、`g:vim_settings_no_restore_cursor`、`g:vim_settings_no_listchars` 等开关。
- `~/.vimrc.local`：在默认配置后加载，适合覆盖主题、字体、个人映射等。

更多示例见 [本地覆盖配置指南](docs/tutorials/local-overrides.md)。

## 故障排除

1. `./vim-manager status` 逐项查看缺失工具与插件。
2. 图标异常：终端字体是否为 Nerd Font。
3. 需要 Markdown 预览：确保 `node` / `yarn` 或 `npm` 可用（见脚本检测输出）。

## 贡献与许可证

欢迎 Issue / PR。许可证以仓库根目录提供的许可文件为准（若有）；未单独提供时以作者声明为准。
