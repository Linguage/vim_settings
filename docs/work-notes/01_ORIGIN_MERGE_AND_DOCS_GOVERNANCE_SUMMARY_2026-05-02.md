---
title: 上游合并与文档治理阶段性小结（会话系列）
date: 2026-05-02
created: "2026-05-02T17:26:54Z"
updated: "2026-05-02T17:45:27Z"
category: worknotes
tags: [vim-settings, upstream-merge, documentation, vim-manager, plugin-profile, worknotes]
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

以下是**最初合并小结落盘时未做或无法仅凭仓库静态保证**的事项：

- 未在最初合并会话末尾对 **`plugin_configs`、`which-key`、`mappings`** 与每一则快捷键做一次「逐键对照开机验收」的最终审计文档。
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

- 每台开发机是否在合并后均已跑通完整 **`install`** / **`bootstrap`** 且无工具缺失。
- 合并后新增的更大功能块（若有晚于本会话总结的提交）是否与 **`README.md` / `c.md`** 已完全同步叙述。

## 8. 2026-05-03 后续吸收、审查与修复补记

在上游合并与文档治理之后，仓库继续围绕「经典 Vim 配置可吸收经验」推进了一轮更聚焦的配置演进。参考来源包括本地 LazyVim 风格分析与临时克隆的 **spf13-vim**；取舍原则是继续保持本仓库作为便携式 Vim 配置，不迁入 Neovim/Lua 生态，不引入旧式 Vundle、ctrlp、Syntastic 或大型语言插件组。

### 8.1 第一批吸收：无依赖体验增强与小插件增量

第一批落地把 spf13-vim 中仍然有价值、且不会显著改变项目定位的能力分成两类处理。

无依赖部分主要强化了默认 Vim 体验：

- 在 `vimrc` 中增加 **`~/.vimrc.before.local`** 与 **`~/.vimrc.local`** 两个本机私有覆盖入口，前者用于默认配置前的开关，后者用于主题、字体和个人映射覆盖。
- 将 backup、undo、view、swap 目录集中到 **`~/.local/state/vim/`**；swap 目录准备好但默认仍维持 `noswapfile`。
- 增加恢复上次光标位置、Git commit message 回到第一行、清理尾随空格时保存光标和搜索寄存器等编辑体验。
- 增加 `:W`、`:Q`、`:Wq`、`:QA`、`:w!!`、命令行 `%%`、`:cwd` / `:cd.`，以及 `Y -> y$`、可视缩进后保留选区、`<leader>gC` 合并冲突标记搜索等日常小入口。

插件部分选择了低耦合的小增量：

- `vim-repeat`：补齐重复操作能力。
- `undotree`：用 `<leader>u` 进入可视化撤销树。
- `vim-signify`：提供轻量 Git gutter 标记，并用 `<leader>gS` 切换。
- `vim-easy-align`：用 `ga` 作为普通/可视模式交互对齐入口。

同期还补了 LazyVim 风格入口，例如 `<leader>ff`、`<leader>fg`、`<leader>fr`、`<leader>fm`、`<leader>ee`，并扩展 which-key 分组；文档同步更新了 README、`c.md` 与 `docs/tutorials/keybindings.md`。

### 8.2 第二批吸收：插件 profile 与本地覆盖教程

第二批落地集中在可维护性上：新增 **`vim-manager --profile minimal|default|full`**。

- `default` 保持当前完整插件清单，作为无参数默认值。
- `minimal` 仅处理基础编辑与检索插件：`vim-sensible`、`vim-surround`、`vim-repeat`、`vim-commentary`、`auto-pairs`、`vim-polyglot`、`fzf.vim`、`vim-which-key`。
- `full` 当前等同 `default`，作为未来 optional 插件承载位。
- `install` / `update` / `status` 按 profile 遍历插件；`clean` 仍以完整清单作为保护集合，避免从 default 切到 minimal 后误删已安装插件。

这一步还新增了 **`docs/tutorials/local-overrides.md`**，把本地覆盖文件、常用开关、swapfile 启用、主题字体覆盖和个人映射写成可复制的简体中文教程，并把链接补到 README 与 `docs/INDEX.md`。Git/NERDTree 工作流也补了 `<leader>gi`、`<leader>gD`、`]h` / `[h`、`<leader>ef` 与更完整的 NERDTree 忽略规则。

