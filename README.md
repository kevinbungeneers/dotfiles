# dotfiles
Dotfiles are text based configuration files that usually reside in your home directory. They dictate how your system works and looks.

This repository contains my set of configuration files, which I manage with stow, a symlink farm manager.

## Installation
First, install homebrew:
```console
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Next, clone this repository:
```console
git clone --recursive https://github.com/kevinbungeneers/dotfiles.git ~/.dotfiles
```

Install applications and tools using homebrew:
```console
cd ~/.dotfiles/brew
brew bundle install
```

## Managing with stow
By default stow will create symlinks in de parent directory of where you invoke the command. So, if you have these dotfiles cloned into `~/.dotfiles`, you can simply configure your shell by running the following command from the `.dotfiles` dir:
```console
stow zsh
```

This will symlink everything from within the `~/.dotfiles/zsh` directory to `~`. Easy.

To unstow your files, run:
```console
stow -D zsh
```
This will remove all previously made symlinks.