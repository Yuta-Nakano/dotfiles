echo '.aliases'

# linux
alias       cl='clear'
alias       ls='exa -xGF'
alias       la='exa -axGF'
alias       ll='exa -alF'
alias     tree='exa -Tx'
alias     trea='exa -Txa'
# alias       ps='procs'
alias      cat='bat'
alias   reload='exec $SHELL -l'
function history-all { history -E 1 }

# brew
function brew-remove {
  brew rm "$1"
  brew rm $(join <(brew leaves) <(brew deps "$1"))
}
alias brew-rm='brew-remove'
alias brew-up='brew update && brew upgrade'

# tree
function glt-install {
  brew install "$1"
  if [ ! `echo $(which $1) | grep $1` ]; then
    sudo apt install "$1"
  fi
}
function glt-change {
  brew install "$1"
  if [ `echo $(which $1) | grep $1` ]; then
    sudo apt remove -y "$1"
    sudo apt autoremove
  fi
}
function glt-remove {
  brew rm "$1"
  brew rm $(join <(brew leaves) <(brew deps "$1"))
  if [ `echo $(which $1) | grep $1` ]; then
    sudo apt remove "$1"
  fi
}


# gitignore.io
function gignore { curl -sLw n https://www.gitignore.io/api/$@ ;}

# docker-compose
alias balse='docker-compose down --rmi all --volumes'
