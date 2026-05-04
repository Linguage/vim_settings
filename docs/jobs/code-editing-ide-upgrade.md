# 代码编辑 IDE 化升级

- `状态`：doing
- `最近更新`：2026-05-04
- `lifecycle`：active patch
- `entrypoint`：`vimrc` 加载 `settings/code_editing.vim`，`vim-manager` 负责插件与依赖安装
- `outputs`：`settings/code_editing.vim`、插件清单、依赖脚本、快捷键文档
- `summary`：默认 profile 引入 Vim 原生 LSP、异步补全、ALE 诊断/修复、EditorConfig 与测试入口；`minimal` profile 保持轻量
- `smoke`：`vim -Nu vimrc -n -es +'qa!'`、`./vim-manager status --profile minimal`、`./vim-manager status --profile default`
- `freeze rule`：默认 profile 能完成 Vim 启动、status 自检和基本 LSP/格式化入口后归档到 `docs/legacy/`

## 本次完成

- 新增 IDE 插件清单：`vim-lsp`、`vim-lsp-settings`、`asyncomplete.vim`、`asyncomplete-lsp.vim`、`ale`、`editorconfig-vim`、`vim-test`。
- 新增 `settings/code_editing.vim`，集中维护 LSP、补全、诊断、格式化和测试快捷键。
- 更新依赖安装与状态检查，默认 profile 会报告 IDE 工具缺失。
- 调整保存前删除尾随空格逻辑，跳过 Markdown、diff 与 patch。

## 下一步

- 安装新增插件后复测 `scriptnames` 与常用 LSP 命令。
- 根据真实日常语言继续补充 formatter / linter 策略。

## 非目标

- 本轮不引入 `coc.nvim`。
- 本轮不做 DAP 断点调试。
