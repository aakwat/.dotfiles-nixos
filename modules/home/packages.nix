{ pkgs, ... }:
{
  # Every user package. System-wide ones live in modules/system/packages.nix.
  home.packages = with pkgs; [
    claude-code

    gcc
    gnumake

    eza
    bat
    ripgrep
    fd
    dust
    btop
    htop

    lazygit
    lazydocker
  ];
}
