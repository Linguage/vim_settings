" ============================================================================
" Vim 基础配置文件
" ============================================================================
" 注意：此文件已被模块化拆分，具体配置请查看 settings/ 目录下的相应文件

" Leader 键必须在加载任何模块前定义，避免早期模块把映射绑定到默认的 "\"。
let mapleader = " "
let g:mapleader = " "

" 获取当前 vimrc 文件所在目录
let s:config_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" 加载本机前置覆盖配置（不由仓库管理）
if filereadable(expand('~/.vimrc.before.local'))
    source ~/.vimrc.before.local
endif

" 加载基础配置
execute 'source ' . s:config_dir . '/settings/basic.vim'

" 加载 UI 和主题配置
execute 'source ' . s:config_dir . '/settings/ui.vim'

" 加载颜色主题配置
execute 'source ' . s:config_dir . '/settings/colorscheme.vim'

" 加载快捷键映射
execute 'source ' . s:config_dir . '/settings/mappings.vim'

" 加载代码编辑增强配置（在插件 runtimepath 前设置默认变量）
execute 'source ' . s:config_dir . '/settings/code_editing.vim'

" 加载插件管理配置
execute 'source ' . s:config_dir . '/settings/plugins.vim'

" 加载插件特定配置
execute 'source ' . s:config_dir . '/settings/plugin_configs.vim'

" ----------------------------------------------------------------------------
" 其他插件配置
" ----------------------------------------------------------------------------

" Auto-pairs 配置
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'

augroup vim_settings_core
    autocmd!
    " Commentary 配置
    autocmd FileType apache setlocal commentstring=#\ %s
augroup END

" Fugitive 配置（Git集成）
if isdirectory(s:config_dir . '/plugins/vim-fugitive')
    nnoremap <leader>gs :Gstatus<CR>
    nnoremap <leader>gd :Gdiff<CR>
    nnoremap <leader>gD :Gdiffsplit<CR>
    nnoremap <leader>gc :Gcommit<CR>
    nnoremap <leader>gb :Gblame<CR>
    nnoremap <leader>gl :Glog<CR>
    nnoremap <leader>gi :Git add -p %<CR>
    nnoremap <leader>gp :Git push<CR>
    nnoremap <leader>gr :Gread<CR>
    nnoremap <leader>gw :Gwrite<CR>
    nnoremap <leader>ge :Gedit<CR>
endif

" Surround 插件无需额外配置，使用默认快捷键：
" cs"'  : 将双引号改为单引号
" ds"   : 删除双引号
" ysiw" : 为当前单词添加双引号

" 多语言语法支持（vim-polyglot）
let g:polyglot_disabled = ['csv']

" ============================================================================
" 自定义函数和命令
" ============================================================================

" 切换行号显示模式
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

" 快速切换主题
function! ToggleBackground()
    if &background == 'dark'
        set background=light
    else
        set background=dark
    endif
endfunction

nnoremap <leader>bg :call ToggleBackground()<CR>

nnoremap <leader>sw :call StripTrailingWhitespace()<CR>

" 加载本机最终覆盖配置（不由仓库管理）
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

" ============================================================================
" 配置文件结束
" ============================================================================
