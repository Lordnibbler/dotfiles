# Dotfiles

A collection of my dotfiles. Running the installer will prompt you Y/N to symlink (`ln -sin`) every file in this directory to your home directory.

I recommend placing this dotfiles directory in your home directory as well for easier editing/pushing to github.

### Installation

```sh
git clone git@github.com:Lordnibbler/dotfiles.git ~/.dotfiles
./.install.sh

# Update .gitconfig with your github username, otherwise you will be committing as me!
vi ~/.gitconfig

# ???
# Profit
```

As a followup step, I like to install [oh my zsh](https://github.com/robbyrussell/oh-my-zsh#basic-installation), as my `.zshrc` already has this configured.

![giphy copy 4](https://cloud.githubusercontent.com/assets/199422/6795973/dea0cf34-d1a6-11e4-90d8-0160d348059c.gif)

### Forking

This repo is designed to be forked and updated with your personal preferences. If you do this, whenever you change your dotfiles simply make a new git commit and push to github!  Woot.
