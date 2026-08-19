{ config, ... }:
let
  # Out-of-store symlinks: edit config/ and it is live, no rebuild.
  # Requires the repo to sit at ~/.dotfiles.
  link = p: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/${p}";
in
{
  xdg.configFile = {
    "niri".source = link "config/niri";
    "waybar".source = link "config/waybar";
    "mako".source = link "config/mako";
    "tofi".source = link "config/tofi";
    "kitty".source = link "config/kitty";
    "hypr".source = link "config/hypr";
    "gtk-3.0".source = link "config/gtk-3.0";
    "gtk-4.0".source = link "config/gtk-4.0";
    "yazi".source = link "config/yazi";
    "zellij".source = link "config/zellij";
    "nvim".source = link "config/nvim";
    "starship.toml".source = link "config/starship.toml";
  };

  home.file = {
    ".local/bin/wallpaper".source = link "scripts/wallpaper.sh";
    ".local/bin/wallpaper-picker".source = link "scripts/wallpaper-picker.sh";
    ".local/bin/powermenu".source = link "scripts/powermenu.sh";
    ".local/bin/screenshot".source = link "scripts/screenshot.sh";
    ".local/bin/cava-waybar".source = link "scripts/cava-waybar.sh";
    ".local/bin/audit-security".source = link "scripts/audit-security.sh";
  };
}
