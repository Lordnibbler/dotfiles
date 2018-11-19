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

# Disable greeting on new terminal
set fish_greeting ''

# Prepend sudo when Alt+S is keyed
function prepend_sudo
  set current_command (commandline)
  commandline "sudo $current_command"
end

# Prepend service_venv when Ctrl+S is keyed
function prepend_service_venv
  set current_command (commandline)
  commandline "service_venv $current_command"
end

# Prepend pytest when Ctrl+T is keyed
function prepend_pytest
  set current_command (commandline)
  commandline "service_venv pytest -s $current_command"
end

function wrap_control_enter
  set current_command (commandline)
  commandline "control enter $current_command.legacy"
end

# Actually bind the keys mentioned above
function fish_user_key_bindings
  bind \cs prepend_service_venv
  bind \ct prepend_pytest
  bind \es prepend_sudo
  bind \ce wrap_control_enter
end

# Paths
#######
# Use rbenv's native fish support
# NOTE: This is only in 1.0.0+ version of rbenv
. (rbenv init -|psub)

# While you can use a single fish array to do this (space-separated list), this is easier to read
set PATH /usr/local/bin /usr/local/sbin $PATH
set PATH $HOME/.bin $PATH

set fish_complete_path ~/.config/fish/completions/ /usr/local/share/fish/completions/ /usr/local/share/fish/vendor_completions.d/ $fish_complete_path

# use a custom directory for fisherman install
set fish_path ~/.dotfiles/config/fish/fisherman

# add fisherman dir to fish_function_path
set fish_function_path ~/.config/fish/fisherman/functions $fish_function_path

# add binaries in ./bundle to $PATH, eliminating need for bundle exec
set PATH ./.bundle/bin $PATH

# Add rails 4 project-specific binstubs to $PATH
set PATH ./bin $PATH

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

# E2E test env vars
###################
set -gx RENTALS_URL http://rentals-legacy-benradler-onebox.dev.lyft.net
set -gx ATS_URL http://ats-legacy-benradler-onebox.dev.lyft.net
set -gx LYFT_COM_URL http://www-benradler-onebox.dev.lyft.net
set -gx TOM_URL http://tom-benradler-onebox.dev.lyft.net
set -gx E2E_BASE_URL http://www-benradler-onebox.dev.lyft.net
set -gx HOST_SERVICE_NAME onebox
set -gx ONEBOX_NAME benradler
set -gx SERVICE_NAME expressdriveint
set -gx SERVICE_REPO_NAME expressdriveint
set -gx USE_MAC true

# nvm
#####
# set -gx NVM_DIR "~/.nvm"
set -g fish_user_paths "/usr/local/opt/node@8/bin" $fish_user_paths

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

# todo.sh
alias t "todo.sh"

# rentals docker
alias ml "control enter rentals.legacy make lint"
alias mtu "control enter rentals.legacy make test_unit"
alias mt "control enter rentals.legacy make typecheck"
alias mf "control enter rentals.legacy make format"
alias mi "control enter rentals.legacy make inspect"
alias pt "control enter rentals.legacy service_venv pytest -s"

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

# autojump for faster filesystem navigation
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# hack; load ~/.nvmrc version of node
# remove/fix when https://github.com/fisherman/nvm/issues/11 is resolved
# nvm use

# go
set -x GOPATH $HOME/go
set -x PATH $PATH /usr/local/go/bin $GOPATH/bin

# virtualfish
eval (python3 -m virtualfish)

status --is-interactive; and source (rbenv init -|psub)
