# Vim 配置管理器 c.md

## 常用运行命令

```bash
cd ~/vim_settings   # 或你的克隆路径

./vim-manager deps          # 安装/检查 rg、fzf、node、vim 等依赖
./vim-manager bootstrap      # deps + install（等价于脚本 bootstrap 流程）

./vim-manager install        # 链接配置并安装托管插件
./vim-manager update        # 更新插件
./vim-manager status        # 检查依赖、符号链接与插件
./vim-manager clean         # 清理未管理插件
./vim-manager uninstall      # 移除符号链接（不删仓库）
./vim-manager help           # 帮助

./scripts/bootstrap.sh       # 全流程安装（chmod +x 后）
./scripts/cleanup.sh         # 清理临时文件（项目根以外的路径见脚本内注释）
```

## 结果路径

- Vim：`vimrc` → `settings/`、`colors/`；持久撤销默认在 `~/.local/state/vim/undo/`（参见 `settings/basic.vim`）。
- 管理脚本：`vim-manager`、`vim_manager_modules/`、`scripts/`。

## 常看文档

- `docs/INDEX.md`
- `docs/tutorials/tutorial.md`、`docs/tutorials/keybindings.md`
- `docs/legacy/changelog.md`
- `docs/specs/`、`Agents.md`、`README.md`
