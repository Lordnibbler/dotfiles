require 'rake'
require 'erb'
require 'ostruct'
require 'yaml'

class ErbBinding < OpenStruct
  def get_binding
    return binding()
  end
end

desc "install the dot files into user's home directory"
task :install do
  p "Installing dotfiles"
  replace_all = false
  Dir['home/{*,.*}'].each do |f|
    file = f.sub(/^home\//, '')
    next if ['.','..'].include?(file)
    if File.exist?(File.join(ENV['HOME'], "#{file}"))
      if already_linked? file
        puts "identical ~/#{file}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/#{file}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/#{file}"
        end
      end
    else
      link_file(file)
    end
  end
  compile_templates
end

desc "Clean broken symlinks"
task :clean_symlinks do
  `find -L ~ -type l -maxdepth 1 | xargs rm -rf $1`
end

desc "Update modules and install"
task :update_and_install => [:init_submodules, :update_submodules, :install] do
end

desc "Install submodules"
task :init_submodules do
  puts "Installing submodules"
  `git submodule init`
end

desc "Update submodules"
task :update_submodules do
  puts "Updating submodules"
  `git submodule update`
  `git submodule foreach git pull origin master`
end

def replace_file(file)
  system %Q{rm -rf "$HOME/#{file}"}
  link_file(file)
end

def compile_templates
  config.each_pair do |k,v|
    template = File.read("templates/#{k.to_s}.erb")
    p "Compiling #{k.to_s}"
    rendered_file = "#{ENV['HOME']}/#{v[:location]}"
    vars = ErbBinding.new(v)
    File.open("#{rendered_file}", 'w') do |new_file|
      new_file.write ERB.new(template).result(vars.send(:get_binding))
    end
  end
end

def link_file(file)
  puts "linking ~/#{file}"
  system %Q{ln -s "$PWD/home/#{file}" "$HOME/#{file}"}
end

def already_linked?(file)
  File.identical? "home/#{file}", File.join(ENV['HOME'], "#{file}")
end

def config
  if File.exist?('config.yml')
    YAML.load_file('config.yml')
  else
    raise "You need to make a config.yml file!"
  end
end

