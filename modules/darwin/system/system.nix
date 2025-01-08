{ config, lib, ... }:

{ 
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
    swapLeftCtrlAndFn = true; # Swap left control and function keys
    enableKeyMapping = true; # Enable key mapping
    # Set up your keyboard preferences here
  };

  system.defaults.WindowManager.EnableStandardClickToShowDesktop = false; # Disable/Enable standard click to show desktop
  # You can add more Mac defaults here as well...
}