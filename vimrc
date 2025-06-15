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
" Vim-Airline 配置
" ----------------------------------------------------------------------------

" 启用airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

" 显示缓冲区
let g:airline#extensions#tabline#buffer_nr_show = 1

" 设置airline主题
try
    let g:airline_theme='dark'
catch
    let g:airline_theme='simple'
endtry

" Powerline字体支持
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode符号
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" 状态栏显示设置
let g:airline_section_b = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'

" 扩展功能
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#hunks#enabled = 1

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
