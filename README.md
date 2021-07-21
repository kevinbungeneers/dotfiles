# dotfiles
This repository contains the configuration files that I use to configure and customize the CLI on my macOS machines.
Most of this configuration is managed through [home-manager](https://github.com/nix-community/home-manager), which allows you to configure everything in a declarative way.

## Installation
The steps described in this section are written with a clean macOS installation in mind and serve mostly as documentation for myself.

### Development Tools
First, we're going to need our development tools installed. The easiest way to do this is by running `xcode-select --install` from your favourite terminal.

### Cloning this repository
With our development tools present, we can now clone this repository:
```console
$ git clone git@github.com:kevinbungeneers/dotfiles.git ~/.config
```

### Nix
Next, we're going to need to have working installation of the [Nix](https://nixos.org/) package manager. Installing Nix on macOS is fairly easy:
```console
$ sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
```

> Running the one-liner above will install Nix in **single user mode**. This is fine for me, as I typically only use/have one user account on my computers, but if you're someone who has multiple accounts, you might want to opt for a multi-user installation. You can read more about it in the [docs](https://nixos.org/manual/nix/stable/).

Once the one-liner has done it's thing, it's time to source the correct environment variables:
```console
. $HOME/.nix-profile/etc/profile.d/nix.sh
```

If all went well, you should be able to run things like `nix-env -qaP`

New Nix installations track the `unstable` channel by default. Switching to stable is a matter of removing the `unstable` channel and adding the `stable` one.

Run `nix-channel --remove nixpkgs` to remove unstable, and `nix-channel --add https://nixos.org/channels/nixpkgs-21.05-darwin nixpkgs` followed with a `nix-channel --update` to add the stable channel.

### Home Manager
Add the appropriate channel. If you're following Nixpkgs master, or unstable, you can run:
```console
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
$ nix-channel --update
```

If you're tracking Nixpkgs version 21.05:
```console
$ nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz home-manager
$ nix-channel --update
```

With the home-manager channel added, we can now do:
```console
$ nix-shell '<home-manager>' -A install
```

Once installed, run `home-manager switch` to activate the configurations defined in [home.nix](https://github.com/kevinbungeneers/dotfiles/blob/master/nixpkgs/home.nix).