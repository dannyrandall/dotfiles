# dotfiles

## dependencies

### zsh
1. [antigen](https://github.com/zsh-users/antigen)
### tmux
1. [tpm](https://github.com/tmux-plugins/tpm)
### neovim
1. [vim-plug](https://github.com/junegunn/vim-plug)
### misc
1. install [nvm](https://github.com/nvm-sh/nvm)

### os specific
#### mac
1. Install [brew](https://brew.sh)
1. Install [karabiner-elements](https://karabiner-elements.pqrs.org)
	- Enable 'Danny caps layer' rules under 'Complex modifications'

## setup
1. clone to `$HOME/dotfiles`
	```
	git clone git@github.com:dannyrandall/dotfiles.git $HOME/dotfiles
	```
1. setup symlinks:
	1. `ln -s $HOME/dotfiles/zshrc $HOME/.zshrc`
	1. `ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf`
	1. `ln -s $HOME/dotfiles/nvimrc $HOME/.nvimrc`
	1. `ln -s $HOME/dotfiles/coc-settings.json $HOME/.vim/coc-settings.json`
1. install vim plugins:
	1. open vim
	1. type and run `:PlugInstall`
1. restart shell :money_with_wings: