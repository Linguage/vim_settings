" ============================================================================
" 界面和主题设置
" ============================================================================

" 启用真彩色支持
if has('termguicolors')
    set termguicolors
endif

" 显示不可见字符（美化空白字符显示）
if !exists('g:vim_settings_no_listchars')
    set list
    set listchars=tab:▸\ ,trail:•,extends:❯,precedes:❮,nbsp:×,eol:¬
endif

" 高亮当前列
set cursorcolumn
set colorcolumn=81,101

" 设置分割线和填充字符
set fillchars+=vert:┃,fold:─,diff:─

" 启用通配符菜单
set wildmenu
set wildmode=longest:full,full

if exists('+wildoptions')
    set wildoptions=pum
endif

" 滚动时保持上下文
set scrolloff=8
set sidescrolloff=8

" 更好的分割窗口
set splitbelow
set splitright

" 设置字体 (仅适用于 GUI 版本如 MacVim/GVim)
if has("gui_macvim")
    " MacVim 专用字体设置
    set guifont=Hack\ Nerd\ Font\ Mono:h14
    " 移除工具栏和菜单栏
    set guioptions-=T
    set guioptions-=m
    " 移除滚动条
    set guioptions-=r
    set guioptions-=L
elseif has("gui_running")
    " 其他 GUI 版本的设置
    set guifont=Hack\ Nerd\ Font\ Mono\ 11
endif

" 自定义颜色设置和高亮
if &t_Co > 2 || has("gui_running")
    " 搜索高亮颜色
    highlight Search ctermbg=yellow ctermfg=black guibg=#ffff00 guifg=#000000
    
    " 当前行高亮
    highlight CursorLine cterm=NONE ctermbg=236 ctermfg=NONE guibg=#2d2d2d guifg=NONE
    " 当前列高亮
    highlight CursorColumn cterm=NONE ctermbg=236 ctermfg=NONE guibg=#2d2d2d guifg=NONE
    
    " 行号颜色
    highlight LineNr ctermfg=240 guifg=#585858
    highlight CursorLineNr ctermfg=yellow cterm=bold guifg=#ffff00 gui=bold
    
    " 状态栏分隔符美化
    highlight VertSplit ctermbg=NONE ctermfg=240 guibg=NONE guifg=#585858
    
    " 匹配括号高亮
    highlight MatchParen cterm=bold ctermbg=none ctermfg=magenta gui=bold guibg=NONE guifg=#ff00ff
    
    " 折叠行美化
    highlight Folded ctermbg=235 ctermfg=249 guibg=#262626 guifg=#b2b2b2
    highlight FoldColumn ctermbg=235 ctermfg=249 guibg=#262626 guifg=#b2b2b2
endif

" 窗口标题设置
if has('title')
    set title
    set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
endif

" 状态栏自定义
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime('\%d/\%m/\%y\ -\ \%H:\%M')}
