# base path
# export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

# dotfiles directory
export DOTFILES=$HOME/dotfiles
export ZSH=$DOTFILES/zsh

# os specific things configurations
if [[ $OSTYPE == darwin* ]]; then
    ## mac specific things
	export GOPATH=$HOME/programming/go

    # path
    export PATH=/usr/local/bin:/usr/local/sbin:$PATH

    # theme (move this out of here once below is gone)
    source $ZSH/themes/geometry/geometry.zsh
else
    ## linux specific things
    export GOPATH=$HOME/programming/go

    # use gpg tty instead of pinentry
    export GPG_TTY=$(tty)

    # theme (move this out of here once below is gone)
    source $ZSH/themes/geometry/geometry.zsh

    # fixes while i still have oh-my-zsh on arch
    if [[ $(uname -r) = *"ARCH"* ]]; then
        export ZSH=$HOME/.oh-my-zsh
        export GOPATH=$HOME/documents/work/go
        ZSH_THEME="geometry/geometry"
        plugins=(zsh-autosuggestions zsh-syntax-highlighting)

        source $ZSH/oh-my-zsh.sh
    fi
fi

# path
export TERM="xterm-256color"

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

# completions
fpath=($ZSH/completions $fpath)
autoload -Uz compinit && compinit -i

# edits for plugins
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=25

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
