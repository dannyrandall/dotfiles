" vim plug
call plug#begin()
" plugins
Plug 'scrooloose/nerdtree'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', { 'branch': 'release', 'do': ':CocInstall coc-python coc-tsserver coc-angular coc-html coc-css coc-json' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-surround'
Plug 'raimondi/delimitmate'
Plug 'leafgarland/typescript-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
call  plug#end()

" general stuff
set autoread
set encoding=utf-8
set backspace=2 " fix backspace on mac
set splitbelow
set splitright

" tabs for indentation, spaces for alignment
set noexpandtab
set autoindent
filetype plugin indent on
set shiftwidth=4
set tabstop=4
set softtabstop=4

" theme, syntax highlighting
syntax on
colorscheme dracula " for colors
highlight Normal ctermbg=None

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" ale (linter)
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
    \   'go': ['golangci-lint'],
    \   'typescript': ['eslint'],
    \   'javascript': ['eslint'],
    \   'markdown': ['vale'],
    \   'asciidoc': ['vale'],
    \   'html': ['prettier'],
    \   'scss': ['prettier'],
    \   'css': ['prettier'],
    \   'json': ['prettier'],
    \   'yaml': ['prettier'],
    \}
let g:ale_fixers = {
    \   '*': ['remove_trailing_lines',
    \         'trim_whitespace'],
    \   'go': ['goimports'],
    \   'typescript': ['prettier'],
    \   'javascript': ['prettier'],
    \   'html': ['prettier'],
    \   'scss': ['prettier'],
    \   'css': ['prettier'],
    \   'json': ['prettier'],
    \   'yaml': ['prettier'],
    \}
let g:ale_linters_explicit = 1 " only use for languges i say
let g:ale_open_list = 0 " don't list errors in window at bottom
let g:ale_lint_on_text_changed = 'never' " don't lint on text change
let g:ale_lint_on_insert_leave = 1 " lint when leaving insert mode
let g:ale_lint_on_enter = 1 " lint when switching to a file
let g:ale_fix_on_save = 1 " run fixers on file save
let g:ale_sign_error = '>>' " text in gutter for error
let g:ale_sign_warning = '--' " text in gutter for warning
let g:ale_echo_msg_error_str = 'err'
let g:ale_echo_msg_warning_str = 'warn'
let g:ale_echo_msg_format = '%s [%linter%]' " message format
let g:ale_completion_enabled = 0 " don't use ale completion
let g:airline#extensions#ale#enabled = 1 " work with airline
let g:ale_go_golangci_lint_options= '--fast --tests=false'
let g:ale_go_golangci_lint_package = 1

" waiting for support on floatwindows! https://github.com/dense-analysis/ale/issues/2418

" change colors for errors/warnings
highlight ALEError ctermbg=Red ctermfg=Black cterm=underline
highlight ALEWarning ctermbg=Yellow ctermfg=Black cterm=underline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" coc.nvim (autocomplete)
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden " apparently TextEdit might fail if not set?
set cmdheight=2 " supposedly better display for messages
set updatetime=300 " update more frequently

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" use <CR> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" close preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" vim-go
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_structs = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1 " highlight everything
let g:go_highlight_build_constraints = 1 " highlighting for go
let g:go_def_mapping_enabled = 0 " i use coc.nvim for godef
let g:go_fmt_autosave = 0 " disable go fmt on save
let g:go_auto_sameids = 1 " show when the same variable is highlighted
let g:go_auto_type_info = 0 " show type info in status bar
let g:go_updatetime = 500 " a litte faster (default is 800)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" nerdtree
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " if no files opened (ie, $ vim) then open by default autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif "open if file is a directory

" function to close vim if there aren't any useful buffers open
function! CheckLeftBuffers()
    if tabpagenr('$') == 1
        let i = 1
        while i <= winnr('$')
            if getbufvar(winbufnr(i), '&buftype') == 'help' ||
                \ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
                \ getbufvar(winbufnr(i), '&buftype') == 'loclist' ||
                \ exists('t:NERDTreeBufName') &&
                \   bufname(winbufnr(i)) == t:NERDTreeBufName ||
                \ bufname(winbufnr(i)) == '__Tag_List__'
                let i += 1
            else
                break
            endif
        endwhile
        if i == winnr('$') + 1
            qall
        endif
    unlet i
    endif
endfunction
autocmd BufEnter * call CheckLeftBuffers()

" use ctrl+t to show/hide window
nnoremap <C-t> :NERDTreeToggle<CR>

" cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1

" vim-airline
let g:airline_theme = 'minimalist'
let g:airline_powerline_fonts = 1 " allow powerline fonts

" fzf
" show preview window with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1, fzf#vim#with_preview('right:50%'))
let g:fzf_layout = { 'down': "~40%" }

" end plugin options
"
" custom key mappings
"
inoremap jj <esc>
"window movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" clipboard (linux)
vnoremap <C-c> :%w !xclip -i -sel c<CR><CR>
vnoremap <C-v> :r !xclip -o -sel -c<CR><CR>
" nerdtree
" vim-go
autocmd Filetype go nnoremap <buffer> <C-d> :GoDef<CR>
autocmd Filetype go nnoremap <buffer> <C-e> :GoDefPop<CR>
" fzf
nnoremap <C-f> :Rg<CR>
"
" end custom key mappings

" extra stuff

autocmd Filetype typescript setlocal ts=2 sw=2 sts=2 et
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 et

" dockerfile syntax highlighting
au BufReadPost dockerfile set ft=dockerfile
au BufReadPost dockerfile-arm set ft=dockerfile

" format json
" command! FormatJSON %!python -m json.tool

" folding
set foldmethod=syntax
set foldnestmax=3
set foldlevel=30
set nofoldenable

" show line numbers
set number

" keep cursor in center of screen
set scrolloff=999

" change location of swap files
set directory=/tmp

" scrolling
set mouse=a
set ttymouse=xterm2

" disable button clicks
:noremap <LeftMouse> <nop>
:noremap <2-LeftMouse> <nop>
:inoremap <LeftMouse> <nop>
:inoremap <2-LeftMouse> <nop>
