# Vim 配置管理器 c.md

## 常用运行命令

```bash
cd ~/vim_settings   # 或你的克隆路径

./vim-manager install    # 一键安装配置与插件
./vim-manager update    # 更新插件
./vim-manager status    # 检查状态
./vim-manager clean    # 清理未管理插件
./vim-manager uninstall # 卸载
./vim-manager help    # 帮助
```

## 结果路径

- Vim 入口：`vimrc`，由安装脚本链接到用户目录（参见 `vim_manager_modules`）
- 模块配置：`settings/`、`colors/`
- 管理脚本：`vim-manager`、`vim_manager_modules/`

## 常看文档

- `docs/INDEX.md`：文档总索引（`docs/` 根目录仅保留此导航文件）
- `docs/tutorials/tutorial.md`、`docs/tutorials/keybindings.md`：教程与快捷键
- `docs/legacy/changelog.md`：更新日志（归档路径下维护）
- `docs/specs/`：BLUEPRINT / ARCHITECTURE / ROADMAP
- `README.md`：项目说明与快速开始
