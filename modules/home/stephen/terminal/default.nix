{ config, pkgs, lib, ... }:

{

  imports = [
    ./starship/default.nix
  ];

  # Some user-level dotfiles
  home.file = {
    # Configure ssh
    ".ssh/config".text = ''
      Host *
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';

    # Configure git
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

    # Configure 1password agent.toml
    ".config/1Password/ssh/agent.toml".text = ''
      # Examples can be found here:
      #  https://developer.1password.com/docs/ssh/agent/config

      [[ssh-keys]]
      item = "github-auth-key"
      vault = "Private"
      
      [[ssh-keys]]
      item = "github-sign-key"
      vault = "Private"
      
      [[ssh-keys]]
      item = "Github-swaphb"
      vault = "Private"
      
      [[ssh-keys]]
      vault = "Employee"
    '';
    
    # Configure zsh
    ".zshrc".text = ''
      eval "$(starship init zsh)"
      export PATH="''${KREW_ROOT:-/Users/${config.home.username}/.krew}/bin:$PATH"
    '';

    # Configure ghostty
    ".config/ghostty/config".text = ''
      background-opacity = 0.9
      theme = "dracula"
    '';

  };
}