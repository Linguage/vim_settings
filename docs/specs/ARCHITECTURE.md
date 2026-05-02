# Vim 配置管理器 架构文档 (Architecture)

> 实现框架文档：功能实现框架与技术细节说明。
> 最近更新: 2026-05-02

---

## 1. 系统总览

本项目由两部分组成：

1. **Vim 运行时配置**：仓库根目录的 `vimrc` 作为主入口，`settings/` 下按Concern拆分模块（基础、插件、UI、快捷键、配色等）。
2. **运维脚本 `vim-manager`**：Bash 入口脚本，按需 `source` `vim_manager_modules/` 内的配置、通用函数、核心业务与命令分发。

典型工作流：新环境可 `./scripts/bootstrap.sh` 或 `./vim-manager bootstrap`；仅更新插件用 `./vim-manager update`；自检 `./vim-manager status`。

## 2. 模块结构

- **`vim-manager`**：`deps` / `bootstrap` / `install` / `update` / `clean` / `status` / `uninstall` / `help`；`install`、`update`、`status`、`clean` 支持 `--profile minimal|default|full`。
- **`vim_manager_modules/`**：`config.sh`（`VERSION`、`PLUGINS`、profile 定义、`REQUIRED_TOOLS`）、`helpers.sh`、`core_logic.sh`、`commands.sh`。
- **`scripts/`**：`bootstrap.sh`、`install_dependencies.sh`、`cleanup.sh` — 自动化安装入口与杂物清理。
- **`settings/`**：`basic.vim`、`plugins.vim`、`plugin_configs.vim`、`ui.vim`、`mappings.vim`、`colorscheme.vim` 等。
- **`colors/`**：配色 Vim 脚本。

{待补充：更细的函数/命令契约}

## 3. 数据流

{待补充：例如插件目录、备份路径、`undo/` 等若纳入设计再写}

## 4. 关键技术决策

{待补充}

## 5. 目录映射

| 路径 | 说明 |
|------|------|
| `vimrc`、`settings/`、`colors/` | Vim 配置主体 |
| `vim-manager`、`vim_manager_modules/` | CLI 与管理实现 |
| `scripts/` | 依赖/bootstrap/cleanup |
| `docs/INDEX.md` | 文档总索引（**`docs/` 根仅此一篇索引文**） |
| `docs/tutorials/` | 上手教程、快捷键一览（如 `tutorial.md`、`keybindings.md`） |
| `docs/legacy/` | 归档：**`changelog.md`**（变更日志）；**`internal/`** 下脚本分析稿、重构计划等非主线历史材料 |
| `docs/work-notes/` | 过程纪要 |
| `docs/specs/` | BLUEPRINT / ARCHITECTURE / ROADMAP |
| `docs/jobs/`、`docs/reports/` | 在制任务说明、经验沉淀索引 |

**说明**：`docs/legacy/` 既承担「结案任务文档」占位（见 `legacy/README.md`），也容纳当前仍可读的 changelog 与 `internal/` 专题归档；若以治理规格需要「变更日志迁至 specs 同级独立目录」，再在 ROADMAP 中单独立项迁移即可。
