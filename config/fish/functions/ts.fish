function ts --description Change --argument directory to teespring dir
  if test -z "$directory"
    set directory .
  end
  cd ~/Code/teespring/$directory
end

complete -c ts -xa "(__fish_complete_path ~/Code/teespring/(commandline -ct) | sed 's/.*\/Code\/teespring\/\(.*\)\$/\1/')"
