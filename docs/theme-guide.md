# 🎨 Vim 主题预览指南

## 快速预览主题

### 1. 安装主题
```bash
./vim-manager themes install
```

### 2. 在 Vim 中实时预览
```vim
" 临时切换主题（不保存设置）
:colorscheme gruvbox
:colorscheme molokai
:colorscheme dracula
:colorscheme nord
```

### 3. 使用主题切换器
```vim
" 加载主题切换器
:source switch_theme.vim

" 运行交互式切换
:SwitchTheme
```

## 主题特色

### 🌟 Gruvbox
**适用场景**: 长时间编程，护眼
**特点**: 
- 温暖的复古色调
- 对比度适中，不刺眼
- 支持深色和浅色模式

**预览代码**:
```vim
:colorscheme gruvbox
:set background=dark
```

### 🔥 Molokai  
**适用场景**: 代码高亮明显，快速识别
**特点**:
- 高对比度深色主题
- 语法高亮清晰
- 经典编程主题

**预览代码**:
```vim
:colorscheme molokai
```

### 🧛 Dracula
**适用场景**: 现代化界面，夜间编程
**特点**:
- 紫色调主色
- 现代感强
- 色彩丰富平衡

**预览代码**:
```vim
:colorscheme dracula
```

### ❄️ Nord
**适用场景**: 简洁优雅，专注编程
**特点**:
- 北欧冷色调
- 蓝灰色主色
- 极简设计风格

**预览代码**:
```vim
:colorscheme nord
```

### 🌃 Tokyo Night
**适用场景**: 夜间编程，炫酷界面
**特点**:
- 蓝紫色夜景色调
- 霓虹感配色
- 现代夜间主题

**预览代码**:
```vim
:colorscheme tokyonight
```

### 📝 Paper Color
**适用场景**: 白天编程，文档编辑
**特点**:
- 清新白色背景
- 柔和色彩搭配
- 适合长时间阅读

**预览代码**:
```vim
:colorscheme papercolor
:set background=light
```

## 快速主题对比

打开一个代码文件，然后快速切换主题进行对比：

```vim
" 1. 打开代码文件
:edit ~/.vimrc

" 2. 依次尝试不同主题
:colorscheme gruvbox
" 观察效果，按任意键继续

:colorscheme dracula  
" 观察效果，按任意键继续

:colorscheme nord
" 观察效果，按任意键继续

" 3. 选择喜欢的主题并保存设置
:colorscheme gruvbox
```

## 自定义主题设置

### 微调主题设置
```vim
" 设置背景透明度 (MacVim/GUI)
hi Normal guibg=NONE ctermbg=NONE

" 调整注释颜色
hi Comment guifg=#666666

" 自定义光标行高亮
hi CursorLine guibg=#2d2d2d

" 调整状态栏颜色
hi StatusLine guifg=#ffffff guibg=#333333
```

### 保存个人主题配置
```vim
" 在 vimrc 中添加个人配置
colorscheme gruvbox
set background=dark

" 个人微调
hi Comment guifg=#999999
hi LineNr guifg=#666666
```

## 主题管理命令总结

```bash
# 安装所有主题
./vim-manager themes install

# 列出已安装主题
./vim-manager themes list

# 交互式切换主题
./vim-manager themes switch

# 查看当前主题
./vim-manager themes current
```

## 故障排除

### 主题不生效
1. 检查配置文件链接：`./vim-manager config link`
2. 重启 Vim 或运行 `:source ~/.vimrc`
3. 确认主题文件存在：`./vim-manager themes list`

### 颜色显示异常
1. 检查终端色彩支持：`echo $TERM`
2. MacVim 用户确认 GUI 模式
3. 终端用户可能需要启用 256 色支持

### 恢复默认主题
```vim
:colorscheme default
```

或编辑 ~/.vimrc 删除 colorscheme 行。
