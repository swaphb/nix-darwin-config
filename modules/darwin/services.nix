{ config, pkgs, ... }:

{
  # Example: Tailscale, other system services
  services.nix-daemon.enable = true;
  services.tailscale.enable = true;

  # Example: you could also place security/pam or other service configs here:
  security.pam.enableSudoTouchIdAuth = true;
}
