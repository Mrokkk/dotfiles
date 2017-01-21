let mapleader = ","
nmap <Leader>t :tabnew<CR>
nmap <Leader>l :tabn<CR>
nmap <Leader>h :tabp<CR>
nmap <F8> :tabn<CR>
nmap <F7> :tabp<CR>
nmap <Leader>q :bd<CR>
nmap <space> viw

nmap <F4> :setlocal spell! spelllang=en_us<CR>
nmap <F5> :%s/\(\l\)\(\u\)/\1\_\l\2/gc<CR>
nmap <C-\> :s/$/;/gc<CR>y
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

set pastetoggle=<Leader>p
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set list
set ttyfast

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'Konfekt/FastFold'
Bundle 'Konfekt/FoldText'
Bundle 'Yggdroot/indentLine'
Bundle 'sjl/gundo.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'vim-airline/vim-airline'
Bundle 'jpo/vim-railscasts-theme'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
Bundle 'scrooloose/nerdcommenter'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'mileszs/ack.vim'
Bundle 'edkolev/tmuxline.vim'
Bundle 'ctrlpvim/ctrlp.vim'

call vundle#end()            " required

filetype plugin indent on    " required
filetype indent on

set shell=/bin/bash
syntax on

set backup
set noswapfile
call system('mkdir -p ~/.vim/backup')
set backupdir=~/.vim/backup,.

let backup_var=strftime("%y%m%d.%Hh%M")
let backup_var="set backupext=_". backup_var
execute backup_var

set mouse=a
set number
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursov
set nowrap
set cursorline
set softtabstop=4
set laststatus=2

let NERDTreeShowHidden = 0
let NERDTreeQuitOnOpen = 0
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
nmap <Leader>e :NERDTreeToggle<CR>
nmap <Leader>f :NERDTreeFind<CR>

let g:airline_powerline_fonts = 1
set t_Co=256
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.space = "\ua0"

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#exclude_preview = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline_theme = 'simple'

" remove latency on switching though modes
set timeoutlen=300 ttimeoutlen=0

" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces

colorscheme railscasts

let g:indentLine_color_term = 242 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)

let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_server_python_interpreter = "/usr/bin/python3"
set completeopt-=preview

nnoremap <Leader>g :YcmCompleter GoTo<CR>

" turn off spell checking
autocmd VimEnter * set nospell

" let g:AutoPairsMapCR = 0

" don't show tildes
hi NonText ctermfg=bg

let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:tmuxline_preset = {
        \ 'a': '#S',
        \ 'b': '#F',
        \ 'c': '#W',
        \ 'win': ['#I', '#W'],
        \ 'cwin': ['#I', '#W'],
        \ 'x': '#(cat /proc/loadavg | cut -d " " -f 1-3)',
        \ 'y': ['%b %d', '%R'],
        \ 'z': '#H'}

