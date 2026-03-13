" ============================================================================
" 快捷键映射
" ============================================================================

" 设置Leader键
let mapleader = " "
let g:mapleader = " "

" 快速保存
nnoremap <leader>w :w!<cr>

" 快速退出
nnoremap <leader>q :confirm q<cr>
nnoremap <leader>Q :qa!<cr>

" 快速编辑vimrc
nnoremap <leader>e :edit $MYVIMRC<cr>

" 重新加载vimrc
nnoremap <leader>r :source $MYVIMRC<cr>

" 命令行中快速粘贴系统剪贴板内容
cnoremap <C-v> <C-r>+

" 快速查看当前默认配置文件
nnoremap <leader>vim :vs $MYVIMRC<cr>

" 清除搜索高亮
nnoremap <leader>/ :nohlsearch<cr>

" 解绑 <leader>f，后续再决定它的用途
nnoremap <leader>f <Nop>

" 使用项目文件选择器查找文件
nnoremap <silent> <C-p> :ProjectFiles<CR>
nnoremap <silent> <leader>fc :Commands<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fh :History:<CR>
nnoremap <silent> <leader>fe :call feedkeys(':edit ', 'nt')<CR>
nnoremap <silent> <leader>fE :call feedkeys(':edit %:h/', 'nt')<CR>
nnoremap <silent> <leader>fq :confirm q<CR>
nnoremap <silent> <leader>fQ :qa!<CR>
nnoremap <silent> <leader>fw :w<CR>
nnoremap <silent> <leader>fx :wq<CR>

" 窗口切换
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 调整窗口大小
nnoremap <leader>= <C-w>=
nnoremap <leader>+ :resize +5<cr>
nnoremap <leader>- :resize -5<cr>
nnoremap <leader>< :vertical resize -5<cr>
nnoremap <leader>> :vertical resize +5<cr>

" 标签页切换
nnoremap <C-w>i gt
nnoremap <C-w>u gT

" 快速移动
nnoremap <leader>j 10j
nnoremap <leader>k 10k

" 缓冲区切换
nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprevious<cr>
nnoremap <leader>bb :buffers<cr>:buffer<Space>

" quickfix 工作流
nnoremap <leader>co :copen<CR>
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>cn :cnext<CR>zz
nnoremap <leader>cp :cprevious<CR>zz
nnoremap ]q :cnext<CR>zz
nnoremap [q :cprevious<CR>zz

" 行尾行首快速移动
nnoremap H g^
nnoremap L g_

" 插入模式下的快捷键
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" 确保 ESC 键正常工作
inoremap <Esc> <Esc>
" 提供额外的退出插入模式方法
inoremap jk <Esc>
inoremap kj <Esc>

" 复制到系统剪贴板
vnoremap <leader>y "+y
nnoremap <leader>p "+p

" 从 0 号寄存器粘贴，避免覆盖最近一次 yank
nnoremap <leader>P "0P
nnoremap <leader>pp "0p

" 全选
nnoremap <leader>a ggVG

" 快速删除行
nnoremap <leader>d dd

" 可视模式粘贴后保持选区
vnoremap p pgv<Esc>
vnoremap <leader>ss :sort<CR>

" 上下移动行或选区
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

" 以当前单词或选区预填充替换命令
nnoremap <F2> :%s/\C\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>
vnoremap <F2> "-y:%s/<C-r>-\C/<C-r>-/g<Left><Left>

" 取消Ex模式
nnoremap Q <nop>

" ripgrep 项目搜索
nnoremap <silent> <leader>gg :silent grep! <C-R><C-W> .<CR>:copen<CR>:redraw!<CR>
nnoremap <silent> <leader>gf :LiveGrep<CR>

" 文件树工作流
nnoremap <silent> <C-y> :NERDTreeToggle<CR>
nnoremap <silent> <leader>cd :cd %:h<CR>:NERDTreeCWD<CR>

" ============================================================================
" Vim学习专用快捷键
" ============================================================================

" 打开Vim学习指南
nmap <leader>hl :edit ~/vim-learning-guide.md<cr>

" 打开Vim练习文件
nmap <leader>hp :edit ~/vim-practice.txt<cr>

" 快速运行vimtutor
nnoremap <leader>ht :!vimtutor<cr>

" 显示按键映射（调试用）
nnoremap <leader>hm :map<cr>

" 打开Vim学习计划
nnoremap <leader>hs :edit ~/vim-learning-plan.md<cr>

" 打开Vim插件指南
nnoremap <leader>hg :edit ~/vim-plugins-guide.md<cr>

" ============================================================================
" 输入法自动切换配置 (macOS)
" 默认关闭，避免终端触发系统自动化权限弹窗。
" 如需启用，在本地配置中设置：
"   let g:vim_settings_enable_input_method_switch = 1
" ============================================================================

if !exists('g:vim_settings_enable_input_method_switch')
    let g:vim_settings_enable_input_method_switch = 0
endif

augroup vim_settings_input_method
    autocmd!
augroup END

if has('macunix') && executable('osascript') && g:vim_settings_enable_input_method_switch
    function! IMSelectEnglish()
        try
            call system("osascript -e 'tell application \"System Events\" to keystroke space using control down'")
            sleep 200m
        catch
        endtry
    endfunction

    augroup vim_settings_input_method
        " 退出插入模式时自动切换到英文输入法
        autocmd InsertLeave * call IMSelectEnglish()
    augroup END

    " 手动切换到英文输入法的快捷键
    nnoremap <leader>en :call IMSelectEnglish()<CR>

    " 手动切换输入法的快捷键 (模拟 Control+Space)
    nnoremap <leader>im :call system("osascript -e 'tell application \"System Events\" to keystroke space using control down'")<CR>
endif
