" ============================================================================
" 代码编辑增强
" ============================================================================

if !exists('g:vim_settings_no_ide')
    let g:vim_settings_no_ide = 0
endif

if g:vim_settings_no_ide
    finish
endif

let s:plugin_root = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/../plugins'

function! s:HasPlugin(plugin_name) abort
    return isdirectory(s:plugin_root . '/' . a:plugin_name)
endfunction

function! s:ForceComplete() abort
    if exists('*asyncomplete#force_refresh')
        call asyncomplete#force_refresh()
    else
        echohl WarningMsg | echom 'asyncomplete is not available. Install default IDE plugins first.' | echohl None
    endif
endfunction

if exists('+completeopt')
    set completeopt=menuone,noselect
endif

" ----------------------------------------------------------------------------
" LSP 与异步补全
" ----------------------------------------------------------------------------

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_document_code_action_signs_enabled = 1
let g:lsp_document_highlight_enabled = 1
let g:lsp_preview_float = 1
let g:lsp_signature_help_enabled = 1
let g:lsp_settings_filetype_vim = ['vim-language-server']

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 200
let g:asyncomplete_min_chars = 2

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <silent> <C-Space> <C-o>:call <SID>ForceComplete()<CR>

function! s:LspCommand(command) abort
    if exists(':' . a:command) == 2
        execute a:command
    else
        echohl WarningMsg | echom a:command . ' is not available. Install vim-lsp plugins first.' | echohl None
    endif
endfunction

function! s:CodeFormat() abort
    if exists(':LspDocumentFormatSync') == 2
        silent! LspDocumentFormatSync
    elseif exists(':ALEFix') == 2
        ALEFix
    else
        echohl WarningMsg | echom 'No formatter is available. Install vim-lsp or ALE first.' | echohl None
    endif
endfunction

command! CodeFormat call <SID>CodeFormat()
command! LspOutline call <SID>LspCommand('LspDocumentSymbol')
command! LspWorkspaceSymbols call <SID>LspCommand('LspWorkspaceSymbol')

function! s:OnLspBufferEnabled() abort
    setlocal omnifunc=lsp#complete
    nnoremap <buffer> <silent> gd :LspDefinition<CR>
    nnoremap <buffer> <silent> gr :LspReferences<CR>
    nnoremap <buffer> <silent> gi :LspImplementation<CR>
    nnoremap <buffer> <silent> gt :LspTypeDefinition<CR>
    nnoremap <buffer> <silent> K :LspHover<CR>
    nnoremap <buffer> <silent> [d :LspPreviousDiagnostic<CR>
    nnoremap <buffer> <silent> ]d :LspNextDiagnostic<CR>
    nnoremap <buffer> <silent> <leader>lr :LspRename<CR>
    nnoremap <buffer> <silent> <leader>la :LspCodeAction<CR>
    nnoremap <buffer> <silent> <leader>lf :CodeFormat<CR>
    nnoremap <buffer> <silent> <leader>lo :LspDocumentSymbol<CR>
    nnoremap <buffer> <silent> <leader>ls :LspWorkspaceSymbol<CR>
endfunction

augroup vim_settings_lsp
    autocmd!
    autocmd User lsp_buffer_enabled call <SID>OnLspBufferEnabled()
augroup END

" 插件尚未安装时也保留这些入口，给出温和提示而不是报未知命令。
nnoremap <silent> <leader>lf :CodeFormat<CR>
nnoremap <silent> <leader>lo :LspOutline<CR>
nnoremap <silent> <leader>ls :LspWorkspaceSymbols<CR>

" ----------------------------------------------------------------------------
" ALE 诊断与修复
" ----------------------------------------------------------------------------

let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 0
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_linters = {
            \ 'sh': ['shellcheck'],
            \ 'markdown': ['markdownlint'],
            \ }
let g:ale_fixers = {
            \ 'sh': ['shfmt'],
            \ 'bash': ['shfmt'],
            \ 'zsh': ['shfmt'],
            \ }

" ----------------------------------------------------------------------------
" 测试工作流
" ----------------------------------------------------------------------------

let test#strategy = 'vimterminal'
nnoremap <silent> <leader>tt :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>tn :TestLast<CR>
nnoremap <silent> <leader>tv :TestVisit<CR>
