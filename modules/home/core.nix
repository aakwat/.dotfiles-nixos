{ pkgs, ... }: 

{
  programs.ssh = {
    enable = true;

    extraConfig = "AddKeysToAgent yes";

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/coffee";
      };
    };
  };


  programs.git = {
    enable = true;
    userName = "Aung Koko Lwin";
    userEmail = "toyko2001@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  home.packages = with pkgs; [
    claude-code

    gcc
    gnumake

    eza
    bat
    ripgrep
    fd
    dust
    btop htop
  ];
}
