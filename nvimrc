""" dein """
if &compatible
  set nocompatible
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('$HOME/cache/dein')
  call dein#begin('$HOME/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')

  """ plugins """
  " Add or remove your plugins here like this:
  call dein#add('dracula/vim', { 'name': 'dracula' })
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 }) 
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('preservim/nerdtree')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('tpope/vim-surround')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('wlangstroth/vim-racket', { 'on_ft': 'racket' })
  call dein#add('JuliaEditorSupport/julia-vim') " this one can't be lazy loaded
  call dein#add('hashivim/vim-terraform', { 'on_ft': ['tf', 'tfvars', 'terraform'] })
  call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release' })
  call dein#add('neoclide/coc-python', { 'on_ft': 'python' })
  call dein#add('neoclide/coc-tsserver', { 'on_ft': 'typescript' })
  call dein#add('neoclide/coc-html', { 'on_ft': 'html' })
  call dein#add('neoclide/coc-css', { 'on_ft': ['css', 'scss'] })
  call dein#add('neoclide/coc-json', { 'on_ft': 'json' })
  call dein#add('neoclide/coc-yaml', { 'on_ft': 'yaml' })

  " Required:
  call dein#end()
  call dein#save_state()
endif
	
" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

""" nerdtree """
" open nerdtree when vim starts up, if no files were given
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" open nerdtree if a directory was passed to vim
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" close nerdtree if it's the only thing left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" set where the splits should go
set splitbelow
set splitright

""" vim airline """
let g:airline_theme = 'minimalist'
let g:airline_powerline_fonts = 1 " allow powerline fonts

""" coc.nvim """
" if hidden is not set, TextEdit might fail.
set hidden
" some servers have issues with backup files, see #649
set nobackup
set nowritebackup
" better display for messages
set cmdheight=2
" you will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
" helper function for below
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" function to show documentation
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" close preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" fold based on lsp
command! -nargs=? Fold :call CocAction('fold', <f-args>)

""" terraform """
let g:terraform_align=1
let g:terraform_fmt_on_save=1

""" tabs """
set noexpandtab
set autoindent
filetype plugin indent on
set ts=4 sw=4 sts=4
autocmd Filetype typescript setlocal ts=2 sw=2 sts=2 et
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 et

""" folding """
set foldmethod=syntax
set foldnestmax=4
" don't autofold at the beginning
set foldlevelstart=99

""" theme """
syntax on
colorscheme dracula
highlight Normal ctermbg=None
" show line numbers
set number

" change location of swap files
set directory=/tmp

""" key mapping """
" remap escape
vnoremap fd <esc>
inoremap fd <esc>
" open nerdtree
map <C-t> :NERDTreeToggle<CR>
" easier window movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
" fzf
nnoremap <C-f> :Rg<CR>

""" go specific """
" format and add missing imports
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
