#!/bin/bash
DOTPATH=$HOME/.dotfiles

# dotpath check
if [ $? -ne 0 ]; then
    die "not found: $DOTPATH"
fi

# os check
case `uname -sr` in
    Linux*-Microsoft)
        # Windows Subsystem for Linux
        OS_CHECK='windows'
        OS_ALIASES_PATH='$HOME/.aliases/windows.sh'

        sudo apt clean
        sudo apt -y autoremove
        sudo apt -y update
        sudo apt install -y curl git docker.io

        # やりようが困るやつ
        cat <<EOF >> $HOME/.profile

# common:
autoload -U compinit
compinit

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
EOF
        ;;
    Darwin*)
        # Mac OS
        OS_CHECK='mac'
        OS_ALIASES_PATH='$HOME/.aliases/mac.sh'
        ;;
esac

# homebrew install when not exists
if [ ! -n $HOMEBREW_VERSION ]; then
    echo 'Homebrew install'
    CI=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    sudo apt install -y build-essential

    if [ "$OS_CHECK" = 'windows' ];
        then
            echo -n -e "\n" >>  $HOME/.profile
            echo '# brew' >> $HOME/.profile
            echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> $HOME/.profile
            source $HOME/.profile
    fi
fi

# zsh install when not exists
if [ ! `echo $(which zsh) | grep zsh` ]; then
    brew install zsh
    echo $(which zsh) | sudo tee -a /etc/shells
    chsh -s $(which zsh)
fi

# perl
# echo '# perl' >> $HOME/.profile
# PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
# echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"' >> $HOME/.profile

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".gitconfig.local" ]] && continue
    [[ "$f" == ".profile" ]] && continue
    ln -snfv "$DOTPATH/$f" "$HOME"/"$f"
done

# ここからはオプションだけど必要なので、どうするか以後考える

# exa, bat, procs, curl, git install
brew install exa bat procs curl git
sudo apt remove -y curl git

# anyenv install when not exists
brew install anyenv
if [ ! `echo $(which anyenv) | grep anyenv` ]; then
    brew install anyenv

    anyenv init
    echo '# anyenv' >> $HOME/.profile
    echo 'eval "$(anyenv init -)"' >> $HOME/.profile
    source $HOME/.profile

    # nodenv, phpenv, rbenv, pyenv install
    anyenv install --init
    anyenv install nodenv
    anyenv install phpenv
    anyenv install rbenv
    anyenv install pyenv

    # install node 12.16.2 LTS
    nodenv install 12.16.2
fi

# zplug install when not exists
if [ ! `echo $(which zplug) | grep zplug` ]; then
    brew install zplug
    echo -n -e "\n" >>  $HOME/.profile
    echo '# zplug (Zsh Plugin Manager)' >> $HOME/.profile
    echo 'export ZPLUG_HOME=$HOMEBREW_PREFIX/opt/zplug' >> $HOME/.profile
    echo 'source $ZPLUG_HOME/init.zsh' >> $HOME/.profile
fi

# aliases
echo -n -e "\n" >>  $HOME/.profile
echo '# aliases' >> $HOME/.profile
echo 'source $HOME/.aliases/common.sh' >> $HOME/.profile
echo "source $OS_ALIASES_PATH" >> $HOME/.profile
source $HOME/.profile

# docker
if [ "$OS_CHECK" = 'windows' ];
    then
        echo -n -e "\n" >>  $HOME/.profile
        echo '# docker' >>  $HOME/.profile
        echo 'export DOCKER_TLS_VERIFY=1' >> $HOME/.profile
        echo 'export DOCKER_HOST="tcp://192.168.99.101:2376"' >> $HOME/.profile
        echo 'export DOCKER_CERT_PATH="/mnt/c/Users/nakano_yuta/.docker/machine/machines/default"' >> $HOME/.profile
        echo 'export DOCKER_MACHINE_NAME="default"' >> $HOME/.profile

        # docker-compose
        sudo curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
        sudo chmod +x /usr/bin/docker-compose
fi

# Clean
sudo apt clean
sudo apt -y autoremove
sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
