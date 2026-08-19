{ pkgs, ... }:

{
  programs.librewolf = {
    enable = true;

    settings = {
      "pravicy.resistFingerprinting" = true;
      "browser.theme.content-theme" = 0;
      "browser.theme.toolbar-theme" = 0;
    };
  };
}
