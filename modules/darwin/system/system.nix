{ config, pkgs, lib, ... }:

{
  system.nixpkgsRelease = "unstable"; # Use the unstable channel for latest Nixpkgs. Stable packages update less frequently, for stable use "24.11"
  
  system.defaults.screencapture = {
    location = "~/Documents/Screenshots"; # Set default screenshot location
    # Add more screencapture settings here
    };

  system.defaults.trackpad = {
    TrackpadThreeFingerDrag = true;
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