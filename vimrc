" ============================================================================
" Vim 基础配置文件
" ============================================================================
" 注意：此文件已被模块化拆分，具体配置请查看 settings/ 目录下的相应文件

" 获取当前 vimrc 文件所在目录
let s:config_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" 加载基础配置
execute 'source ' . s:config_dir . '/settings/basic.vim'

" 加载 UI 和主题配置
execute 'source ' . s:config_dir . '/settings/ui.vim'

" 加载颜色主题配置
execute 'source ' . s:config_dir . '/settings/colorscheme.vim'

" 加载快捷键映射
execute 'source ' . s:config_dir . '/settings/mappings.vim'

" 加载插件管理配置
execute 'source ' . s:config_dir . '/settings/plugins.vim'

" 加载插件特定配置
execute 'source ' . s:config_dir . '/settings/plugin_configs.vim'

" 在新标签页中打开
let NERDTreeMapOpenInTab='<ENTER>'

" ----------------------------------------------------------------------------
" 其他插件配置
" ----------------------------------------------------------------------------

" Auto-pairs 配置
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'

" Commentary 配置
autocmd FileType apache setlocal commentstring=#\ %s

" Fugitive 配置（Git集成）
nmap <leader>gs :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gb :Gblame<CR>
nmap <leader>gl :Glog<CR>
nmap <leader>gp :Git push<CR>
nmap <leader>gr :Gread<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>ge :Gedit<CR>

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

" 删除所有trailing whitespace
function! StripTrailingWhitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

nnoremap <leader>sw :call StripTrailingWhitespace()<CR>

" ============================================================================
" 配置文件结束
" ============================================================================
