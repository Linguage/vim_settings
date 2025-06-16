" ============================================================================
" 插件配置
" ============================================================================

" ----------------------------------------------------------------------------
" Vim-Airline 基础配置
" ----------------------------------------------------------------------------

" 启用 tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" 使用最基础的主题
let g:airline_theme = 'dark'

" 禁用可能有问题的功能，先确保基本工作
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#whitespace#enabled = 0

" ---------------------------
" 图标支持配置
" ---------------------------

" 基础配置
let g:airline_powerline_fonts = 1

" MacVim 使用 all-the-icons
if has('gui_macvim')
    " all-the-icons 配置
    let g:webdevicons_enable = 0  " 禁用 vim-devicons
    let g:webdevicons_enable_nerdtree = 0
    
    " 加载 all-the-icons
    if exists('*all_the_icons#update_settings')
        call all_the_icons#update_settings()
    endif
    
    " NERDTree 使用 all-the-icons
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
    let g:NERDTreeNodeDelimiter = "\u00a0"
    
    " 自定义文件类型图标
    let g:NERDTreeExtensionHighlightColor = {}
    let g:NERDTreeExactMatchHighlightColor = {}
    let g:NERDTreePatternMatchHighlightColor = {}
    
    " 文件夹图标
    let g:NERDTreeDirArrowCollapsible = '📁'
    let g:NERDTreeDirArrowExpandable = '📂'
    
    " 文件类型图标
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['py'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
    
    " 在 NERDTree 中显示图标
    let g:NERDTreeGitStatusUseNerdFonts = 1
    let g:NERDTreeGitStatusIndicatorMapCustom = {
        \ 'Modified'  :'✹',
        \ 'Staged'    :'✚',
        \ 'Untracked' :'✭',
        \ 'Renamed'   :'➜',
        \ 'Unmerged'  :'═',
        \ 'Deleted'   :'✖',
        \ 'Dirty'     :'✗',
        \ 'Clean'     :'✓',
        \ 'Ignored'   :'☒',
        \ 'Unknown'   :'?'
    \ }
else
    " 终端使用 vim-devicons
    let g:webdevicons_enable = 1
    let g:webdevicons_enable_nerdtree = 1
    let g:webdevicons_conceal_nerdtree_brackets = 1
    let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
    let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
    let g:WebDevIconsUnicodeDecorateFolderNodes = 1
    let g:DevIconsEnableFoldersOpenClose = 1
    
    " 自定义文件类型图标
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['py'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
endif

" NERDTree 图标优化
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" 自定义文件类型图标
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['py'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''


" 不自定义符号，使用默认
" let g:airline_symbols = {}

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

" 默认不自动打开NERDTree
" 注释掉自动打开NERDTree的行
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" 关闭vim时自动关闭NERDTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTree 快捷键 - 使用<leader>n切换NERDTree
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
noremap <silent> <leader>f :NERDTreeFind<CR>

" 在新标签页中打开文件
let NERDTreeMapOpenInTab='<ENTER>'
