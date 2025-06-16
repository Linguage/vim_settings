<div align="center">

# Vim 配置管理器

**v3.0 - 模块化重构版本**

[English](README.en.md) | [简体中文](README.zh.md)

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

# 一键安装
./vim-manager install
```

## 📚 文档

- [English Documentation](README.en.md) - 英文文档
- [中文文档](README.zh.md) - 详细的中文说明
- [快捷键参考](./docs/keybindings.zh.md) - 按键绑定和命令参考
- [更新日志](./docs/changelog.zh.md) - 版本历史和变更记录

## 🔧 管理命令

| 命令 | 功能 | 说明 |
|------|------|------|
| `./vim-manager install` | 安装 | 一键安装配置和所有插件 |
| `./vim-manager update` | 更新 | 更新所有插件到最新版本 |
| `./vim-manager status` | 状态 | 检查配置和插件状态 |
| `./vim-manager clean` | 清理 | 移除未管理的插件 |
| `./vim-manager uninstall` | 卸载 | 完全移除配置 |
| `./vim-manager help` | 帮助 | 显示帮助信息 |

## 📊 版本亮点

### v3.0 (2025-06-16) - 模块化重构
- 🎯 **代码减少 63%**：从 1075 行精简到 396 行
- 🧩 **模块化设计**：拆分为 4 个专用模块
- ⚡ **性能优化**：更快的启动和响应速度
- 🛡️ **功能聚焦**：移除冗余，专注核心功能

## 许可证

[MIT 许可证](LICENSE)
