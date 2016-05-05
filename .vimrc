colorscheme desert
set backupdir=~/.vim_temp
autocmd Filetype gitcommit setlocal spell textwidth=72
let backup_var=strftime("%y%m%d.%Hh%M")
let backup_var="set backupext=_". backup_var
execute backup_var

