#!/bin/sh

mkdir -p ~/repos
mkdir -p ~/.tmux

cd ~/repos

git clone https://github.com/Mrokkk/dotfiles.git
git clone https://github.com/Mrokkk/blocklet-server.git
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://aur.archlinux.org/rua.git

cp dotfiles/.Xresources ~
cp dotfiles/.bashrc ~
cp dotfiles/.blocklets.json ~
cp dotfiles/.gitconfig ~
cp dotfiles/.gtkrc-2.0 ~
cp dotfiles/.i3blocks.conf ~
cp dotfiles/.tmux.conf ~
cp dotfiles/.vimrc ~
cp dotfiles/.xinitrc ~

cp -r dotfiles/.config ~
cp -r dotfiles/.bash ~

wget -O /tmp/ohmyzsh-install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sed -i "s/.*exec zsh.*//g" /tmp/ohmyzsh-install.sh
sh /tmp/ohmyzsh-install.sh

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

cp dotfiles/.zshrc ~

vim +BundleInstall +qall

pushd blocklet-server
dub build
popd

pushd rua
makepkg
sudo pacman -U rua-*.pkg.tar.zst
popd

rua install gruvbox-material-gtk-theme-git
rua install gruvbox-material-icon-theme-git
