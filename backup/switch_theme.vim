" Vim 主题切换器
" 使用方法: :source switch_theme.vim 然后运行 :SwitchTheme

function! SwitchTheme()
    let themes = []
    let colors_dir = expand('<sfile>:p:h') . '/colors'
    
    " 获取所有主题文件
    for file in split(glob(colors_dir . '/*.vim'), '\n')
        let theme_name = fnamemodify(file, ':t:r')
        call add(themes, theme_name)
    endfor
    
    if empty(themes)
        echo "未找到主题文件"
        return
    endif
    
    " 显示主题列表
    echo "可用主题:"
    for i in range(len(themes))
        echo (i+1) . ". " . themes[i]
    endfor
    
    " 获取用户选择
    let choice = input("请选择主题 [1-" . len(themes) . "]: ")
    let choice_num = str2nr(choice)
    
    if choice_num > 0 && choice_num <= len(themes)
        let selected_theme = themes[choice_num - 1]
        execute 'colorscheme ' . selected_theme
        echo "\n已切换到主题: " . selected_theme
        
        " 保存设置到 vimrc
        let vimrc_path = expand('~/.vimrc')
        if filereadable(vimrc_path)
            let lines = readfile(vimrc_path)
            let found = 0
            for i in range(len(lines))
                if lines[i] =~ '^\s*colorscheme\s'
                    let lines[i] = 'colorscheme ' . selected_theme
                    let found = 1
                    break
                endif
            endfor
            if !found
                call add(lines, 'colorscheme ' . selected_theme)
            endif
            call writefile(lines, vimrc_path)
            echo "已保存主题设置到 ~/.vimrc"
        endif
    else
        echo "无效选择"
    endif
endfunction

command! SwitchTheme call SwitchTheme()
