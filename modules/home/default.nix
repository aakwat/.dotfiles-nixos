{ ... }:
{
  imports = [
    ./packages.nix
    ./links.nix

    ./shell/fish.nix
    ./shell/starship.nix
    ./shell/kitty.nix

    ./desktop/theme.nix

    ./programs/git.nix
    ./programs/ssh.nix
    ./programs/librewolf.nix
    ./programs/neovim.nix
  ];

  home.username = "kwat";
  home.homeDirectory = "/home/kwat";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
