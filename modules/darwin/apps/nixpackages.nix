{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    lens
    vscode
    spotify
    slack
    kubectl
    discord
    _1password-cli
    brave
    teleport
    tenv
    google-cloud-sdk
    awscli
    azure-cli
    go
    starship
  ];
}
