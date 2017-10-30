# Prompt function
function fish_prompt --description 'Write out the prompt'
  set -l last_status $status
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

  echo -s "$__paradox_prompt_cwd" (prompt_pwd) (__fish_git_prompt) (set_color 00adeb) (paradox_git_hash) "$__paradox_prompt_normal" "$prompt_status"
  echo "$__paradox_prompt_delim"
end
