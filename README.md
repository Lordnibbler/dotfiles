# Dotfiles

A collection of my dotfiles. Running the installer will prompt you Y/N to overwrite symlinks (`ln -sin`) for every file in this directory to your home directory.

I recommend placing this dotfiles directory in your home directory as well for easier editing/pushing to github (see installation section below:)

### Installation

```sh
git clone git@github.com:Lordnibbler/dotfiles.git ~/.dotfiles
./.install.sh

# IMPORTANT: Update .gitconfig with your github username, otherwise you will be committing as me!
vi ~/.gitconfig
```

### Fish Shell

If you plan to use [fish shell](http://fishshell.com/), there are a lot of nice configurations already in `/config/fish`.

Follow these instructions to get Fish set as the default shell:

1. Install Fish
  ```sh
  brew update; brew install fish
  ```

2. Open a completely new terminal session, just to be safe.

3. `chsh` to fish (changes default shell on OS X/Linux)
  ```sh
  echo $(which fish) | sudo tee -a /etc/shells
  chsh -s $(which fish)
  ```

4. If you use iTerm2, you can change your color scheme. [Simply download a scheme](https://github.com/mbadolato/iTerm2-Color-Schemes/tree/master/schemes). Then, go to Preferences > Profiles > Colors Tab > Load Presets, and choose a `.itermcolors` file.

5. You can install [oh my fish](https://github.com/bpinto/oh-my-fish) if you don't like my customizations.

#### Fish Caveats

Fish and nvm (node version manager) don't play nice as of now.  To work around this:

1. Install NVM
  ```sh
  brew install nvm
  ```

2. [Install NVM wrapper](https://github.com/passcod/nvm-fish-wrapper) (optional if you want to use Node Version Manager)

### ZSH

If you plan to use ZSH, I install [oh my zsh](https://github.com/robbyrussell/oh-my-zsh#basic-installation), as my `.zshrc` already has this configured.

### Forking

This repo is designed to be forked and updated with your personal preferences. If you do this, whenever you change your dotfiles simply make a new git commit and push to github!  Woot. If you improve this repo and want to see your changes implemented here, please submit a Pull Request!

![giphy copy 4](https://cloud.githubusercontent.com/assets/199422/6795973/dea0cf34-d1a6-11e4-90d8-0160d348059c.gif)
