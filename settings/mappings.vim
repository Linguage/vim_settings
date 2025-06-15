" ============================================================================
" 快捷键映射
" ============================================================================

" 设置Leader键
let mapleader = ","
let g:mapleader = ","

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

" 复制到系统剪贴板
vmap <leader>y "+y
nmap <leader>p "+p

" 全选
nmap <leader>a ggVG

" 快速删除行
nmap <leader>d dd

" 取消Ex模式
nnoremap Q <nop>
