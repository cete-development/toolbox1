#!/bin/sh

backup() { cp -f -- "$1" "$1.bak.$(date +%Y%m%d-%H%M%S)"; }

lssh() {
  [ -z "$1" ] && echo "Usage: lssh <keyfile>" && return 1
  eval "$(ssh-agent -s)"
  ssh-add "$HOME/.ssh/$1"
}

lextract() {
  local file="$1"

  [ ! -f "$file" ] && {
    echo "'$file' is not a valid file"
    return 1
  }

  case "$file" in
      *.tar.bz2) tar xjf "$file" ;;
      *.tar.gz)  tar xzf "$file" ;;
      *.tbz2)    tar xjf "$file" ;;
      *.tgz)     tar xzf "$file" ;;
      *.tar.xz)  tar xf  "$file" ;;
      *.tar.zst) tar xf  "$file" ;;
      *.tar)     tar xf  "$file" ;;
      *.bz2)     bunzip2 "$file" ;;
      *.gz)      gunzip "$file" ;;
      *.zip)     unzip "$file" ;;
      *.rar)     unrar x "$file" ;;
      *.7z)      7z x "$file" ;;
      *.Z)       uncompress "$file" ;;
      *.deb)     ar x "$file" ;;
      *) echo "'$file' cannot be extracted" ;;
  esac
}

lmksshkey() {
  local name="$1"
  [ -z "$name" ] && { echo "Usage: lmksshkey <name>"; return 1; }

  ssh-keygen -o -a 100 -t ed25519 -C "$name" -f "$HOME/.ssh/$name"
}

clone_repo() {
    printf "repo Username: "
    read usrn
    printf "repo Name: "
    read rpnm

    #git clone https://github.com/$usrn/$rpnm   #for https
    git clone git@github.com:$usrn/$rpnm.git
}

get_path() {
    find "$(pwd)" -type f -name "$1" -print -quit
}
