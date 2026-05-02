---
title: 上游合并与文档治理阶段性小结（会话系列）
date: 2026-05-02
created: "2026-05-02T17:26:54Z"
category: worknotes
tags: [vim-settings, upstream-merge, documentation, vim-manager, worknotes]
---

# 上游合并与文档治理阶段性小结

## 1. 背景与动机

仓库 `vim_settings` 长期在本地演进文档与脚手架（Specs、Agents、 tutorials、reports、legacy），与远端 `origin/main` 的配置与脚本已出现分叉。目标是在**不大规模推翻既有写法**的前提下，建立可维护的文档入口策略，并按约定把 **Vim/管理脚本对齐远端能力**（如 `vim-manager` v3.3、fzf.vim/csv.vim、`scripts/`、`settings/*`），同时清除不再使用的 Copilot 相关配置。

## 2. 本阶段主要目标

- 固化「用户可见文档」的入口：**`README.md`、`c.md`、`docs/INDEX.md`**；`docs/specs`、`docs/tutorials`、`docs/legacy` 各司其职。
- **`Agents.md`** 作为协作入口指向上述结构。
- **`origin/main`** 合并时坚持：**文档结构与中文用户文档以本地为准**；**运行时与 shim 脚本以远端实现为准**，冲突后删掉不应恢复的远端英文镜像目录与已过时的路径占位。
- 合并后：**插件清单与 manifest 一致**；移除历史遗留目录造成的 **孤儿插件**噪声（如仅 manifest 不再需要却仍在 `plugins/` 下的条目）。

## 3. 已落实的主要改动（按主题）

### 3.1 文档与目录

- 用户教程与快捷键说明落在 **`docs/tutorials/`**（如 `tutorial.md`、`keybindings.md`）。
- **`keybindings`** 内容与远端中文版参考对齐的同时，删减了本地 `settings/mappings.vim` 未实现的整块说明（例如已删除的冗长 fugitive `<leader>g*` 表），改为简短的 `:Git` / `:help fugitive` 引导。
- 规格说明与架构决策保留在 **`docs/specs/`**，对外索引由 **`docs/INDEX.md`** 维护。
- 历史与不面向终端用户的材料收敛到 **`docs/legacy/`**（必要时的内部笔记可放在 **`docs/legacy/internal/`**）。
- **`docs/reference/`、`docs/internal/`** 在用户侧已不再使用；上下文已统一到 tutorials/legacy。
- **`README.md`**、**`docs/legacy/changelog.md`** 增补 **v3.3** 相关说明，与合并后的工具链一致。

### 3.2 上游合并与删除项

- 完成 **`merge origin/main`**，冲突按「文档本地 / Vim 与脚本远端」策略解决。
- 主动移除了合并中不应长期保留的远端镜像与路径，例如 **`AGENTS.md`**（与本地 **`Agents.md`** 策略冲突）、**`docs/worknotes/`**、**`docs/reference/`**、**`getting-started`**、**`changelogs`** 等；保留并强化本地 **`Agents.md`**。

### 3.3 运行时、`vim-manager` 与脚本

- **`vim_manager_modules/config.sh`** 对齐 **v3.3**：清单含 **fzf.vim、csv.vim**，`REQUIRED_TOOLS` 纳入 **rg、fzf、node** 等与远端一致的依赖描述。
- **`scripts/`**（如 `bootstrap`、`install_dependencies`、`cleanup`）纳入架构说明与工作流入口（**`Agents.md`**、**`docs/specs/ARCHITECTURE.md`**）。
- **`plugin_configs`** 等配置随合并更新；会话中还移除了 Copilot 相关片段，保证与「不再使用 Copilot」一致。

### 3.4 孤儿插件目录

- **`all-the-icons`**、**`nvim-web-devicons`** 曾与当前 manifest **`vim-devicons`** 不一致而成为「未管理插件」告警来源。
- 处理路径：优先 **`./vim-manager clean`**；若在受限环境删除失败（如对插件仓库内 `.git` 触发权限错误），需在非沙盒或 **`rm -rf`** 有足够权限的机器上移除对应目录后再跑 **`vim-manager status`** 确认告警消失。
- （与会话时点一致的目标）manifest 与子目录对齐后，`status` 应不再报告上述孤儿条目。

## 4. 校验与诚实记录

会话中做过的检查（节选，非穷尽）：

- **`bash -n`** 对部分 shell 脚本做语法校验（通过）。
- **`./vim-manager help / status`** 等与合并后入口一致性相关的冒烟（在清理孤儿插件后预期无多余未管理条目）。
- 工作区内 **`grep`/路径检查**：确认已删目录名、旧英文名入口不再作为主要文档链路。

以下**本次未做或无法仅凭仓库静态保证**：

- 未在此系列会话末尾对 **`plugin_configs`、`which-key`、`plugin_configs`** 与每一则快捷键做一次「逐键对照开机验收」的最终审计文档。
- **`./vim-manager install` / `./scripts/bootstrap`** 是否已在用户每台机器最新跑通，取决于目标环境与网络，会话未代为执行全链路安装验收。

## 5. Git 与时间线备注

- 合并相关提交在仓库记录中可见（例如带有「吸收 v3.3 Vim 与管理脚本」语义的 merge 提交）；**`docs/work-notes/update-summary.md`** 在此之后有过一次与合并结果对齐的修订。
- **若本笔记落盘之后仓库继续演进**（例如引入 plugin profiles、扩展 `vim-manager` 子命令等），应以 **`git log` 中本文件 `date` 之后的提交** 为准单独补充纪要；本笔记不替代后续提交的说明。

## 6. 待办与开放事项

| 事项 | 说明 |
|------|------|
| 推送远端 | 若本地 `main` 已领先 `origin/main`，按需 **`git push`**。 |
| 安装与 symlink | 新 clone 或合并后若 **`status`** 仍报坏链，在用户环境执行 **`./vim-manager install`** 或 **`./scripts/bootstrap`**。 |
| 规格与实现对齐（可选） | 若需「Specs 与实际按键 100% 一致」的签字版，可增加一次专题对照并迁入 **`docs/reports/`**。 |

## 7. 已证实结论 vs 未逐项核实假设

**已在本系列会话上下文或仓库状态中可确认的：**

- 文档入口策略（`INDEX` → tutorials/specs/legacy）与 **`Agents.md`** 指链一致。
- 合并策略被执行：关键 Vim/脚本能力与 v3.3 描述一致的关键文件已更新。
- Copilot 相关配置已从插件配置链路中移除（以当时工作区为准）。

**尚未逐项核实的推断（需在后续工作或用户机上验证）：**

- 每台开发机是否在合并后均已跑通完整 **`install`**/`bootstrap`** 且无工具缺失。
- 合并后新增的更大功能块（若有晚于本会话总结的提交）是否与 **`README.md` / `c.md`** 已完全同步叙述。
