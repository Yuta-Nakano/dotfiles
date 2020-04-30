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
# alias brew="env PATH=${PATH/${HOME}\/\.pyenv\/shims:/} brew"
function brew-remove {
  brew rm "$1"
  brew rm $(join <(brew leaves) <(brew deps "$1"))
}
alias brew-rm='brew-remove'
alias brew-up='brew update && brew upgrade'


# gitignore.io
function gignore { curl -sLw n https://www.gitignore.io/api/$@ ;}
