# base path

export TERM="xterm-256color"

if [[ $UID == 0 ]]; then
    BASE=/home/dannyrandall
else
    BASE=$HOME
fi

# dotfiles directory
export DOTFILES=$BASE/dotfiles

# os specific things configurations
if [[ $OSTYPE == darwin* ]]; then
    ## mac specific things
	export GOPATH=$BASE/programming/go

    # path
    export PATH=/usr/local/bin:/usr/local/sbin:$PATH
else
    ## linux specific things
    export LPASS_DISABLE_PINENTRY=1

    if [[ $(uname -r) = *"ARCH"* ]]; then
        export GOPATH=$BASE/programming/go
    else
        export GOPATH=$BASE/Documents/programming/go
    fi
fi

# antigen
source $DOTFILES/zsh/antigen/antigen.zsh

# antigen oh-my-zsh plugins
antigen use oh-my-zsh
antigen bundle wd
antigen bundle git

# other antigen bundles
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

# theme
antigen theme denysdovhan/spaceship-prompt

antigen apply

# theme options
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  # hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  # node          # Node.js section
  # ruby          # Ruby section
  # elixir        # Elixir section
  # xcode         # Xcode section
  # swift         # Swift section
  # golang        # Go section
  # php           # PHP section
  # rust          # Rust section
  # haskell       # Haskell Stack section
  # julia         # Julia section
  # docker        # Docker section
  # aws           # Amazon Web Services section
  venv          # virtualenv section
  # conda         # conda virtualenv section
  # pyenv         # Pyenv section
  # dotnet        # .NET section
  # ember         # Ember.js section
  # kubecontext   # Kubectl context section
  # terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_RPROMPT_ORDER=(
  git           # Git section (git_branch + git_status)
  vi_mode       # Vi-mode indicator
  battery       # Battery level and status
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

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# completions
fpath=($ZSH/plugins/wd $fpath)
fpath=($DOTFILES/zsh/completions $fpath)
autoload -Uz compinit && compinit -i

# edits for plugins
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=25

# export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'

# go
export PATH=$GOPATH/bin:$PATH

# pip
export PATH=~/.local/bin:$PATH

# ruby gems
export PATH=~/.gem/ruby/2.4.0/bin:$PATH

# gradle
export PATH=$PATH:/opt/gradle/gradle-4.10.1/bin

# aliases
[ -f $BASE/.aliases ] && source $BASE/.aliases

# functions
[ -f $BASE/.functions ] && source $BASE/.functions

# load work env. vars
[ -f $BASE/.envrc ] && source $BASE/.envrc

# cargo (rust)
export PATH="$BASE/.cargo/bin:$PATH"

# fixing commands
eval $(thefuck --alias)

# Added by Krypton
export GPG_TTY=$(tty)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
