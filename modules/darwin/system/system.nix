{ config, pkgs, lib, ... }:

{
  system.nixpkgsRelease = "unstable"; # Use the unstable channel for latest Nixpkgs. Stable packages update less frequently, for stable use "24.11"
  
  # system.defaults.loginwindow = {
  #   GuestEnabled = false; # Disable guest account
  #   AdminHostInfo = "HostName"; # Show hostname on login window
  #   AdminHostInfoTime = true; # Show time on login window
  #   LoginwindowText = "Super Awesome Mac"; # Set login window text
  #   # Add more loginwindow settings here
  #   };
  
  system.defaults.screencapture = {
    location = "~/Documents/Screenshots"; # Set default screenshot location
    # Add more screencapture settings here
    };

  # # Finder Settings
  # system.defaults.finder = {
  #   FXPreferredViewStyle = "Nlsv";    # Set default view style to list view
  #   NewWindowTarget = "PfHm";         # Set default new window target to home folder
  #   ShowMountedServersOnDesktop = true; # Show mounted servers on desktop
  #   ShowPathbar = true;               # Show path bar
  #   # Add more Finder settings here
  #   };

  # system.defaults.NSGlobalDomain = {
  #   AppleInterfaceStyle = "Dark";     # "Dark" or "Light" - Darkmode all the things
  #   AppleHighlightColor = "Purple";   # Set highlight color
  #   # Add more NSGlobalDomain settings here
  # };

  # # If you also want to do e.g. Dock preferences from the same user-level file:
  # system.defaults.dock = {
  #   autohide = true;
  #   orientation = "bottom";
  #   persistent-apps = [
  #     /Applications/Safari.app
  #     /System/Applications/Utilities/Terminal.app
  #     # Add your persistent apps here
  #   ];
  #   persistent-others = [
  #     # Add your persistent others here
  #     "~/Documents"
  #     "~/code"
  #   ];
  #   show-recents = false;
  #   tilesize = 36; # Set the icon size on the dock; default is 64
  # };

  system.default.tracpad = {
    tracpadThreeFingerDrag = true;
    FirstClickThreshold = 1;
    SecondClickThreshold = 1;
    # Set up your trackpad preferences here
  };

  system.keyboard = {
    swapLeftCtrlAndFn = true;
    # Set up your keyboard preferences here
  };
  # You can add more Mac defaults here as well...
}