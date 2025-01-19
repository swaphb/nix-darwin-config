{ config, pkgs, lib, ... }:

{
  # Darwin-level Homebrew configuration
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    taps = [];
    brews = [
      "cowsay"
      "git"
      "helm"
      "k9s"
      "podman"
      "podman-compose"
    ];
    casks = [
      "1password"
      "ghostty"
      "joplin"
      "localsend"
      "logi-options+"
      "podman-desktop"
      "teleport-connect"
      "utm"
    ];
    masApps = {
      "1Password for Safari" = 1569813296;
      "tailscale" = 1475387142;
      "Windows App" = 1295203466;
      "wireguard" = 1451685025;
      "wipr" = 1320666476;
    };
  };
}
