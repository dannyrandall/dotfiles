" vim plug
call plug#begin()
" plugins
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'tpope/vim-surround'
Plug 'raimondi/delimitmate'
Plug 'leafgarland/typescript-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'elixir-editors/vim-elixir'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

" set file specific things on
filetype on
filetype plugin on
filetype indent on

" plugin options
"
" nerdtree
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

" ale
let g:ale_linters = {
    \   'go': ['go vet',
    \          'golint'],
    \   'typescript': ['tslint'],
    \   'javascript': ['prettier'],
    \   'html': ['prettier'],
    \   'scss': ['prettier'],
    \   'css': ['prettier'],
    \   'markdown': ['prettier'],
    \   'json': ['prettier'],
    \   'yaml': ['prettier'],
    \}
let g:ale_fixers = {
    \   'go': ['goimports'],
    \   'typescript': ['prettier'],
    \   'javascript': ['prettier'],
    \   'html': ['prettier'],
    \   'scss': ['prettier'],
    \   'css': ['prettier'],
    \   'markdown': ['prettier'],
    \   'json': ['prettier'],
    \   'yaml': ['prettier'],
    \}
let g:ale_fix_on_save = 1
let g:ale_open_list = 1 " list errors in window at bottom
let g:ale_list_window_size = 4 " height of error list at bottom
let g:ale_lint_delay = 2500
let g:ale_lint_on_text_changed = 'always'
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'err'
let g:ale_echo_msg_warning_str = 'warn'
let g:ale_echo_msg_format = '%s [%linter%]'
nmap <silent> <C-n> <Plug>(ale_next_wrap)
nmap <silent> <C-m> <Plug>(ale_previous_wrap)

" You Complete Me
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_echo_current_diagnostic = 0
let g:ycm_max_diagnostics_to_display = 0
"  let g:ycm_filter_diagnostics = {
"    \ 'java': {
"    \      'regex': ['.*'],
"    \      'level': 'error',
"    \    }
"    \ }

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1 " highlighting for go
let g:go_def_mapping_enabled = 0 " so i can have custom keys for go def
let g:go_fmt_autosave = 0 " disable go fmt on save

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
nnoremap <C-t> :NERDTreeToggle<CR>
" vim-go
autocmd Filetype go nnoremap <buffer> <C-d> :GoDef<CR>
autocmd Filetype go nnoremap <buffer> <C-e> :GoDefPop<CR>
" fzf
nnoremap <C-f> :Rg<CR>
"
" end custom key mappings

" extra stuff
"
" set custom tab width
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

autocmd Filetype typescript setlocal ts=2 sw=2 sts=2 et
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 et

" dockerfile syntax highlighting
au BufReadPost dockerfile set ft=dockerfile
au BufReadPost dockerfile-arm set ft=dockerfile

" format json
command! FormatJSON %!python -m json.tool

" fix backspace on mac
set backspace=2

" set color scheme
colorscheme koehler

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

" change colors for errors/warnings
highlight ALEError ctermbg=Red ctermfg=Black
highlight ALEWarning ctermbg=Blue ctermfg=Black
