{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # Optional: Declarative tap management
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

  outputs = inputs@{ self, nix-darwin, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, home-manager, ... }: 
  let
    username = "stephen";
    hostname = "swaphb-mba";
    configuration = { pkgs, lib, inputs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget

      #####################
      ### Nix Packages ###
      #####################
      environment.systemPackages =
        [ 
          pkgs.vim
          pkgs.lens
          pkgs.vscode
          pkgs.spotify
          pkgs.slack
          pkgs.podman-desktop
          pkgs.kubectl
          pkgs.discord
          pkgs._1password-cli
          pkgs._1password-gui
          pkgs.brave
        ];
      
      ################
      ### Homebrew ###
      ################
      homebrew = {
        enable = true;
        # onActivation.cleanup = "uninstall";
    
        taps = [];
        brews = [ 
          "cowsay" 
          "git"
          "k9s"
          "helm"
          "tfenv"
          ];
        casks = [];
      };

      ################
      ### Nix-Darwin ###
      ################
      nix.extraOptions = ''
        experimental-features = nix-command flakes
      '';
      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      services = { 
        tailscale = {
          enable = true;
        };
      };

      # Enable the darwin security.pam module for sudo Touch ID authentication.
      security = { 
        pam = {
          enableSudoTouchIdAuth = true;
        };
      };

      # Enable the nix-darwin module system.
      nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs = {
        fish = {
          enable = false;
        };
        zsh = {
          enable = true;
        };
      };
      # programs.fish.enable = true;
      # Enable 1password plugins on interactive shell init
      programs.bash.interactiveShellInit = ''
        source /home/${username}/.config/op/plugins.sh
      '';

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      system.defaults = {
        dock = {
          autohide = true;
          mru-spaces = false;
        };
        finder = {
          AppleShowAllFiles = true;
          AppleShowAllExtensions = true;
          FXPreferredViewStyle = "clmv";
        };
        loginwindow.LoginwindowText = "${hostname}";
        screencapture.location = "~/Pictures/screenshots";
        screensaver.askForPasswordDelay = 10;
        trackpad = {
          # Click = "click";
          # DragLock = true;
          # Dragging = true;
          TrackpadThreeFingerDrag = true;
          FirstClickThreshold = 1;
        };
      };
      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config = {
        allowUnfree = true;
        allowBroken = true;
      };
    };

    homeconfig = { pkgs, lib, ... }: {
      # this is internal compatibility configuration 
      # for home-manager, don't change this!
      home.stateVersion = "24.05";
      # Let home-manager install and manage itself.
      programs.home-manager.enable = true;

      home.packages = with pkgs; [ ];

      home.sessionVariables = {
          EDITOR = "nano";
      };

      home.homeDirectory = lib.mkForce "/Users/${username}";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#${hostname}
    darwinConfigurations."${hostname}" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "${username}";
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
            };
            autoMigrate = true; # Automatically migrate from brewfile to flake if brew already exists.
            mutableTaps = false; 
          };
        }
        home-manager.darwinModules.home-manager  
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.verbose = true;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."${hostname}".pkgs;
  };
}


