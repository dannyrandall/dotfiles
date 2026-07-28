# dotfiles

## Setup
1. clone to `$HOME/dotfiles`
	```sh
	git clone git@github.com:dannyrandall/dotfiles.git $HOME/dotfiles
	```
1. symlink `config` directory:
	```sh
	ln -s $HOME/dotfiles/config $HOME/.config
	```
1. install [antigen](https://github.com/zsh-users/antigen) to `$HOME/.antigen.zsh` (where `zshrc` sources it):
	```sh
	curl -L git.io/antigen > $HOME/.antigen.zsh
	```
1. symlink `zsh` config:
	```sh
	ln -s $HOME/dotfiles/zshrc $HOME/.zshrc
	```
1. install [brew](https://brew.sh)
1. install cli tools with [brew](https://brew.sh): [neovim](https://neovim.io/), [tpack](https://github.com/tmuxpack/tpack), [mise](https://github.com/jdx/mise), [tmux](https://github.com/tmux/tmux), [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter), [ripgrep](https://github.com/BurntSushi/ripgrep)
	```sh
	brew install neovim tmuxpack/tpack/tpack mise tmux tree-sitter-cli ripgrep
	```
1. install the language servers (see [Language servers](#language-servers))

## Language servers
Servers are enabled in `config/nvim/lua/plugins/lspconfig.lua` but their binaries have to be
installed separately — `nvim-lspconfig` only ships the configs. Each server is looked up on
`$PATH`, so anything installed into a `mise`-managed runtime needs reinstalling if you change
that runtime's default version.

| server | language(s) | install |
| --- | --- | --- |
| [`vtsls`](https://github.com/yioneko/vtsls) | typescript, javascript | `npm i -g @vtsls/language-server typescript` |
| [`jsonls`](https://github.com/hrsh7th/vscode-langservers-extracted) | json | `npm i -g vscode-langservers-extracted` |
| [`ty`](https://github.com/astral-sh/ty) | python | `uv tool install ty@latest` |
| [`marksman`](https://github.com/artempyanykh/marksman) | markdown | `brew install marksman` |

Or all at once:
```sh
npm i -g @vtsls/language-server typescript vscode-langservers-extracted
uv tool install ty@latest
brew install marksman
```

`npm` and `uv` come from [mise](https://github.com/jdx/mise) (see `config/mise/config.toml`), so
install those runtimes before the servers.

### Mac
1. install [karabiner-elements](https://karabiner-elements.pqrs.org)
	- Enable 'Danny caps layer' rules under 'Complex modifications'
1. install [fira code](https://github.com/tonsky/FiraCode)
1. setup [catppuccin iterm2 profile](https://github.com/catppuccin/iterm)
	- Update font to Fira Code and font size to 14
1. install [vscode](https://code.visualstudio.com/)
