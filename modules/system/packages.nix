{ pkgs, ... }:
{
  # Every system-wide package. User tools live in modules/home.
  environment.systemPackages = with pkgs; [
    # base
    git
    vim
    wget
    curl
    gnupg
    age

    # wayland session — what config/niri/config.kdl spawns or binds
    xwayland-satellite
    wl-clipboard
    cliphist
    jq
    waybar
    mako
    tofi
    awww
    hypridle
    hyprlock
    hyprpolkitagent
    networkmanagerapplet
    brightnessctl
    playerctl
    cava
    swappy
    pavucontrol

    # files
    nemo
    nemo-fileroller
    ffmpegthumbnailer
    webp-pixbuf-loader

    # apps
    telegram-desktop
    viber
    spotify
  ];
}
