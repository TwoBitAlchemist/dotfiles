# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function parse_git_branch {
      ref=$(/usr/lib/git-core/git-symbolic-ref HEAD 2>/dev/null) || return
      echo ${ref#refs/heads/}
}

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
export 	PS1="\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h'; else echo '\[\033[0;33m\]\u\[\033[0;37m\]@\[\033[0;96m\]\h'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\[\033[0m\]\[\033[0;37m\]\342\224\200[\[\033[0;43m\]\$(parse_git_branch)\[\033[0;37m\]]\n\[\033[0;37m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]"

## Default Options for Common Commands
# Per man bash, if the last character of an alias is a space,
# the next command is also checked to see if it is an alias
# Obviously, this is very handy with sudo
alias sudo='sudo '

# Always create intervening directories
alias mkdir='mkdir -p'

# ls options
alias ls='ls --color --indicator-style=slash --group-directories-first'
alias lsa='ls -A'
alias lsl='ls -lh'
alias lsla='ls -lAh'
alias lslabel='lsla /dev/disk/by-label/'
alias lsbyid='lsla /dev/disk/by-id/'
alias lsuuid='lsla /dev/disk/by-uuid'

# Anticipate frequent typo :P
alias cd..='cd ..'

# Add heroku toolbelt to path
#PATH="/usr/local/heroku/bin:$PATH"
# Add executable ruby gems to path
#PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
