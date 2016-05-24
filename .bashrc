# Colors
RED="\[$(tput setaf 1)\]"
GREEN="\[$(tput setaf 2)\]"
YELLOW="\[$(tput setaf 3)\]"
BLUE="\[$(tput setaf 4)\]"
MAGENTA="\[$(tput setaf 5)\]"
CYAN="\[$(tput setaf 6)\]"
WHITE="\[$(tput setaf 7)\]"

# Text attributes
BOLD="\[$(tput bold)\]"
UNDERLINE="\[$(tput sgr 0 1)\]"

# Reset attributes and colors
RESET="\[$(tput sgr0)\]"

JAVA_BIN=/usr/lib64/java/bin
TOOLCHAINS_DIR=$HOME/toolchains
LD_LIB=$HOME/toolchains/x86-linux-gnu/lib64
CLOC_DIR=/usr/opt/cloc

if [ -d $JAVA_BIN ]; then
	PATH=$PATH:$JAVA_BIN
fi

if [ -d $TOOLCHAINS_DIR ]; then
	PATH=$PATH:`ls -d $TOOLCHAINS_DIR/*/ | xargs printf ":%sbin"`
fi

if [ -d $CLOC_DIR ]; then
	PATH=$PATH:$CLOC_DIR
fi

if [ -d $LD_LIB ]; then
	LD_LIBRARY_PATH=$LD_LIB
fi

export LD_LIBRARY_PATH
export PATH
export EDITOR=vim
export LESSCHARSET="utf-8"
export HISTCONTROL=ignoredups

if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

if [ $EUID = 0 ]; then
	USER_COLOR=$RED
else
	USER_COLOR=$GREEN
fi

if [[ $(tty) == *"tty"* ]]; then
	PWD_COLOR=$CYAN
else
	PWD_COLOR=$BLUE
fi

__PROMPT="$BOLD$USER_COLOR\u@\H$RESET:$PWD_COLOR[\w]$RESET"

__PROMPT_END=" \$ "

if [ -f $HOME/.git-prompt ]; then
	. $HOME/.git-prompt
	GIT_PS1_SHOWDIRTYSTATE=1
	GIT_PS1_SHOWCOLORHINTS=1
	GIT_PS1_DESCRIBE_STYLE="branch"
	GIT_PS1_SHOWUPSTREAM="verbose"
	PROMPT_COMMAND='__git_ps1 "$__PROMPT" "$__PROMPT_END" " [%s]"'
else
	PS1="$__PROMPT$__PROMPT_END"
	PROMPT_COMMAND=
fi

hex(){
	printf "0x%x\n" $1
}

dec(){
	printf "%d\n" $1
}

# Aliases
alias ls="ls --color=always"
alias l="ls -lah"
alias l.="ls -lah | less -R"
alias p="ps -A"
alias p.="ps -AF | less -R"
alias c=clear
alias d="du -hd 1 | sort -h"
alias f="find / -name 2>/dev/null"
alias f.="find . -name 2>/dev/null"

