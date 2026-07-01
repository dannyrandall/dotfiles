# dotfiles

## Mac Setup
1. install [brew](https://brew.sh)
1. clone to `$HOME/dotfiles`
	```sh
	git clone git@github.com:dannyrandall/dotfiles.git $HOME/dotfiles
	```
1. symlink `config` directory:
	```sh
	ln -s $HOME/dotfiles/config $HOME/.config
	```
1. install [karabiner-elements](https://karabiner-elements.pqrs.org)
	- Enable 'Danny caps layer' rules under 'Complex modifications'
1. install [fira code](https://github.com/tonsky/FiraCode)
1. setup [catppuccin iterm2 profile](https://github.com/catppuccin/iterm)
	- Update font to Fira Code and font size to 14
1. install [vscode](https://code.visualstudio.com/)
1. install [neovim](https://neovim.io/)
1. install [mise](https://github.com/jdx/mise)
1. install [antigen](https://github.com/zsh-users/antigen)
1. install [tpack](https://github.com/tmuxpack/tpack)
1. symlink `zsh` config:
	```sh
	ln -s $HOME/dotfiles/zshrc $HOME/.zshrc
	```
