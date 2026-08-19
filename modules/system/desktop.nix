{ pkgs, ... }:
{
  programs.niri.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
      user = "kwat";
    };
  };

  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    # Burmese also works as a plain xkb layout — config/niri sets "us,mm".
    fcitx5.addons = [
      pkgs.fcitx5-gtk
      pkgs.fcitx5-m17n
      pkgs.qt6Packages.fcitx5-configtool
    ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.defaultFonts = {
    serif = [
      "Noto Serif"
      "Noto Serif CJK SC"
    ];
    sansSerif = [
      "Noto Sans"
      "Noto Sans CJK SC"
    ];
    monospace = [ "JetBrainsMono Nerd Font" ];
    emoji = [ "Noto Color Emoji" ];
  };

  services.gvfs.enable = true;
  services.tumbler.enable = true;
}
