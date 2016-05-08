# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export LC_ALL="en_US.UTF-8"
export PAGER=vimpager
export PYTHONSTARTUP=~/.pythonstartup


# Allow any key to unfreeze terminal after CTRL-S Scroll Lock
stty ixany

# No overwrite on > redirect; force with >|
set -o noclobber

# Cats rule, dogs drool, etc. etc.
#set -o emacs
set -o vi

# basename \"$VIRTUAL_ENV\"
# https://bbs.archlinux.org/viewtopic.php?pid=1068202#p1068202
# Colors
light_red="\[\e[0;31m\]"
light_green="\[\e[0;32m\]"
light_brown="\[\e[0;33m\]"
light_cyan="\[\e[0;36m\]"
light_gray="\[\e[0;37m\]"
bright_white="\[\e[1;37m\]"
reset_color="\[\e[0m\]"

# UTF-8 Connector pieces
box_color=$light_gray
ul_box_corner="\342\224\214"
ll_box_corner="\342\224\224"
flat_dash="\342\224\200"
prompt_aglet="\342\225\274"
big_red_x="$light_red\342\234\227$box_color"

# Username settings
_root="$light_red\h"
_user="$light_brown\u$light_gray@$light_cyan\h"

function add_git_branch {
    ref=$(/usr/lib/git-core/git-symbolic-ref HEAD 2>/dev/null) || return
    hilite="\e[0;43m"
    _br_display="[$hilite${bright_white:2: -2}"
    _br_display+=${ref#refs/heads/}
    _br_display+="${box_color:2: -2}]"
    echo -e $_br_display
}

# Virtualenv name display
_venv="($reset_color%s$box_color)"

_PS1="$box_color$ul_box_corner$flat_dash"
_PS1+="\$([[ \$? != 0 ]] && echo \"[$big_red_x]$flat_dash\")"
_PS1+="[$(if [[ ${EUID} == 0 ]];then echo $_root; else echo $_user; fi)"
_PS1+="$box_color]$flat_dash[$light_green\w$box_color]"
_PS1+="$flat_dash\$(add_git_branch)\n"
_PS1+="$ll_box_corner$flat_dash"
_PS1+="\$([[ -n \$VIRTUAL_ENV ]] && printf \"$_venv\" \${VIRTUAL_ENV#$HOME/})"
_PS1+="$flat_dash$prompt_aglet$reset_color"

export PS1="$_PS1 "

# Use custom PS1 (above) instead of default virtualenv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

## Default Options for Common Commands
# Per man bash, if the last character of an alias is a space,
# the next command is also checked to see if it is an alias
# Obviously, this is very handy with sudo
alias sudo='sudo '

# ls options
alias ls='ls --color --indicator-style=slash --group-directories-first'
alias lsa='ls -A'
alias lsl='ls -lh'
alias lsla='ls -lAh'

# Anticipate frequent typo :P
alias cd..='cd ..'

# Add heroku toolbelt to path
#PATH="/usr/local/heroku/bin:$PATH"
# Add executable ruby gems to path
#PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
