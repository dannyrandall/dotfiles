export DOTFILES=$HOME/dotfiles
export TERM="xterm-256color"
export EDITOR="nvim"

export PATH=$PATH:$HOME/bin # manually installed
export PATH=$PATH:$HOME/.local/bin # should probably use instead of $HOME/bin
export PATH=$PATH:$HOME/go/bin # golang
. "$HOME/.cargo/env" # rust

if [[ $OSTYPE == darwin* ]]; then # mac stuff
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

### antigen ###
source $HOME/.antigen.zsh

antigen use oh-my-zsh

antigen bundle wd
antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

antigen theme denysdovhan/spaceship-prompt

antigen apply
### end antigen ###

### zsh theme ###
SPACESHIP_PROMPT_ORDER=(
  time
  user
  dir
  host
  package
  venv
  exec_time
  line_sep
  jobs
  exit_code
  char
)
SPACESHIP_RPROMPT_ORDER=(
  aws
  git
)
SPACESHIP_PROMPT_ADD_NEWLINE="true"
SPACESHIP_PROMPT_SEPARATE_LINE="false"
SPACESHIP_CHAR_SYMBOL="➜ "
SPACESHIP_CHAR_SYMBOL_ROOT=$SPACESHIP_CHAR_SYMBOL
SPACESHIP_CHAR_COLOR_SUCCESS="green"
SPACESHIP_CHAR_COLOR_FAILURE="red"
SPACESHIP_CHAR_COLOR_SECONDARY="yellow"
SPACESHIP_USER_SHOW="needed"
SPACESHIP_HOST_PREFIX="@"
### end zsh theme ###

# completion options
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=25

eval "$(mise activate zsh)"
source <(mise completion zsh)

[ -f $DOTFILES/aliases ] && source $DOTFILES/aliases
[ -f $DOTFILES/functions ] && source $DOTFILES/functions
[ -f $DOTFILES/amzn-zshrc ] && source $DOTFILES/amzn-zshrc

autoload -Uz compinit && compinit