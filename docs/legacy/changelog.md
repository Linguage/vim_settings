# 更新日志

## v3.3 - 2026-03-13 / 后续合并 - 吸收远端 vim 配置与 manager 增强

- **`vim-manager`**：新增 `deps`、`bootstrap`；`status` 检查外部工具；`update`/`install` 后执行插件后置步骤（详见 `vim_manager_modules/commands.sh` / `core_logic.sh`）。
- **插件清单**：增加 `fzf.vim`、`csv.vim`；移除未在清单中维护的冗余 devicons 变体（以 `config.sh` 为准）。
- **`settings/`**：基础编辑体验（`rg`、quickfix、持久化撤销目录 `~/.local/state/vim/undo/`）、FZF 项目文件、CSV、Markdown 等与远端提交对齐。
- **`scripts/`**：`bootstrap.sh`、`install_dependencies.sh` 作为自动化入口；`cleanup.sh` 用于项目根目录常见临时文件清理。
- **文档**：仍按本仓库 **`docs/INDEX.md`** 与 **仅中文** 约定组织；不保留远端 `docs/worknotes/`、`docs/reference/*` 镜像路径；快捷键文档位于 `docs/tutorials/keybindings.md`。

## v3.2 - 2026-05-02 - 移除 Copilot、文档仅中文与目录整理

- 移除所有 GitHub Copilot 相关的用户文档、`vim-manager` 中无效的 `copilot` 子命令占位，以及配置中的 Copilot 注释占位段。
- 用户文档仅以**简体中文**维护；删除英文 README 与 `.en` 文档镜像。
- `docs/` 根目录仅保留总索引 `[INDEX.md](../INDEX.md)`；读者向正文分布在 `tutorials/`、`legacy/`（含 `internal/`）、`work-notes/` 等。
- （说明：早前「v3.1」条目中的 Copilot 描述已不适用，以本版本为准；插入模式 `jk` / `kj` 等按键仍参见当前快捷键文档。）

## v3.0 - 2025-06-16 - 模块化重构与功能优化

### 重大更新：全面重构与模块化

本次更新对 `vim-manager` 进行了彻底的重构，遵循奥卡姆剃刀原则，大幅精简代码并提升维护性。经过重构，脚本从原来的约 1075 行减少到模块化的架构，代码量显著缩减，同时保持核心插件管理能力。

### 重构成果

- **模块化**：主入口加 `vim_manager_modules/`（`config.sh`、`helpers.sh`、`core_logic.sh`、`commands.sh`）。
- **插件管理**：`PLUGINS` 清单与克隆、更新、`clean`、`status`、`uninstall` 等命令保持可用。

### 移除的冗余模块（节选）

为实现精简，已从脚本中移除与「核心插件清单管理」重叠或未完成的功能入口，例如历史上的主题一键下载、`manage_plugins` 平行入口、环境全自动安装、`start_macvim` 等细节（参见 [vim-manager-deivse-plan.md](internal/vim-manager-deivse-plan.md)）。

### 核心命令保留

- `install` / `deps` / `bootstrap` / `update` / `clean` / `status` / `uninstall` / `help`

### 升级说明

拉取仓库后按需执行 `./vim-manager install` 或 `./vim-manager status`；配置习惯无需因模块化而改变。

---

## v2.0 - 2025-06-15 - 初始 vim-manager 系统

### 新增功能

- 专用配置管理脚本与插件清单
- `install`、`update`、`status`、`clean`、`uninstall` 等命令
- 备份、符号链接与可移植路径处理

---

## v1.0 - 初始版本

### 项目启动

- 核心配置文件 (`vimrc`)、模块化设置 (`settings/`)、配色 (`colors/`)
- 插件：NERDTree、vim-airline、vim-fugitive、vim-surround、vim-commentary、vim-polyglot 等
- 用户文档：`README.md`、快捷键与变更说明（仅以当前仓库所载为准）

## 已知问题

- 在某些终端模拟器中图标可能依赖 Nerd Font，请参阅根目录 README 中的字体说明。