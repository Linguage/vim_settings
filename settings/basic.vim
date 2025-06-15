" ============================================================================
" 基础配置
" ============================================================================

" 不兼容vi模式
set nocompatible

" 基本编辑器选项
set number
set relativenumber
set cursorline
set showcmd
set showmatch
set mouse=a
set laststatus=2
set ruler
set cmdheight=1

" 缩进和制表符设置
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set autoindent
set smarttab

" 搜索设置
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

" 折叠设置
set foldenable
set foldmethod=indent
set foldlevelstart=99

" 文件编码和处理
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,gb2312,cp936,ucs-bom,big5,latin1
set fileformats=unix,dos,mac
set nobackup
set nowritebackup
set noswapfile

" 启用持久化撤销
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/undo//
    if !isdirectory(&undodir)
        call mkdir(&undodir, 'p', 0700)
    endif
endif

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

" 启用文件类型检测
filetype on
filetype plugin on
filetype indent on

" 启用语法高亮
syntax enable
syntax on
