" ============================================================================
" 插件配置
" ============================================================================

let s:plugin_root = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/../plugins'

function! s:HasPlugin(plugin_name) abort
    return isdirectory(s:plugin_root . '/' . a:plugin_name)
endfunction

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
if s:HasPlugin('nerdtree')
    let NERDTreeShowHidden=1
    let NERDTreeIgnore=['^\.git$', '^\.hg$', '^\.svn$', '^\.bzr$', '\.pyc$', '\~$', '\.swp$', '\.swo$', '\.DS_Store$']
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
    nnoremap <silent> <leader>nf :NERDTreeFind<CR>
    nnoremap <silent> <leader>ef :NERDTreeFind<CR>

    " 在新标签页中打开文件
    let NERDTreeMapOpenInTab='<ENTER>'
endif

" ----------------------------------------------------------------------------
" Git 标记、撤销树与通用对齐
" ----------------------------------------------------------------------------

if s:HasPlugin('vim-signify')
    let g:signify_sign_add = '+'
    let g:signify_sign_delete = '_'
    let g:signify_sign_delete_first_line = '^'
    let g:signify_sign_change = '~'
    nnoremap <silent> <leader>gS :SignifyToggle<CR>
    nnoremap <silent> ]h :SignifyHunkNext<CR>
    nnoremap <silent> [h :SignifyHunkPrev<CR>
endif

if s:HasPlugin('undotree')
    let g:undotree_SetFocusWhenToggle = 1
    nnoremap <silent> <leader>u :UndotreeToggle<CR>
endif

if s:HasPlugin('vim-easy-align')
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
endif

" ----------------------------------------------------------------------------
" FZF 文件选择器配置
" ----------------------------------------------------------------------------

if isdirectory(s:plugin_root . '/fzf.vim')
    let g:fzf_action = {
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-x': 'split',
        \ 'ctrl-v': 'vsplit'
    \ }
    let g:fzf_vim = get(g:, 'fzf_vim', {})
    let g:fzf_vim.commands_expect = 'ctrl-x,alt-enter'
    let g:fzf_vim.commands_options = [
        \ '--layout=reverse',
        \ '--info=inline',
        \ '--exact',
        \ '--no-sort'
    \ ]
    let g:fzf_vim.buffers_options = [
        \ '--layout=reverse',
        \ '--info=inline'
    \ ]
    let g:fzf_vim.history_options = [
        \ '--layout=reverse',
        \ '--info=inline'
    \ ]
    let g:fzf_layout = {
        \ 'window': {
        \   'width': 0.88,
        \   'height': 0.70,
        \   'xoffset': 0.5,
        \   'yoffset': 0.5,
        \   'border': 'rounded'
        \ }
    \ }

    function! s:ProjectRoot() abort
        let l:start = expand('%:p:h')
        if empty(l:start)
            let l:start = getcwd()
        endif

        let l:git_root = systemlist('git -C ' . shellescape(l:start) . ' rev-parse --show-toplevel')
        if v:shell_error == 0 && !empty(l:git_root)
            return l:git_root[0]
        endif

        return l:start
    endfunction

    function! s:ProjectFiles() abort
        let l:root = s:ProjectRoot()
        let l:spec = fzf#vim#with_preview({
                    \ 'dir': l:root,
                    \ 'options': ['--layout=reverse', '--info=inline', '--prompt', 'Files> ']
                    \ })

        let l:is_git_root = systemlist('git -C ' . shellescape(l:root) . ' rev-parse --show-toplevel')
        if v:shell_error == 0 && !empty(l:is_git_root)
            call fzf#vim#gitfiles('', l:spec, 0)
        else
            call fzf#vim#files(l:root, l:spec, 0)
        endif
    endfunction

    function! s:ProjectExplorer() abort
        let l:root = s:ProjectRoot()
        execute 'cd ' . fnameescape(l:root)
        if s:HasPlugin('nerdtree')
            execute 'NERDTree ' . fnameescape(l:root)
        else
            execute 'edit ' . fnameescape(l:root)
        endif
    endfunction

    command! ProjectFiles call <SID>ProjectFiles()
    command! ProjectExplorer call <SID>ProjectExplorer()
else
    function! s:ProjectFilesFallback() abort
        call feedkeys(":find ", 'n')
    endfunction

    command! ProjectFiles call <SID>ProjectFilesFallback()
    function! s:ProjectExplorerFallback() abort
        execute 'edit ' . fnameescape(getcwd())
    endfunction

    command! ProjectExplorer call <SID>ProjectExplorerFallback()
endif

" ----------------------------------------------------------------------------
" CSV 配置
" ----------------------------------------------------------------------------

" csv.vim 默认不会把文件直接排版成表格，这里开启更直观的自动排列体验。
" 大文件自动跳过，避免明显拖慢 Vim。
let g:csv_autocmd_arrange = 1
let g:csv_autocmd_arrange_size = 2 * 1024 * 1024
let g:csv_highlight_column = 'y'

augroup vim_settings_csv
    autocmd!
    autocmd BufRead,BufNewFile *.csv,*.dat setfiletype csv
    autocmd BufRead,BufNewFile *.tsv,*.tab let b:delimiter = "\t" | setfiletype csv
augroup END

" ----------------------------------------------------------------------------
" Markdown Preview 配置
" ----------------------------------------------------------------------------

" 设置 Markdown Preview 插件路径（避免重复加载）
if s:HasPlugin('markdown-preview.nvim')
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
    nnoremap <silent> <leader>md :MarkdownPreview<CR>
    nnoremap <silent> <leader>mc :MarkdownPreviewStop<CR>
endif

" ----------------------------------------------------------------------------
" which-key 配置（按下 <leader> 弹出菜单）
" ----------------------------------------------------------------------------

" 建议的输入超时，保证快速弹出
set timeout
set timeoutlen=400

" 可选：为分组起名，展示更友好
let g:which_key_map = {}
let g:which_key_map.f = { 'name': '+file' }
let g:which_key_map.g = { 'name': '+git' }
let g:which_key_map.b = { 'name': '+buffer' }
let g:which_key_map.c = { 'name': '+quickfix' }
let g:which_key_map.h = { 'name': '+help' }
let g:which_key_map.l = { 'name': '+lsp/code' }
let g:which_key_map.p = { 'name': '+plugin' }
let g:which_key_map.w = { 'name': '+window' }
let g:which_key_map.t = { 'name': '+test' }

if s:HasPlugin('markdown-preview.nvim')
    let g:which_key_map.m = { 'name': '+markdown' }
endif

if s:HasPlugin('nerdtree')
    let g:which_key_map.n = { 'name': '+nerdtree' }
endif

if s:HasPlugin('vim-which-key')
    " 在按下 <leader><leader> 时弹出 which-key，避免和 leader 组合键冲突
    nnoremap <silent> <leader><leader> :WhichKey '<Space>'<CR>

    augroup vim_settings_which_key
        autocmd!
        " 启动 which-key（确保加载）
        autocmd VimEnter * call which_key#register('<Space>', 'g:which_key_map')
    augroup END
endif
