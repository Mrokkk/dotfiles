[[ $- != *i* ]] && return

export PAGER="less"
export EDITOR="vim"
export LESSCHARSET="utf-8"
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTCONTROL=ignoredups
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"
export TERM="xterm-256color"
export CCACHE_ENABLED=1

shopt -s checkwinsize
shopt -s expand_aliases

[[ -f /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion
[[ -f ~/.bash_prompt ]] && . ~/.bash_prompt
[[ -f ~/.bash_functions ]] && . ~/.bash_functions
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ $CCACHE_ENABLED ]] && export PATH=/usr/lib/ccache/bin:$PATH && export CXXFLAGS=-fdiagnostics-color=always && export CFLAGS=-fdiagnostics-color=always

