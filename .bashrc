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

# https://bbs.archlinux.org/viewtopic.php?pid=1068202#p1068202
[[ -e ".ansi-color-vars" ]] && . .ansi-color-vars

# UTF-8 Connector pieces
box_color_=$gray
ul_box_corner_="\342\224\214"
ll_box_corner_="\342\224\224"
flat_dash_="\342\224\200"
prompt_aglet_="\342\225\274"
big_red_x="$red\342\234\227$box_color"


function colorize_git_state {
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse @{u} 2>/dev/null)
    BASE=$(git merge-base @ @{u} 2>/dev/null)

    gitColor=$white
    if [[ -z $REMOTE ]]; then
        gitColor+=$boldbggreen      # no upstream configured
    elif [[ $LOCAL = $REMOTE ]]; then
        gitColor+=$boldbgblue        # up to date
    elif [[ $LOCAL = $BASE ]]; then
        gitColor+=$boldbgred         # needs pull
    elif [[ $REMOTE = $BASE ]]; then
        gitColor+=$boldbgcyan        # changes to push
    else
        gitColor+=$boldbgmagenta     # local and remote have diverged
    fi
}


function add_git_branch {
    ref=$(git symbolic-ref --short HEAD 2>/dev/null) || return
    colorize_git_state
    echo -e ">$gitColor $ref $nocolor$box_color_"
}

function display_user {
    _root="$red\h"
    _user="$yellow\u$gray@$cyan\h"
    if [[ $EUID == 0 ]]; then
        echo $_root;
    else
        echo $_user;
    fi
}

# Virtualenv name display
_venv="($nocolor%s$box_color_)"

# Line 1
_PS1="$box_color_$ul_box_corner_$flat_dash_"
_PS1+="\$([[ \$? != 0 ]] && echo \"[$big_red_x]$flat_dash_\")"
_PS1+="//$(display_user)$box_color_:$green\w$box_color_/$flat_dash_"
_PS1+="\$(add_git_branch)\n"
# Line 2
_PS1+="$ll_box_corner_$flat_dash_"
_PS1+="\$([[ -n \$VIRTUAL_ENV ]] && printf \"$_venv\" \${VIRTUAL_ENV#$HOME/})"
_PS1+="$flat_dash_$prompt_aglet_$brightwhite"

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
