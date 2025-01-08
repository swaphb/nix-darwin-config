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
      "k9s"
      "helm"
      "podman"
      "podman-compose"
    ];
    casks = [
      "1password"
      "podman-desktop"
      "teleport-connect"
      "utm"
      "localsend"
      "joplin"
    ];
    masApps = {
      "1Password for Safari" = 1569813296;
      "wireguard" = 1451685025;
      "wipr" = 1320666476;
    };
  };
}
