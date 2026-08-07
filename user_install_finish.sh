#!/bin/bash

set -e

base_dir=$(dirname "$0")

. "${base_dir}/utils.sh"

cd ~/repos

export BUILDDIR=/tmp/makepkg

cleanup()
{
    rm -rf "${BUILDDIR}"
}

trap cleanup EXIT

pushd_silent dotfiles

for pkg in aur/*
do
    pushd_silent "${pkg}"
    step_name="$(basename "${pkg//-/_}")"
    step step_name makepkg --syncdeps --noconfirm --install --clean
    popd_silent
done

popd_silent

pushd_silent player/archlinux
step "install_player" makepkg --syncdeps --noconfirm --install --clean
rm -rf player*
popd_silent

pushd_silent blocklet-server/archlinux
step "install_blocklet_server" makepkg --syncdeps --noconfirm --install --clean
rm -rf blocklet-server*
popd_silent

step "firecfg_fix" firecfg --fix
