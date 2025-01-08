# Nix Darwin Configuration

This repository contains a multi-host, multi-user Darwin system configuration using Nix flakes. It leverages `nix-darwin` and `home-manager` to manage macOS configurations declaratively.

## Description

The flake configuration is designed to support multiple hosts and users with specific configurations for each. It uses let-bindings and strict commas for better readability and maintainability.

These variables can then be used throughout the flake configuration to customize settings for each host and user.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Modules](#modules)
- [How to Use](#how-to-use)
- [Building and Switching](#building-and-switching)
- [Common Commands](#common-commands)
- [Troubleshooting](#troubleshooting)
- [Dirty Git Tree](#dirty-git-tree)
- [Path Does Not Exist](#path-does-not-exist)
- [References](#references)

## Overview

- **nix-darwin**: Brings the power of Nix on macOS for system-wide configurations.
- **Home Manager**: Manages user-level configuration (dotfiles, shells, packages) using Nix.
- **nix-homebrew**: Allows declarative management of Homebrew (including taps, casks, etc.) via Nix.

By splitting the configuration into multiple files under `./modules/`, each file focuses on a specific area (e.g., system packages, services, dotfiles, etc.).

## Requirements

- **Nix**: You need Nix installed.
- **nix-darwin**: The Darwin modules rely on nix-darwin.
- **Git**: This is a Flake-based workflow, so your configuration should be in a Git repository.

After installing Nix, you can install nix-darwin (one recommended approach is from the official Nix-Darwin docs).

## Modules
- **flake.nix**: The top-level file defining all inputs (nixpkgs, nix-darwin, home-manager, nix-homebrew) and outputs (your nix-darwin configuration). Imports each module (e.g., `./modules/darwin/homebrew.nix`) into `darwinConfigurations.<hostname>.modules`.
- **modules/darwin/apps/**:
  - `homebrew.nix`: Holds Homebrew-related configurations (brew packages, casks, etc.).
  - `nixpackages.nix`: Holds your `environment.systemPackages`.
  - `services.nix`: Configures system services (e.g., Tailscale, nix-daemon, security/pam).
  - `default.nix`: Aggregates all .nix files in the directory for easier reference by the flake.
- **modules/darwin/security/**:
  - `default.nix`: Consolidated configurations for security related settings.
- **modules/darwin/system/**:
  - `appearance.nix`: Appearance related settings (e.g., dock, interface, login window settings, etc ).
  - `finder.nix`: Finder related customizations.
  - `system.nix`: System configuration (e.g., trackpad, keyboard mapping, screenshot default location, etc...).
  - `default.nix`: Aggregates all .nix files in directory for easier reference by the flake
- **modules/home/**:
  - `<username>/dotfiles.nix`: Holds user-level dotfiles managed by Home Manager (e.g., `~/.gitconfig`, `~/.ssh/config`).
- **rebuild.sh**: A convenience script that typically runs something like:
  ```sh
  #!/usr/bin/env bash
  darwin-rebuild switch --flake .#<hostname>
  ```

## How to Use

In the `flake.nix` file, you can define host-specific and user-specific variables using let-bindings. Examples shown in the `flake.nix` file.

To add a new host or user, update the `hostVars` and `userVars` sections in the `flake.nix` file with the new configurations. Follow the existing structure to ensure consistency.

Execution:

1. **Clone the repository**:
    ```sh
    git clone https://github.com/your-username/nix-darwin-config.git
    cd nix-darwin-config
    ```

2. **Install Nix**:
    Follow the instructions on the [Nix website](https://nixos.org/download.html) to install Nix.

3. **Enable Flakes**:
    Ensure that flakes are enabled in your Nix configuration:
    ```sh
    mkdir -p ~/.config/nix
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
    ```

4. **Apply Configuration**:
    To apply the configuration for a specific host, run:
    ```sh
    nix build .#darwinConfigurations.<hostname>.system
    ./result/sw/bin/darwin-rebuild switch --flake .
    ```

    Replace `<hostname>` with the actual hostname defined in the `flake.nix` file (e.g., `swaphb-mba`).

## Building and Switching

1. Clone this repo (or ensure you have your local copy).
2. Install nix-darwin if you haven’t already.
3. From the root of this repository (where `flake.nix` resides), run:
    ```sh
    darwin-rebuild switch --flake .#<hostname>
    ```
    Replace `<hostname>` with the actual name of your system defined in `flake.nix` (e.g., `swaphb-mba`).

Alternatively, if you have a script `rebuild.sh`, run:

```sh
./rebuild.sh
```
which should do the same command under the hood.

## Common Commands

- **Build without switching**:
    ```sh
    darwin-rebuild build --flake .#<hostname>
    ```
    This only builds the configuration but doesn’t apply it.

- **Show changes**:
    ```sh
    darwin-rebuild dry-activate --flake .#<hostname>
    ```
    See what changes will be made without applying them.

- **List available flake outputs**:
    ```sh
    nix flake show
    ```
- **Build with switching**
    ```sh
    darwin-rebuild switch --flake .#<hostname>
    ```
- **Update upstream flakes**
    ```sh
    nix flake update
    ```

## Troubleshooting

### Dirty Git Tree

If you see warnings like:
```
warning: Git tree '/path/to/your/repo' is dirty
```
It means you have uncommitted changes.

**Solution**: Either commit the changes or pass `--impure` (not recommended), or stage/commit the changes to keep the flake happy:
```sh
git add -A
git commit -m "Commit message"
```

### Path Does Not Exist

If you get an error similar to:
```
error: path '/nix/store/...-source/modules/darwin/homebrew.nix' does not exist
```
It usually means:

- You haven’t actually created or committed the file.
- There’s a typo or case mismatch in the file name.
- The file is in a different directory than you think.

**Solution**: Make sure the file exists, check for correct spelling/capitalization, and commit it to Git.

## References

- [NixOS Wiki: Flakes](https://nixos.wiki/wiki/Flakes)
- [nix-darwin](https://github.com/LnL7/nix-darwin)
- [Home Manager](https://github.com/nix-community/home-manager)
- [nix-homebrew (zhaofengli-wip)](https://github.com/zhaofengli/nix-homebrew)

With this multi-file approach, you can easily add, remove, or tweak individual modules without having a giant monolithic `flake.nix`.