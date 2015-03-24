# Dotfiles

### Installation

Please note the rake task will require Ruby, Rubygems, and Homebrew (assuming you're on OS X).

0. Clone the repo
1. [Install brew](http://brew.sh/)
2. Then Run
  ```sh
  brew update
  brew install ruby
  sudo gem update --system
  ```

3. Copy `config_example.yml` to `config.yml` and update values
4. run the rake task from inside the repo
  ```sh
  rake install
  ```
  
