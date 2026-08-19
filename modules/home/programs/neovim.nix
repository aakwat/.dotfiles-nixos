{ pkgs, ... }:
{
  # No programs.neovim: config/nvim is LazyVim, symlinked by links.nix, and
  # the module would write into the same directory.
  home.packages = with pkgs; [
    neovim
    lua-language-server
    stylua
  ];

  home.sessionVariables.EDITOR = "nvim";
}
