# dotfiles
This repository contains the configuration for `$HOME`, as well as some other things to fine-tune my macOS experience.
Most of it is managed with [nix](https://nixos.org/) and [home-manager](https://github.com/nix-community/home-manager).

## Prerequisites
### Development Tools
Make sure you have your development tools installed. Running `xcode-select --install` in your terminal should work just fine, or you could install Xcode in full.

### Nix (the package manager)
There are several ways to install Nix. You can use the [official installer](https://nixos.org/download#nix-install-macos) or use the one from [determinate systems](https://github.com/DeterminateSystems/nix-installer).

Either one is fine. The one from Determinate Systems has some quality-of-life improvements, such as:
- survives macOS updates (see https://github.com/NixOS/nix/issues/3616)
- doesn't configure channels and enables flake support by default
- offers a built-in way to uninstall Nix

If you went with the official installer, make sure that the `experimental-features` is set to `flakes nix-command repl-flake`. You can check by running:
```console
nix show-config
```

If `experimental-features` is not set or does not contain `flakes` and `nix-command`, set them by configuring Nix:
```console
mkdir -p ~/.config/nix
cat <<EOF >> ~/.config/nix/nix.conf
experimental-features = flakes nix-command
EOF
```

Finally, restart the Nix daemon:
```console
sudo launchctl stop org.nixos.nix-daemon
sudo launchctl start org.nixos.nix-daemon
```

## Installation
Now that we have both our development tools and the nix package manager installed, it's time to clone this repository:
```console
git clone git@github.com:kevinbungeneers/dotfiles.git ~/.dotfiles
```

Enter the dotfiles directory and run:
```console
nix run home-manager -- switch --flake .
```

### Configure the Dock
Going through System Settings and dragging icons in and out of the dock is a bit too tedious for my taste. That's why I created a little script that configures the dock just the way I like:
```console
cd ~/.dotfiles/dock
./configure.zsh
```

### Configure Terminal.app
My terminal emulator of choice is the one that's included with the OS. I've added a custom terminal configuration, based on [this one](https://github.com/nordtheme/terminal-app).

## Management
### Making changes
Much like a home, dotfiles are never finished. Occasionally you'll want to switch things up and add, replace or remove tooling and/or configuration options.
Any changes you've made will need to be activated. From within your dotfiles directory:
```console
nix run home-manager -- switch --flake .
```

**Note:** If your home configuration is named like `<user>`, home-manager will automatically pick the right configuration to apply. Otherwise, you'll need to specify your configuration explicitly, like so: `home-manager switch --flake ".#<name-of-your-configuration>`

### Rolling back changes
With each switch you execute, home-manager will create a new "generation". If you were to break something, you could easily perform a rollback to a previous generation.

List all generations:
```console
nix run home-manager -- generations
```

Activating a specific generation:
```console
/nix/store/jyjpp3glrv202sck83y04ji0cl538rjn-home-manager-generation/activate
```

### Removing old generations
As time goes by and the number of generations grows, your nix store will inevitably grow too. Running `nix store gc` won't be as effective, as those binaries are still linked to a home-manager generation.

This is why it's a good idea to remove some older generations from time to time. You can either remove specific generations by doing:
```console
nix run home-manager -- remove-generations 1 2
```

Or, remove generations that are older than, for instance, 30 days:
```console
nix run home-manager -- expire-generations "-30 days"
```