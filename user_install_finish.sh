#!/bin/sh

cd ~/repos
pushd rua
makepkg
sudo pacman -U rua-*.pkg.tar.zst
popd

rua install gruvbox-material-gtk-theme-git
rua install gruvbox-material-icon-theme-git
