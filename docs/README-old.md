# Vim Settings Repository

这个仓库包含了完整的 Vim 配置文件和教程，帮助你快速搭建一个功能强大的编辑器环境。

## 📁 文件说明

### Vim 配置文件
- **`.vimrc`** - 完整的 Vim 配置文件，包含所有基础和高级设置
- **`macvim_config.vim`** - MacVim 专用配置 (GUI界面优化)
- **`setup_vim.sh`** - 自动化 Vim 环境安装脚本
- **`start_macvim.sh`** - MacVim 启动和测试脚本

### 教程文档
- **`vim-guide.md`** - 详细的 Vim 配置和使用指南
- **`Vim环境配置指南.md`** - 传统 Vim 环境配置完整指南

## 🚀 快速开始

### 方式一：一键部署（推荐）

```bash
# 运行一键部署脚本
./deploy.sh
```

部署选项：
1. **基础部署** - vim配置 + 基础插件（推荐新手）
2. **完整部署** - 所有推荐插件 + 主题
3. **自定义部署** - 手动选择插件
4. **仅更新现有插件**

### 方式二：手动安装

```bash
# 1. 创建配置文件链接
./link_vimrc.sh

# 2. 安装插件
./install_plugins.sh

# 选择推荐套装：
# - 输入 13: 状态栏套装 (vim-airline + 主题)
# - 输入 14: 基础开发套装 (注释+包围+文件树+状态栏)
```

### 方式三：MacVim GUI 环境

如果你更喜欢图形界面的 Vim：

```bash
# 运行部署脚本并选择自定义部署
./deploy.sh
# 选择选项 3，系统会询问是否配置 MacVim

# 或者直接启动 MacVim 测试
./start_macvim.sh
```

MacVim 配置特性：
- **大窗口**: 默认 140x45 大小
- **优化字体**: SF Mono 15pt (或其他编程字体)
- **界面简洁**: 隐藏工具栏、滚动条等
- **快捷键**: Cmd+T 新标签页, Cmd+数字键切换标签
- **透明度**: 轻微透明效果
- **自动居中**: 启动时窗口自动居中

## 🎯 主要功能

### Vim 配置特性
- ✅ 语法高亮和文件类型检测
- ✅ 智能缩进和自动补全
- ✅ 搜索增强（高亮、大小写智能）
- ✅ 文件备份和持久化撤销
- ✅ 自定义状态栏
- ✅ 窗口和缓冲区管理
- ✅ Git 集成支持
- ✅ 多种颜色主题

### 快捷键系统
- **Leader 键**: 空格键 `<Space>`
- **文件操作**: `<Space>w` 保存, `<Space>q` 退出
- **窗口导航**: `Ctrl+h/j/k/l` 在窗口间移动
- **配置管理**: `<Space>ev` 编辑配置, `<Space>sv` 重新加载

### 插件支持
- **NERDTree**: 文件树浏览器
- **vim-commentary**: 快速注释
- **vim-surround**: 编辑包围字符
- **vim-fugitive**: Git 集成
- **vim-polyglot**: 多语言语法支持

## 📚 学习资源

### 内置教程
```bash
# Vim 交互式教程
vimtutor

# 在 Vim 中查看帮助
:help
:help quickref
```

### 文档阅读顺序
1. 新手：先阅读 `Vim环境配置指南.md`
2. 进阶：学习 `vim-guide.md`
3. 日常：使用快捷键参考

## 🔧 自定义配置

### 修改主题
编辑 `.vimrc` 文件，找到主题设置部分：
```vim
colorscheme molokai    " 可改为 solarized, gruvbox 等
```

### 添加插件
在 `~/.vim/pack/plugins/start/` 目录下克隆插件：
```bash
cd ~/.vim/pack/plugins/start/
git clone https://github.com/author/plugin-name.git
```

### 调整快捷键
编辑 `.vimrc`，在快捷键设置部分添加：
```vim
nnoremap <Leader>自定义键 :命令<CR>
```

## 🎨 支持的文件类型

- **编程语言**: Python, JavaScript, TypeScript, Go, Rust, Java, C/C++
- **标记语言**: HTML, CSS, Markdown, XML, JSON, YAML
- **配置文件**: Vim script, Shell script, Docker, 等

## 🛠️ 故障排除

### 常见问题

#### 配置未生效
```bash
# 检查配置文件位置
ls -la ~/.vimrc

# 重新加载
vim -c "source ~/.vimrc"
```

#### 插件未加载
```bash
# 检查插件目录
ls -la ~/.vim/pack/plugins/start/
```

#### 颜色显示问题
确保终端支持 256 色或真彩色：
```bash
echo $TERM
export TERM=xterm-256color
```

### 重置配置
如果遇到问题，可以重置：
```bash
# 删除配置
rm -rf ~/.vim ~/.vimrc

# 重新运行安装脚本
./setup_vim.sh
```

## 📋 系统要求

- **操作系统**: macOS, Linux, Windows (WSL)
- **Vim 版本**: 8.0+ (推荐 8.2+)
- **可选依赖**: Git (用于插件管理)

## 📦 目录结构

```
vim_settings/
├── vimrc                      # 统一 Vim 配置文件
├── vim-manager               # 统一管理脚本
├── vim-guide.md              # Vim 详细指南
├── Vim环境配置指南.md        # Vim 配置指南
└── README.md                 # 本文件
```

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这些配置！

## 📄 许可证

本项目采用 MIT 许可证，详见各个配置文件的注释。

---

**Happy Vimming! 🎉**

如果这些配置对你有帮助，请给个 ⭐ 支持一下！
