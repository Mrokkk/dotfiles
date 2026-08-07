if [[ -n "${BASH_VERSION}" ]]
then
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

    __PROMPT="$PWD_COLOR\w$RESET"

    __PROMPT_END=" \$ "

    if [[ -f ~/.bash/git-prompt ]]; then
        . ~/.bash/git-prompt
        GIT_PS1_SHOWDIRTYSTATE=1
        GIT_PS1_SHOWCOLORHINTS=1
        GIT_PS1_DESCRIBE_STYLE="branch"
        GIT_PS1_SHOWUPSTREAM="verbose"
        PROMPT_COMMAND='__git_ps1 "$__PROMPT" "$__PROMPT_END" " [%s]"'
    else
        PS1="$__PROMPT$__PROMPT_END"
        PROMPT_COMMAND=
    fi
fi
