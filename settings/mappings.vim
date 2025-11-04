" ============================================================================
" 快捷键映射
" ============================================================================

" 设置Leader键
let mapleader = " "
let g:mapleader = " "

" 快速保存
nmap <leader>w :w!<cr>

" 快速退出
nmap <leader>q :q<cr>
nmap <leader>Q :qa!<cr>

" 快速编辑vimrc
nmap <leader>e :edit $MYVIMRC<cr>

" 重新加载vimrc
nmap <leader>r :source $MYVIMRC<cr>

" 清除搜索高亮
nmap <leader>/ :nohlsearch<cr>

" 窗口切换
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" 调整窗口大小
nmap <leader>= <C-w>=
nmap <leader>+ :resize +5<cr>
nmap <leader>- :resize -5<cr>
nmap <leader>< :vertical resize -5<cr>
nmap <leader>> :vertical resize +5<cr>

" 快速移动
nmap <leader>j 10j
nmap <leader>k 10k

" 行尾行首快速移动
nmap H ^
nmap L $

" 插入模式下的快捷键
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>

" 确保 ESC 键正常工作
inoremap <Esc> <Esc>
" 提供额外的退出插入模式方法
inoremap jk <Esc>
inoremap kj <Esc>

" 复制到系统剪贴板
vmap <leader>y "+y
nmap <leader>p "+p

" 全选
nmap <leader>a ggVG

" 快速删除行
nmap <leader>d dd

" 取消Ex模式
nnoremap Q <nop>

" ============================================================================
" Vim学习专用快捷键
" ============================================================================

" 打开Vim学习指南
nmap <leader>hl :edit ~/vim-learning-guide.md<cr>

" 打开Vim练习文件
nmap <leader>hp :edit ~/vim-practice.txt<cr>

" 快速运行vimtutor
nmap <leader>ht :!vimtutor<cr>

" 显示当前模式（学习用）
set showmode

" 显示按键映射（调试用）
nmap <leader>hm :map<cr>

" 打开Vim学习计划
nmap <leader>hs :edit ~/vim-learning-plan.md<cr>

" 打开Vim插件指南
nmap <leader>hg :edit ~/vim-plugins-guide.md<cr>

" ============================================================================
" 输入法自动切换配置 (macOS)
" ============================================================================

" 输入法切换函数 (macOS)
function! IMSelectEnglish()
    " 尝试多种方法切换到英文输入法

    " 方法1: 使用系统的快捷键切换 (通常是 Control+Space 或 Fn+Globe)
    " 这会循环切换输入法，如果当前是中文，通常会切换到英文
    try
        " 发送 Control+Space
        call system("osascript -e 'tell application \"System Events\" to keystroke space using control down'")
        " 等待一下
        sleep 200m

        " 如果还是不行，再试一次（因为可能需要按两次）
    catch
        " 如果AppleScript失败，静默处理
    endtry
endfunction

  " 退出插入模式时自动切换到英文输入法
  " 进入Normal模式时确保英文输入法
  " 进入vim时切换到英文输入法
  " 焦点回到vim时切换到英文输入法
  autocmd InsertLeave * call IMSelectEnglish()

  " 手动切换到英文输入法的快捷键
  nnoremap <leader>en :call IMSelectEnglish()<CR>

" 手动切换输入法的快捷键 (模拟 Control+Space)
nnoremap <leader>im :call system("osascript -e 'tell application \"System Events\" to keystroke space using control down'")<CR>
