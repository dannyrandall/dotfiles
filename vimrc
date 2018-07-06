" vim plug
call plug#begin()
" plugins
Plug 'scrooloose/nerdtree'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang' }
Plug 'w0rp/ale'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'tpope/vim-surround'
Plug 'raimondi/delimitmate'
Plug 'leafgarland/typescript-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

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
    \}
let g:ale_fixers = {
    \   'go': ['goimports'],
    \}
let g:ale_fix_on_save = 1
let g:ale_open_list = 1 " list errors in window at bottom
let g:ale_list_window_size = 7 " height of error list at bottom
let g:airline#extensions#ale#enabled = 1
nmap <silent> <C-n> <Plug>(ale_next_wrap)
nmap <silent> <C-m> <Plug>(ale_previous_wrap)

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1 " highlighting for go
let g:go_fmt_autosave = 0 " disable go fmt on save
inoremap iee <C-o>:GoIfErr<CR>


" cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1

" vim-airline
let g:airline_theme='minimalist'
let g:airline_powerline_fonts=1 " allow powerline fonts

" end plugin options
"
" custom key mappings
"
inoremap jj <esc>
noremap <C-T> :NERDTreeToggle<CR>
"window movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" clipboard (linux)
vnoremap <C-c> :%w !xclip -i -sel c<CR><CR>
vnoremap <C-v> :r !xclip -o -sel -c<CR><CR>
"
" end custom key mappings

" extra stuff
"
" set custom tab width
set tabstop=4
set expandtab
set shiftwidth=4

autocmd Filetype js,ts,css setlocal tabstop=2
autocmd Filetype js,ts,css setlocal shiftwidth=2

" format json
command! FormatJSON %!python -m json.tool

" fix backspace on mac
set backspace=2

" set color scheme
colorscheme koehler

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
