{ pkgs, ... }:
{
  networking.networkmanager.enable = true;
  # ProtonVPN's app connects through NetworkManager.
  networking.networkmanager.plugins = [ pkgs.networkmanager-openvpn ];

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };
}
