let mapleader = ","

nmap <Leader>t :tabnew<CR>
nmap <Leader>l :tabn<CR>
nmap <Leader>h :tabp<CR>
nmap <Leader>q :bd<CR>
nmap <space> viw

" Open .vimrc
nmap <Leader>rc :tabnew<CR>:e ~/.vimrc<CR>

" Camel case to Pascal case
nmap <F5> :%s/\(\l\)\(\u\)/\1\_\l\2/gc<CR>

" Add a semicolon and the line's end
nmap <C-\> :s/$/;/gc<CR>y$

" Replace selection
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
vnoremap <C-R> "hy:%s/\<<C-r>h\>//gc<left><left><left>

" Paste and copy from/to clipboard
nmap <Leader>p :set paste<CR>:r !xclip -selection clipboard -o<CR>:set nopaste<CR>
vnoremap <Leader>y :w !xclip -selection clipboard<CR><CR>

nnoremap <Leader>g :YcmCompleter GoTo<CR>
nmap <Leader>. :FZF<CR>
nmap <Leader>; :Limelight!!<CR>
nmap <Leader>e :NERDTreeToggle<CR>
nmap <Leader>f :NERDTreeFind<CR>

" Show svn blame
nmap <Leader>bl :Blame<CR>

set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set list
set ttyfast
set nocompatible
filetype off
filetype plugin indent on
filetype indent on
syntax on
set mouse=a                     " Enable mouse support
set number                      " Display line numbers
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set nowrap                      " Do not wrap lines
set cursorline                  " Highlight current line
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
Bundle 'junegunn/fzf.vim'
call vundle#end()

colorscheme railscasts

" NERDTree config
let NERDTreeShowHidden = 0
let NERDTreeQuitOnOpen = 0
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Airline config
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

" Ycm config
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_server_python_interpreter = "/usr/bin/python3"
set completeopt-=preview

" Vim snippets
let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" For Dlang
autocmd BufNewFile,BufReadPost *.dt set filetype=pug

" Don't show tildes
hi NonText ctermfg=bg

let g:fzf_layout = { 'down': '~30%' }

function! s:SvnBlame()
   let cmdline = "svn blame " . bufname("%")
   let nline = line(".") + 1
   botright new
   setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
   silent execute "$read !" . cmdline
   setlocal nomodifiable
   execute "normal " . nline . "gg"
   execute "set filetype=cpp"
endfunction
command! -nargs=* Blame call s:SvnBlame()

let g:tmuxline_preset = {
        \ 'a': '#S',
        \ 'win': ['#I', '#W'],
        \ 'cwin': ['#I', '#W'],
        \ 'x': '#(cat /proc/loadavg | cut -d " " -f 1-3)',
        \ 'y': ['%b %d', '%R'],
        \ 'z': '#H',
        \ 'options' : {'status-justify' : 'left'}}

