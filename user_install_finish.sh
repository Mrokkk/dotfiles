#!/bin/sh

set -e

cd ~/repos

export BUILDDIR=/tmp/makepkg

pushd rua
makepkg --syncdeps --rmdeps
sudo pacman -U rua-*.pkg.tar.zst
popd

pushd gruvbox-material-theme-git
sed -i 's#github.com/sainnhe#github.com/Mrokkk#g' PKGBUILD
sed -i 's/^options=.*/options=("!strip" "!debug")/g' PKGBUILD
makepkg --syncdeps --rmdeps
sudo pacman -U gruvbox-material-*.tar.zst
popd

pushd taglib
sed -i '/-DBUILD_SHARED_LIBS=ON/s/$/ -DCMAKE_BUILD_TYPE=Release/' PKGBUILD
sed -i '/--build build/s/$/ -- -j$(nproc)/' PKGBUILD
makepkg --syncdeps --rmdeps
sudo pacman -U taglib-*.tar.zst
popd

pushd python-pytaglib
makepkg --syncdeps --rmdeps
sudo pacman -U python-pytaglib-*.tar.zst
popd

pushd qman
makepkg --syncdeps --rmdeps
sudo pacman -U qman-*.tar.zst
popd

rm -rf "${BUILDDIR}"
