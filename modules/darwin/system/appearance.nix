{ config, pkgs, lib, ... }:
{  
  # If you also want to do e.g. Dock preferences from the same user-level file:
  system.defaults.dock = {
    autohide = true;
    orientation = "bottom";
    persistent-apps = [
      /Applications/Safari.app
      /System/Applications/Utilities/Terminal.app
      # Add your persistent apps here
    ];
    persistent-others = [
      # Add your persistent others here
      "~/Documents"
      "~/code"
    ];
    show-recents = false;
    tilesize = 36; # Set the icon size on the dock; default is 64
  };


system.defaults.NSGlobalDomain = {
    AppleInterfaceStyle = "Dark";     # "Dark" or "Light" - Darkmode all the things
    AppleHighlightColor = "Purple";   # Set highlight color
    # Add more NSGlobalDomain settings here
  };

  system.defaults.loginwindow = {
    GuestEnabled = false; # Disable guest account
    AdminHostInfo = "HostName"; # Show hostname on login window
    AdminHostInfoTime = true; # Show time on login window
    LoginwindowText = "Super Awesome Mac"; # Set login window text
    # Add more loginwindow settings here
    };
}