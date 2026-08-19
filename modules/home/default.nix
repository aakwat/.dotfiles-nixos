{ config, pkgs, ... }:

{
  imports = [
    ./core.nix

    ./shell/fish.nix
    ./shell/starship.nix
    ./shell/kitty.nix

    ./desktop/niri.nix
    ./desktop/tofi.nix

    ./programs/librewolf.nix
    ./programs/neovim.nix
  ];

  home.username = "kwat";
  home.homeDirectory = "/home/kwat";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
