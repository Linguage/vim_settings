" ============================================================================
" 界面和主题设置
" ============================================================================

" 启用真彩色支持
if has('termguicolors')
    set termguicolors
endif

" 加载颜色方案配置
source ~/Documents/vim_settings/settings/colorscheme.vim

" 显示不可见字符
set list
set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×

" 设置分割线
set fillchars+=vert:│

" 启用通派符菜单
set wildmenu
set wildmode=longest:full,full

" 滚动时保持上下文
set scrolloff=5
set sidescrolloff=5

" 设置字体 (仅适用于 GUI 版本如 MacVim/GVim)
if has("gui_running")
    " MacVim/GVim 字体设置
    set guifont=Menlo\ Regular:h14
endif

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
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime('\%d/\%m/\%y\ -\ \%H:\%M')}
