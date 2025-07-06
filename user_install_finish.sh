#!/bin/sh

set -e

cd ~/repos

export BUILDDIR=/tmp/makepkg

pushd rua
makepkg --syncdeps --rmdeps
sudo pacman -U rua-[0-9]*.pkg.tar.zst
rm -rf rua* pkg src
popd

pushd gruvbox-material-theme-git
sed -i 's#github.com/sainnhe#github.com/Mrokkk#g' PKGBUILD
sed -i 's/^options=.*/options=("!strip" "!debug")/g' PKGBUILD
makepkg --syncdeps --rmdeps
sudo pacman -U gruvbox-material-[0-9]*.tar.zst
rm -rf gruvbox-material* pkg src
popd

pushd taglib
sed -i '/-DBUILD_SHARED_LIBS=ON/s/$/ -DCMAKE_BUILD_TYPE=Release/' PKGBUILD
sed -i '/--build build/s/$/ -- -j$(nproc)/' PKGBUILD
makepkg --syncdeps --rmdeps
sudo pacman -U taglib-[0-9]*.tar.zst
rm -rf taglib* pkg src
popd

pushd python-pytaglib
makepkg --syncdeps --rmdeps
sudo pacman -U python-pytaglib-[0-9]*.tar.zst
rm -rf python-pytaglib* pkg src
popd

pushd qman
makepkg --syncdeps --rmdeps
sudo pacman -U qman-[0-9]*.tar.zst
rm -rf qman* pkg src
popd

pushd player
makepkg --syncdeps --rmdeps
sudo pacman -U player-[0-9]*.tar.zst
rm -rf player* pkg src
popd

pushd blocklet-server
makepkg --syncdeps --rmdeps
sudo pacman -U blocklet-server-[0-9]*.tar.zst
rm -rf blocklet-server* pkg src
popd

rm -rf "${BUILDDIR}"
