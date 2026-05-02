# 上手教程

本教程面向**第一次使用本仓库**的读者：从克隆到日常编辑与维护的最短路径。更细的按键见 [快捷键与使用指南](keybindings.md)，版本历史见 [更新日志](../legacy/changelog.md)。全站索引见 [INDEX.md](../INDEX.md)。

## 1. 你需要什么

- **Git**：克隆仓库、拉取插件（`git --version`）。
- **Bash**：运行 `vim-manager`（macOS / Linux 一般已有）。
- **Vim**：建议较新版本。
- **Nerd Font**（推荐）：状态栏与文件树图标，详见根目录 `README.md`。

## 2. 安装配置

```bash
git clone <你的仓库地址> ~/vim_settings
cd ~/vim_settings
chmod +x vim-manager
./vim-manager install
```

装完后可先检查：

```bash
./vim-manager status
```

## 3. 第一次打开 Vim

```bash
vim
```

建议立刻记住：`Leader` 为**空格**；常用映射（普通模式）如 `<leader>e` 编辑 `vimrc`、`<leader>r` 重载配置、`<leader>w` 保存。完整表见 [快捷键与使用指南](keybindings.md)。

## 4. 文件树（NERDTree）

- `<leader>n`：打开/关闭 NERDTree
- `<leader>f`：在树中定位当前文件

## 5. 日常维护命令

| 命令 | 用途 |
|------|------|
| `./vim-manager update` | 更新已安装插件 |
| `./vim-manager status` | 查看链接与插件状态 |
| `./vim-manager clean` | 清理未被清单管理的插件目录（有风险，确认提示） |
| `./vim-manager help` | 帮助 |

## 6. 接下来读什么

- [文档索引 INDEX.md](../INDEX.md)
- [架构说明](../specs/ARCHITECTURE.md)、[路线图](../specs/ROADMAP.md)

若有故障，见根目录 `README.md` 的「故障排除」，并运行 `./vim-manager status`。
