############################
# Interactive shell guard #
############################
case $- in
  *i*) ;;
  *) return ;;
esac

################################
# Portable utility: source file
################################
load_if_exists() {
  if [ -f "$1" ]; then
    . "$1"
    printf '\033[34m%s imported.\033[0m\n' "$2"
  fi
}

load_if_exists "$HOME/base_functions.sh" "Base functions"
load_if_exists "$HOME/base_aliases.sh" "Base aliases"

################
# History
################
export HISTCONTROL=ignoreboth
export HISTSIZE=1000
export HISTFILESIZE=2000

shopt -s histappend checkwinsize

################
# Lesspipe
################
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

################
# dircolors
################
if [ -x /usr/bin/dircolors ]; then
  [ -r "$HOME/.dircolors" ] && \
    eval "$(dircolors -b "$HOME/.dircolors")" || \
    eval "$(dircolors -b)"

  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

################
# PATH
################
export PATH="$HOME/.local/bin:$PATH"

################
# BASH prompt fallback
################
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
  ;;
esac
