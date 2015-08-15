# Dotfiles

A collection of my dotfiles. Running the installer will prompt you Y/N to overwrite symlinks (`ln -sin`) for every file in this directory to your home directory.

I recommend placing this dotfiles directory in your home directory as well for easier editing/pushing to github (see installation section below:)

### Installation

```sh
# to clone without submodules, remove `--recursive` flag
git clone --recursive git@github.com:Lordnibbler/dotfiles.git ~/.dotfiles

# install the dotfiles symlinks
~/.dotfiles/.install.sh

# IMPORTANT: Update .gitconfig with your github username, otherwise you will be committing as me!
vi ~/.gitconfig
```

### Fish Shell

If you plan to use [fish shell](http://fishshell.com/), there are a lot of nice configurations already in `/config/fish`.

Follow these instructions to get Fish set as the default shell:

1. Install Fish (and optionally, nvm)
  ```sh
  brew update; brew install fish nvm
  ```

2. Open a completely new terminal session, just to be safe.

3. Test fish by typing `fish`

4. If you see the following error, you need to upgrade to the `HEAD` version of rbenv for native fish support (this is not available in 0.4.0)

  ```sh
  # if you see this error:
  # 'case' builtin not inside of switch block (line 10): case "$command"

  # upgrade to HEAD rbenv
  brew upgrade --HEAD rbenv

  # then reload fish
  reload
  ```

5. `chsh` to fish (changes default shell on OS X/Linux)
  ```sh
  echo $(which fish) | sudo tee -a /etc/shells
  chsh -s $(which fish)
  ```

6. If you use iTerm2, you can change your color scheme. [Simply download a scheme](https://github.com/mbadolato/iTerm2-Color-Schemes/tree/master/schemes). Then, go to Preferences > Profiles > Colors Tab > Load Presets, and choose a `.itermcolors` file.

6. You can install [oh my fish](https://github.com/bpinto/oh-my-fish) if you don't like my customizations.

#### Fish Caveats

Fish and nvm (node version manager) don't play nice as of now.  To work around this:

1. Install NVM
  ```sh
  brew install nvm
  ```

2. [Install NVM wrapper](https://github.com/passcod/nvm-fish-wrapper) (optional if you want to use Node Version Manager)

3. As of August 15, 2015, you need to [follow the instructions here](https://github.com/passcod/nvm-fish-wrapper/issues/13) in order to get fish and nvm to play nicely with my `fish.config`

### ZSH

1. Install ZSH

  ```sh
  brew update; brew install zsh
  ```

2. Install [oh my zsh](https://github.com/robbyrussell/oh-my-zsh#basic-installation)
If you plan to use ZSH, I install oh my zsh as my `.zshrc` already has this configured.

### Forking

This repo is designed to be forked and updated with your personal preferences. If you do this, whenever you change your dotfiles simply make a new git commit and push to github!  Woot. If you improve this repo and want to see your changes implemented here, please submit a Pull Request!

![giphy copy 4](https://cloud.githubusercontent.com/assets/199422/6795973/dea0cf34-d1a6-11e4-90d8-0160d348059c.gif)
