{ pkgs, ... }:
{
  # System-wide only: bootstrap tools, root's rescue editor, and what system
  # services load. Anything the user launches lives in modules/home/packages.nix.
  environment.systemPackages = with pkgs; [
    git # nixos-rebuild reads the flake through it
    vim
    wget
    curl

    xwayland-satellite # niri session
    hyprpolkitagent

    ffmpegthumbnailer # loaded by services.tumbler
    webp-pixbuf-loader
  ];
}