### 8.3 配置审查发现的问题

随后对当前配置做了一次 review，重点不是功能是否能启动，而是 profile、插件映射和管理脚本失败路径是否可信。确认出的主要问题包括：

- **minimal profile 与运行时映射脱节**：minimal 环境可以 `status` 全绿，但 Vimscript 仍无条件注册 NERDTree、Fugitive、Signify、Undotree、EasyAlign、Markdown Preview 等命令映射，按键时可能报 `E492`。
- **`no_autochdir` 会被 view 的 `curdir` 绕过**：旧 view 文件保存过 local cwd 时，即使用户设置了 `g:vim_settings_no_autochdir = 1`，`loadview` 仍可能恢复旧目录。
- **`vim-manager update` 假成功**：`git pull --rebase --autostash` 的退出码未检查，失败时仍打印 updated。
- **`vim-manager install` 假完成**：单个插件 clone 失败只打印错误，整体函数仍返回成功。
- **`deps` / `uninstall` 忽略参数**：主入口已透传命令参数，但这两个命令没有校验未知选项。

### 8.4 已完成修复

针对上述 review 点，已完成修复：

- `settings/plugin_configs.vim` 增加 `s:HasPlugin()`，按插件目录存在与否注册 NERDTree、Signify、Undotree、EasyAlign、Markdown Preview 与 which-key 相关配置和映射。
- `settings/mappings.vim` 和 `vimrc` 对 NERDTree / Fugitive 映射加插件存在性守卫，避免 minimal 或手动删插件后留下坏按键。
- `settings/basic.vim` 从 `viewoptions` 移除 `curdir`，并在 `g:vim_settings_no_autochdir` 开启时跳过 `loadview`，避免旧 view 文件改变 cwd。
- `vim_manager_modules/core_logic.sh` 让 `install_plugins` 累计 clone 失败并返回非零状态。
- `vim_manager_modules/commands.sh` 让 `install` / `update` 传播失败；`deps` / `uninstall` 拒绝未知参数；help 改为说明 profile 只支持 `install`、`bootstrap`、`update`、`status`、`clean`。

### 8.5 后续验证

本轮修复后做过的验证包括：

- `bash -n vim-manager vim_manager_modules/*.sh scripts/*.sh`
- `vim -Nu vimrc -n -es +'qa!'`
- `vim -Nu vimrc -n -es +'verbose nmap <leader>gi' +'verbose nmap ]h' +'verbose nmap <leader>ef' +'qa!'`
- `./vim-manager status --profile minimal`
- `./vim-manager status --profile unknown`
- `./vim-manager deps --profile unknown`
- `./vim-manager uninstall --profile unknown`
- `git diff --check`

此外还用临时目录模拟了两类关键场景：

- **minimal 插件目录**：仅提供 minimal profile 的插件时，`<leader>ff` 与 which-key 仍可用；`<leader>ef`、`]h`、`<leader>u`、`<leader>gi`、`<leader>mp` 等依赖 default/full 插件的映射不再注册。
- **旧 view + no_autochdir**：先让旧 view 保存到另一个 local cwd，再启用 `g:vim_settings_no_autochdir = 1` 打开文件，最终 cwd 保持在当前项目目录，不再被旧 view 覆盖。

失败路径也做了局部模拟：无效插件 clone 会让 `install_plugins` 返回非零；无效远端更新会让 `do_update` 以非零退出，并报告更新失败。

### 8.6 当前状态与仍需留意的事项

截至本补记，配置已经从「能启动」推进到更接近「profile 语义与运行时行为一致」。不过仍有几项后续可选工作：

- 若未来继续扩大 profile，最好把“插件清单、runtimepath、插件配置守卫、文档快捷键”作为同一组变更一起验收。
- `settings/plugin_configs.vim` 里部分 UI 图标变量仍是为完整插件集准备；当前不会造成启动失败，但若要让 minimal 更干净，可进一步把 airline/devicons 相关变量也按插件存在性分组。
- 本轮没有执行真实网络环境下的完整 `./vim-manager update` 或从零 `./vim-manager bootstrap`；已验证语法、启动、profile 状态、关键映射、失败状态与临时环境行为。
