" ============================================================================
" 统一 Vim 配置文件 (vimrc)
" 智能检测环境，自动适配 vim/nvim/macvim，terminal/GUI
" ============================================================================

" 环境检测
" ============================================================================
let g:is_nvim = has('nvim')
let g:is_vim8 = v:version >= 800
let g:is_gui = has('gui_running') || has('gui_macvim') || exists('g:GuiLoaded')
let g:is_macvim = has('gui_macvim')
let g:is_terminal = !g:is_gui

" 基础设置
" ============================================================================
set nocompatible              " 关闭 vi 兼容模式
filetype plugin indent on    " 启用文件类型检测、插件和缩进
syntax enable                 " 启用语法高亮

" 显示设置
" ============================================================================
set number                    " 显示行号
set relativenumber           " 显示相对行号
set cursorline               " 高亮当前行
set showcmd                  " 显示命令
set showmode                 " 显示当前模式
set ruler                    " 显示光标位置
set laststatus=2             " 总是显示状态栏
set wrap                     " 自动换行
set linebreak                " 在单词边界换行
set showmatch                " 显示匹配的括号
set matchtime=2              " 匹配括号高亮时间

" 界面美化设置
set fillchars=vert:│,fold:·,diff:╱  " 细分割线
set fillchars+=eob:\          " 隐藏空行的波浪号 (~)

" 搜索设置
" ============================================================================
set hlsearch                 " 高亮搜索结果
set incsearch                " 实时搜索
set ignorecase               " 搜索时忽略大小写
set smartcase                " 智能大小写搜索
set wrapscan                 " 搜索到文件末尾时重新从开头搜索

" 编辑设置
" ============================================================================
set tabstop=4                " Tab 显示宽度
set shiftwidth=4             " 自动缩进宽度
set expandtab                " 使用空格替代 Tab
set autoindent               " 自动缩进
set smartindent              " 智能缩进
set backspace=indent,eol,start " 退格键功能
set whichwrap=b,s,h,l,<,>,[,] " 光标跨行移动

" 文件和备份设置
" ============================================================================
set autoread                 " 文件被外部修改时自动读取
set autowrite                " 自动保存
set backup                   " 创建备份文件
set backupdir=~/.vim/backup  " 备份文件目录
set directory=~/.vim/swap    " 交换文件目录
set undofile                 " 启用持久化撤销
set undodir=~/.vim/undo      " 撤销文件目录

" 创建必要的目录
if !isdirectory(expand("~/.vim/backup"))
    call mkdir(expand("~/.vim/backup"), "p")
endif
if !isdirectory(expand("~/.vim/swap"))
    call mkdir(expand("~/.vim/swap"), "p")
endif
if !isdirectory(expand("~/.vim/undo"))
    call mkdir(expand("~/.vim/undo"), "p")
endif

" 通用界面设置
" ============================================================================
set wildmenu                 " 命令行补全菜单
set wildmode=longest:full,full " 补全模式
set scrolloff=8              " 垂直滚动边距
set sidescrolloff=8          " 水平滚动边距
set clipboard=unnamed        " 使用系统剪贴板
set mouse=a                  " 启用鼠标支持
set encoding=utf-8           " 文件编码
set fileencoding=utf-8       " 文件保存编码
set termencoding=utf-8       " 终端编码

" 性能设置
" ============================================================================
set updatetime=300           " 更新时间
set timeoutlen=500           " 键盘超时时间
set ttimeoutlen=50           " 键码超时时间
set lazyredraw               " 延迟重绘
set ttyfast                  " 快速终端连接

" 配置目录变量（用于插件管理）
let s:config_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" GUI 专用设置 (MacVim, GVim 等)
" ============================================================================
if g:is_gui
    " 字体设置
    if g:is_macvim
        " MacVim 字体设置
        set guifont=Cascadia\ Code:h15
        " 备用字体
        " set guifont=SF\ Mono:h15
        " set guifont=Monaco:h14
        " set guifont=Menlo:h14
        set guifontwide=PingFang\ SC:h15  " 中文字体
    else
        " 其他 GUI 的字体设置
        set guifont=Cascadia\ Code\ 12
    endif
    
    " 窗口大小设置
    if g:is_macvim
        set columns=140          " 窗口宽度
        set lines=45             " 窗口高度
        set linespace=3          " 行间距
    endif
    
    " 界面元素设置
    set guioptions-=T            " 隐藏工具栏
    set guioptions-=m            " 隐藏菜单栏
    set guioptions-=r            " 隐藏右侧滚动条
    set guioptions-=R            " 隐藏右侧滚动条 (分割窗口)
    set guioptions-=l            " 隐藏左侧滚动条
    set guioptions-=L            " 隐藏左侧滚动条 (分割窗口)
    set guioptions-=b            " 隐藏底部滚动条
    set guioptions+=c            " 使用控制台对话框
    
    " MacVim 专用设置
    if g:is_macvim
        set transparency=8       " 透明度
        
        " 窗口居中
        function! CenterWindow()
            winpos 100 50
        endfunction
        autocmd VimEnter * call CenterWindow()
        
        " Mac 专用快捷键
        nnoremap <D-t> :tabnew<CR>
        nnoremap <D-w> :tabclose<CR>
        nnoremap <D-e> :NERDTreeToggle<CR>
        nnoremap <D-0> :set guifont=Cascadia\ Code:h15<CR>
        
        " Cmd+数字键切换标签页
        for i in range(1, 9)
            execute 'nnoremap <D-' . i . '> ' . i . 'gt'
        endfor
    endif
    
    " 光标设置
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    
    " 禁用闪烁
    set noerrorbells
    set novisualbell
    set t_vb=
