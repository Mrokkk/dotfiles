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

if [ -d $JAVA_BIN ]; then
	PATH=$PATH:$JAVA_BIN
fi

if [ -d $TOOLCHAINS_DIR ]; then
	export PATH=$PATH:`ls -d $TOOLCHAINS_DIR/*/ | xargs printf ":%sbin"`
	export LD_LIBRARY_PATH=`ls -d $TOOLCHAINS_DIR/*/ | xargs printf ":%slib64"`
fi

export EDITOR=vim
export HISTCONTROL=ignoredups

if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

if [ "$(id -u)" = "0" ]; then
	USER_COLOR=$RED
else
	USER_COLOR=$GREEN
fi

__PROMPT="${BOLD}${USER_COLOR}\u@\H${RESET}:${BLUE}[\w]${RESET}"
__PROMPT_END='`if [ $? = 0 ]; then echo "\[$(tput setaf 2)\] \$ \[$(tput sgr0)\]";'
__PROMPT_END+='else echo "\[$(tput setaf 1)\] \$ \[$(tput sgr0)\]"; fi`'

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

