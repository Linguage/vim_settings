# AGENTS.md

本文档为 AI 助手提供项目上下文和操作指南。

---

## 项目概述

这是一个模块化的 Vim 配置管理项目，使用 `vim-manager` 脚本进行配置和插件管理。项目支持一键安装、自动化插件管理和跨设备同步。

**当前版本**：v3.3  
**最后更新**：2026-03-13  
**主要运行环境**：macOS / Linux 终端 Vim

---

## AI 安装部署指南

### 快速部署流程

当需要在新环境中部署此 Vim 配置时，按以下步骤操作：

#### 1. 前置条件检查

在开始安装前，确认以下条件：

```bash
# 检查 Git 是否已安装
git --version

# 检查当前是否已有 Vim 配置
ls -la ~/.vim ~/.vimrc 2>/dev/null
```

#### 2. 克隆仓库

```bash
# 克隆到用户目录
git clone <repository-url> ~/vim_settings

# 进入项目目录
cd ~/vim_settings
```

#### 3. 执行自动化安装

```bash
# 赋予脚本执行权限
chmod +x vim-manager scripts/bootstrap.sh scripts/install_dependencies.sh

# 执行一键安装（依赖 + 配置 + 插件）
./scripts/bootstrap.sh
```

#### 4. 验证安装

```bash
# 检查符号链接是否正确
ls -la ~/.vim ~/.vimrc

# 检查插件状态
./vim-manager status

# 测试 Vim 启动
vim -Nu vimrc -c "q"
```

### 安装后配置

#### 必需配置

