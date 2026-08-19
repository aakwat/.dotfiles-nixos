{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    withPython3 = false;
    withRuby = false;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      stylua
    ];
  };

  xdg.configFile."nvim" = {
    source = ../../../config/nvim;
    recursive = true;
  };
}
