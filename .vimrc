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

" Sort lines
nmap <Leader>x {l<C-v>}h:sort u<CR>

" Replace selection
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
vnoremap <C-t> "hy:%s/\<<C-r>h\>//gc<left><left><left>

" Paste and copy from/to clipboard
nmap <Leader>p :set paste<CR>:r !xclip -selection clipboard -o<CR>:set nopaste<CR>
vnoremap <Leader>y :w !xclip -selection clipboard<CR><CR>

nmap <Leader>. :FZF<CR>
nmap <Leader>e :NERDTreeToggle<CR>
nmap <Leader>f :NERDTreeFind<CR>

set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set list
set ttyfast
set nocompatible
filetype off
filetype plugin indent on
filetype indent on
filetype plugin on
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
Bundle 'vim-airline/vim-airline'
Bundle 'jpo/vim-railscasts-theme'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'sainnhe/gruvbox-material'
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
Bundle 'junegunn/vim-easy-align'
Bundle 'bfrg/vim-cpp-modern'
Bundle 'prabirshrestha/vim-lsp'
Bundle 'mg979/vim-visual-multi'
Bundle 'vim-scripts/AnsiEsc.vim'
call vundle#end()

if has('termguicolors')
    set termguicolors
endif

set background=dark
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_disable_italic_comment = 1
colorscheme gruvbox-material

hi NonText ctermfg=bg " don't show tildes

" NERDTree config
let NERDTreeShowHidden = 0
let NERDTreeQuitOnOpen = 0
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Airline config
let g:airline_theme = 'gruvbox_material'
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

" For Dlang and C3lang
autocmd BufNewFile,BufReadPost *.dt set filetype=pug
autocmd BufNewFile,BufReadPost *.c3 set filetype=c3
au BufReadPost *.h set syntax=c

let g:fzf_layout = { 'down': '~30%' }

let g:tmuxline_preset = {
    \ 'a': '#S',
    \ 'win': ['#I', '#W'],
    \ 'cwin': ['#I', '#W'],
    \ 'x': '#(cat /proc/loadavg | cut -d " " -f 1-3)',
    \ 'y': ['%b %d', '%R'],
    \ 'z': '#H',
    \ 'options' : {'status-justify' : 'left'}}

let g:lsp_document_highlight_enabled = 0
let g:lsp_semantic_enabled = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 0
let g:lsp_diagnostics_highlights_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 0

set completeopt+=menu,menuone,noselect

if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd']},
            \ 'whitelist': ['c', 'cpp'],
            \ 'allowlist': ['c', 'cpp'],
            \ 'semantic_highlight': {
            \     'entity.name.namespace.cpp': 'Type',
            \     'entity.name.function.cpp':'Function',
            \     'entity.name.function.method.cpp': 'Function',
            \     'entity.name.function.preprocessor.cpp': 'PreProc',
            \     'entity.name.type.enum.cpp':'Identifier',
            \     'entity.name.type.class.cpp': 'Identifier',
            \     'entity.name.type.template.cpp': 'Type',
            \     'variable.other.cpp': 'Variable',
            \     'variable.other.field.cpp': 'Variable',
            \     'variable.other.enummember.cpp': 'Constant',
            \     'meta.disabled':'Comment'
            \ }})
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
    augroup end
endif

if executable('pylsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
    au FileType py setlocal omnifunc=lsp#complete
endif

if executable('bash-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'bash-language-server',
        \ 'cmd': {server_info->['bash-language-server', 'start']},
        \ 'allowlist': ['sh', 'bash'],
        \ })
    au FileType sh setlocal omnifunc=lsp#complete
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gt <plug>(lsp-declaration)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> [f <plug>(lsp-previous-error)
    nmap <buffer> ]f <plug>(lsp-next-error)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
    inoremap <buffer> . .<C-x><C-o>
    inoremap <buffer> -> -><C-x><C-o>
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

function! CompleteInf()
    let l:nl=[]
    let l:l=complete_info()
    for k in l['items']
        call add(nl, k['word']. ' : ' .k['abbr'])
    endfor

    if l['mode'] == 'whole_line'
        let l:prefix = '^\s*\zs.*$'
    else
        let l:prefix = '\k*$' " default
    endif

    let l:retval = fzf#vim#complete(fzf#wrap({'prefix': prefix, 'source': nl, 'reducer': { lines -> split(lines[0], '\zs : ')[0] }}))
    return retval
endfunction

function! SortLines() range
    execute a:firstline . "," . a:lastline . 's/^\(.*\)$/\=strdisplaywidth( submatch(0) ) . " " . submatch(0)/'
    execute a:firstline . "," . a:lastline . 'sort n'
    execute a:firstline . "," . a:lastline . 's/^\d\+\s//'
endfunction

inoremap <expr><c-l> CompleteInf()
