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

" 将 Vim 状态文件集中到用户 state 目录，避免污染项目目录。
let s:state_root = expand('~/.local/state/vim')
let s:state_dirs = {
            \ 'backup': s:state_root . '/backup//',
            \ 'swap': s:state_root . '/swap//',
            \ 'undo': s:state_root . '/undo//',
            \ 'view': s:state_root . '/view//'
            \ }

for s:state_dir in values(s:state_dirs)
    if !isdirectory(s:state_dir)
        call mkdir(s:state_dir, 'p', 0700)
    endif
endfor

" 启用集中备份；swap 目录已准备好，但默认仍关闭 swapfile。
set backup
set writebackup
let &backupdir = s:state_dirs.backup

if exists('+directory')
    let &directory = s:state_dirs.swap
endif

if exists('+viewdir')
    let &viewdir = s:state_dirs.view
endif

set viewoptions=folds,cursor

" 启用持久化撤销
if has('persistent_undo')
    set undofile
    let &undodir = s:state_dirs.undo
endif

set undolevels=1000
set undoreload=10000
set signcolumn=yes
set complete=.,w,b,u,t
set pumheight=20
set hidden
set path+=**
set shortmess+=c

if exists('+completeopt')
    set completeopt=menuone,noselect
endif

set wildignorecase

if exists('+wildcharm')
    set wildcharm=<Tab>
endif

if exists('+confirm')
    set confirm
endif

" 自动保存和读取
set autoread
set autowrite

if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --hidden
    set grepformat=%f:%l:%c:%m
endif

function! s:IsNormalFileBuffer() abort
    return &buftype ==# '' && expand('%') !=# ''
endfunction

function! s:RestoreCursorPosition() abort
    if exists('g:vim_settings_no_restore_cursor') || &filetype ==# 'gitcommit'
        return
    endif

    let l:last_line = line("'\"")
    if l:last_line > 1 && l:last_line <= line('$')
        silent! normal! g`"
    endif
endfunction

function! StripTrailingWhitespace() abort
    let l:search = @/
    let l:line = line('.')
    let l:col = col('.')
    %s/\s\+$//e
    let @/ = l:search
    call cursor(l:line, l:col)
endfunction

augroup vim_settings_basic
    autocmd!
    " 文件修改检测
    autocmd FocusGained * checktime

    " 删除末尾空格
    autocmd BufWritePre * if !exists('g:vim_settings_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif

    " 自动切换到文件目录
    autocmd BufEnter * if !exists('g:vim_settings_no_autochdir') && bufname('') !~ '^\[A-Za-z0-9\]*://' | lcd %:p:h | endif

    " 恢复上次光标位置；Git commit message 始终从第一行开始。
    autocmd BufWinEnter * if <SID>IsNormalFileBuffer() | call <SID>RestoreCursorPosition() | endif
    autocmd FileType gitcommit call cursor(1, 1)

    " 保存和恢复窗口视图信息（折叠、光标等）。
    autocmd BufWinLeave * if <SID>IsNormalFileBuffer() | silent! mkview | endif
    autocmd BufWinEnter * if <SID>IsNormalFileBuffer() && !exists('g:vim_settings_no_autochdir') | silent! loadview | endif

    " Markdown 更适合按自然语言阅读，启用软换行
    autocmd FileType markdown,mkd,pandoc setlocal wrap linebreak
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
command! -bang -nargs=* -complete=file W write<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Q quit<bang>
command! -bang QA qall<bang>
command! -bang Qa qall<bang>
cmap w!! w !sudo tee % >/dev/null
cnoremap <expr> %% getcmdtype() ==# ':' ? fnameescape(expand('%:h')) . '/' : '%%'
cnoreabbrev <expr> cwd ((getcmdtype()==':') && (getcmdline() =~# '^\s*cwd\>')) ? 'lcd %:p:h' : 'cwd'
cnoreabbrev <expr> cd. ((getcmdtype()==':') && (getcmdline() =~# '^\s*cd\.\>')) ? 'lcd %:p:h' : 'cd.'
cnoreabbrev <expr> shell ((getcmdtype()==':') && (getcmdline() =~# '^\s*shell\>')) ? 'Shell' : 'shell'
nnoremap <silent> <leader>sh :Shell<CR>
