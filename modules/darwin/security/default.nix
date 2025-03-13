{ config, pkgs, ... }:
{
  # Enable TouchID for PAM auth: you could also place security/pam or other service configs here:
  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults.alf = {
    allowsignedenabled = 1; # Allows any signed Application to accept incoming requests. Default is true. 0 = disabled 1 = enabled
    allowdownloadsignedenabled = 0; # Allows any signed Application to accept incoming requests. Default is false. 0 = disabled 1 = enabled
    globalstate = 1; # Enable the internal firewall to prevent unauthorised applications, programs and services from accepting incoming connections. 0 = disabled 1 = enabled 2 = blocks all connections except for essential services
    loggingenabled = 0; # Enable logging of blocked incoming connections. 0 = disabled 1 = enabled
    stealthenabled = 1; # Enable stealth mode. This will prevent the computer from responding to ICMP ping requests and will not answer to port scans. 0 = disabled 1 = enabled
  };
}