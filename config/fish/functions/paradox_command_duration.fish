function paradox_command_duration --description "Get the current command duration"
  if begin; set -q CMD_DURATION; and test $CMD_DURATION -ge 500; end
    # I do it in this somewhat roundabout way to preserve some floating point math
    set -l x (math "scale=2;$CMD_DURATION / 1000")
    set -l seconds (math "$x % 60")
    set -l timestamp (printf "%.02gs" $seconds)
    if test $x -ge 60
      set -l x (math "$x / 60")
      set -l minutes (math "$x % 60")
      set -l timestamp (printf "%dm" $minutes) timestamp
      if test $x -ge 60
        set -l x (math "$x / 60")
        set -l hours (math "$x % 24")
        set -l timestamp (printf "%dh" $hours) timestamp

        if test $x -ge 24
          set -l days (math "$x / 24")
          set -l timestamp (printf "%dd" $days) timestamp

        end
      end
    end
    echo -s "[⌛️ $timestamp]"
  end
end
