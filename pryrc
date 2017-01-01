=begin

Author: Capt. Downer
Email: captdowner (@) gma1l d0t c0m
Repo: https:github.com/CaptDowner/.pryrc


Pry custom commands defined in my .pryrc:
  cat(f)           Display text file contents.
  chk	           List current startup info for services.
  dt	           Show the system date and time.
  fl(fn)           Load and execute a Ruby source file.
  gl2(str)         List gems matching search parameter.
  glist	           List all installed gems.
  lc	           Display only filenames in multiple column format.
  lf	           List only filenames, one per line, in alpha order.
  loc	           Display which computer is in use.
  lpci	           List all pci devices.
  lsa	           List all files in filename order.
  lsd	           List only directories.
  lss	           List all files by size from smallest to largest.
  lusb	           List all usb devices.
  path	           Display current PATH.
  pm	           Show methods defined in .pryrc.
  pss	           Display process list.
  pwd	           Print (current) working directory.
  rl 	           Reload and excute the most recently loaded ruby source file.
  rqa(f)           Search for installed RPM.
  sip	           Show location, current ip(s) and network addresses.
  time(&b)         Display execution timing.

=end

require 'pry'

# Set Pry theme
Pry.config.theme = "tomorrow-night"
# Other (IMHO) good looking pry-themes:
# "vividchalk", "railscasts", "github", "solarized"
# "pry-zealand-16", "tomorrow", "pry-modern", "monokai"

# Configure Pry's prompt, showiung current Ruby and Rails versions
# Rails version is shown after you require 'rails'
Pry.config.prompt = proc do |obj, level, _|
  prompt = ""
  prompt << "#{Rails.version}@" if defined?(Rails)
  prompt << "#{RUBY_VERSION}"
  "#{prompt} (#{obj})> "
end

# Reformat Exception
Pry.config.exception_handler = proc do |output, exception, _|
  output.puts "\e[31m#{exception.class}: #{exception.message}"
  output.puts "from #{exception.backtrace.first}\e[0m"
end

# Using Rails, I include some utilities
if defined?(Rails)
  begin
    require "rails/console/app"
    require "rails/console/helpers"
  rescue LoadError => e
    require "console_app"
    require "console_with_helpers"
  end
end

# Shortcuts for debugging commands
if defined?(PryByebug)
  Pry.commands.alias_command 'c',  'continue'
  Pry.commands.alias_command 's',  'step'
  Pry.commands.alias_command 'n',  'next'
  Pry.commands.alias_command 'f',  'finish'
  Pry.commands.alias_command 'ss', 'show-source'
end

# ===================
# Custom Pry aliases
# ===================
# Where am I?
Pry.config.commands.alias_command 'w', 'whereami'
# Clear Screen
Pry.config.commands.alias_command '.cls', '.clear'

# Return only the methods not present on basic objects
class Object
  def ims
    (self.methods - Object.instance_methods).sort
  end
end

# Load and execute a Ruby source file
def fl(fn)
  fn += '.rb' unless fn =~ /\.rb/
  @@recent = fn
  load "#{fn}"
end

# Reload and excute the most recently loaded ruby source file
def rl
  fl(@@recent)
end

# Display only filenames in multiple column format
def lc
  op = %x{ ls -aC }
  op.gsub!('\t','\n')
  puts op
end

# List all files in filename order
def lsa
  puts %x{ls -la}.split("\n")
end

# List all files by size from smallest to largest
def lss
  puts %x{ls -la -S -r}.split("\n")
end

# List only directories
def ld
  puts %x{ls -la | egrep "^d"}
end

# List all files by date
def lsd
  puts %x{ls -la --sort=t -r -p}
end

# List only filenames, one per line, in alpha order
def lf
  puts %x(ls -aF)
end

# Print (current) working directory
def pwd
  %x{pwd}.rstrip
end

# Pist all installed gems
def glist
  puts %x{ gem list }
end

# List gems matching search parameter
def gl2(str)
  puts %x{ gem list | sort | grep #{str} }
end

# Display execution timing
def time(&b)
  require 'benchmark'
  res = nil
  timing = Benchmark.measure do
     res = yield
  end
  puts "Using yield, it took:     user       system     total       real"
  puts "                      #{timing}"
  res
end

# Display which computer is in use
def loc
  pc=%x{ cat /var/www/html/location.txt }
  print pc
end

# Display current PATH
def path
  %x{ echo $PATH }
end

# Display process list
def pss
  op = %x{ ps --context ax }
  puts op
end

# Find installed RPM, where f = string|regexp
def rqa(f)
  # if f is a string, convert it to a regexp
  if(f.class == String)
    f = Regexp.new f
  end
  # output list of .rpm files matching the regexp
  ((%x{rpm -qa | sort}).split("\n").each.grep f).each {|m| puts m }
end

# Show the system date and time
def dt
  puts %x{date}
end

# List current startup info for services
def chk
  puts %x{/sbin/chkconfig --list}
end

# List all pci devices
def lpci
  puts %x{ lspci }
end

# List all usb devices
def lusb
  puts %x{ lsusb }
end

# Show location, current ip(s) and network addresses
def sip
  # you must have a text file named "location.txt"
  # which should identify your machine in a unique way
  # I include a computer name, ip address, and email in mine

  if(Dir.entries('/var/www/html/').detect {|f| f.match /^location.txt/})
    f = File.open("/var/www/html/location.txt","r")
      f.each_byte do |i|
        print i.chr
      end
    f.close
  end
  print %x(ifconfig)
end

# Show methods defined in .pryrc
# This depends heavily on the format of
# method definitions. A single comment
# line, followed by the method 'def <method>'
# line will include any new methods in this
# method summary.
def pm
  res=[]
  save_comment=String.new
  data = %x{ cat ~/.pryrc }
  str_arr = data.split("\n")

  puts "Pry custom commands defined in .pryrc:"
  counter=0

  while(str_arr[counter] != nil)
    # Ruby 1.9 returns an ordinal rather than a character, so...
    if(str_arr[counter][0] == "#"  || str_arr[counter][0] == 35) then
      save_comment = str_arr[counter]
    elsif(str_arr[counter].index("def") == 0) then
      m = str_arr[counter].gsub("def ","")
      m.chomp

      # output so columns are aligned
      if(m.length < 8) then
        res << (m + "\t   " + save_comment + "\n")
      else
        res << (m + "   " + save_comment + "\n")
      end

      m = ""
      save_comment = ""
    end
    counter += 1
  end
  res.sort!
  0.upto(counter) do |x|
    print res[x]
  end

end

# Display text file contents
def cat(f)
  puts %x{cat #{f}}
end

# When opening pry, show summary of methods defined
pm
