{ config, pkgs, ... }:
{
  # Enable TouchID for PAM auth: you could also place security/pam or other service configs here:
  security.pam.enableSudoTouchIdAuth = true;
}