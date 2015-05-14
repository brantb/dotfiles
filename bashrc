# Internal commands
# Color definitions (Comments refer to Solarized color)
C_DEFAULT="\[\033[m\]"
C_BLACK="\[\033[30m\]"			# base02
C_RED="\[\033[31m\]"			# red
C_GREEN="\[\033[32m\]"			# green
C_YELLOW="\[\033[33m\]"			# yellow
C_BLUE="\[\033[34m\]"			# blue
C_MAGENTA="\[\033[35m\]"		# magenta
C_CYAN="\[\033[36m\]"			# cyan
C_WHITE="\[\033[37m\]"			# base2
C_BRBLACK="\[\033[1;30m\]"		# base03
C_BRRED="\[\033[1;31m\]"		# orange
C_BRGREEN="\[\033[1;32m\]"		# base01
C_BRYELLOW="\[\033[1;33m\]"		# base00
C_BRBLUE="\[\033[1;34m\]"		# base0
C_BRMAGENTA="\[\033[1;35m\]"	# violet
C_BRCYAN="\[\033[1;36m\]"		# base1
C_BRWHITE="\[\033[1;37m\]"		# base3
# Background colors (No bright versions, not supported :()
C_BG_BLACK="\[\033[40m\]"		# base02
C_BG_RED="\[\033[41m\]"			# red
C_BG_GREEN="\[\033[42m\]"		# green
C_BG_YELLOW="\[\033[43m\]"		# yellow
C_BG_BLUE="\[\033[44m\]"		# blue
C_BG_MAGENTA="\[\033[45m\]"		# magenta
C_BG_CYAN="\[\033[46m\]"		# cyan
C_BG_WHITE="\[\033[47m\]"		# base2

_path_add() {
    # Adds a directory to $PATH, but only if it isn't already present.
    # http://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there/39995#39995
    if [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$PATH:$1"
    fi
}
_dir_chomp () {
    # Shortens the working directory.
    # First param is pwd, second param is the soft limit.
    # From http://stackoverflow.com/questions/3497885/code-challenge-bash-prompt-path-shortener/3499237#3499237
    # which asks for the shortest solution in characters, explaining the complete lack of readability or clarity.
    local IFS=/ c=1 n d
    local p=(${1/#$HOME/\~}) r=${p[*]}
    local s=${#r}
    while ((s>$2&&c<${#p[*]}-1))
    do
        d=${p[c]}
        n=1;[[ $d = .* ]]&&n=2
        ((s-=${#d}-n))
        p[c++]=${d:0:n}
    done
    echo "${p[*]}"
}
_command_exists() {
    type "$1" &> /dev/null ;
}
_set_exit_color() {
    if [[ $? != "0" ]]; then EXITCOLOR=$C_RED; else EXITCOLOR=$C_GREEN; fi
}
_set_ps1_hostname() {
	if [[ $TERM == screen* ]] && [ -n "$TMUX" ]; then
		PS1_HOSTNAME=
	else
		PS1_HOSTNAME="$(whoami)@${C_YELLOW}${HOSTNAME}${EXITCOLOR}:"
	fi
}
_set_git_prompt_string() {
    if type -t __git_ps1 &> /dev/null; then
        PS1_GIT="$(__git_ps1)"
    fi 
}
_set_title() {
	echo -ne "\033]2;$1\007"
}

# Paths and environment variables for non-interactive shells
# These REALLY need to come first, which is why we don't use _path_add() like below
PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# If this is a non-interactive shell, return
if [[ $- != *i* ]]
then
  return
fi

# Prompt
MAX_WD_LENGTH="50"
PROMPT_COMMAND='_set_exit_color;\
	_set_git_prompt_string;\
	_set_ps1_hostname;\
	PS1="${EXITCOLOR}[${PS1_HOSTNAME}$(_dir_chomp "$(pwd)" $MAX_WD_LENGTH)${C_YELLOW}${PS1_GIT}${EXITCOLOR}]\$${C_DEFAULT} ";\
	_set_title ${HOSTNAME%%.*}:${PWD/$HOME/\~}'

# Environment variables for interactive shells
export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
export GIT_PS1_SHOWUPSTREAM="verbose"

# Turn off ctrl+s
stty ixany
stty ixoff -ixon
stty stop undef
stty start undef

# Aliases and commands
alias ls='ls -F'
alias v='ls -ahlO'
alias cls='clear'
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"
alias screensaver="/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine &"
alias brewup='brew update && brew upgrade --all && brew cleanup'
alias cdf='cd "$(osascript -e "tell application \"Finder\" to if window 1 exists then if target of window 1 as string is not \":\" then get POSIX path of (target of window 1 as alias)")"'
alias gs='git status'
alias gd='git diff'
alias gl='git log'
alias server='open http://localhost:8000 && python -m SimpleHTTPServer'

mkcd() {
    dir="$*";
    mkdir -p "$dir" && cd "$dir";
}
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.war)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
    esac
    else
        echo "'$1' is not a valid file"
    fi
}
# Show the fortune while we set up other things
if _command_exists fortune && [ "$TERM_PROGRAM" != "DTerm" ]; then
	fortune
	echo
fi

if _command_exists hub; then
	`hub alias -s bash`
fi

if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if _command_exists dircolors; then
    eval `dircolors --bourne-shell ~/.dir_colors`
fi
if _command_exists rbenv; then
	eval "$(rbenv init -)"
fi

# Run local config
if [ -f ~/.bashrc.local ]; then
	. ~/.bashrc.local
fi

