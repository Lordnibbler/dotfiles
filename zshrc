# If you come from bash you might have to change your $PATH.

# homebrew path
eval "$(/opt/homebrew/bin/brew shellenv)"

# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=./.bundle/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set fzf installation directory path
export FZF_BASE=/usr/local/bin/fzf

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
ZSH_THEME="spaceship" 

# spaceship-prompt customizations
SPACESHIP_CHAR_SYMBOL=$ 
SPACESHIP_CHAR_SUFFIX=\ 

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  fzf
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias reload="source ~/.zshrc"
alias dotf="cd ~/.dotfiles"
alias g="git"

alias b="bundle"
alias bx="bundle exec"

# make hub and git commands one and the same
eval "$(hub alias -s)"

# rbenv setup
eval "$(rbenv init -)"

# for rails binstubs
export PATH=./bin:$PATH

# pyenv setup
# Add pyenv executable to PATH and
# enable shims by adding the following
# to ~/.profile and ~/.zprofile:

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Load pyenv into the shell by adding
# the following to ~/.zshrc:

eval "$(pyenv init -)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# poppy auto completions
# https://github.robot.car/cruise/poppy#3-post-installation-optional-setup
autoload -U compinit && compinit
if [ -x "$(which poppy)" ]; then source <(poppy completion zsh); fi
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ben.radler/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ben.radler/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ben.radler/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ben.radler/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# FNM setup
eval "$(fnm env --use-on-cd)"

# gcloud homebrew setup
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

# k9s aliases
alias auth="authcli"
alias kdev="kubectx gke_cruise-paas-product-dev-2545_us-west1_paas-product-dev-us-west1"
alias kstaging="kubectx gke_cruise-paas-product-stg-4368_us-west1_paas-product-staging-us-west1"
alias kprod="kubectx gke_cruise-paas-product-prod-6e2b_us-west1_paas-product-prod-us-west1"
alias kprodrnd="kubectx gke_paas-product-rnd-prod_us-west1_paas-product-rnd-prod-us-west1"
alias k9dev="kdev && k9s -n dispatch"
alias k9staging="kstaging && k9s -n dispatch"
alias k9prod="kprod && k9s -n dispatch"
alias k9prodrnd="kprodrnd && k9s -n dispatch"
