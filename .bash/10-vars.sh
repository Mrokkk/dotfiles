export PAGER="less"
export EDITOR="vim"
export MANPAGER="sh -c 'col -bx | bat --paging=always --theme=gruvbox-dark -l man -p'"
export MANROFFOPT="-c"
export LESSCHARSET="utf-8"

if [[ -n "${BASH_VERSION}" ]]
then
    export HISTFILESIZE=
    export HISTSIZE=
fi

export HISTTIMEFORMAT="[%F %T] "
export HISTCONTROL=ignoredups

export CCACHE_ENABLED=1
