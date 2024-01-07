# dotfiles
This repository contains the configuration for `$HOME`, as well as some other things to fine-tune my macOS experience.
Most of it is managed with [nix](https://nixos.org/) and [home-manager](https://github.com/nix-community/home-manager).

## Setup
**Note:** The steps described in this section are written with a clean macOS installation in mind and serve mostly as documentation for myself.

### Fonts
I'm using [powerlevel10k](https://github.com/romkatv/powerlevel10k) as ZSH theme. In order for that theme to actually look good, you'll need to have the [MesloLGS NF](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip) fonts installed. More specifically, the `MesloLGSNerdFontMono-{Bold,BoldItalic,Italic,Regular}.tff` fonts.

### Terminal
My terminal emulator of choice is the one that's included with the OS. I've added a custom terminal configuration, based on [this one](https://github.com/nordtheme/terminal-app). I've changed the default font to the one mentioned above, changed the default window size, etc.

### Development Tools
Make sure you have your development tools installed. Running `xcode-select --install` in your terminal should work just fine, or you could install Xcode in full.

### Nix (the package manager)
There are several ways to install Nix. You can use the [official installer](https://nixos.org/download#nix-install-macos) or use the one from [determinate systems](https://github.com/DeterminateSystems/nix-installer).

Either one is fine. The one from Determinate Systems has some quality-of-life improvements, such as:
- survives macOS updates (see https://github.com/NixOS/nix/issues/3616)
- doesn't configure channels, as we're using flakes anyway
- offers a built-in way to perform an uninstall

### Installing our dotfiles
Now that we have both our development tools and the nix package manager installed, it's time to clone this repository:
```console
git clone git@github.com:kevinbungeneers/dotfiles.git
```

Enter the dotfiles directory and run:
```console
nix build
result/activate
```

This will effectively install our dotfiles, along with all it's dependencies, as a package.

## Making changes
Much like a home, dotfiles are never finished. Every now and then you'll switch things up and add, replace or remove tooling and/or configuration options.
Any changes you've made will need to be be activated. From within your dotfiles directory:
```console
home-manager switch --flake .
```

**Note:** If your home configuration is named like `<user>@<host>`, home-manager will automatically pick the right configuration to apply. Otherwise, you'll need to specify your configuration explicitely, like so: `home-manager switch --flake ".#<name-of-your-configuration>`


## Rolling back changes
With each switch you execute, home-manager will create a new "generation". If you were to break something, you could easily perform a rollback to a previous generation.

List all generations:
```console
home-manager generations
```

Activating a specific generation:
```console
/nix/store/jyjpp3glrv202sck83y04ji0cl538rjn-home-manager-generation/activate
```
