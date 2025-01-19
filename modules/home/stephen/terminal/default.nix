{ config, pkgs, lib, ... }:

{

  imports = [
    ./starship/default.nix
  ];

  # Some user-level dotfiles
  home.file = {
    ".ssh/config".text = ''
      Host *
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';

    ".gitconfig".text = ''
      [user]
        name = swaphb
        email = s@swaphb.com
        signingkey = ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJx0WMlfx+AwcROXFO+/all/WkLvBKpEkjwRY15tjSiB

      [gpg]
        format = ssh

      [gpg "ssh"]
        program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"

      [commit]
        gpgSign = true
    '';
    
    ".zshrc".text = ''
      eval "$(starship init zsh)"
    '';

    ".config/ghostty/config".text = ''
      background-opacity = 0.9
      theme = "dracula"
    '';

  };
}