# 🎯 Vim Settings - 统一配置管理

现代化、可移植的 Vim 环境配置，支持一键部署和智能适配。

## ✨ 特性

- 🚀 **一键安装**: 单个脚本完成所有配置
- 🎨 **界面美化**: Cascadia Code 字体 + 细分割线 + 隐藏波浪号
- 📁 **文件管理**: NERDTree 默认关闭，快捷键切换
- 🔧 **智能适配**: 自动检测 vim/nvim/macvim，terminal/GUI
- 📦 **插件管理**: 本地插件，无需网络依赖
- 🍎 **MacVim 优化**: 大窗口 + 透明度 + Mac 快捷键
- 🌈 **主题支持**: 多主题备选，优雅降级

## 🚀 快速开始

### 一键安装

```bash
# 克隆配置
git clone <repository> ~/.vim-settings
cd ~/.vim-settings

# 运行安装（会自动链接配置文件）
./vim-manager install
```

### 手动链接配置

如果只想链接配置文件而不安装插件：

```bash
# 链接配置文件到用户目录
./vim-manager config link

# 检查链接状态
./vim-manager status
```

### 选择安装方案

1. **基础安装** - vim + 基础插件 (推荐新手)
2. **完整安装** - 所有插件 + 主题 + 字体
3. **MacVim 专用** - GUI 优化 + 完整功能
4. **自定义安装** - 手动选择组件

## 🔧 管理命令

```bash
# 基础操作
./vim-manager install          # 安装环境
./vim-manager status           # 检查状态
./vim-manager start            # 启动 MacVim

# 插件管理
./vim-manager plugins list     # 列出插件
./vim-manager plugins update   # 更新插件

# 主题管理
./vim-manager themes list      # 列出主题
./vim-manager themes install   # 安装所有主题
./vim-manager themes switch    # 交互式切换主题
./vim-manager themes current   # 显示当前主题

# 配置管理
./vim-manager config link      # 链接配置文件
```

## ⌨️ 快捷键

| 功能 | 快捷键 | 说明 |
|------|--------|------|
| 文件树切换 | `Space + e` 或 `Ctrl + n` | 开关 NERDTree |
| 保存文件 | `Space + w` | 快速保存 |
| 退出 | `Space + q` | 快速退出 |
| 取消高亮 | `Space + h` | 清除搜索高亮 |
| 分割窗口 | `Space + sv/sh` | 垂直/水平分割 |
| 窗口切换 | `Ctrl + hjkl` | 方向键切换窗口 |

### MacVim 专用快捷键

| 功能 | 快捷键 | 说明 |
|------|--------|------|
| 新标签页 | `Cmd + t` | 新建标签 |
| 关闭标签 | `Cmd + w` | 关闭当前标签 |
| 文件树 | `Cmd + e` | NERDTree 切换 |
| 标签切换 | `Cmd + 1-9` | 快速切换标签 |
| 重置字体 | `Cmd + 0` | 恢复 Cascadia Code |

## 📁 项目结构

```
vim_settings/
├── vimrc                    # 统一配置文件 (智能适配)
├── vim-manager              # 统一管理脚本
├── README.md                # 使用说明
├── plugins/                 # 本地插件目录
├── colors/                  # 主题目录
└── docs/                    # 详细文档
    └── vim-guide.md         # Vim 完整指南
```

## 🎨 界面配置

### 字体设置
- **主字体**: Cascadia Code (15pt)
- **中文字体**: PingFang SC (15pt)
- **备用字体**: SF Mono, Monaco, Menlo

### 美化特性
- ✅ 细分割线 (`│`)
- ✅ 隐藏空行波浪号
- ✅ 相对行号 + 绝对行号
- ✅ 高亮当前行
- ✅ 状态栏美化

### MacVim 专用
- 🖥️ 大窗口 (140x45)
- 🌟 透明度效果
- 🎯 窗口自动居中
- 🚫 隐藏工具栏/菜单栏

## 📦 插件列表

### 基础插件
- **NERDTree** - 文件树浏览器
- **vim-airline** - 状态栏美化
- **vim-commentary** - 快速注释
- **vim-surround** - 包围字符编辑

### 完整插件
- **vim-fugitive** - Git 集成
- **vim-polyglot** - 语法高亮增强
- **auto-pairs** - 自动括号匹配
- **vim-sensible** - 基础设置优化

## 🎨 主题管理

### 安装主题

```bash
# 一键安装所有主题
./vim-manager themes install
```

### 可用主题

| 主题名称 | 风格 | 描述 |
|----------|------|------|
| **gruvbox** | 深色 | 温暖的复古色调，护眼且优雅 |
| **molokai** | 深色 | 经典的深色主题，对比度高 |
| **solarized** | 深色/浅色 | 科学设计的护眼配色方案 |
| **dracula** | 深色 | 现代深色主题，色彩丰富 |
| **onedark** | 深色 | Atom 编辑器的经典深色主题 |
| **nord** | 深色 | 北欧风格的冷色调主题 |
| **tokyonight** | 深色 | 东京夜景风格，蓝紫色调 |
| **papercolor** | 浅色 | 清新的白色主题，适合白天 |

### 切换主题

```bash
# 交互式切换主题
./vim-manager themes switch

# 查看当前主题
./vim-manager themes current

# 列出所有已安装主题
./vim-manager themes list
```

### 在 Vim 中切换主题

```vim
" 方法1: 直接命令
:colorscheme gruvbox

" 方法2: 使用主题切换器
:source switch_theme.vim
:SwitchTheme

" 方法3: 临时预览主题
:colorscheme dracula    " 临时切换，不保存
```

### 设置默认主题

编辑配置文件设置启动时的默认主题：

```vim
" 在 vimrc 中添加或修改
colorscheme gruvbox
set background=dark     " 或 light
```

## 🔧 自定义配置

### 修改字体
```vim
" 在 vimrc 中修改
set guifont=JetBrains\ Mono:h14
```

### 调整窗口大小
```vim
" MacVim 窗口大小
set columns=120
set lines=40
```

### 添加插件
```bash
# 手动克隆到 plugins 目录
git clone <plugin-url> plugins/<plugin-name>

# 或使用管理脚本
./vim-manager plugins add <plugin-url>
```

## 🐛 故障排除

### 配置未生效
```bash
# 重新链接配置文件
./vim-manager config link

# 检查状态
./vim-manager status
```

### 插件问题
```bash
# 更新所有插件
./vim-manager plugins update

# 清理插件缓存
./vim-manager plugins clean
```

### MacVim 启动问题
```bash
# 检查 MacVim 安装
which mvim

# 重新安装 MacVim
brew install --cask macvim
```

## 📚 详细文档

- [Vim 完整指南](docs/vim-guide.md) - 传统 Vim 详细配置和使用教程
- [主题预览指南](docs/theme-guide.md) - 主题安装、切换和自定义指南

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个配置！

## 📄 许可证

MIT License - 自由使用和修改
