# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.
echo '.profile'
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 022

# if running bash
# if [ -n "$BASH_VERSION" ]; then
#     # include .bashrc if it exists
#     if [ -f "$HOME/.bashrc" ]; then
# 	. "$HOME/.bashrc"
#     fi
# fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# common:
setopt auto_cd
setopt auto_menu
setopt auto_param_keys
# setopt auto_param_slash
setopt auto_pushd
setopt list_packed
setopt list_types
setopt mark_dirs
setopt nolistbeep

export HISTFILE=~/.history
export HISTSIZE=10000
export SAVEHIST=100000
setopt hist_expand
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

bindkey ^R history-incremental-search-backward

# common: colors
# autoload -U colors && colors
# setopt prompt_subst

# brew
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/isl@0.18/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/isl@0.18/include"

# zsh
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# zplug (Zsh Plugin Manager)
export ZPLUG_HOME=$HOMEBREW_PREFIX/opt/zplug
source $ZPLUG_HOME/init.zsh

# zplug > plugin
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "mafredri/zsh-async", from:"github", use:"async.zsh"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "junegunn/fzf-bin", as:command,  rename-to:"fzf", from:gh-r
zplug "b4b4r07/enhancd", use:init.sh
zplug "plugins/git", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2, lazy:true
zplug "chrissicool/zsh-256color", lazy:true
zplug "jessarcher/zsh-artisan", lazy:true

# zplug > theme
zplug "romkatv/powerlevel10k", as:theme, depth:1

# zplug > Install an uninstalled zplug item
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# zplug > Link the command from zplug,
#         add it to your PATH, and load the plugin
zplug load

# zplug > Settings when the plugin exists
if zplug check b4b4r07/enhancd; then
    export ENHANCD_FILTER=fzy:fzf:peco
fi

# anyenv
eval "$(anyenv init -)"
# vue
export PATH="$HOME/.anyenv/envs/nodenv/versions/12.18.0/bin:$PATH"
eval "$(nodenv init -)"

# aliases
source $HOME/.aliases/common.sh
source $HOME/.aliases/windows.sh
