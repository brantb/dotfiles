# Commands
path_add() {
    # Adds a directory to $PATH, but only if it isn't already present.
    # http://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there/39995#39995
    if [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$PATH:$1"
    fi
}

# define colors
C_DEFAULT="\[\033[m\]"
C_WHITE="\[\033[1m\]"
C_BLACK="\[\033[30m\]"
C_RED="\[\033[31m\]"
C_GREEN="\[\033[32m\]"
C_YELLOW="\[\033[33m\]"
C_BLUE="\[\033[34m\]"
C_PURPLE="\[\033[35m\]"
C_CYAN="\[\033[36m\]"
C_LIGHTGRAY="\[\033[37m\]"
C_DARKGRAY="\[\033[1;30m\]"
C_LIGHTRED="\[\033[1;31m\]"
C_LIGHTGREEN="\[\033[1;32m\]"
C_LIGHTYELLOW="\[\033[1;33m\]"
C_LIGHTBLUE="\[\033[1;34m\]"
C_LIGHTPURPLE="\[\033[1;35m\]"
C_LIGHTCYAN="\[\033[1;36m\]"
C_BG_BLACK="\[\033[40m\]"
C_BG_RED="\[\033[41m\]"
C_BG_GREEN="\[\033[42m\]"
C_BG_YELLOW="\[\033[43m\]"
C_BG_BLUE="\[\033[44m\]"
C_BG_PURPLE="\[\033[45m\]"
C_BG_CYAN="\[\033[46m\]"
C_BG_LIGHTGRAY="\[\033[47m\]"

# Internal commands
_command_exists() {
  type "$1" &> /dev/null ;
}
_set_exit_color() {
	if [[ $? != "0" ]]; then EXITCOLOR=$C_RED; else EXITCOLOR=$C_GREEN; fi
}

# Prompt
MAX_WD_LENGTH="50"
export PROMPT_COMMAND='_set_exit_color;PS1="${EXITCOLOR}[$(if (( $(pwd|wc -c|tr -d " ") > $MAX_WD_LENGTH )); then echo "\\W"; else echo "\\w"; fi)$C_YELLOW$(__git_ps1)${EXITCOLOR}]$C_DEFAULT "'

# Set options
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
path_add /usr/local/sbin
path_add /usr/local/bin
path_add ~/Applications/bin

# Aliases
alias ls='ls -F'
alias v='ls -ahl'
alias cls='clear'
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"
alias screensaver="/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine &"

if _command_exists fortune; then
  fortune
  echo
fi

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

