{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.resumeDevice = "/dev/disk/by-label/swap";

  hardware.bluetooth.enable = true;

  networking.hostName = "genius";
  networking.networkmanager.enable = true;
  networking.firewall = { 
    enable = true; 
    allowedTCPPorts = [ ];
  };

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  users.groups.kwat.gid = 1000;
  users.users.kwat = {
    isNormalUser = true;
    uid = 1000;
    group = "kwat";
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    shell = pkgs.fish;
    initialPassword = "changeme";
  };
  programs.fish.enable = true;

  programs.niri.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = { automatic = true; dates = "weekly"; options = "--delete-older-than 14d"; };
  nixpkgs.config.allowUnfree = true;

  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.saned.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim neovim
    gnupg
    wget
    curl

    nemo nemo-fileroller ffmpegthumbnailer webp-pixbuf-loader
  ];

  system.stateVersion = "25.11";
}
