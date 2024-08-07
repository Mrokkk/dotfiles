#!/bin/bash

function mcd()
{
    mkdir -p $1 && cd $1
}

function path()
{
    stat -L "${1}" >/dev/null && readlink -f "${1}";
}

function pacsize()
{
    for file in /var/lib/pacman/local/*
    do
        size="$(sed -n '/^%SIZE%$/{N;s/.*\n//p}'< $file/desc)"
        echo $((size / 1024/1024))MB ${file##*/}
    done | sort -n
}

function int()
{
    ~/.bash/conv "${@}"
}

function fshow()
{
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute:
                  (grep -o '[a-f0-9]\{7\}' | head -1 |
                  xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                  {}
FZF-EOF"
}

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always %'"

# fshow_preview - git commit browser with previews
function fshow_preview()
{
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
            --header "enter to view, alt-y to copy hash" \
            --bind "enter:execute:$_viewGitLogLine" \
            --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

alias fl=fshow_preview

function fd()
{
    local root=$(git rev-parse --show-toplevel)
    local preview="git diff --no-relative --color=always -- ${root}/{-1}"
    git diff --name-only |
        fzf --no-multi --reverse --ansi \
            --preview="$preview" \
            --bind "enter:execute:echo ${root}/{} | xargs -o vim"
}

function fa()
{
    local preview="git diff --color=always {-1}"
    git ls-files --deleted --modified --other --exclude-standard :/ |
        fzf -0 --reverse -m --ansi \
            --preview="${preview}" \
            --bind "enter:execute(echo {} | xargs -r -o git add -p)+reload(git ls-files --deleted --modified --other --exclude-standard :/)"
}

function ff_cd()
{
    local f=`readlink -f "$(cat ${1})/${2}"`
    if [[ -d "${f}" ]]
    then
        /bin/ls -1 --color=always "${f}"
        echo -n "${f}" >${1}
    fi
}

function ff_preview()
{
    local f="$(cat ${1})/${2}"
    if [[ -f "${f}" ]]
    then
        /bin/bat -f "${f}"
    else
        /bin/ls -1 --color=always "${f}"
    fi
}

function ff()
{
    local cwd=$(mktemp)
    echo -n "${PWD}" > "${cwd}"
    local preview=". ~/.zsh/40-functions.sh; ff_preview ${cwd} {}"
    local enter_dir=". ~/.zsh/40-functions.sh; ff_cd ${cwd} {} 2>/tmp/ffstderr"
    local exit_dir=". ~/.zsh/40-functions.sh; ff_cd ${cwd} .. 2>/tmp/ffstderr"
    local open=". ~/.zsh/40-functions.sh; ff_cd ${cwd} .. 2>/tmp/ffstderr"

    while :
    do
        local ret=$(ls -1 --color=always `cat ${cwd}` |
            fzf --reverse --no-multi --ansi \
                --preview="${preview}" \
                --bind "tab:reload(${enter_dir})" \
                --bind "shift-tab:reload(${exit_dir})")

        if [[ -z "${ret}" ]]
        then
            return
        fi

        local f=$(cat ${cwd})/${ret}
        if [[ -f "${f}" ]]
        then
            echo "${f}" | xargs -o vim
        fi
    done

    rm "${cwd}"
}
