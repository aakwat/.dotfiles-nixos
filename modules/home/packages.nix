{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # dev
    claude-code
    gcc
    gnumake
    lazygit
    lazydocker

    # cli
    eza
    bat
    ripgrep
    fd
    dust
    btop
    htop
    fastfetch
    jq
    zellij
    yazi
    gnupg
    age

    # wayland session — what config/mango spawns or binds
    waybar
    mako
    tofi
    cliphist
    wl-clipboard
    hypridle
    brightnessctl
    playerctl
    cava
    impala # waybar wifi action
    bluetuith # waybar bluetooth action
    swappy
    pavucontrol
    networkmanagerapplet
    awww

    # apps
    nemo
    nemo-fileroller
    telegram-desktop
    viber
    spotify
    libreoffice-fresh
    proton-vpn
  ];
}
