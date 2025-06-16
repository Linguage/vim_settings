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

" 将插件目录添加到runtimepath
if isdirectory(s:plugin_dir)
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-sensible'
    execute 'set runtimepath+=' . s:plugin_dir . '/nerdtree'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-airline'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-airline-themes'
    execute 'set runtimepath+=' . s:plugin_dir . '/auto-pairs'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-commentary'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-surround'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-fugitive'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-polyglot'
    execute 'set runtimepath+=' . s:plugin_dir . '/vim-devicons'
    
    " 加载插件帮助文档
    silent! helptags ALL
endif
