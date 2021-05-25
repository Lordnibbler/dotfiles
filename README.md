# Dotfiles

A collection of my dotfiles. Running the installer will prompt you Y/N to overwrite symlinks (`ln -sin`) for every file in this directory to your home directory.

I recommend placing this dotfiles directory in your home directory as well for easier editing/pushing to github (see installation section below:)

### Installation

```sh
# to clone without submodules, remove `--recursive` flag
git clone --recursive git@github.com:Lordnibbler/dotfiles.git ~/.dotfiles

# install the dotfiles symlinks
cd ~/.dotfiles && .install.sh

# IMPORTANT: Update .gitconfig with your github username, otherwise you will be committing as me!
vi ~/.gitconfig
```

```sh
# install homebrew files from brewfile
cd ~/.dotfiles && brew bundle
```

Install spaceship prompt:

```sh
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

Install zsh-autosuggestions

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

If you use iTerm2, you can change your color scheme. [Simply download a scheme](https://github.com/mbadolato/iTerm2-Color-Schemes/tree/master/schemes). Then, go to Preferences > Profiles > Colors Tab > Load Presets, and choose a `.itermcolors` file.

### Forking

This repo is designed to be forked and updated with your personal preferences. If you do this, whenever you change your dotfiles simply make a new git commit and push to github!  Woot. If you improve this repo and want to see your changes implemented here, please submit a Pull Request!

![giphy copy 4](https://cloud.githubusercontent.com/assets/199422/6795973/dea0cf34-d1a6-11e4-90d8-0160d348059c.gif)
