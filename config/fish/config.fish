# nvm-wrapper
source ~/.config/fish/nvm-wrapper/nvm.fish

# If you don't want to run the head version of rbenv, uncomment this line
# set paradox_old_rbenv true
#
# Fish colors and escape codes
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

# add binaries in ./bundle to $PATH, eliminating need for bundle exec
set PATH ./.bundle/bin $PATH

# Add rails 4 project-specific binstubs to $PATH
set PATH ./bin $PATH

# add the NPM binaries to $PATH
set PATH $PATH /usr/local/share/npm/bin

# Set my editors to Sublime Text 2
# setenv EDITOR "atom -w"
# setenv VISUAL "atom -w"
# setenv PAGER "most"

# Git prompt options
set -g __fish_git_prompt_showstashstate true
set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_showcolorhints true

# Set some individual git colors
set -g __fish_git_prompt_color_suffix yellow
set -g __fish_git_prompt_color_upstream_ahead red
set -g __fish_git_prompt_color_upstream_behind violet
set -g __fish_git_prompt_color_cleanstate green --bold

# Alias zone

# Rehash fish configs quickly
alias reload '. ~/.config/fish/config.fish'

# Git
# Hub is a useful tool that provides github integration. If you don't use it, I recommend deleting these lines
alias git hub
alias g hub
alias gst "git status"

# Ruby
alias b "bundle"
alias bx "bundle exec"
alias rk "rake"
alias rb "ruby"

# Shell/filesystem
alias .. "cd ../"
alias ... "cd ../../"
alias .... "cd ../../../"
alias dotf "cd $HOME/.dotfiles"

# Run something in the latest version of ruby
alias rbl "env RBENV_VERSION=latest "

# start/stop postgres (homebrew version)
alias pgstart "pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pgstop "pg_ctl -D /usr/local/var/postgres stop -s -m fast"

# Prompt function
function fish_prompt --description 'Write out the prompt'

  set -l last_status $status

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __paradox_prompt_normal
    set -g __paradox_prompt_normal (set_color normal)
  end

  if not set -q -g __fish_classic_git_functions_defined
    set -g __fish_classic_git_functions_defined

    function __fish_repaint_status --on-variable fish_color_status --description "Event handler; repaint when fish_color_status changes"
      if status --is-interactive
        set -e __paradox_prompt_status
        commandline -f repaint ^/dev/null
      end
    end
  end

  # Get the current Git commit hash
  function __paradox_git_hash --description "Get the current git commit hash, if we're in a git working tree"
    set -l git_info (command git rev-parse --is-inside-work-tree --short HEAD ^/dev/null)
    if test (count $git_info) -gt 1
      set -l inside_worktree $git_info[1]
      set -l git_head $git_info[2]
      if test "true" = "$inside_worktree"
        echo -s "[$git_head]"
      end
    end
  end

  function __paradox_command_duration --description "Get the current command duration"
    if set -q CMD_DURATION
      echo -s "[⌛️ $CMD_DURATION]"
    end
  end

  switch $USER

  case root

    if not set -q __paradox_prompt_cwd
      if set -q fish_color_cwd_root
        set -g __paradox_prompt_cwd (set_color $fish_color_cwd_root)
      else
        set -g __paradox_prompt_cwd (set_color $fish_color_cwd)
      end
    end
    if not set -q __paradox_prompt_delim
      set -g __paradox_prompt_delim '! '
    end

  case '*'

    if not set -q __paradox_prompt_cwd
      set -g __paradox_prompt_cwd (set_color $fish_color_cwd)
    end

    if not set -q __paradox_prompt_delim
      set -g __paradox_prompt_delim '$ '
    end

  end

  echo -s "$__paradox_prompt_cwd" (prompt_pwd) (__fish_git_prompt) (set_color 00adeb) (__paradox_git_hash) "$__paradox_prompt_normal" "$prompt_status" " $__paradox_prompt_delim"
end

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

# Right-hand prompt
function fish_right_prompt
  set -l rb_version (command ruby -e 'print RUBY_VERSION' ^/dev/null)
  echo -s (set_color blue) "(💎  $rb_version)" (set_color green) (__paradox_command_duration) (set_color normal)
end