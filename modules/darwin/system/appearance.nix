{ config, pkgs, lib, username, ... }:
let
  homeDirectory = "/Users/${username}";
in
{  
  # If you also want to do e.g. Dock preferences from the same user-level file:
  system.defaults.dock = {
    autohide = true;
    orientation = "bottom";
    persistent-apps = [
      /Applications/Safari.app
      /Applications/Ghostty.app
      "/Applications/Cursor.app"
      "/${pkgs.vscode}/Applications/Visual Studio Code.app" # Use the nixpkgs path to the app for apps installed via nix. This will automatically use the latest nix store path.
      "/${pkgs.lens}/Applications/Lens.app"
      "/${pkgs.slack}/Applications/Slack.app"
      "/${pkgs.discord}/Applications/Discord.app"
      "/${pkgs.spotify}/Applications/Spotify.app"
      "/Applications/joplin.app"
      # Add your persistent apps here
    ];
    persistent-others = [
      "${homeDirectory}/code"
      "${homeDirectory}/Downloads"
      # Add your persistent others here
    ];
    show-recents = false;
    tilesize = 36; # Set the icon size on the dock; default is 64
  };

  system.defaults.NSGlobalDomain = {
    AppleInterfaceStyle = "Dark";     # "Dark" or "Light" - Darkmode all the things
    # Add more NSGlobalDomain settings here
  };

  system.defaults.loginwindow = {
    GuestEnabled = false; # Disable guest account
    LoginwindowText = "Super Awesome Mac"; # Set login window text
    # Add more loginwindow settings here
  };
}