{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    _1password-cli
    awscli
    azure-cli
    brave
    discord
    go
    google-cloud-sdk
    kubectl
    krew
    lens
    slack
    spotify
    starship
    teleport
    tenv
    vim
    vscode
  ];
}
