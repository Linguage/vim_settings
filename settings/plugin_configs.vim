" ============================================================================
" 插件配置
" ============================================================================

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
