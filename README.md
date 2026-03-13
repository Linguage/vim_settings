<div align="center">

# Vim 配置管理器

**v3.3 - 模块化重构版本**

</div>

一个现代化、高度可定制的 Vim 配置，专为高效的开发工作流程设计。配备强大的模块化管理脚本，支持一键安装和跨设备轻松维护。

## ✨ 项目特点

- 🚀 **一键安装和配置** - 使用 `vim-manager` 脚本快速部署
- 🧩 **模块化架构** - v3.0 采用清晰的模块化设计，易于维护
- 🎨 **现代化界面** - 美观的状态栏和丰富的图标支持
- 📁 **强大的文件浏览** - NERDTree 文件浏览器和搜索功能
- 🛠️ **完整的开发工具链** - Git 集成、智能编辑、多语言支持
- 🔄 **简单的更新和维护** - 自动插件管理和状态检查

## 🚀 快速开始

```bash
# 克隆仓库
git clone <your-repo-url> ~/vim_settings

# 进入目录
cd ~/vim_settings

# 给脚本执行权限
chmod +x vim-manager scripts/bootstrap.sh scripts/install_dependencies.sh

# 全自动安装依赖、配置与插件
./scripts/bootstrap.sh
```

## 📚 文档

- [详细文档](./docs/getting-started.md) - 完整的安装、配置和使用指南
- [快捷键参考](./docs/reference/keybindings.zh.md) - 按键绑定和命令参考
- [更新日志](./docs/changelogs.md) - 版本历史和变更记录

## 🗂️ 目录说明

- `vim-manager`：主入口脚本，保留在根目录便于直接执行
- `vim_manager_modules/`：管理脚本模块
- `scripts/`：辅助维护脚本
- `docs/reference/`：当前有效的参考文档
- `docs/history/`：历史版本与阶段总结
- `docs/plans/`：规划类文档
- `docs/legacy/`：保留的旧文档
- `docs/notes/`：个人笔记和写作实验

## 🔧 管理命令

| 命令 | 功能 | 说明 |
|------|------|------|
| `./vim-manager deps` | 依赖 | 安装外部依赖，如 `vim`、`rg`、`fzf`、`node` |
| `./vim-manager install` | 安装 | 链接配置、安装托管插件并执行插件后安装步骤 |
| `./vim-manager bootstrap` | 全装 | 从零开始安装依赖、配置与插件 |
| `./vim-manager update` | 更新 | 更新所有插件并重新执行插件后安装步骤 |
| `./vim-manager status` | 状态 | 检查依赖、符号链接、托管插件和未托管插件 |
| `./vim-manager clean` | 清理 | 移除未管理的插件 |
| `./vim-manager uninstall` | 卸载 | 移除由脚本创建的符号链接 |
| `./vim-manager help` | 帮助 | 显示帮助信息 |

辅助维护脚本位于 `scripts/`：
- `scripts/install_dependencies.sh`：安装依赖
- `scripts/bootstrap.sh`：执行全自动安装
- `scripts/cleanup.sh`：清理项目根目录中的临时文件和空目录

## 📊 版本亮点

### v3.3 (2026-03-13) - 功能完善
- 🧹 **移除冗余**：清理不使用的插件和配置
- 📝 **文档更新**：重构文档结构和内容组织
- 🔧 **配置优化**：改进插件加载和依赖管理

### v3.0 (2025-06-16) - 模块化重构
- 🎯 **代码减少 63%**：从 1075 行精简到 396 行
- 🧩 **模块化设计**：拆分为 4 个专用模块
- ⚡ **性能优化**：更快的启动和响应速度
- 🛡️ **功能聚焦**：移除冗余，专注核心功能

## 许可证

[MIT 许可证](LICENSE)
