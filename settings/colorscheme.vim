" Color scheme configuration
" =========================

" 获取当前配置目录的父目录（vim_settings目录）
let s:vim_config_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

" 将自定义colors目录添加到运行时路径
execute 'set runtimepath+=' . s:vim_config_dir

" Enable syntax highlighting
syntax enable

" Set default color scheme
try
    colorscheme gruvbox
catch /^Vim\%((\a\+)\)\=:E185/
    " If gruvbox is not found, fall back to another theme
    try
        colorscheme PaperColor
    catch /^Vim\%((\a\+)\)\=:E185/
        " If all else fails, use the default
        colorscheme desert
    endtry
endtry

" Set background (dark/light)
set background=dark

" Custom commands to switch between color schemes
command! ThemePaperColor colorscheme PaperColor | set background=light
command! ThemeGruvbox colorscheme gruvbox | set background=dark
command! ThemeMolokai colorscheme molokai | set background=dark
command! ThemeSolarized colorscheme solarized | set background=light

" Theme selection function
function! SelectColorScheme()
    echo "请选择主题 (Select Theme):"
    echo "1. PaperColor (Light)"
    echo "2. Gruvbox (Dark)"
    echo "3. Molokai (Dark)"
    echo "4. Solarized (Light)"
    echo "5. 取消 (Cancel)"
    echo ""
    let choice = nr2char(getchar())
    
    if choice == '1'
        execute 'ThemePaperColor'
        echo "已切换到 PaperColor 主题"
    elseif choice == '2'
        execute 'ThemeGruvbox'
        echo "已切换到 Gruvbox 主题"
    elseif choice == '3'
        execute 'ThemeMolokai'
        echo "已切换到 Molokai 主题"
    elseif choice == '4'
        execute 'ThemeSolarized'
        echo "已切换到 Solarized 主题"
    elseif choice == '5' || choice == "\<Esc>"
        echo "已取消主题选择"
    else
        echo "无效选择，请输入 1-5"
    endif
    redraw!
endfunction

" 绑定快捷键到主题选择函数
" 按 <Leader>t 来打开主题选择菜单
nnoremap <silent> <Leader>t :call SelectColorScheme()<CR>

" 可选：也可以使用 <Leader>th (theme) 作为快捷键
nnoremap <silent> <Leader>th :call SelectColorScheme()<CR>

" 主题信息将通过 airline 状态栏显示，无需单独设置 statusline
