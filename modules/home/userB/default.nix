{ config, pkgs, lib, username, ... }:

{
  home.file.".gitconfig".text = ''
    [user]
      name = "User B"
      email = "userA@example.com"
  '';

  home.file.".zshrc".text = ''
    # userA's custom zsh config
  '';

  imports = [
    # User B's imports
  ];

  home = {
    packages = with pkgs; [
      # User B's packages
    ];

  };
}