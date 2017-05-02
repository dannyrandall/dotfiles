" vim plug
call plug#begin()
" plugins
Plug 'scrooloose/nerdtree'
Plug 'fatih/vim-go'
Plug 'scrooloose/syntastic'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang' }
Plug 'raimondi/delimitmate'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'herringtondarkholme/yats.vim'
Plug 'leafgarland/typescript-vim' 
Plug 'Chiel92/vim-autoformat'
call plug#end()

" plugin options
"
" nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " if no files opened (ie, $ vim) then open by default autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif "open if file is a directory
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close if nerdtree is last window

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1 " highlighting for go
let g:go_fmt_command = "goimports" " use goimports for automatic import paths (instead of gofmt)

" let g:go_list_type = quickfix fix location list window not appearing

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%* " placement for checking
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0 " change when to check syntax
let g:syntastic_go_checkers = ['govet', 'errcheck', 'go'] " set go checkers
"let g:syntastic_typescript_checkers = ['tslint']

" cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1

" vim-autoformat
noremap <F3> :Autoformat<CR>
au BufWrite * :Autoformat

" end plugin options
"
" custom key mappings
"
inoremap jj <esc>
"fix vim-go at some point
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
set shiftwidth=4

" set color scheme
colorscheme slate
" fix syntastic colors
hi Search ctermbg=red ctermfg=black

" show line numbers
set number

" keep cursor in center of screen
set scrolloff=999

" change location of swap files
set directory=/tmp

"scrolling for urxvt
set mouse=a
set ttymouse=xterm2
" disable button clicks
:map <LeftMouse> <nop>
:map <2-LeftMouse> <nop>
