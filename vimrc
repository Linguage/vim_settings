" ============================================================================
" Vim 基础配置文件
" ============================================================================

" ============================================================================
" 第一阶段：基础配置（无插件）
" ============================================================================

" ----------------------------------------------------------------------------
" 基本编辑器选项
" ----------------------------------------------------------------------------

" 启用语法高亮
syntax enable
syntax on

" 显示行号
set number
set relativenumber

" 高亮当前行
set cursorline

" 显示命令
set showcmd

" 显示匹配的括号
set showmatch

" 启用鼠标支持
set mouse=a

" 显示状态栏
set laststatus=2

" 显示标尺
set ruler

" 设置命令行高度
set cmdheight=1

" 不兼容vi模式
set nocompatible

" 启用文件类型检测
filetype on
filetype plugin on
filetype indent on

" ----------------------------------------------------------------------------
" 缩进和制表符设置
" ----------------------------------------------------------------------------

" 制表符宽度
set tabstop=4
set shiftwidth=4
set softtabstop=4

" 使用空格替代制表符
set expandtab

" 智能缩进
set smartindent
set autoindent

" 智能制表符
set smarttab

" ----------------------------------------------------------------------------
" 搜索设置
" ----------------------------------------------------------------------------

" 高亮搜索结果
set hlsearch

" 实时搜索
set incsearch

" 忽略大小写搜索兼容智能搜索
set ignorecase
set smartcase

" 搜索时循环查找
set wrapscan

" ----------------------------------------------------------------------------
" 折叠设置
" ----------------------------------------------------------------------------

" 启用折叠
set foldenable

" 基于缩进折叠
set foldmethod=indent

" 启动时不折叠
set foldlevelstart=99

" ----------------------------------------------------------------------------
" 外观设置
" ----------------------------------------------------------------------------

" 启用真彩色支持
if has('termguicolors')
    set termguicolors
endif

" 设置背景为暗色
set background=dark

" 显示不可见字符
set list
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×

" 设置分割线
set fillchars+=vert:│

" 启用通配符菜单
set wildmenu
set wildmode=longest:full,full

" 滚动时保持上下文
set scrolloff=5
set sidescrolloff=5

" ----------------------------------------------------------------------------
" 快捷键映射
" ----------------------------------------------------------------------------

" 设置Leader键
let mapleader = ","
let g:mapleader = ","

" 快速保存
nmap <leader>w :w!<cr>

" 快速退出
nmap <leader>q :q<cr>
nmap <leader>Q :qa!<cr>

" 快速编辑vimrc
nmap <leader>e :edit $MYVIMRC<cr>

" 重新加载vimrc
nmap <leader>r :source $MYVIMRC<cr>

" 清除搜索高亮
nmap <leader>/ :nohlsearch<cr>

" 窗口切换
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" 调整窗口大小
nmap <leader>= <C-w>=
nmap <leader>+ :resize +5<cr>
nmap <leader>- :resize -5<cr>
nmap <leader>< :vertical resize -5<cr>
nmap <leader>> :vertical resize +5<cr>

" 快速移动
nmap <leader>j 10j
nmap <leader>k 10k

" 行尾行首快速移动
nmap H ^
nmap L $

" 插入模式下的快捷键
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>

" 复制到系统剪贴板
vmap <leader>y "+y
nmap <leader>p "+p

" 全选
nmap <leader>a ggVG

" 快速删除行
nmap <leader>d dd

" 取消Ex模式
nnoremap Q <nop>

" ----------------------------------------------------------------------------
" 文件编码和处理
" ----------------------------------------------------------------------------

" 文件编码
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,gb2312,cp936,ucs-bom,big5,latin1

" 文件格式
set fileformats=unix,dos,mac

" 关闭备份文件
set nobackup
set nowritebackup

" 关闭交换文件
set noswapfile

" 启用持久化撤销
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/undo//
    if !isdirectory(&undodir)
        call mkdir(&undodir, 'p', 0700)
    endif
endif

" 设置撤销级数
set undolevels=1000
set undoreload=10000

" 自动保存和读取
set autoread
set autowrite

" 文件修改检测
au FocusGained * :checktime

" 删除末尾空格
autocmd BufWritePre * :%s/\s\+$//e

