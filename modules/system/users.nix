{ pkgs, ... }:
{
  programs.fish.enable = true; # required before fish can be a login shell

  users.groups.kwat.gid = 1000;

  users.users.kwat = {
    isNormalUser = true;
    uid = 1000;
    group = "kwat";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "input"
      "podman"
    ];
    # TODO(install): passwd kwat on first boot, then delete this line.
    # initialPassword lands in the world-readable /nix/store.
    initialPassword = "changeme";
  };
}
