# dotfiles
This repository contains the configuration for `$HOME` as well as some other things to fine-tune my macOS experience.
Most of it is managed with [nix](https://nixos.org/), [nix-darwin](https://github.com/nix-darwin/nix-darwin?tab=readme-ov-file#readme) and [home-manager](https://github.com/nix-community/home-manager).

## Structure
My dotfiles are organized around **capabilities** and **composition**:
- `modules/` is a library of reusable "capability modules" (e.g., shell, editor, local-ingress). These modules can be composed by both system-level configurations (`nix-darwin`) and user-level configurations (`home-manager`), depending on what the capability configures.
- `hosts/<hostname>/default.nix` defines a machine's system configuration and selects the capabilities it needs, such as enabling local-ingress to provide local DNS resolution and reverse-proxying. A capability that supports system-level configuration has a `darwin.nix` file.
- `users/<username>/default.nix` defines a user's home configuration and composes user-focused capabilities, like how the shell behaves and how editors are configured. A capability that supports user-level configuration has a `home.nix` file.
- `flake.nix` is the entry point, tying both the system and user configurations together.

## Prerequisites
### Development Tools
Make sure you have your development tools installed. Running `xcode-select --install` in your terminal should work just fine, or you could install Xcode in full.

### Nix (the package manager)
There are several ways to install Nix. You can use the [official installer](https://nixos.org/download#nix-install-macos) or use the one from [determinate systems](https://github.com/DeterminateSystems/nix-installer).

Either one is fine. The one from Determinate Systems has some quality-of-life improvements, such as:
- survives macOS updates (see https://github.com/NixOS/nix/issues/3616)
- doesn't configure channels and enables flake support by default
- offers a built-in way to uninstall Nix

If you went with the official installer, make sure that `experimental-features` includes at least `flakes` and `nix-command`. You can check by running:
```console
nix show-config | grep experimental-features
```

## Installation
> **Warning:** This repository contains _my_ configuration and is specifically tuned to _my_ workflow. Read the source before blindly following along!

Now that we have both our development tools and the nix package manager installed, it's time to clone this repository:
```console
git clone git@github.com:kevinbungeneers/dotfiles.git ~/.dotfiles
```

### Install `nix-darwin`
Install nix-darwin and activate the configuration:
```console
cd ~/.dotfiles
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .
```

Once installed, you can simply rebuild your configuration:
```console
cd ~/.dotfiles
sudo darwin-rebuild switch --flake .
```

### Configure the Dock
Going through System Settings and dragging icons in and out of the dock is a bit too tedious for my taste. That's why I created a little script that configures the dock just the way I like:
```console
cd ~/.dotfiles/macos/dock
./configure.zsh
```

### Install macOS software
The `macos/install/` directory is a collection of app/tool installer scripts that you can run to get a fresh machine to a usable state quickly.
It complements the `nix-darwin` and `home-manager` configurations by covering the kind of things that are often:
- Not managed via Nix (or not worth the effort to)
- GUI apps distributed as `.dmg`/`pkg`/vendor installers
- Mac-specific utilities

## Managing your configuration
### Updating inputs
All inputs are pinned to a specific version in the `flake.lock` file.
Updating these are just a simple command away:
```console
nix flake update
```

Alternatively, you could also update a single input:
```console
nix flake update nixpkgs
```

### Making changes
Much like a home, dotfiles are never finished. Occasionally you'll want to switch things up and add, replace or remove tooling and/or configuration options.
Any changes you've made will need to be activated. From within the dotfiles directory:
```console
sudo darwin-rebuild switch --flake .
```
Switching generations doesn’t update flake inputs; it just activates what you built.

### Rolling back changes
With each switch you execute, a new "generation" will be created. If you were to break something, you could easily perform a rollback to a previous generation.

List all generations:
```console
sudo darwin-rebuild --list-generations
```

Going back to the previous generation:
```console
sudo darwin-rebuild --rollback
```

Activating a specific generation:
```console
sudo darwin-rebuild --switch-generation 1
```

### Cleaning up old `nix-darwin` generations

`nix-darwin` generations are just profile generations under the system profile, plus the corresponding build results in the Nix store. Cleanup is typically a 2-step process:
1. delete old generations from the profile
2. garbage-collect the store

#### Remove old `nix-darwin` generations
List them:
```console
sudo nix-env -p /nix/var/nix/profiles/system --list-generations
```

Delete everything older than N days (example: keep last 14 days):
```console
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +14d
```

Or delete specific generation numbers:
```console
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations 45 46
```

#### Garbage-collect unreferenced store paths
After deleting generations, run GC to actually free disk space:
``` sh
sudo nix-collect-garbage -d
```

`-d` removes old GC roots and then collects; it’s the “full cleanup” version.