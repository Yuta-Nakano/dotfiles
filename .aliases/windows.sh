alias open='explorer.exe'
alias hosts='code /mnt/c/windows/system32/drivers/etc/hosts'
alias git-u='/home/linuxbrew/.linuxbrew/bin/git'
alias git='git.exe'

# function git {
#   if [ `echo $(pwd) | grep ~/` ]; then
#     echo `/home/linuxbrew/.linuxbrew/bin/git "$@"`
#   else
#     echo `git.exe "$@"`
#   fi
# }

function git-config-sync {
  # Dotfile => Windows/User
  cp $HOME/.dotfiles/.gitconfig /mnt/c/Users/"$USER"/.gitconfig
  cp $HOME/.dotfiles/.gitignore.global /mnt/c/Users/"$USER"/.gitignore.global
  # Dotfile => WSL/~
  cp $HOME/.dotfiles/.gitconfig "$HOME"/.gitconfig
  cp $HOME/.dotfiles/.gitconfig.hub "$HOME"/.gitconfig.hub
  cp $HOME/.dotfiles/.gitignore.global "$HOME"/.gitignore.global
}