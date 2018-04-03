# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH 
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export PATH="/usr/local/bin:$PATH"
export TERM="xterm-256color"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.  # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="geometry/geometry"

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

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git wd zsh-autosuggestions zsh-syntax-highlighting)

# edits for plugins
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=25
#ZSH_AUTOSUGGEST_USE_ASYNC=true

source $ZSH/oh-my-zsh.sh

#if gopass >/dev/null; then
#	source <(gopass completion zsh)
#fi

# User configuration

# Default user
DEFAULT_USER="dannyrandall"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# go
if [[ $OSTYPE == darwin* ]]; then
	export GOPATH=$HOME/programming/go	
else 
	export GOPATH=~/documents/work/go
fi
export PATH=$GOPATH/bin:$PATH

# ruby gems
export PATH=~/.gem/ruby/2.4.0/bin:$PATH

# use gpg tty instead of pinentry
export GPG_TTY=$(tty)

# aliases
[ -f $HOME/.aliases ] && source $HOME/.aliases

# functions
[ -f $HOME/.functions ] && source $HOME/.functions

# load work env. vars
[ -f $HOME/.envrc ] && source $HOME/.envrc

# fixing commands
eval $(thefuck --alias)
