{ config, pkgs, lib, ... }:

{  
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