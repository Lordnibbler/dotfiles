function lyft --description Change --argument directory to lyft src dir
  if test -z "$directory"
    set directory .
  end
  cd ~/src/$directory
end

complete -c lyft -xa "(__fish_complete_path ~/src/(commandline -ct) | sed 's/.*\/src\/\(.*\)\$/\1/')"
