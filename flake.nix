{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    # home-manager.url = "github:nix-community/home-manager";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
          pkgs.vim
        ];
      
      nix.extraOptions = ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';
      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      services.tailscale = {
        enable = true;
      };

      security.pam.enableSudoTouchIdAuth = true;

      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;
      # Enable 1password plugins on interactive shell init
      programs.bash.interactiveShellInit = ''
        source /home/stephen/.config/op/plugins.sh
      '';

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.LoginwindowText = "swaphb-mba";
        screencapture.location = "~/Pictures/screenshots";
        screensaver.askForPasswordDelay = 10;
      };

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config = {
        allowUnfree = true;
        allowBroken = true;
        # homebrew = {
        #   enable = true;
        #   packages = with pkgs; [
        #     # homebrew packages
        #     "1password-cli"
        #     "1password"
        #   ];
        # };
        # allowAliases = true;
        # packageOverrides = pkgs: {
        #   # Add a package to the set.
        #   _1password-cli = pkgs.callPackage ./pkgs/1password-cli { };
        #   _1password-gui = pkgs.callPackage ./pkgs/1password-gui { };
        # };
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#swaphb-mba
    darwinConfigurations."swaphb-mba" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."swaphb-mba".pkgs;
  };
}


