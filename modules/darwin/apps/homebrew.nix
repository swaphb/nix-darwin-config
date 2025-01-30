{ config, pkgs, lib, ... }:

{
  # Darwin-level Homebrew configuration
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    taps = [];
    brews = [
      "git"
      "helm"
      "k9s"
    ];
    casks = [
      "1password"
      "cursor"
      "elgato-wave-link"
      "firefox"
      "ghostty"
      "joplin"
      "localsend"
      "logi-options+"
      "orbstack"
      "teleport-connect"
      "utm"
      "zen-browser"
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
