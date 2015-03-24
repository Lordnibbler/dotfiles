require "rubygems"
# Load all modules in the ~/.irbrc.d directory
Dir.open(File.join(ENV['HOME'], '.irbrc.d')) do |dir|
  dir.grep(/[.]rb$/).each { |entry| load File.join(dir.path, entry) }
end

IRB.conf[:PROMPT_MODE] = :SIMPLE
