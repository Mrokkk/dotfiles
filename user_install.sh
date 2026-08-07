#!/bin/sh

set -e

base_dir=$(dirname "$0")

. "${base_dir}/utils.sh"

_install_ohmyzsh()
{
    wget -O /tmp/ohmyzsh-install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    sed -i "s/.*exec zsh.*//g" /tmp/ohmyzsh-install.sh
    sh /tmp/ohmyzsh-install.sh
}

mkdir -p ~/repos
mkdir -p ~/.tmux

mkdir -p ~/.local/share/rofi/themes
mkdir -p ~/.config/alacritty

cd ~/repos

step "clone_dotfiles"       clone https://github.com/Mrokkk/dotfiles.git
step "clone_bloclet_server" clone https://github.com/Mrokkk/blocklet-server.git
step "clone_player"         clone https://github.com/Mrokkk/player.git

step "install_tmux_tpm"     clone_revision 99469c4a9b1ccf77fade25842dc7bafbc8ce9946 https://github.com/tmux-plugins/tpm          ~/.tmux/plugins/tpm
step "install_vim_vundle"   clone_revision 5548a1a937d4e72606520c7484cd384e6c76b565 https://github.com/VundleVim/Vundle.vim.git  ~/.vim/bundle/Vundle.vim

pushd_silent dotfiles

rsync -acq home/.* ~

step "install_vim_plugins"          vim +BundleInstall +qall
step "generate_tmuxline_conf"       vim +"TmuxlineSnapshot ${HOME}/.tmux/tmuxline.conf" +qall
step "install_alacritty_themes"     clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
step "install_ohmyzsh"              _install_ohmyzsh
step "install_zsh_autosuggestions"  clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

install_to "home/.zshrc" ~

popd_silent
