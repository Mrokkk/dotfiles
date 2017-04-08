let mapleader = ","
nmap <Leader>t :tabnew<CR>
nmap <Leader>l :tabn<CR>
nmap <Leader>h :tabp<CR>
nmap <F8> :tabn<CR>
nmap <F7> :tabp<CR>
nmap <Leader>q :bd<CR>
nmap <space> viw
nmap <Leader>rc :tabnew<CR>:e ~/.vimrc<CR>
nmap <Leader>s :source %<CR>
nmap <F4> :setlocal spell! spelllang=en_us<CR>
nmap <F5> :%s/\(\l\)\(\u\)/\1\_\l\2/gc<CR>
nmap <C-\> :s/$/;/gc<CR>y
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
set pastetoggle=<Leader>p

set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set list
set ttyfast
set nocompatible
filetype off
filetype plugin indent on
filetype indent on
syntax on
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
set timeoutlen=300 ttimeoutlen=0
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

autocmd VimEnter * set nospell

" Don't use swap files
set noswapfile

" Keep backup
set backup
call system('mkdir -p ~/.vim/backup')
set backupdir=~/.vim/backup,.
let backup_var=strftime("%y%m%d.%Hh%M")
let backup_var="set backupext=_". backup_var
execute backup_var

" Keep undo history
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir
if has('persistent_undo')
    let undoDir = expand(vimDir . '/undodir')
    call system('mkdir ' . vimDir)
    call system('mkdir ' . undoDir)
    let &undodir = undoDir
    set undofile
endif

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'Konfekt/FastFold'
Bundle 'Konfekt/FoldText'
"Bundle 'Yggdroot/indentLine' " was fucking slow
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
Bundle 'digitaltoad/vim-pug'
Bundle 'junegunn/limelight.vim'
Bundle 'idanarye/vim-dutyl'
Bundle 'junegunn/fzf.vim'
call vundle#end()
call dutyl#register#tool('dcd-client','/usr/bin/dcd-client')
call dutyl#register#tool('dcd-server','/usr/bin/dcd-server')
call dutyl#register#tool('dub','/usr/bin/dub')
colorscheme railscasts

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

let g:indentLine_color_term = 242 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)

let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_server_python_interpreter = "/usr/bin/python3"
set completeopt-=preview
nnoremap <Leader>g :YcmCompleter GoTo<CR>
set completefunc=dutyl#dComplete

" don't show tildes
hi NonText ctermfg=bg

let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:tmuxline_preset = {
        \ 'a': '#S',
        \ 'win': ['#I', '#W'],
        \ 'cwin': ['#I', '#W'],
        \ 'x': '#(cat /proc/loadavg | cut -d " " -f 1-3)',
        \ 'y': ['%b %d', '%R'],
        \ 'z': '#H',
        \ 'options' : {'status-justify' : 'left'}}

autocmd BufNewFile,BufReadPost *.dt set filetype=pug

let g:fzf_layout = { 'down': '~30%' }
nmap <Leader>. :FZF<CR>

nmap <Leader>; :Limelight!!<CR>

let g:dutyl_stdImportPaths = ['/usr/include/dlang/dmd']
