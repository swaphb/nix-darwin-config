{ config, pkgs, lib, ... }:

{
  home.file.".gitconfig".text = ''
    [user]
      name = "User B"
      email = "userA@example.com"
  '';

  home.file.".zshrc".text = ''
    # userA's custom zsh config
  '';
}
