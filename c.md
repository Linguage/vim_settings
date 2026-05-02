# Vim 配置管理器 c.md

## 常用运行命令

```bash
cd ~/vim_settings   # 或你的克隆路径

./vim-manager deps          # 安装/检查 rg、fzf、node、vim 等依赖
./vim-manager bootstrap      # deps + install（等价于脚本 bootstrap 流程）

./vim-manager install        # 链接配置并安装托管插件
./vim-manager install --profile minimal  # 仅安装基础编辑与检索插件
./vim-manager update        # 更新插件
./vim-manager status --profile default   # 检查依赖、符号链接与默认 profile 插件
./vim-manager clean         # 清理未管理插件
./vim-manager uninstall      # 移除符号链接（不删仓库）
./vim-manager help           # 帮助

./scripts/bootstrap.sh       # 全流程安装（chmod +x 后）
./scripts/cleanup.sh         # 清理临时文件（项目根以外的路径见脚本内注释）
```

## 结果路径

- Vim：`vimrc` → `settings/`、`colors/`；状态文件集中在 `~/.local/state/vim/`（`undo/`、`backup/`、`view/`、预留 `swap/`；参见 `settings/basic.vim`）。
- 管理脚本：`vim-manager`、`vim_manager_modules/`、`scripts/`。
- 本机覆盖：`~/.vimrc.before.local`（默认配置前加载）、`~/.vimrc.local`（默认配置后加载），不由仓库管理。

## 常用新增入口

- `<leader>ff`：项目文件查找；`<leader>fg`：fzf/ripgrep 交互搜索；`<leader>gf`：quickfix 搜索。
- `<leader>u`：撤销树；`<leader>gS`：Git 变更标记开关；`]h` / `[h`：跳转 Git hunk；`ga`：通用交互对齐。
- `<leader>ee`：文件树；`<leader>ef` / `<leader>nf`：在文件树中定位当前文件；`<leader>gC`：查找合并冲突标记。
- `<leader>gi`：交互式暂存当前文件；`<leader>gD`：打开 Fugitive diffsplit。
- 本地开关可写入 `~/.vimrc.before.local`：`g:vim_settings_no_autochdir`、`g:vim_settings_keep_trailing_whitespace`、`g:vim_settings_no_restore_cursor`、`g:vim_settings_no_listchars`。

## 常看文档

- `docs/INDEX.md`
- `docs/tutorials/tutorial.md`、`docs/tutorials/keybindings.md`、`docs/tutorials/local-overrides.md`
- `docs/legacy/changelog.md`
- `docs/specs/`、`Agents.md`、`README.md`
