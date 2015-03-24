# If mode indicator wasn't setup by theme, define a default.
if [[ "$MODE_INDICATOR" == "" ]]; then
  MODE_INDICATOR="%{$fg_bold[red]%}<%{$reset_color%}%{$fg[red]%}<<%{$reset_color%}"
fi

function zle-line-init {
  zle reset-prompt
}

# If I am using vi keys, I want to know what mode I'm currently using.
# zle-keymap-select is executed every time KEYMAP changes.
# From http://zshwiki.org/home/examples/zlewidgets
rprompt_cached=$RPROMPT
function zle-line-init zle-keymap-select {
  RPROMPT="${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/$rprompt_cached}"
  zle reset-prompt
}

# Accept RETURN in vi command mode.
function accept_line {
  RPROMPT=$rprompt_cached
  builtin zle .accept-line
}

zle -N zle-line-init
zle -N zle-keymap-select
zle -N accept_line
zle -N edit-command-line

