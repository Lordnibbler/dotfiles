export ZSH_HISTORY_PATH=$HOME/.zsh_history
unsetopt correct

# Autoload zsh functions.
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

for zsh_source in $HOME/.zsh/*.zsh; do
  source $zsh_source
done

if [[ -s $HOME/.local.zsh ]] ; then source $HOME/.local.zsh ; fi

. $HOME/.shell_profile
