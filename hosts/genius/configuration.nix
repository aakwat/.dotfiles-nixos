{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
  ];

  networking.hostName = "genius";

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.resumeDevice = "/dev/disk/by-label/swap";

  hardware.bluetooth.enable = true;

  # Set once from the release you installed. Never bump it.
  system.stateVersion = "25.11";
}
