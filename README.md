# dotfiles
This repository contains the configuration for `$HOME` as well as some other things to fine-tune my macOS experience.
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
> **Warning:** This repository contains _my_ configuration and is specifically tuned to _my_ workflow. Read the source before blindly following along!

Now that we have both our development tools and the nix package manager installed, it's time to clone this repository:
```console
git clone git@github.com:kevinbungeneers/dotfiles.git ~/.dotfiles
```

### Setup Home manager
Install home-manager and activate the configuration:
```console
cd ~/.dotfiles/home-manager
nix run home-manager -- switch --flake .
```

> **Tip:** To save yourself a few keystrokes you could symlink the home-manager directory to `~/.config/home-manager`.
This way you won't need to pass the `dir` option when invoking the switch command:
>```shell
> ln -s ~/.dotfiles/home-manager ~/.config/home-manager
> home-manager switch
> ```

### Configure the Dock
Going through System Settings and dragging icons in and out of the dock is a bit too tedious for my taste. That's why I created a little script that configures the dock just the way I like:
```console
cd ~/.dotfiles/dock
./configure.zsh
```

## Managing your home manager configuration
### Updating inputs
Both the `home-manager` and `nixpkgs` inputs are pinned to a specific version in the `flake.lock` file.
Updating these are just a simple command away:
```shell
nix flake update
```

Alternatively you could also update a single input:
```shell
nix flake update nixpkgs
```

### Making changes
Much like a home, dotfiles are never finished. Occasionally you'll want to switch things up and add, replace or remove tooling and/or configuration options.
Any changes you've made will need to be activated. From within your home-manager directory:
```console
home-manager -- switch --flake .
```

Activating a new generation does not update programs or tools.

**Note:** If your home configuration is named like `<user>`, home-manager will automatically pick the right configuration to apply. Otherwise, you'll need to specify your configuration explicitly, like so: `home-manager switch --flake ".#<name-of-your-configuration>`

### Rolling back changes
With each switch you execute, home-manager will create a new "generation". If you were to break something, you could easily perform a rollback to a previous generation.

List all generations:
```console
home-manager generations
```

Activating a specific generation:
```console
/nix/store/jyjpp3glrv202sck83y04ji0cl538rjn-home-manager-generation/activate
```

### Removing old generations
As time goes by and the number of generations grows, your nix store will inevitably grow too. Running `nix store gc` won't be as effective, as those binaries are still linked to a home-manager generation.

This is why it's a good idea to remove some older generations from time to time. You can either remove specific generations by doing:
```console
home-manager remove-generations 1 2
```

Or, remove generations that are older than 30 days:
```console
home-manager expire-generations "-30 days"
```
