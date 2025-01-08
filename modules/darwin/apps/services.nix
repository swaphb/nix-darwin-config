{ config, pkgs, ... }:

{
  # Example: Tailscale, other system services
  services.nix-daemon.enable = true;
  services.tailscale.enable = true;
}
