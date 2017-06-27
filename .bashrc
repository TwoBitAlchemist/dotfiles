# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export LC_ALL="en_US.UTF-8"
export PYTHONSTARTUP=~/.pythonstartup


# Allow any key to unfreeze terminal after CTRL-S Scroll Lock
stty ixany

# No overwrite on > redirect; force with >|
# set -o noclobber

# Cats rule, dogs drool, etc. etc.
#set -o emacs
set -o vi

# https://bbs.archlinux.org/viewtopic.php?pid=1068202#p1068202
[[ -e "$HOME/.ansi-color-vars" ]] && . $HOME/.ansi-color-vars

# \x01 and \x02 -- readline library escape delimiters
#                  equivalent to \[ \] but more portable

# UTF-8 Connector pieces
box_color_=$gray
ul_box_corner_="\342\224\214"
ll_box_corner_="\342\224\224"
flat_dash_="\342\224\200"
prompt_aglet_="\342\225\274"
big_red_x="\[$red\]\342\234\227\[$box_color_\]"


function add_git_branch {
    BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null) || return

    LOCAL_SHA=$(git rev-parse HEAD)
    REMOTE_SHA=$(git rev-parse origin/$BRANCH 2>/dev/null)
    MERGE_BASE=$(git merge-base $BRANCH origin/$BRANCH 2>/dev/null)

    git_color=$white
    if [[ -z $REMOTE_SHA ]]; then
        git_color+=$boldbggray        # no upstream configured
    elif [[ $LOCAL_SHA = $REMOTE_SHA ]]; then
        git_color+=$boldbgblue        # up to date
    elif [[ $LOCAL_SHA = $MERGE_BASE ]]; then
        git_color+=$boldbgcyan        # needs pull
    elif [[ $REMOTE_SHA = $MERGE_BASE ]]; then
        git_color+=$boldbggreen       # changes to push
    else
        git_color+=$boldbgred         # local and remote have diverged
    fi
    echo -e ">\x01$git_color\x02 $BRANCH \x01$box_color_\x02"
}

function display_user_and_pwd {
    _root="\x01$white${boldbggreen}\x02ACCESS GRANTED\x01$nocolor $red\x02\w"
    _user="\x01$yellow\x02\u\x01$gray\x02@"
    _host="\x01$cyan\x02\h\x01$box_color_\x02:\x01$green\x02\w"
    if [[ $EUID == 0 ]]; then
        echo -e $_root;
    else
        echo -e $_user$_host;
    fi
}

# Virtualenv name display
function print_venv {
    fmt="(\x01$nocolor\x02%s\x01$box_color_\x02)"
    [[ -n $VIRTUAL_ENV ]] && printf $fmt $(basename $VIRTUAL_ENV)
}

# Line 1
PS1="\[$box_color_\]$ul_box_corner_$flat_dash_"
PS1+="\$([[ \$? != 0 ]] && echo \"[$big_red_x]$flat_dash_\")"
PS1+="//$(display_user_and_pwd)\[$box_color_\]/$flat_dash_"
PS1+="\$(add_git_branch)\n"
# Line 2
PS1+="$ll_box_corner_$flat_dash_"
PS1+="\$(print_venv)"
PS1+="$flat_dash_$prompt_aglet_\[$nocolor\] "

export PS1=$PS1

# Use custom PS1 (above) instead of default virtualenv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

## Default Options for Common Commands
# Per man bash, if the last character of an alias is a space,
# the next command is also checked to see if it is an alias
# Obviously, this is very handy with sudo
alias sudo='sudo '

# ls options
if ls --color &>/dev/null; then
    alias ls='ls --color --indicator-style=slash --group-directories-first '
else
    # approx. equiv. of above on MacOS X ls which does not support long opts
    alias ls='ls -FG '
fi
alias lsa='ls -A '
alias lsl='ls -lh '
alias lsla='ls -lAh '

# Anticipate frequent typo :P
alias cd..='cd ..'

# Add heroku toolbelt to path
#PATH="/usr/local/heroku/bin:$PATH"
# Add executable ruby gems to path
#PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
