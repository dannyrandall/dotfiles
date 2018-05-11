# base path
# export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

# dotfiles directory
export DOTFILES=$HOME/dotfiles
export ZSH=$DOTFILES/zsh

# os specific things configurations
if [[ $OSTYPE == darwin* ]]; then
    ## mac specific things
	export GOPATH=$HOME/programming/go

    # brew
    export PATH=/usr/local/bin:/usr/local/sbin:$PATH
else
    ## linux specific things
	export GOPATH=~/documents/work/go

    # use gpg tty instead of pinentry
    export GPG_TTY=$(tty)
fi

# path
export TERM="xterm-256color"

# theme
source $ZSH/geometry/geometry.zsh

# custom stuff for geometry
GEOMETRY_PROMPT_PLUGINS=(git exec_time)
PROMPT_GEOMETRY_COLORIZE_SYMBOL="true"
PROMPT_GEOMETRY_COLORIZE_ROOT="true"
GEOMETRY_SYMBOL_GIT_DIRTY="◆"
GEOMETRY_SYMBOL_GIT_CLEAN="◇"
GEOMETRY_COLOR_GIT_DIRTY="red"
GEOMETRY_COLOR_GIT_CLEAN="green"
PROMPT_GEOMETRY_GIT_TIME="false"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(zsh-autosuggestions zsh-syntax-highlighting)

# edits for plugins
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=25

# User configuration

# Default user
DEFAULT_USER="dannyrandall"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'

# go
export PATH=$GOPATH/bin:$PATH

# ruby gems
export PATH=~/.gem/ruby/2.4.0/bin:$PATH

# aliases
[ -f $HOME/.aliases ] && source $HOME/.aliases

# functions
[ -f $HOME/.functions ] && source $HOME/.functions

# load work env. vars
[ -f $HOME/.envrc ] && source $HOME/.envrc

# fixing commands
eval $(thefuck --alias)
