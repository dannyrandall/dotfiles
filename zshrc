export DOTFILES=$HOME/dotfiles

export TERM="xterm-256color"
export EDITOR="nvim"

# os specific things configurations
if [[ $OSTYPE == darwin* ]]; then ## mac specific things
    # path
    export PATH=/usr/local/bin:/usr/local/sbin:$PATH
else ## linux specific things
    export GOPATH=$HOME/programming/go

	# node verison manager
	[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh
fi

# antigen
source $HOME/.antigen.zsh

antigen use oh-my-zsh

antigen bundle wd
antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

antigen theme denysdovhan/spaceship-prompt

antigen apply

# theme options
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  package       # Package version
  venv          # virtualenv section
  exec_time     # Execution time
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_RPROMPT_ORDER=(
  aws           # Amazon Web Services section
  vi_mode       # Vi-mode indicator
  git           # Git section (git_branch + git_status)
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

# path
export PATH=$PATH:$HOME/bin # manually installed bins
export PATH=~/.local/bin:$PATH # pip
export PATH=$HOME/.gem/ruby/2.6.0/bin:$PATH # ruby gems

# aliases
[ -f $DOTFILES/aliases ] && source $DOTFILES/aliases

# functions
[ -f $DOTFILES/.functions ] && source $DOTFILES/.functions

# cargo (rust)
export PATH="$HOME/.cargo/bin:$PATH"

# Added by Krypton
export GPG_TTY=$(tty)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh