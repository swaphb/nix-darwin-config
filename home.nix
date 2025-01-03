{ pkgs, ... }: {
  home = {
    stateVersion = "23.11";
    username = "emiliazapata";
    homeDirectory = "/Users/emiliazapata";
    # Then we add the packages we want in the array using pkgs.<name>
    packages = [
      pkgs.git
      pkgs.neovim
    ];
  };
  # This is to ensure programs are using ~/.config rather than
  # /Users/<username/Library/whatever
  xdg.enable = true;

  programs.home-manager.enable = true;
#   programs.fish.enable = true;
  programs.zsh.enable = true;
}