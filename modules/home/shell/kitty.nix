{ pkgs, ... }:
{
  # Package only — config/kitty is symlinked by links.nix, and
  # programs.kitty would overwrite kitty.conf.
  home.packages = [ pkgs.kitty ];
}