" 自动切换到文件目录
autocmd BufEnter * if bufname("") !~ "^\\[A-Za-z0-9\\]*://" | lcd %:p:h | endif

" ----------------------------------------------------------------------------
" 颜色主题和外观
" ----------------------------------------------------------------------------

" 设置颜色主题
try
    colorscheme desert
catch
    colorscheme default
endtry

" 自定义颜色设置
if &t_Co > 2 || has("gui_running")
    " 搜索高亮颜色
    highlight Search ctermbg=yellow ctermfg=black guibg=yellow guifg=black
    
    " 当前行高亮
    highlight CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
    
    " 行号颜色
    highlight LineNr ctermfg=grey guifg=grey
    
    " 状态栏颜色
    highlight StatusLine ctermbg=blue ctermfg=white guibg=blue guifg=white
    
    " 分割线颜色
    highlight VertSplit ctermbg=black ctermfg=grey guibg=black guifg=grey
endif

" 状态栏自定义
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

" ============================================================================
" 第二阶段：高级配置（插件）
" ============================================================================

" ----------------------------------------------------------------------------
" 插件加载机制
" ----------------------------------------------------------------------------

" 检测插件目录
let s:plugin_dir = expand('~/.vim/plugins')
let s:local_plugin_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/plugins'

" 使用本地插件目录（如果存在）
if isdirectory(s:local_plugin_dir)
    let s:plugin_dir = s:local_plugin_dir
endif

" 将插件目录添加到runtimepath
if isdirectory(s:plugin_dir)
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-sensible'
    execute 'set runtimepath+=' . s:plugin_dir . '/nerdtree'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-airline'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-airline-themes'
    execute 'set runtimepath+=' . s:plugin_dir . '/auto-pairs'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-commentary'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-surround'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-fugitive'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-polyglot'
    
    " 加载插件帮助文档
    silent! helptags ALL
endif

" ----------------------------------------------------------------------------
" NERDTree 配置
" ----------------------------------------------------------------------------

" NERDTree 基本设置
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp$', '\.DS_Store$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let NERDTreeShowBookmarks=1
let NERDTreeWinSize=25
let NERDTreeWinPos="left"
let NERDTreeHighlightCursorline=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" 启动时自动打开NERDTree
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" 关闭vim时自动关闭NERDTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTree 快捷键
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

" 在新标签页中打开
let NERDTreeMapOpenInTab='<ENTER>'

" ----------------------------------------------------------------------------
" Vim-Airline 配置
" ----------------------------------------------------------------------------

" 启用airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

" 显示缓冲区
let g:airline#extensions#tabline#buffer_nr_show = 1

" 设置airline主题
try
    let g:airline_theme='dark'
catch
    let g:airline_theme='simple'
endtry

" Powerline字体支持
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode符号
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" 状态栏显示设置
let g:airline_section_b = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'

" 扩展功能
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#hunks#enabled = 1

" ----------------------------------------------------------------------------
" 其他插件配置
" ----------------------------------------------------------------------------

" Auto-pairs 配置
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'

" Commentary 配置
autocmd FileType apache setlocal commentstring=#\ %s

" Fugitive 配置（Git集成）
nmap <leader>gs :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gb :Gblame<CR>
nmap <leader>gl :Glog<CR>
nmap <leader>gp :Git push<CR>
nmap <leader>gr :Gread<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>ge :Gedit<CR>

" Surround 插件无需额外配置，使用默认快捷键：
" cs"'  : 将双引号改为单引号
" ds"   : 删除双引号
" ysiw" : 为当前单词添加双引号

" 多语言语法支持（vim-polyglot）
let g:polyglot_disabled = ['csv']

" ============================================================================
" 自定义函数和命令
" ============================================================================

" 切换行号显示模式
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

" 快速切换主题
function! ToggleBackground()
    if &background == 'dark'
        set background=light
    else
        set background=dark
    endif
endfunction

nnoremap <leader>bg :call ToggleBackground()<CR>

" 删除所有trailing whitespace
function! StripTrailingWhitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

nnoremap <leader>sw :call StripTrailingWhitespace()<CR>

" ============================================================================
" 配置文件结束
" ============================================================================
