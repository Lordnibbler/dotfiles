# Allow for functions in the prompt.
setopt PROMPT_SUBST

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'

# Set the prompt.
if [ -n $__RVM_AVAILABLE ]; then
  RPROMPT=$'%{${fg[yellow]}%}($(rbenv version-name))%{${fg[default]}%}'
fi

if [ -s ~/.zsh/plugins/vi_prompt.zsh ]; then
  source ~/.zsh/plugins/vi_prompt.zsh
fi
