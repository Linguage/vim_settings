# 便携式 Vim 配置

[English](README.en.md) | [简体中文](README.zh.md)

本仓库包含一个高度可定制的 Vim 配置，专为现代高效的工作流程设计。它配备了一个强大的管理脚本，可以一键安装并在多台设备上轻松维护。

## 主要特性

- **现代化界面**：使用 `vim-airline` 和 `vim-airline-themes` 提供美观且信息丰富的状态栏和标签栏。
- **图标支持**：集成 `nvim-web-devicons`，为 NERDTree 提供简洁现代的文件和文件夹图标。
- **增强的文件导航**：使用 `preservim/nerdtree` 提供直观的文件系统浏览器。
- **Git 集成**：利用 `tpope/vim-fugitive` 实现 Vim 内无缝的 Git 命令操作。
- **智能编辑**：包含 `vim-surround`、`vim-commentary` 和 `auto-pairs` 等必备插件，加速常见编辑任务。
- **多语言支持**：通过 `vim-polyglot` 为多种编程语言提供丰富的语法高亮和缩进支持。

## 先决条件

1.  **Git**：用于克隆插件。可以通过运行 `git --version` 检查是否已安装。
2.  **Nerd Font**：需要安装支持图标的字体。我们推荐使用 [Hack Nerd Font](https://www.nerdfonts.com/font-downloads) 或其他 Nerd Font 字体。

## 安装与管理

本配置通过一个简单而强大的 shell 脚本 `vim-manager` 进行管理。

### 快速安装

在新机器上设置此配置，请按照以下步骤操作：

1.  将本仓库克隆到您选择的位置：
    ```bash
    git clone <your-repo-url> ~/vim_settings
    ```
2.  进入目录：
    ```bash
    cd ~/vim_settings
    ```
3.  使管理脚本可执行：
    ```bash
    chmod +x vim-manager
    ```
4.  运行一键安装程序：
    ```bash
    ./vim-manager install
    ```

安装完成！脚本将自动备份现有的 Vim 配置，创建必要的符号链接，并安装所有必需的插件。

### 可用命令

`vim-manager` 脚本提供了一套完整的命令，方便维护：

-   `./vim-manager install`
    安装配置，链接文件，并从清单中克隆所有插件。

-   `./vim-manager update`
    更新所有已安装的插件到最新版本。

-   `./vim-manager status`
    检查符号链接状态，并列出所有托管和非托管的插件。

-   `./vim-manager clean`
    移除 `plugins/` 目录中未在清单中列出的插件。删除前会显示确认提示。

-   `./vim-manager uninstall`
    安全地移除所有符号链接和整个 `plugins/` 目录。您的源配置文件不会被删除。

-   `./vim-manager help`
    显示包含所有可用命令的帮助信息。

## 文档

- [快捷键指南](./docs/keybindings.zh.md) - 所有自定义快捷键和插件命令的参考
- [更新日志](./docs/changelog.zh.md) - 版本更新历史记录

## 故障排除

如果遇到任何问题，请尝试以下步骤：

1. 确保您已安装 Nerd Font 并在终端中启用
2. 运行 `./vim-manager status` 检查配置状态
3. 查看 `:checkhealth` 的输出以获取更多诊断信息

## 贡献

欢迎提交问题和拉取请求。请确保您的更改符合项目的代码风格。

## 许可证

[MIT 许可证](LICENSE)
