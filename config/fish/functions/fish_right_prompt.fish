# Right-hand prompt
function fish_right_prompt
  set -l rb_version (command ruby -e 'print RUBY_VERSION' ^/dev/null)
  set -l node_version (command node --version ^/dev/null)
  echo -s (set_color blue) "(💎  $rb_version  ☕️  $node_version)" (set_color green) (paradox_command_duration) (set_color normal)
end
