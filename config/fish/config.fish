# fundle packages
fundle plugin 'edc/bass'
fundle plugin 'tuvistavie/fish-fastdir'

fundle init

# use bass to source the bash nvm script
bass source ~/.nvm/nvm.sh

# If you don't want to run the head version of rbenv, uncomment this line
# set paradox_old_rbenv true

# Fish colors and escape codes
##############################
set fish_color_autosuggestion 808080
set fish_color_command green\x1e--bold
set fish_color_cwd yellow
set fish_color_cwd_root yellow\x1e--bold
set fish_color_normal white
set fish_color_param blue\x1e--bold
set fish_color_quote cyan\x1e--bold
set fish_color_search_match magenta
set fish_color_valid_path magenta\x1e--underline

# Greeting on new terminal
# set fish_greeting (date)

# Prepend sudo when Alt+S is keyed
function prepend_sudo
  set current_command (commandline)
  commandline "sudo $current_command"
end

# Prepend bx (bundle exec) when Alt+X is keyed
function prepend_bundle_exec
  set current_command (commandline)
  commandline "bx $current_command"
end

# Prepend g (git) when Alt+G is keyed
function prepend_git
  set current_command (commandline)
  commandline "g $current_command"
end

# Prepend rbl (rbenv latest ) when Alt+R is keyed
function prepend_rbl
  set current_command (commandline)
  commandline "rbl $current_command"
end

# Actually bind the keys mentioned above
function fish_user_key_bindings
  bind \es prepend_sudo
  bind \ex prepend_bundle_exec
  bind \eg prepend_git
  bind \er prepend_rbl
end

# Paths
#######

# While you can use a single fish array to do this (space-separated list), this is easier to read
set PATH /usr/local/bin /usr/local/sbin $PATH
if set -q paradox_old_rbenv
  set PATH $HOME/.rbenv/shims $PATH
end
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.bin $PATH

if not set -q paradox_old_rbenv
  # Use rbenv's native fish support
  # NOTE: This is only in HEAD of rbenv as of this date (2014/09/02)
  . (rbenv init -|psub)
end

set fish_complete_path ~/.config/fish/completions/ /usr/local/share/fish/completions/ /usr/local/share/fish/vendor_completions.d/ $fish_complete_path

# add binaries in ./bundle to $PATH, eliminating need for bundle exec
set PATH ./.bundle/bin $PATH

# Add rails 4 project-specific binstubs to $PATH
set PATH ./bin $PATH

# add the NPM binaries to $PATH
set PATH $PATH /usr/local/share/npm/bin

# add $GOPATH to $PATH (necessary if you will use golang)
set -x GOPATH "$HOME/Code/go"
set PATH $PATH "$GOPATH/bin"

# Set my editors to Atom
setenv EDITOR "atom -w"
setenv VISUAL "atom -w"
# setenv PAGER "most"

# Git Prompt
############

# Git prompt options
set -g __fish_git_prompt_showstashstate true
set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_showcolorhints true

# Set some individual git colors
set -g __fish_git_prompt_color_suffix yellow
set -g __fish_git_prompt_color_upstream_ahead red
set -g __fish_git_prompt_color_upstream_behind violet
set -g __fish_git_prompt_color_cleanstate green --bold

# Aliases
#########

# Rehash fish configs quickly - doesn't truly reload, launches a new shell, but results the same
alias reload 'exec fish -l'

# Git
# Hub is a useful tool that provides github integration.
alias git hub
alias g hub

# Ruby
alias b "bundle"
alias bx "bundle exec"
alias rk "rake"
alias rb "ruby"

# Shell/filesystem
alias dotf "cd $HOME/.dotfiles"

# Run something in the latest version of ruby
alias rbl "env RBENV_VERSION=latest "

# start/stop postgres (homebrew version)
alias pgstart "pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pgstop "pg_ctl -D /usr/local/var/postgres stop -s -m fast"

# initialize our new variables
# in theory this would be in a fish_prompt event, but this file isn't sourced
# until the fish_prompt function is called anyway.
if not set -q __prompt_initialized_2
  set -U fish_color_user blue
  set -U fish_color_host green
  set -U fish_color_status red
  set -U fish_color_splitter red
  set -U __prompt_initialized_2
end
