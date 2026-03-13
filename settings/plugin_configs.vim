" ============================================================================
" 插件配置
" ============================================================================

let s:plugin_root = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/../plugins'

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
" ---------------------------
" 图标支持配置 (LazyVim 风格)
" ---------------------------

" 基础配置
let g:airline_powerline_fonts = 1
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" 设置 NERDTree 图标
let g:NERDTreeDirArrowExpandable = ''  " 右箭头
let g:NERDTreeDirArrowCollapsible = ''  " 下箭头

" 自定义文件类型图标 (LazyVim 风格)
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['jsx'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['ts'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tsx'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['py'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['scss'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['yaml'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['toml'] = ''

" Git 状态图标
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  : '',
    \ 'Staged'    : '✓',
    \ 'Untracked' : '',
    \ 'Renamed'   : '➜',
    \ 'Unmerged'  : '',
    \ 'Deleted'   : '✗',
    \ 'Dirty'     : '',
    \ 'Clean'     : '✓',
    \ 'Ignored'   : '◌',
    \ 'Unknown'   : '?'
\ }

" 文件夹图标
let g:DevIconsDefaultFolderOpenSymbol = ''
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''

" 在状态栏显示文件类型图标
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_tabline = 1


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

augroup vim_settings_nerdtree
    autocmd!
    " 关闭vim时自动关闭NERDTree
    autocmd BufEnter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
augroup END

" NERDTree 快捷键 - 使用<leader>n切换NERDTree
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>f :NERDTreeFind<CR>

" 在新标签页中打开文件
let NERDTreeMapOpenInTab='<ENTER>'

" ----------------------------------------------------------------------------
" Markdown Preview 配置
" ----------------------------------------------------------------------------

" 设置 Markdown Preview 插件路径（避免重复加载）
let g:mkdp_path_to_plugin = s:plugin_root . '/markdown-preview.nvim/app'

" 默认使用浏览器打开（Chrome 或系统默认）
function! MkdpOpenBrowser(url)
    execute 'silent !open ' . shellescape(a:url)
endfunction
let g:mkdp_browserfunc = 'MkdpOpenBrowser'

" 仅在 markdown、pandoc 等文件类型自动加载
let g:mkdp_filetypes = ['markdown', 'mkd', 'md', 'pandoc']

" 启动/关闭预览的快捷键
nnoremap <silent> <leader>mp :MarkdownPreviewToggle<CR>
nnoremap <silent> <leader>mo :MarkdownPreview<CR>
nnoremap <silent> <leader>mc :MarkdownPreviewStop<CR>

" ----------------------------------------------------------------------------
" which-key 配置（按下 <leader> 弹出菜单）
" ----------------------------------------------------------------------------

" 建议的输入超时，保证快速弹出
set timeout
set timeoutlen=400

" 在按下 <leader> 时弹出 which-key
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" 可选：为分组起名，展示更友好
let g:which_key_map = {}
let g:which_key_map.f = { 'name': '+file' }
let g:which_key_map.g = { 'name': '+git' }
let g:which_key_map.w = { 'name': '+window' }
let g:which_key_map.t = { 'name': '+theme' }

augroup vim_settings_which_key
    autocmd!
    " 启动 which-key（确保加载）
    autocmd VimEnter * call which_key#register('<Space>', 'g:which_key_map')
augroup END
