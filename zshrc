export DOTFILES=$HOME/dotfiles
export TERM="xterm-256color"
export EDITOR="nvim"

# os specific things configurations
if [[ $OSTYPE == darwin* ]]; then ## mac specific things
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
	export PATH=$PATH:$HOME/go/bin # golang
else
  export GOPATH=$HOME/programming/go

	# node verison manager
	[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh
fi

export PATH=$PATH:$HOME/bin # manually installed

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
### end antigen plugins ###

# theme options
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
  git
  vi_mode
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

# completion options
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=25

[ -f $DOTFILES/aliases ] && source $DOTFILES/aliases
[ -f $DOTFILES/.functions ] && source $DOTFILES/.functions
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh