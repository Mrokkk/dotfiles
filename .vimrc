set tabstop=4
set backspace=indent,eol,start
set autoindent
set copyindent
set nowrap
set number
set numberwidth=4
set shiftwidth=4
set textwidth=80
set title
set noerrorbells
set visualbell
set noswapfile

colorscheme desert
set backupdir=~/.vim_temp
autocmd Filetype gitcommit setlocal spell textwidth=72
let backup_var=strftime("%y%m%d.%Hh%M")
let backup_var="set backupext=_". backup_var
execute backup_var

