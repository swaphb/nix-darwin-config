{ config, pkgs, lib, ... }:
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

  targets.darwin.defaults = {
    dock = {
      autohide = true;
      orientation = "bottom";
      persistent-apps = [
        "/Applications/Safari.app"
        "/Applications/Ghostty.app"
        "/Applications/Cursor.app"
        "/${pkgs.vscode}/Applications/Visual Studio Code.app"
        "/${pkgs.lens}/Applications/Lens.app"
        "/${pkgs.slack}/Applications/Slack.app"
        "/${pkgs.discord}/Applications/Discord.app"
        "/${pkgs.spotify}/Applications/Spotify.app"
        "/Applications/joplin.app"
      ];
      persistent-others = [
        "${config.home.homeDirectory}/code"
        "${config.home.homeDirectory}/Downloads"
      ];
      show-recents = false;
      tilesize = 36;
    };
  };
}
