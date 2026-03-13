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
set showmode
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
set textwidth=100

" 搜索设置
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan
set infercase

" 搜索结果与翻页后保持焦点稳定
nnoremap * *Nzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" 在软换行文本中按屏幕行移动
nnoremap j gj
nnoremap k gk

" 可视模式下用选区内容直接搜索
vnoremap / "-y/<C-r>-<CR>N

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
set belloff=all
set breakindent

if has('clipboard')
    set clipboard=unnamed,unnamedplus
endif

if has('macunix')
    if exists('+ttimeout')
        set ttimeout
    endif
    if exists('+ttimeoutlen')
        set ttimeoutlen=10
    endif
endif

" 启用持久化撤销
if has('persistent_undo')
    let s:undo_dir = expand('~/.vim/undo//')
    set undofile
    let &undodir = s:undo_dir
    if !isdirectory(s:undo_dir)
        call mkdir(s:undo_dir, 'p', 0700)
    endif
endif

set undolevels=1000
set undoreload=10000
set signcolumn=yes
set complete=.,w,b,u,t
set pumheight=20
set path+=**
set shortmess+=c

if exists('+completeopt')
    set completeopt=menuone,noselect
endif

set wildignorecase

if exists('+wildcharm')
    set wildcharm=<Tab>
endif

" 自动保存和读取
set autoread
set autowrite

if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --hidden
    set grepformat=%f:%l:%c:%m
endif

augroup vim_settings_basic
    autocmd!
    " 文件修改检测
    autocmd FocusGained * checktime

    " 删除末尾空格
    autocmd BufWritePre * %s/\s\+$//e

    " 自动切换到文件目录
    autocmd BufEnter * if bufname('') !~ '^\[A-Za-z0-9\]*://' | lcd %:p:h | endif
augroup END

" 启用文件类型检测
filetype on
filetype plugin on
filetype indent on

" 启用语法高亮
syntax enable
syntax on

function! s:OpenShell() abort
    if has('terminal')
        execute 'terminal'
    elseif has('macunix') || has('gui_running')
        if exists('g:preferred_terminal') && type(g:preferred_terminal) == type('') && g:preferred_terminal !=# ''
            execute 'silent !open -a ' . shellescape(g:preferred_terminal)
        else
            silent !open -a Terminal
        endif
    else
        echohl WarningMsg | echom 'No :terminal support; open an external terminal.' | echohl None
    endif
endfunction

function! s:LiveGrep() abort
    let l:pattern = input('Rg> ')
    if empty(l:pattern)
        return
    endif

    execute 'silent grep! ' . fnameescape(l:pattern) . ' .'
    copen
    redraw!
endfunction

command! Shell call s:OpenShell()
command! LiveGrep call s:LiveGrep()
cnoreabbrev <expr> shell ((getcmdtype()==':') && (getcmdline() =~# '^\s*shell\>')) ? 'Shell' : 'shell'
nnoremap <silent> <leader>sh :Shell<CR>
