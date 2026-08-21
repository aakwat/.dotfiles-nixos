{ pkgs, ... }:
{
  # Package only — config/foot is symlinked by links.nix.
  home.packages = [ pkgs.foot ];
}
