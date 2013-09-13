export ZSH_HISTORY_PATH=$HOME/.zsh_history

# source $ZSH/oh-my-zsh.sh
unsetopt correct_all
DISABLE_CORRECTION="true"

# Autoload zsh functions.
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

for zsh_source in $HOME/.zsh/*.zsh; do
  source $zsh_source
done

if [[ -s $HOME/.local.zsh ]] ; then source $HOME/.local.zsh ; fi

. $HOME/.shell_profile


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# option + arrow to move between words
bindkey -e
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

# use postgres.app's server
PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"

# To enable shims and autocompletion add to your profile:
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# rbenv-vars from stouset, eliminates need for bundle exec
PATH=./.bundle/bin:$PATH

# tmuxinator
source ~/.bin/tmuxinator.zsh