1. **安装 Nerd Font**：
   - 推荐字体：[Hack Nerd Font](https://www.nerdfonts.com/font-downloads)
   - 在终端中启用已安装的 Nerd Font

2. **重启终端**：
   - 使符号链接生效
   - 确保 Vim 正确加载配置

#### 可选配置

- 配置 Git 用户信息（如果使用 vim-fugitive）
- 调整主题：编辑 `~/.vim/settings/colorscheme.vim`
- 自定义映射：编辑 `~/.vim/settings/mappings.vim`

### 故障排除

#### 常见问题

1. **符号链接冲突**：
   ```bash
   # 查看现有配置
   ls -la ~/.vim ~/.vimrc
   
   # 手动备份
   mv ~/.vim ~/.vim.backup.$(date +%Y%m%d)
   mv ~/.vimrc ~/.vimrc.backup.$(date +%Y%m%d)
   
   # 重新安装
   ./vim-manager install
   ```

2. **插件加载失败**：
   ```bash
   # 检查插件目录
   ls -la ~/vim_settings/plugins/
   
   # 重新安装插件
   ./vim-manager update
   ```

3. **图标显示异常**：
   - 确认已安装并启用 Nerd Font
   - 重启终端

4. **权限问题**：
   ```bash
   # 确保脚本有执行权限
   chmod +x vim-manager scripts/*.sh
   ```

#### 清理与重置

```bash
# 清理未托管的插件
./vim-manager clean

# 完全卸载（保留仓库）
./vim-manager uninstall

# 重新安装
./vim-manager install
```

---

## 项目结构

```
vim_settings/
├── vim-manager                    # 主管理脚本（主入口）
├── vim_manager_modules/           # 管理脚本模块
│   ├── config.sh                  # 配置和插件清单
│   ├── helpers.sh                 # 工具函数
│   ├── core_logic.sh              # 核心业务逻辑
│   └── commands.sh                # 命令处理器
├── scripts/                       # 辅助维护脚本
│   ├── bootstrap.sh               # 全自动安装脚本
│   ├── install_dependencies.sh    # 依赖安装脚本
│   └── cleanup.sh                 # 清理脚本
├── vimrc                          # 主配置文件
├── settings/                      # 模块化配置
│   ├── basic.vim                  # 基础设置
│   ├── ui.vim                     # 界面设置
│   ├── mappings.vim               # 按键映射
│   ├── plugins.vim                # 插件加载
│   ├── plugin_configs.vim         # 插件配置
│   └── colorscheme.vim            # 主题配置
├── colors/                        # 颜色主题
├── plugins/                       # 插件目录（自动管理）
├── docs/                          # 文档目录
│   ├── getting-started.md         # 详细使用文档
│   ├── changelogs.md              # 更新日志
│   ├── reference/                 # 参考文档
│   └── worknotes/                 # 工作笔记
└── AGENTS.md                      # 本文件
```

---

## 关键文件说明

### 管理脚本

| 文件 | 用途 | 重要程度 |
|------|------|----------|
| `vim-manager` | 主入口脚本，所有命令的入口 | ⭐⭐⭐ |
| `vim_manager_modules/config.sh` | 插件清单和配置定义 | ⭐⭐⭐ |
| `scripts/bootstrap.sh` | 一键安装流程 | ⭐⭐⭐ |
| `scripts/install_dependencies.sh` | 外部依赖安装 | ⭐⭐ |

### 配置文件

| 文件 | 用途 | 修改频率 |
|------|------|----------|
| `vimrc` | 主配置入口 | 低 |
| `settings/basic.vim` | 基础 Vim 设置 | 中 |
| `settings/mappings.vim` | 按键映射 | 高 |
| `settings/plugin_configs.vim` | 插件特定配置 | 中 |
| `settings/colorscheme.vim` | 主题配置 | 低 |

### 文档文件

| 文件 | 用途 |
|------|------|
| `README.md` | 项目主 README |
| `docs/getting-started.md` | 详细使用指南 |
| `docs/changelogs.md` | 版本变更记录 |
| `docs/reference/keybindings.zh.md` | 快捷键参考 |

---

## 核心命令参考

### vim-manager 命令

```bash
# 安装外部依赖（vim、rg、fzf、node）
./vim-manager deps

# 安装配置、链接文件、克隆插件
./vim-manager install

# 完整安装（依赖 + 配置 + 插件）
./vim-manager bootstrap

# 更新所有插件
./vim-manager update

# 检查状态（依赖、符号链接、插件）
./vim-manager status

# 清理未托管的插件
./vim-manager clean

# 卸载配置（仅移除符号链接）
./vim-manager uninstall

# 显示帮助
./vim-manager help
```

### 辅助脚本

```bash
# 完整自动化安装
./scripts/bootstrap.sh

# 安装外部依赖
./scripts/install_dependencies.sh

# 清理项目临时文件
./scripts/cleanup.sh
```

---

## 插件清单

项目当前托管 **14 个插件**：

| 插件 | 功能 | 关键映射 |
|------|------|----------|
| `vim-airline` | 状态栏 | - |
| `vim-airline-themes` | 状态栏主题 | - |
| `nerdtree` | 文件浏览器 | `<C-y>` / `<leader>n` |
| `vim-devicons` | 图标支持 | - |
| `vim-fugitive` | Git 集成 | `:Gstatus` / `:Gblame` |
| `vim-surround` | 包围编辑 | `cs` / `ds` / `ys` |
| `vim-commentary` | 注释切换 | `gc` |
| `vim-polyglot` | 语言支持 | - |
| `auto-pairs` | 自动配对 | - |
| `vim-sensible` | 合理默认 | - |
| `fzf.vim` | 模糊搜索 | `<C-p>` / `<leader>fc` |
| `csv.vim` | CSV 查看 | `:CSVTable` |
| `markdown-preview.nvim` | Markdown 预览 | `:MarkdownPreview` |
| `vim-which-key` | 快捷键提示 | `<leader>` |

---

## 开发指南

### 修改配置

1. **修改基础设置**：
   - 编辑 `settings/basic.vim`
   - 避免在 `vimrc` 中直接添加设置

2. **添加新映射**：
   - 编辑 `settings/mappings.vim`
   - 使用 `nnoremap` / `vnoremap` / `inoremap`（非递归映射）
   - 同时更新 `docs/reference/keybindings.zh.md`

3. **添加新插件**：
   - 编辑 `vim_manager_modules/config.sh` 中的 `PLUGINS` 数组
   - 在 `settings/plugins.vim` 中添加到 `runtimepath`
   - 在 `settings/plugin_configs.vim` 中配置插件
   - 更新 `docs/changelogs.md`

### 代码风格

- **Shell 脚本**：遵循 Google Shell Style Guide
- **Vim 配置**：使用非递归映射，添加描述性注释
- **文档**：使用 Markdown，保持简洁清晰

### 提交规范

```
<type>(<scope>): <subject>

<body>

<footer>
```

**类型**：
- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档更新
- `refactor`: 重构
- `chore`: 维护任务

**示例**：
```
feat(plugin): add fzf.vim for fuzzy search

- Add fzf.vim to plugin manifest
- Add Ctrl-p mapping for file search
- Add leader fc/fb/fh for command/buffer/history

Closes #123
```

---

## 环境要求

### 必需依赖

- **Git**：克隆插件
- **Vim**：支持 `+clipboard` 的版本
- **Nerd Font**：图标显示

### 推荐依赖

- **ripgrep (rg)**：项目全文搜索
- **fzf**：模糊文件查找
- **Node.js**：markdown-preview 插件依赖

### 平台支持

- ✅ macOS（主要支持）
- ✅ Linux
- ⚠️ Windows（未测试）

---

## 测试与验证

### 快速测试

```bash
# 测试配置加载
vim -Nu vimrc -c "q"

# 检查插件状态
./vim-manager status

# 检查特定映射
vim -Nu vimrc -c "verbose nmap <leader>n" -c "q"
```

### 完整验证

1. 启动 Vim 并检查：
   - 状态栏显示正常（airline）
   - NERDTree 图标显示正确
   - `<C-p>` 文件搜索工作
   - `<leader>n` 文件树切换工作

2. Git 工作流测试：
   - `:Gstatus` 显示 Git 状态
   - `:Gblame` 显示 blame 信息

3. 编辑功能测试：
   - `gc` 注释/取消注释
   - `cs"`'` 修改包围字符
   - 自动括号配对

---

## 注意事项

### AI 助手须知

1. **不要直接修改 `~/.vimrc`**：
   - 此项目使用符号链接管理
   - 所有修改应在仓库内进行

2. **修改插件清单后需要更新**：
   - 修改 `config.sh` 后运行 `./vim-manager install`
   - 更新文档中的插件列表

3. **保持向后兼容**：
   - 避免删除现有映射
   - 新映射不要覆盖常用功能

4. **文档同步**：
   - 修改配置后更新相关文档
   - 更新 `changelogs.md` 记录变更

5. **测试优先**：
   - 修改后先验证配置加载
   - 检查映射是否冲突

---

## 相关文档

- [详细使用文档](./docs/getting-started.md)
- [快捷键参考](./docs/reference/keybindings.zh.md)
- [更新日志](./docs/changelogs.md)

---

## 联系与支持

- **问题反馈**：提交 GitHub Issue
- **功能建议**：提交 GitHub Issue 或 Pull Request
- **许可证**：MIT License
