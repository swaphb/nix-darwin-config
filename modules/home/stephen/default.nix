{ config, pkgs, lib, ... }:
{
  imports = [
    ./terminal/default.nix
  ];

  home = {
    packages = with pkgs; [
      _1password-cli
      awscli2
      azure-cli
      brave
      discord
      go
      google-cloud-sdk
      kubectl
      krew
      lens
      ollama
      slack
      spotify
      teleport
      tenv
      vim
      vscode
    ];
  };
}
