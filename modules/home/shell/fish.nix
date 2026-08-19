{ ... }:
{
  programs.fish = {
    enable = true;

    # alias = shadow a command with flags you always want.
    shellAliases = {
      ll = "eza -lh  --icons --group-directories-first --git";
      la = "eza -lha --icons --group-directories-first --git";
      lt = "eza --tree --level=2 --icons";
      vim = "nvim";
      top = "btop";
      lgit = "lazygit";
      ldocker = "lazydocker";
      zj = "zellij";
      df = "df -h";
      free = "free -h";
    };

    # abbr = expands to editable text before it runs.
    shellAbbrs = {
      rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles#genius";
    };
  };
}
