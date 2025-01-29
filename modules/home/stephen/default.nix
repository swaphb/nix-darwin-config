{ config, pkgs, lib, username, ... }:
{
  imports = [
    ./terminal/default.nix
  ];

  home = {
    packages = with pkgs; [
      _1password-cli
      awscli
      azure-cli
      brave
      discord
      go
      google-cloud-sdk
      kubectl
      krew
      lens
      slack
      spotify
      teleport
      tenv
      vim
      vscode
    ];

  };
  system.defaults.dock = {
    autohide = true;
    orientation = "bottom";
    persistent-apps = [
      /Applications/Safari.app
      /Applications/Ghostty.app
      "/${pkgs.vscode}/Applications/Visual Studio Code.app" # Use the nixpkgs path to the app for apps installed via nix. This will automatically use the latest nix store path.
      "/${pkgs.lens}/Applications/Lens.app"
      "/${pkgs.slack}/Applications/Slack.app"
      "/${pkgs.discord}/Applications/Discord.app"
      "/${pkgs.spotify}/Applications/Spotify.app"
      "/Applications/joplin.app"
      # Add your persistent apps here
    ];
    persistent-others = [
      "${config.home-manager.users.stephen.home.homeDirectory}/code"
      "${config.home-manager.users.stephen.home.homeDirectory}/Downloads"
      # Add your persistent others here
    ];
  };
}
