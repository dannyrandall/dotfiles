" vim plug
call plug#begin()
" plugins
Plug 'scrooloose/nerdtree'
Plug 'fatih/vim-go'
Plug 'scrooloose/syntastic'
call plug#end()

" plugin option sdfjdklasd;lkfdjskald;fsldadfdsadfssdf;asdfjdsa
"
" nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " if no files opened (ie, $ vim) then open by default
autocmd StdinReadPre * let s:std_in=1
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
let g:go_list_type = "quickfix" " fix location list window not appearing

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%* " placement for checking
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0 " change when to check syntax
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] } " set go checkers

" end plugin options
"
" custom key mappings
"
inoremap jj <esc>
map <C-t> :NERDTreeToggle<CR>
"
" end custom key mappings


" extra stuff
"
" set custom tab width
set tabstop=4
set shiftwidth=4

" set color scheme
colorscheme slate

" show line numbers
set number
set relativenumber

" keep cursor in center of screen
set scrolloff=999

