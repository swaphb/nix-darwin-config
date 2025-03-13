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

- **flake.nix**: The top-level file defining all inputs (nixpkgs, nix-darwin, home-manager, nix-homebrew) and outputs.
- **modules/darwin/apps/**:
  - `homebrew.nix`: Holds Homebrew-related configurations (brew packages, casks, etc.).
  - `default.nix`: Aggregates all .nix files in the directory.
- **modules/darwin/security/**:
  - `default.nix`: Consolidated configurations for security related settings.
- **modules/darwin/system/**:
  - `system.nix`: System configuration (e.g., trackpad, keyboard mapping, screenshot default location, etc.).
  - `default.nix`: Aggregates all .nix files in directory.
- **modules/home/**:
  - `<username>/`: User-specific configurations
  - `<username>/terminal/`: Terminal-related configurations including shell setup
  - `<username>/terminal/starship/`: Starship prompt configurations

## Management Script

The repository includes an interactive management script (`manage.sh`) that provides a unified interface for common tasks:

```sh
./manage.sh
```

The script offers the following options:

1. **Rebuild configuration**: Rebuilds the current configuration
2. **Update flakes and rebuild**: Updates all flake inputs and rebuilds
3. **Clean nix store**: Runs garbage collection on the Nix store
4. **Exit**: Exits the script

For rebuild operations (options 1 and 2), the script will:
- Prompt for the hostname (defaults to "swaphb-mba" if not specified)
- Execute the appropriate commands

## How to Use

1. **Clone the repository**:
    ```sh
    git clone https://github.com/your-username/nix-darwin-config.git
    cd nix-darwin-config
    ```

2. **Install Nix**:
    Follow the instructions on the [Nix website](https://nixos.org/download.html) to install Nix.

3. **Enable Flakes**:
    ```sh
    mkdir -p ~/.config/nix
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
    ```

4. **Apply Configuration**:
    ```sh
    nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake .#swaphb-mba
    ```
    Select option 1 to rebuild the configuration, and enter your hostname when prompted.

## Common Commands

All common commands are now available through the management script (`./manage.sh`). However, you can still run commands manually if needed:

- **Build without switching**:
    ```sh
    darwin-rebuild build --flake .#<hostname>
    ```

- **Show changes**:
    ```sh
    darwin-rebuild dry-activate --flake .#<hostname>
    ```

- **List available flake outputs**:
    ```sh
    nix flake show
    ```

## Troubleshooting

### Dirty Git Tree

If you see warnings about a dirty Git tree:
```
warning: Git tree '/path/to/your/repo' is dirty
```

**Solution**: Commit your changes:
```sh
git add -A
git commit -m "Commit message"
```

### Path Does Not Exist

If you get path-related errors:
```
error: path '/nix/store/...-source/modules/darwin/homebrew.nix' does not exist
```

**Solution**: 
- Verify the file exists
- Check for correct spelling/capitalization
- Ensure the file is committed to Git

## References

- [NixOS Wiki: Flakes](https://nixos.wiki/wiki/Flakes)
- [nix-darwin](https://github.com/LnL7/nix-darwin)
- [Home Manager](https://github.com/nix-community/home-manager)
- [nix-homebrew (zhaofengli-wip)](https://github.com/zhaofengli/nix-homebrew)