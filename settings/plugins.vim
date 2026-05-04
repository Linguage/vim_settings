" ============================================================================
" 插件管理
" ============================================================================

" 检测插件目录
let s:plugin_dir = expand('~/.vim/plugins')
let s:local_plugin_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/../plugins'

" 使用本地插件目录（如果存在）
if isdirectory(s:local_plugin_dir)
    let s:plugin_dir = s:local_plugin_dir
endif

if isdirectory('/opt/homebrew/opt/fzf')
    set runtimepath+=/opt/homebrew/opt/fzf
elseif isdirectory('/usr/local/opt/fzf')
    set runtimepath+=/usr/local/opt/fzf
endif

" 将插件目录添加到runtimepath
if isdirectory(s:plugin_dir)
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-sensible'
    execute 'set runtimepath+=' . s:plugin_dir . '/nerdtree'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-airline'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-airline-themes'
    execute 'set runtimepath+=' . s:plugin_dir . '/auto-pairs'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-repeat'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-commentary'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-surround'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-fugitive'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-signify'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-polyglot'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-devicons'
    execute 'set runtimepath+=' . s:plugin_dir . '/undotree'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-easy-align'
    execute 'set runtimepath+=' . s:plugin_dir . '/fzf.vim'
    execute 'set runtimepath+=' . s:plugin_dir . '/csv.vim'
    " Markdown preview plugin
    execute 'set runtimepath+=' . s:plugin_dir . '/markdown-preview.nvim'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-which-key'

    if !exists('g:vim_settings_no_ide') || !g:vim_settings_no_ide
        execute 'set runtimepath+=' . s:plugin_dir . '/editorconfig-vim'
        execute 'set runtimepath+=' . s:plugin_dir . '/vim-lsp'
        execute 'set runtimepath+=' . s:plugin_dir . '/vim-lsp-settings'
        execute 'set runtimepath+=' . s:plugin_dir . '/asyncomplete.vim'
        execute 'set runtimepath+=' . s:plugin_dir . '/asyncomplete-lsp.vim'
        execute 'set runtimepath+=' . s:plugin_dir . '/ale'
        execute 'set runtimepath+=' . s:plugin_dir . '/vim-test'
    endif

    " 加载插件帮助文档
    silent! helptags ALL
endif
