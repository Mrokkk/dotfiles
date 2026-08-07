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
Bundle 'preservim/nerdtree', {'v': '690d061b591525890f1471c6675bcb5bdc8cdff9'}
Bundle 'Konfekt/FastFold', {'v': 'fff6d05064dec4d7e1398aa507db35fcd57edfb4'}
Bundle 'Konfekt/FoldText', {'v': 'bb17060d3373b63fc5b127136c10b6d1616ebcd9'}
Bundle 'sjl/gundo.vim', {'v': 'c5efef192b975b8e7d5fa3c6db932648d3b76323'}
Bundle 'vim-airline/vim-airline', {'v': '45003f9451d8038064ffe804cf8e8eb0f6a20210'}
Bundle 'vim-airline/vim-airline-themes', {'v': 'cda3b5ea087f7e301a3d4e61727108f66ba6dd20'}
Bundle 'jpo/vim-railscasts-theme', {'v': '826e17cc7a7fdc1aef16b9ddfaf271b51fc2e0a8'}
Bundle 'sainnhe/gruvbox-material', {'v': 'f5f912fbc7cf2d45da6928b792d554f85c7aa89a'}
Bundle 'preservim/nerdcommenter', {'v': 'a462bbda1e26f44fb3d3eb9d9d1c6a07aa98e665'}
Bundle 'MarcWeber/vim-addon-mw-utils', {'v': '6aaf4fee472db7cbec6d2c8eea69fdf3a8f8a75d'}
Bundle 'tomtom/tlib_vim', {'v': 'd3bdad7b5e4253dc7ce6793342d7b8755c67ff0c'}
Bundle 'SirVer/ultisnips', {'v': 'dbc458e110bb49299da76ec53f8b09b4f6dce28a'}
Bundle 'honza/vim-snippets', {'v': 'dbc458e110bb49299da76ec53f8b09b4f6dce28a'}
Bundle 'mileszs/ack.vim', {'v': '36e40f9ec91bdbf6f1adf408522a73a6925c3042'}
Bundle 'edkolev/tmuxline.vim', {'v': '4119c553923212cc67f4e135e6f946dc3ec0a4d6'}
Bundle 'ctrlpvim/ctrlp.vim', {'v': '475a864e7f01dfc5c93965778417cc66e77f3dcc'}
Bundle 'digitaltoad/vim-pug', {'v': 'ea39cd942cf3194230cf72bfb838901a5344d3b3'}
Bundle 'junegunn/limelight.vim', {'v': '0c8cc7f503a775c505dc9c67f1f5041ab4d5f1fd'}
Bundle 'junegunn/fzf.vim', {'v': '3cb44a8ba588e1ada409af495bdc6a4d2d37d5da'}
Bundle 'junegunn/vim-easy-align', {'v': '9815a55dbcd817784458df7a18acacc6f82b1241'}
Bundle 'bfrg/vim-cpp-modern', {'v': '850561ee5b2a600cd00efcf95d85162dba988765'}
Bundle 'prabirshrestha/async.vim', {'v': '2082d13bb195f3203d41a308b89417426a7deca1'}
Bundle 'prabirshrestha/vim-lsp', {'v': '04428c920002ac7cfacbecacb070a8af57b455d0'}
Bundle 'mg979/vim-visual-multi', {'v': 'a6975e7c1ee157615bbc80fc25e4392f71c344d4'}
Bundle 'vim-scripts/AnsiEsc.vim', {'v': 'd2bb7878622e4c16203acf1c92a0f4bc7ac58003'}
call vundle#end()

if has('termguicolors')
    set termguicolors
endif

set background=dark
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_disable_italic_comment = 1

try
    colorscheme gruvbox-material
catch
endtry

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
"let g:lsp_semantic_enabled = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 0
"let g:lsp_diagnostics_highlights_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_work_done_progress_enabled = 0
"let g:lsp_log_file = expand("~/.vim/vimlsp.log")
"let g:lsp_log_verbose = 0

set completeopt+=menu,menuone,noselect

if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info->['clangd', '-j', '4']},
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
    inoremap <C-@> <C-x><C-o>
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

inoremap <expr><c-l> CompleteInf()