endif

" 终端专用设置
" ============================================================================
if g:is_terminal
    " 更好的色彩支持
    if &term =~ "xterm\\|rxvt\\|screen"
        set t_Co=256
    endif
    
    " 光标形状设置（终端环境）
    if &term =~ "xterm\\|rxvt"
        let &t_SI = "\<Esc>[6 q"  " 插入模式细光标
        let &t_EI = "\<Esc>[2 q"  " 普通模式块光标
    endif
endif

" 分割线设置
" ============================================================================
highlight VertSplit cterm=NONE ctermfg=240 ctermbg=NONE
highlight VertSplit gui=NONE guifg=#585858 guibg=NONE
highlight clear VertSplit

" 快捷键设置
" ============================================================================
let mapleader = " "          " Leader 键为空格

" 基础快捷键
nnoremap <Leader>w :w<CR>            " 快速保存
nnoremap <Leader>q :q<CR>            " 快速退出
nnoremap <Leader>x :x<CR>            " 保存并退出
nnoremap <Leader>h :nohlsearch<CR>   " 取消搜索高亮

" 文件浏览快捷键
nnoremap <Leader>e :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

" 窗口操作
nnoremap <C-h> <C-w>h        " 左窗口
nnoremap <C-j> <C-w>j        " 下窗口
nnoremap <C-k> <C-w>k        " 上窗口
nnoremap <C-l> <C-w>l        " 右窗口

" 分割窗口
nnoremap <Leader>sh :split<CR>
nnoremap <Leader>sv :vsplit<CR>

" 缓冲区操作
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bd :bdelete<CR>

" 快速编辑配置文件
nnoremap <Leader>ev :edit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

" 本地插件管理
" ============================================================================
let s:local_plugin_dir = s:config_dir . '/plugins'
let s:local_colors_dir = s:config_dir . '/colors'

" 确保目录存在
if !isdirectory(s:local_plugin_dir)
    call mkdir(s:local_plugin_dir, 'p')
endif
if !isdirectory(s:local_colors_dir)
    call mkdir(s:local_colors_dir, 'p')
endif

" 添加到运行时路径
if isdirectory(s:local_plugin_dir)
    execute 'set runtimepath+=' . s:local_plugin_dir . '/*'
endif
if isdirectory(s:local_colors_dir)
    execute 'set runtimepath+=' . s:local_colors_dir
endif

" 插件配置
" ============================================================================

" vim-airline 状态栏配置
if isdirectory(s:config_dir . '/plugins/vim-airline')
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail'
    let g:airline_powerline_fonts = 0
    
    " 自定义符号
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_left_sep = '▶'
    let g:airline_right_sep = '◀'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.readonly = '⊗'
    let g:airline_symbols.dirty = '⚡'
endif

" NERDTree 配置
if isdirectory(s:config_dir . '/plugins/nerdtree')
    let NERDTreeShowHidden=1
    let NERDTreeMinimalUI=1
    let NERDTreeDirArrows=1
    let NERDTreeAutoDeleteBuffer=1
    let NERDTreeQuitOnOpen=1
    let NERDTreeWinSize=30
    let NERDTreeIgnore=['\.DS_Store$', '\.git$', '__pycache__', '\.pyc$']
    
    " 默认不自动打开 NERDTree
    " 自动关闭（当只剩 NERDTree 时）
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    
    " 图标设置
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
endif

" 文件类型设置
" ============================================================================
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType javascript,typescript setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType html,css setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType markdown setlocal wrap linebreak

" 自动命令
" ============================================================================
autocmd BufWritePre * :%s/\s\+$//e  " 去除行尾空格
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" 实用函数
" ============================================================================
function! ToggleNumber()
    if &relativenumber
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunction
nnoremap <Leader>tn :call ToggleNumber()<CR>

" 配置版本信息
let g:vimrc_version = "2.0-unified"
let g:vimrc_updated = "2025-06-15"
