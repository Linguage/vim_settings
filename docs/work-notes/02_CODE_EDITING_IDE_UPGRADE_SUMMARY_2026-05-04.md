---
title: 代码编辑 IDE 化升级阶段小结
date: 2026-05-04
created: "2026-05-04T00:00:00Z"
category: worknotes
tags: [vim-settings, ide-upgrade, vim-lsp, asyncomplete, ale, session-summary]
---

# 代码编辑 IDE 化升级阶段小结

本轮工作围绕“把当前 Vim 配置从轻量文本编辑器进一步推进到可用于日常代码编辑的默认工作台”展开。目标不是切换到 Neovim 或重做插件体系，而是在保留 `vim-manager` 与 profile 机制的前提下，补齐 LSP、补全、诊断、格式化、测试入口，以及与之配套的安装脚本和中文文档。

## 1. 背景与动机

此前仓库已经具备文件搜索、NERDTree、Git、撤销树、which-key 等通用能力，但作为代码编辑器仍缺少几类现代开发体验：语言跳转与悬浮信息、异步补全、诊断与格式化入口、测试命令，以及面向新环境的一键部署链路。会话中的判断是继续采用传统 Vim 生态，在现有 Bash 管理脚本和本地 `plugins/` 目录模型上演进，而不是转向 `coc.nvim` 或 Neovim/Lua 方案。

## 2. 本阶段主要目标

- 让 `default` / `full` profile 默认带上 Vim 原生 IDE 层，`minimal` 保持轻量。
- 把新能力接入现有自动部署流程：`vim-manager install`、`bootstrap`、`deps`、`status`。
- 补一份集中配置模块，避免把 LSP、ALE、测试映射散落到多个旧文件里。
- 将新增工作流同步到 README、快捷键文档和路线图，而不是只停留在实现层。

## 3. 已落实的主要改动

### 3.1 IDE 插件与 profile 接入

新增插件清单：

- `vim-lsp`
- `vim-lsp-settings`
- `asyncomplete.vim`
- `asyncomplete-lsp.vim`
- `ale`
- `editorconfig-vim`
- `vim-test`

这些插件已写入 `vim_manager_modules/config.sh` 的托管清单，并由 `settings/plugins.vim` 在 `g:vim_settings_no_ide` 未开启时加入 `runtimepath`。其中 `minimal` profile 继续只保留基础编辑与检索插件，不要求 IDE 层插件存在。

本轮还实际执行了 `./vim-manager install --profile default`，确认新增插件目录已经落到本地 `plugins/` 下：

- `plugins/vim-lsp`
- `plugins/vim-lsp-settings`
- `plugins/asyncomplete.vim`
- `plugins/asyncomplete-lsp.vim`
- `plugins/ale`
- `plugins/editorconfig-vim`
- `plugins/vim-test`

### 3.2 运行时配置与编辑行为

新增 `settings/code_editing.vim` 作为 IDE 层入口，集中维护以下内容：

- `g:vim_settings_no_ide` 总开关
- `vim-lsp` 的 buffer 内跳转、hover、rename、code action、符号查询映射
- `asyncomplete` 的自动补全和手动刷新入口
- `ALE` 的 shell / markdown 诊断与 shell 格式化策略
- `vim-test` 的测试运行快捷键
- `:CodeFormat`、`:LspOutline`、`:LspWorkspaceSymbols` 这类统一命令入口

`vimrc` 也已调整为在插件 `runtimepath` 配置前先加载该模块，确保默认变量和开关在插件初始化前生效。

同时，本轮对原有保存前清理尾随空格逻辑做了一个更贴近代码编辑场景的修正：Markdown、diff、patch 文件默认跳过这一步，以免破坏 Markdown 的硬换行或补丁语义；普通脚本文件仍保持自动清理。

### 3.3 自动安装、自检与文档

安装脚本和状态检查同步扩展：

- `scripts/install_dependencies.sh` 增加 `shellcheck`、`shfmt`
- 同一脚本增加 npm 全局语言工具安装：`bash-language-server`、`vim-language-server`、`vscode-langservers-extracted`、`yaml-language-server`、`markdownlint-cli2`
- `vim_manager_modules/commands.sh` 的 `status` 会在 `default` / `full` profile 下额外报告 IDE 工具缺失情况

文档侧已同步更新：

- `README.md`
- `c.md`
- `docs/tutorials/keybindings.md`
- `docs/specs/ROADMAP.md`
- `docs/jobs/code-editing-ide-upgrade.md`
- `.editorconfig`

其中 README 和快捷键文档已经明确说明：新机器下载后可以通过 `vim-manager` 自动部署 IDE 层；如果只想轻量使用，则继续走 `--profile minimal`。

## 4. 验证与诚实记录

本轮实际执行并通过的验证包括：

- `bash -n vim-manager vim_manager_modules/config.sh vim_manager_modules/commands.sh vim_manager_modules/core_logic.sh scripts/install_dependencies.sh scripts/bootstrap.sh scripts/cleanup.sh`
- `vim -Nu vimrc -i NONE -n -es +'qa!'`
- `./vim-manager install --profile default`
- `./vim-manager status --profile minimal`
- `./vim-manager status --profile default`
- 通过 `scriptnames` 确认 IDE 插件已被 Vim 运行时加载
- 对临时 `.sh`、`.vim`、`.json`、`.yaml` 文件执行 `LspStatus` / `ALEInfo` / `CodeFormat` 等命令冒烟
- `git diff --check`
- `./scripts/cleanup.sh --dry-run`

针对尾随空格行为还做了两类定向验证：

- Markdown 文件中的行尾双空格在保存后仍被保留
- Shell 示例文件中的普通尾随空格在保存后会被清理

## 5. 当前状态与未完成项

当前仓库已经具备“默认 profile 带 IDE 层，minimal 仍轻量”的结构；新增插件也已安装到本机，npm 语言服务器已安装完成。`./vim-manager status --profile default` 现在只剩两项外部工具缺口：

- `shellcheck`
- `shfmt`

这两项没有在本轮内补齐，不是脚本没有接入，而是实际执行 `./vim-manager deps` 时，Homebrew 自动更新命中了镜像长队列，等待时间过长，因此中止了该次包管理器运行。换言之：

- **已确认**：脚本已经支持自动安装这两项
- **尚未确认**：当前这台机器在 Homebrew 网络恢复顺畅时是否能一次性装成

如果后续继续推进，可以直接在用户环境重跑 `./vim-manager deps`，或单独安装 `shellcheck` / `shfmt` 后再执行一次 `status` 做收口。

## 6. 已证实结论 vs 尚待环境完成的事项

**已证实的：**

- IDE 层已经进入托管插件清单与默认 profile。
- Vim 启动、运行时加载、自检命令和文档入口彼此一致。
- `minimal` profile 不会误要求 IDE 插件。
- npm 语言服务器包已经装到本机并被 `status` 识别。

**仍依赖外部环境完成的：**

- `shellcheck` 与 `shfmt` 的本机安装结果。
- 真正打开真实项目文件时，各语言服务器在用户常用仓库中的实际表现。

