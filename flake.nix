{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nix-homebrew, home-manager, ... }:
    let
      username = "stephen";
      hostname = "swaphb-mba";

      # Minimal Darwin system config (minus environment.systemPackages/services)
      configuration = { pkgs, lib, inputs, ... }: {
        # Some general Darwin/Nix configuration
        nix.extraOptions = ''
          experimental-features = nix-command flakes
        '';

        # This can stay here or move to modules/darwin/services.nix
        # services.nix-daemon.enable = true;

        # Enable the nix-darwin module system.
        nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # zsh, fish, etc.
        programs.zsh.enable = true;
        programs.bash.interactiveShellInit = ''
          source /home/${username}/.config/op/plugins.sh
        '';

        system.configurationRevision = self.rev or self.dirtyRev or null;

        system.defaults = {
          # ...
        };

        system.stateVersion = 4;
        nixpkgs.hostPlatform = "aarch64-darwin";
        nixpkgs.config = {
          allowUnfree = true;
          allowBroken = true;
        };
      };

      # Minimal home-manager config (minus dotfiles)
      homeconfig = { pkgs, lib, ... }: {
        home.stateVersion = "24.05";
        programs.home-manager.enable = true;

        home.packages = with pkgs; [ ];
        home.sessionVariables = {
          EDITOR = "nano";
        };
        home.homeDirectory = lib.mkForce "/Users/${username}";
      };
    in
    {
      darwinConfigurations."${hostname}" = nix-darwin.lib.darwinSystem {
        modules =
          [
            # Main Darwin config
            configuration

            # The official nix-homebrew module from your flake inputs
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                enableRosetta = true;
                user = "${username}";
                taps = {
                  "homebrew/homebrew-core" = inputs.homebrew-core;
                  "homebrew/homebrew-cask" = inputs.homebrew-cask;
                  "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
                };
                autoMigrate = true;
                mutableTaps = false;
              };
            }

            # Our own modules for Darwin-level configs
            ./modules/darwin/homebrew.nix
            ./modules/darwin/nixpackages.nix
            ./modules/darwin/services.nix

            # Home Manager
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.verbose = true;
              home-manager.users.${username} = {
                imports = [
                  homeconfig
                  ./modules/home/dotfiles.nix
                ];
              };
            }
          ];
      };

      darwinPackages = self.darwinConfigurations."${hostname}".pkgs;
    };
}
