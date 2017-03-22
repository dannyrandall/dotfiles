" vim plug
call plug#begin()
" plugins
Plug 'scrooloose/nerdtree'

call plug#end()

" plugin options
" 
" nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " if no files opened (ie, $ vim) then open by default
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif "open if file is a directory
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close if nerdtree is last window
"
" end plugin options
"
" custom key mappings
"
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

" keep cursor in center of screen
set scrolloff=999

