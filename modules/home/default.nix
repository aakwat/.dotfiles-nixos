{ ... }:
{
  imports = [
    ./packages.nix
    ./links.nix

    ./shell/fish.nix
    ./shell/starship.nix
    ./shell/kitty.nix
    ./shell/zoxide.nix

    ./desktop/theme.nix

    ./programs/git.nix
    ./programs/ssh.nix
    ./programs/librewolf.nix
    ./programs/neovim.nix
  ];

  home.username = "kwat";
  home.homeDirectory = "/home/kwat";
  home.stateVersion = "25.11";

  # links.nix puts scripts here; no NixOS profile covers it.
  home.sessionPath = [ "$HOME/.local/bin" ];

  programs.home-manager.enable = true;
}
