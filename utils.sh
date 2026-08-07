#!/bin/bash

cache_file="$(readlink -f "${base_dir}/.steps")"
tmp_cache_file="/tmp/$(basename "${cache_file}")"

if [ -f "${tmp_cache_file}" ]
then
    cat "${tmp_cache_file}" >> "${cache_file}"
    rm "${tmp_cache_file}"
fi

echo "Cache file: ${cache_file}"

if [ -f "${cache_file}" ]
then
    . "${cache_file}"
fi

die()
{
    echo "${@}"
    exit 1
}

copy_cache_file_to_tmp()
{
    cp "${cache_file}" "${tmp_cache_file}"
    chmod 666 "${tmp_cache_file}"
}

pushd_silent()
{
    pushd "${1}" &>/dev/null || die "No directory: ${1}"
}

popd_silent()
{
    popd &>/dev/null || die "Cannot go back to previous dir!"
}

step()
{
    local step_name="${1}"
    local cmd="${*:2}"

    if [ -n "${!step_name}" ]
    then
        echo "${step_name}: nothing to do"
        return 0
    fi

    echo "${step_name}: starting"

    eval "${cmd}"

    echo "${step_name}: finished"

    touch "${cache_file}"
    echo "${step_name}=1" >> "${cache_file}"
}

install_to()
{
    local src="${1}"
    local dest="${2}"

    if [ -d "${src}" ]
    then
        rsync -acrq "${src}/" "${dest}/$(basename "${src}")"
    else
        rsync -acq "${src}/" "${dest}"
    fi
}

clone_revision()
{
    git clone --depth 1 --revision "${@}"
}

clone()
{
    git clone "${@}"
}
